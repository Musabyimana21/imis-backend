@echo off
title IMIS Basic Start

echo ========================================
echo IMIS Basic Start
echo ========================================
echo.

echo Stopping any running services...
taskkill /f /im python.exe >nul 2>&1
taskkill /f /im node.exe >nul 2>&1

echo.
echo Starting backend...
cd backend
start "IMIS Backend" cmd /k "python main.py"

echo.
echo Starting frontend...
cd ..\frontend
start "IMIS Frontend" cmd /k "npm run dev"
cd ..

echo.
echo IMIS is starting!
echo.
echo Access points:
echo Frontend: http://localhost:5173
echo Backend:  http://localhost:8000
echo.

timeout /t 10
start http://localhost:5173

echo.
echo Done! IMIS should be running now.
echo Check the opened terminal windows.
echo.
pause