@echo off
echo ========================================
echo   Starting IMIS on Custom Ports
echo ========================================
echo.
echo Backend: http://localhost:8008
echo Frontend: http://localhost:5178
echo.

REM Update frontend .env
cd frontend
echo PUBLIC_API_URL=http://localhost:8008 > .env
echo [OK] Frontend configured for port 8008 backend

REM Start Backend on port 8008
cd ..\backend
echo.
echo Starting Backend on port 8008...
start "IMIS Backend - Port 8008" cmd /k "python -m uvicorn app.main:app --reload --port 8008 --host 0.0.0.0"

timeout /t 3 /nobreak >nul

REM Start Frontend on port 5178
cd ..\frontend
echo Starting Frontend on port 5178...
start "IMIS Frontend - Port 5178" cmd /k "npm run dev -- --port 5178"

echo.
echo ========================================
echo   IMIS Started Successfully!
echo ========================================
echo.
echo Backend API: http://localhost:8008
echo API Docs: http://localhost:8008/docs
echo Frontend: http://localhost:5178
echo.
echo Login:
echo   Admin: admin@imis.rw / admin123
echo   User: user@imis.rw / user123
echo.
echo Payment works with phones that have balance!
echo Test with: 250789751597
echo.
pause
