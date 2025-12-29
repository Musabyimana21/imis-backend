@echo off
echo ========================================
echo    IMIS - Starting with IP 192.168.61.61
echo ========================================

echo Killing any existing processes...
taskkill /f /im python.exe 2>nul
taskkill /f /im node.exe 2>nul
timeout /t 2 /nobreak >nul

echo Starting Backend on 192.168.61.61:8001...
start "IMIS Backend" cmd /k "cd /d t:\IMIS\backend && pip install -r requirements.txt && uvicorn app.main:app --host 192.168.61.61 --port 8001 --reload"

echo Waiting for backend to start...
timeout /t 5 /nobreak >nul

echo Starting Frontend on 192.168.61.61:5173...
start "IMIS Frontend" cmd /k "cd /d t:\IMIS\frontend && npm install && npm run dev -- --host 192.168.61.61 --port 5173"

echo.
echo ========================================
echo    IMIS Started Successfully!
echo ========================================
echo Frontend: http://192.168.61.61:5173
echo Backend:  http://192.168.61.61:8001
echo API Docs: http://192.168.61.61:8001/docs
echo ========================================

pause