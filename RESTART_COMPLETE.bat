@echo off
title IMIS Complete Restart
color 0A

echo ========================================
echo ISHAKIRO IMIS - Complete System Restart
echo ========================================
echo.

REM Step 1: Create database
echo [1/5] Setting up database...
psql -U postgres -d postgres -c "DROP DATABASE IF EXISTS imis;" >nul 2>&1
psql -U postgres -d postgres -c "CREATE DATABASE imis;" >nul 2>&1
echo Database created successfully!
echo.

REM Step 2: Install backend dependencies
echo [2/5] Installing backend dependencies...
cd backend
pip install -r requirements.txt >nul 2>&1
echo Backend dependencies installed!
echo.

REM Step 3: Install frontend dependencies
echo [3/5] Installing frontend dependencies...
cd ..\frontend
call npm install >nul 2>&1
echo Frontend dependencies installed!
echo.

REM Step 4: Seed database
echo [4/5] Seeding database with sample data...
cd ..\backend
python seed_data.py
echo Database seeded!
echo.

REM Step 5: Start services
echo [5/5] Starting services...
echo.
echo Starting Backend (FastAPI) on http://localhost:8000
echo Starting Frontend (SvelteKit) on http://localhost:5173
echo.

REM Start backend in new window
start "IMIS Backend" cmd /k "cd /d %~dp0backend && uvicorn app.main:app --reload --host 0.0.0.0 --port 8000"

REM Wait 3 seconds
timeout /t 3 /nobreak >nul

REM Start frontend in new window
start "IMIS Frontend" cmd /k "cd /d %~dp0frontend && npm run dev"

echo.
echo ========================================
echo System Started Successfully!
echo ========================================
echo.
echo Frontend: http://localhost:5173
echo Backend API: http://localhost:8000
echo API Docs: http://localhost:8000/docs
echo.
echo Test Accounts:
echo   Admin: admin@imis.rw / admin123
echo   User: user1@imis.rw / password123
echo.
echo Press any key to open browser...
pause >nul
start http://localhost:5173
