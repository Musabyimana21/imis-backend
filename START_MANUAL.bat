@echo off
color 0A
title IMIS Manual Setup

echo ========================================
echo IMIS Manual Setup (No Docker Required)
echo ========================================
echo.

echo Killing any existing processes...
for /f "tokens=5" %%a in ('netstat -ano ^| findstr ":8001" 2^>nul') do taskkill /F /PID %%a 2>nul
for /f "tokens=5" %%a in ('netstat -ano ^| findstr ":5173" 2^>nul') do taskkill /F /PID %%a 2>nul

echo.
echo Starting Backend...
cd backend
if not exist venv (
    echo Creating Python virtual environment...
    python -m venv venv
)
start "IMIS Backend" cmd /k "venv\Scripts\activate && pip install -q -r requirements.txt && uvicorn app.main:app --reload --port 8001"
cd ..

echo.
echo Starting Frontend...
cd frontend
if not exist node_modules (
    echo Installing Node dependencies...
    call npm install
)
start "IMIS Frontend" cmd /k "npm run dev"
cd ..

echo.
echo Waiting for services to start (15 seconds)...
timeout /t 15 /nobreak >nul

echo.
echo ========================================
echo IMIS is now running!
echo ========================================
echo.
echo Frontend: http://localhost:5173
echo Backend:  http://localhost:8001
echo API Docs: http://localhost:8001/docs
echo.
echo Two new windows opened:
echo - IMIS Backend (port 8001)
echo - IMIS Frontend (port 5173)
echo.
echo Close those windows to stop the services.
echo.
pause
