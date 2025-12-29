@echo off
echo ========================================
echo COMPLETE FIX - KILLING ALL AND RESTART
echo ========================================

echo Killing all Python and Node processes...
taskkill /f /im python.exe 2>nul
taskkill /f /im node.exe 2>nul

echo Waiting 3 seconds...
timeout /t 3 /nobreak >nul

echo Starting Backend on Port 8003...
cd backend
start "Backend" cmd /k "python -m uvicorn app.main:app --reload --host 0.0.0.0 --port 8003"

echo Waiting 5 seconds for backend...
timeout /t 5 /nobreak >nul

echo Starting Frontend...
cd ..\frontend
start "Frontend" cmd /k "npm run dev -- --port 5175"

echo ========================================
echo SYSTEM RESTARTED ON NEW PORTS:
echo Frontend: http://localhost:5175
echo Backend:  http://localhost:8003
echo Test:     http://localhost:5175/report-lost
echo ========================================
pause