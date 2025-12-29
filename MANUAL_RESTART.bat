@echo off
echo MANUAL RESTART - IMIS SYSTEM
echo =============================

REM Force kill all processes first
call FORCE_KILL.bat

echo.
echo Starting backend on port 8001...
cd backend
start "IMIS Backend" cmd /k "python -m uvicorn app.main:app --reload --host 0.0.0.0 --port 8001"

echo Waiting for backend to start...
timeout /t 8 /nobreak >nul

echo.
echo Starting frontend...
cd ..\frontend
start "IMIS Frontend" cmd /k "npm run dev"

echo.
echo =============================
echo [OK] MANUAL RESTART COMPLETE
echo =============================
echo Frontend: http://localhost:5173
echo Backend:  http://localhost:8001
echo API Docs: http://localhost:8001/docs
echo.
echo Both services starting in separate windows...