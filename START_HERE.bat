@echo off
color 0A
title IMIS - Ishakiro Information Management System

:menu
cls
echo.
echo  ========================================================
echo  IMIS - Ishakiro Information Management System
echo  ========================================================
echo.
echo  [1] Start IMIS (Automatic Setup)
echo  [2] Stop IMIS
echo  [3] Test System Health
echo  [4] Create Admin User
echo  [5] View Logs (Docker)
echo  [6] Open Frontend (Browser)
echo  [7] Open API Docs (Browser)
echo  [8] Exit
echo.
echo  ========================================================
echo.

set /p choice="Select option (1-8): "

if "%choice%"=="1" goto start
if "%choice%"=="2" goto stop
if "%choice%"=="3" goto test
if "%choice%"=="4" goto admin
if "%choice%"=="5" goto logs
if "%choice%"=="6" goto frontend
if "%choice%"=="7" goto docs
if "%choice%"=="8" goto exit

echo Invalid choice. Please try again.
timeout /t 2 >nul
goto menu

:start
cls
echo Starting IMIS...
call setup.bat
echo.
echo Press any key to return to menu...
pause >nul
goto menu

:stop
cls
echo Stopping IMIS...
call stop.bat
echo.
echo Press any key to return to menu...
pause >nul
goto menu

:test
cls
call test-system.bat
echo.
echo Press any key to return to menu...
pause >nul
goto menu

:admin
cls
call create-admin.bat
echo.
echo Press any key to return to menu...
pause >nul
goto menu

:logs
cls
echo Viewing Docker logs...
docker-compose logs -f
goto menu

:frontend
cls
echo Opening frontend...
start http://localhost:5173
echo.
echo Press any key to return to menu...
pause >nul
goto menu

:docs
cls
echo Opening API documentation...
start http://localhost:8000/docs
echo.
echo Press any key to return to menu...
pause >nul
goto menu

:exit
cls
echo Thank you for using IMIS!
timeout /t 2 >nul
exit
