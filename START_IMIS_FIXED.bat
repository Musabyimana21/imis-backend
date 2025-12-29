@echo off
echo STARTING IMIS WITH CORS FIX
echo ===========================

echo 1. Starting backend on port 8001...
start "IMIS Backend" cmd /k "cd backend && python -m uvicorn app.main:app --reload --host 0.0.0.0 --port 8001"

echo 2. Waiting for backend to start...
timeout /t 5 /nobreak > nul

echo 3. Starting frontend...
start "IMIS Frontend" cmd /k "cd frontend && npm run dev"

echo.
echo ===========================
echo IMIS STARTED!
echo ===========================
echo Backend:  http://localhost:8001
echo Frontend: http://localhost:5173 or http://localhost:5174
echo.
echo Both services are running in separate windows.
echo Close those windows to stop the services.
echo.
pause