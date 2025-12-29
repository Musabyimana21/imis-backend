@echo off
title IMIS Reliable Start
setlocal enabledelayedexpansion

echo Starting IMIS (Reliable Mode)...
echo.

echo Step 1: Cleanup...
taskkill /f /im python.exe >nul 2>&1
taskkill /f /im node.exe >nul 2>&1
timeout /t 1 >nul

echo Step 2: Checking backend...
if not exist backend\app\main.py (
    echo ERROR: Backend not found!
    pause
    exit /b 1
)

cd backend

echo Step 3: Quick dependency check...
echo Checking essential packages...
python -c "import fastapi, uvicorn" >nul 2>&1
if %errorlevel% neq 0 (
    echo Installing core packages...
    pip install fastapi uvicorn --no-cache-dir --timeout 30
)

echo Step 4: Database test (timeout 10s)...
timeout 10 python test_db.py >nul 2>&1
if %errorlevel% neq 0 (
    echo Database issue - trying quick setup...
    timeout 15 python setup_db.py >nul 2>&1
    timeout 15 python init_db.py >nul 2>&1
)

echo Step 5: Starting backend (port 8001)...
start "IMIS-Backend" cmd /k "python -m uvicorn app.main:app --host 0.0.0.0 --port 8001 --reload"
timeout /t 2 >nul

echo Step 6: Frontend check...
cd ..
if exist frontend\package.json (
    cd frontend
    echo Starting frontend...
    start "IMIS-Frontend" cmd /k "npm run dev -- --port 5173"
    cd ..
)

echo.
echo ✅ IMIS Started!
echo 🌐 Frontend: http://localhost:5173
echo 🔧 Backend: http://localhost:8001
echo 📚 API Docs: http://localhost:8001/docs
echo.
echo Press any key to open browser...
pause >nul
start http://localhost:5173