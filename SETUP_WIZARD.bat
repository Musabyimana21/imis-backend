@echo off
title IMIS Setup Wizard
color 0A

:menu
cls
echo.
echo  ========================================================
echo  IMIS Setup Wizard
echo  ========================================================
echo.
echo  [1] Check if PostgreSQL is installed
echo  [2] Reset PostgreSQL password
echo  [3] Test database connection
echo  [4] Start IMIS
echo  [5] Help - I'm stuck!
echo  [6] Exit
echo.
echo  ========================================================
echo.

set /p choice="Select option (1-6): "

if "%choice%"=="1" goto check_pg
if "%choice%"=="2" goto reset_pass
if "%choice%"=="3" goto test_db
if "%choice%"=="4" goto start_imis
if "%choice%"=="5" goto help
if "%choice%"=="6" goto exit

echo Invalid choice. Please try again.
timeout /t 2 >nul
goto menu

:check_pg
cls
call CHECK_POSTGRESQL.bat
pause
goto menu

:reset_pass
cls
call RESET_POSTGRESQL_PASSWORD.bat
pause
goto menu

:test_db
cls
call TEST_DATABASE.bat
pause
goto menu

:start_imis
cls
call START_WITH_DB.bat
goto menu

:help
cls
echo.
echo  ========================================================
echo  HELP - Common Issues
echo  ========================================================
echo.
echo  Problem: Don't know if PostgreSQL is installed
echo  Solution: Choose option 1
echo.
echo  Problem: Forgot PostgreSQL password
echo  Solution: Choose option 2 to reset it
echo.
echo  Problem: Password authentication failed
echo  Solution: Choose option 2, then option 3, then option 4
echo.
echo  Problem: Backend won't start
echo  Solution: Make sure options 1, 2, 3 work first
echo.
echo  ========================================================
echo.
pause
goto menu

:exit
cls
echo Thank you for using IMIS Setup Wizard!
timeout /t 2 >nul
exit
