@echo off
title ISHAKIRO IMIS - Complete System Startup
color 0A

echo.
echo ========================================
echo   ISHAKIRO INFORMATION MANAGEMENT
echo   Lost ^& Found System for Rwanda
echo ========================================
echo.

REM Kill any existing processes
echo [*] Stopping existing services...
taskkill /F /IM python.exe >nul 2>&1
taskkill /F /IM node.exe >nul 2>&1
timeout /t 2 /nobreak >nul

REM Create database
echo [*] Setting up database...
psql -U postgres -d postgres -c "DROP DATABASE IF EXISTS imis;" >nul 2>&1
psql -U postgres -d postgres -c "CREATE DATABASE imis;" >nul 2>&1
echo     Database ready!

REM Install backend dependencies
echo [*] Installing backend dependencies...
cd backend
pip install -q -r requirements.txt
echo     Backend dependencies installed!

REM Seed database
echo [*] Seeding database with sample data...
python seed_data_auto.py
echo     Database seeded!

REM Install frontend dependencies
echo [*] Installing frontend dependencies...
cd ..\frontend
call npm install >nul 2>&1
echo     Frontend dependencies installed!

echo.
echo ========================================
echo   Starting Services
echo ========================================
echo.

REM Start backend
echo [*] Starting Backend API on http://localhost:8000
cd ..\backend
start "IMIS Backend API" cmd /k "title IMIS Backend API && color 0B && uvicorn app.main:app --reload --host 0.0.0.0 --port 8000"

REM Wait for backend
echo [*] Waiting for backend to start...
timeout /t 5 /nobreak >nul

REM Start frontend
echo [*] Starting Frontend on http://localhost:5173
cd ..\frontend
start "IMIS Frontend" cmd /k "title IMIS Frontend && color 0D && npm run dev"

echo.
echo ========================================
echo   System Started Successfully!
echo ========================================
echo.
echo   Frontend:  http://localhost:5173
echo   Backend:   http://localhost:8000
echo   API Docs:  http://localhost:8000/docs
echo   Health:    http://localhost:8000/health
echo.
echo ========================================
echo   Test Accounts
echo ========================================
echo.
echo   Admin:  admin@imis.rw / admin123
echo   User 1: user1@imis.rw / password123
echo   User 2: user2@imis.rw / password123
echo.
echo ========================================
echo   Features Available
echo ========================================
echo.
echo   [x] Report Lost Items
echo   [x] Report Found Items
echo   [x] AI-Powered Matching
echo   [x] Real-Time Messaging
echo   [x] Mobile Money Payments
echo   [x] Admin Dashboard
echo   [x] Bilingual Support
echo.
echo ========================================
echo.
echo Opening browser in 3 seconds...
timeout /t 3 /nobreak >nul
start http://localhost:5173
echo.
echo System is running! Press any key to stop all services...
pause >nul

REM Stop services
echo.
echo Stopping services...
taskkill /F /IM python.exe >nul 2>&1
taskkill /F /IM node.exe >nul 2>&1
echo Services stopped!
