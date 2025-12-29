@echo off
echo ========================================
echo COMPLETE RESTART - KILLING EVERYTHING
echo ========================================

echo Killing all processes...
taskkill /f /im python.exe 2>nul
taskkill /f /im node.exe 2>nul

echo Waiting 5 seconds...
timeout /t 5 /nobreak >nul

echo Starting Backend on Port 9002...
cd /d T:\IMIS
start "IMIS Backend" cmd /k "python simple_backend.py"

echo Waiting 5 seconds for backend...
timeout /t 5 /nobreak >nul

echo Starting Frontend...
cd /d T:\IMIS\frontend
start "IMIS Frontend" cmd /k "npm run dev"

echo Waiting 10 seconds for frontend...
timeout /t 10 /nobreak >nul

echo ========================================
echo ✅ SYSTEM RESTARTED!
echo ========================================
echo Frontend: http://localhost:5173 or http://localhost:5174
echo Backend:  http://localhost:9002
echo.
echo Check the opened windows for actual ports!
pause