@echo off
cls
color 0B
title ISHAKIRO IMIS - Master Control

:menu
cls
echo.
echo  ╔════════════════════════════════════════════════════════╗
echo  ║                                                        ║
echo  ║         ISHAKIRO INFORMATION MANAGEMENT SYSTEM         ║
echo  ║              Lost ^& Found Platform for Rwanda          ║
echo  ║                                                        ║
echo  ╚════════════════════════════════════════════════════════╝
echo.
echo  ┌────────────────────────────────────────────────────────┐
echo  │  1. START COMPLETE SYSTEM (Recommended)               │
echo  │  2. TEST ALL FEATURES                                 │
echo  │  3. STOP ALL SERVICES                                 │
echo  │  4. VIEW SYSTEM STATUS                                │
echo  │  5. OPEN FRONTEND                                     │
echo  │  6. OPEN API DOCS                                     │
echo  │  7. RESET DATABASE                                    │
echo  │  8. EXIT                                              │
echo  └────────────────────────────────────────────────────────┘
echo.
set /p choice="  Select option (1-8): "

if "%choice%"=="1" goto start_system
if "%choice%"=="2" goto test_system
if "%choice%"=="3" goto stop_services
if "%choice%"=="4" goto system_status
if "%choice%"=="5" goto open_frontend
if "%choice%"=="6" goto open_docs
if "%choice%"=="7" goto reset_db
if "%choice%"=="8" goto exit

echo  Invalid choice! Press any key to try again...
pause >nul
goto menu

:start_system
cls
echo.
echo  ╔════════════════════════════════════════════════════════╗
echo  ║           STARTING COMPLETE SYSTEM                     ║
echo  ╚════════════════════════════════════════════════════════╝
echo.
call START_EVERYTHING.bat
goto menu

:test_system
cls
echo.
echo  ╔════════════════════════════════════════════════════════╗
echo  ║           TESTING ALL FEATURES                         ║
echo  ╚════════════════════════════════════════════════════════╝
echo.
call TEST_ALL.bat
goto menu

:stop_services
cls
echo.
echo  ╔════════════════════════════════════════════════════════╗
echo  ║           STOPPING ALL SERVICES                        ║
echo  ╚════════════════════════════════════════════════════════╝
echo.
echo  Stopping backend...
taskkill /F /IM python.exe >nul 2>&1
echo  Stopping frontend...
taskkill /F /IM node.exe >nul 2>&1
echo.
echo  All services stopped!
echo.
pause
goto menu

:system_status
cls
echo.
echo  ╔════════════════════════════════════════════════════════╗
echo  ║           SYSTEM STATUS                                ║
echo  ╚════════════════════════════════════════════════════════╝
echo.
echo  Checking services...
echo.

REM Check PostgreSQL
sc query postgresql-x64-18 | find "RUNNING" >nul
if %errorlevel% equ 0 (
    echo  [✓] PostgreSQL: RUNNING
) else (
    echo  [✗] PostgreSQL: STOPPED
)

REM Check Backend
curl -s http://localhost:8000/health >nul 2>&1
if %errorlevel% equ 0 (
    echo  [✓] Backend API: RUNNING on http://localhost:8000
) else (
    echo  [✗] Backend API: STOPPED
)

REM Check Frontend
curl -s http://localhost:5173 >nul 2>&1
if %errorlevel% equ 0 (
    echo  [✓] Frontend: RUNNING on http://localhost:5173
) else (
    echo  [✗] Frontend: STOPPED
)

echo.
echo  ┌────────────────────────────────────────────────────────┐
echo  │  Access Points:                                        │
echo  │  - Frontend:  http://localhost:5173                    │
echo  │  - Backend:   http://localhost:8000                    │
echo  │  - API Docs:  http://localhost:8000/docs               │
echo  │  - Health:    http://localhost:8000/health             │
echo  └────────────────────────────────────────────────────────┘
echo.
echo  ┌────────────────────────────────────────────────────────┐
echo  │  Test Accounts:                                        │
echo  │  - Admin: admin@imis.rw / admin123                     │
echo  │  - User:  user1@imis.rw / password123                  │
echo  └────────────────────────────────────────────────────────┘
echo.
pause
goto menu

:open_frontend
start http://localhost:5173
goto menu

:open_docs
start http://localhost:8000/docs
goto menu

:reset_db
cls
echo.
echo  ╔════════════════════════════════════════════════════════╗
echo  ║           RESET DATABASE                               ║
echo  ╚════════════════════════════════════════════════════════╝
echo.
echo  WARNING: This will delete all data!
echo.
set /p confirm="  Are you sure? (yes/no): "
if not "%confirm%"=="yes" goto menu

echo.
echo  Resetting database...
psql -U postgres -d postgres -c "DROP DATABASE IF EXISTS imis;" >nul 2>&1
psql -U postgres -d postgres -c "CREATE DATABASE imis;" >nul 2>&1
echo  Database reset!
echo.
echo  Seeding with sample data...
cd backend
python seed_data_auto.py
cd ..
echo  Database ready!
echo.
pause
goto menu

:exit
cls
echo.
echo  ╔════════════════════════════════════════════════════════╗
echo  ║           THANK YOU FOR USING ISHAKIRO!                ║
echo  ╚════════════════════════════════════════════════════════╝
echo.
echo  Stopping all services...
taskkill /F /IM python.exe >nul 2>&1
taskkill /F /IM node.exe >nul 2>&1
echo.
echo  Goodbye! 👋
echo.
timeout /t 2 /nobreak >nul
exit
