@echo off
echo ========================================
echo IMIS HARD RESTART - Complete Rebuild
echo ========================================

echo.
echo [1/6] Stopping all processes...
taskkill /f /im python.exe 2>nul
taskkill /f /im node.exe 2>nul
timeout /t 2 >nul

echo.
echo [2/6] Cleaning backend cache...
cd /d "%~dp0backend"
if exist __pycache__ rmdir /s /q __pycache__
if exist app\__pycache__ rmdir /s /q app\__pycache__
if exist app\api\__pycache__ rmdir /s /q app\api\__pycache__
if exist app\core\__pycache__ rmdir /s /q app\core\__pycache__
if exist app\models\__pycache__ rmdir /s /q app\models\__pycache__
if exist app\services\__pycache__ rmdir /s /q app\services\__pycache__

echo.
echo [3/6] Installing backend dependencies...
pip install -r requirements.txt --quiet

echo.
echo [4/6] Cleaning frontend cache...
cd /d "%~dp0frontend"
if exist node_modules rmdir /s /q node_modules
if exist .svelte-kit rmdir /s /q .svelte-kit
if exist build rmdir /s /q build

echo.
echo [5/6] Installing frontend dependencies...
npm install --silent

echo.
echo [6/6] Starting services...
echo Starting backend on port 8001...
start "IMIS Backend" cmd /k "cd /d %~dp0backend && python -m uvicorn app.main:app --reload --host 0.0.0.0 --port 8001"

timeout /t 3 >nul

echo Starting frontend on port 5173...
start "IMIS Frontend" cmd /k "cd /d %~dp0frontend && npm run dev"

echo.
echo ========================================
echo IMIS HARD RESTART COMPLETE!
echo ========================================
echo Backend: http://localhost:8001
echo Frontend: http://localhost:5173
echo API Docs: http://localhost:8001/docs
echo ========================================

timeout /t 5 >nul