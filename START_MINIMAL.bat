@echo off
title IMIS Minimal Start

echo IMIS Minimal Start...

:: Kill existing processes
taskkill /f /im python.exe >nul 2>&1
taskkill /f /im node.exe >nul 2>&1

:: Start backend
echo Starting backend...
cd backend
start "Backend" cmd /k "python -m uvicorn app.main:app --port 8001"
timeout /t 2 >nul

:: Start frontend
echo Starting frontend...
cd ..\frontend
start "Frontend" cmd /k "npm run dev"
cd ..

echo.
echo ✅ Services starting...
echo 🌐 Frontend: http://localhost:5173
echo 🔧 Backend: http://localhost:8001
echo.

timeout /t 3 >nul
start http://localhost:5173

echo Done! Check the terminal windows.
pause