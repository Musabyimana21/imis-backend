@echo off
title Fix Port Issue & Start IMIS
echo Fixing port conflict and starting IMIS...

echo Step 1: Kill any existing processes...
taskkill /f /im python.exe >nul 2>&1
taskkill /f /im node.exe >nul 2>&1
timeout /t 2 >nul

echo Step 2: Starting backend on port 8001...
cd backend
start "IMIS-Backend" cmd /k "python -m uvicorn app.main:app --host 0.0.0.0 --port 8001 --reload"
timeout /t 3 >nul

echo Step 3: Starting frontend...
cd ..\frontend
start "IMIS-Frontend" cmd /k "npm run dev -- --port 5173"

echo.
echo ✅ IMIS Fixed and Started!
echo 🌐 Frontend: http://localhost:5173
echo 🔧 Backend: http://localhost:8001
echo 📚 API Docs: http://localhost:8001/docs
echo.
echo Waiting 5 seconds then opening browser...
timeout /t 5 >nul
start http://localhost:5173

echo.
echo If you still get "Failed to fetch" error:
echo 1. Wait 10 more seconds for backend to fully start
echo 2. Check that both terminals opened successfully
echo 3. Try refreshing the browser
pause