@echo off
title Check PostgreSQL Installation
color 0A

echo ========================================
echo PostgreSQL Installation Check
echo ========================================
echo.

echo Checking if PostgreSQL is installed...
echo.

REM Check PostgreSQL 18
if exist "C:\Program Files\PostgreSQL\18" (
    echo [FOUND] PostgreSQL 18 installed at: C:\Program Files\PostgreSQL\18
    set PG_VERSION=18
    goto :check_service
)

REM Check PostgreSQL 17
if exist "C:\Program Files\PostgreSQL\17" (
    echo [FOUND] PostgreSQL 17 installed at: C:\Program Files\PostgreSQL\17
    set PG_VERSION=17
    goto :check_service
)

REM Check PostgreSQL 16
if exist "C:\Program Files\PostgreSQL\16" (
    echo [FOUND] PostgreSQL 16 installed at: C:\Program Files\PostgreSQL\16
    set PG_VERSION=16
    goto :check_service
)

REM Check PostgreSQL 15
if exist "C:\Program Files\PostgreSQL\15" (
    echo [FOUND] PostgreSQL 15 installed at: C:\Program Files\PostgreSQL\15
    set PG_VERSION=15
    goto :check_service
)

echo [NOT FOUND] PostgreSQL is NOT installed
echo.
echo You need to install PostgreSQL first.
echo Run: INSTALL_POSTGRESQL.bat
echo.
pause
exit /b 1

:check_service
echo.
echo Checking PostgreSQL service...
sc query postgresql-x64-%PG_VERSION% | find "RUNNING" >nul
if %errorlevel% equ 0 (
    echo [RUNNING] PostgreSQL service is running
) else (
    echo [STOPPED] PostgreSQL service is NOT running
    echo.
    echo Starting PostgreSQL service...
    net start postgresql-x64-%PG_VERSION%
)

echo.
echo ========================================
echo PostgreSQL Status
echo ========================================
echo.
echo Installation: FOUND (Version %PG_VERSION%)
echo Location: C:\Program Files\PostgreSQL\%PG_VERSION%
echo Service: Check above
echo.
echo ========================================
echo Password Recovery
echo ========================================
echo.
echo PostgreSQL passwords are encrypted and cannot be revealed.
echo.
echo OPTIONS:
echo.
echo 1. Try common passwords you might have used
echo 2. Check installation notes/emails
echo 3. Reset password (see below)
echo.
echo ========================================
echo Reset Password (if forgotten)
echo ========================================
echo.
echo Step 1: Edit pg_hba.conf
echo   Location: C:\Program Files\PostgreSQL\%PG_VERSION%\data\pg_hba.conf
echo   Change all "md5" to "trust"
echo.
echo Step 2: Restart PostgreSQL
echo   net stop postgresql-x64-%PG_VERSION%
echo   net start postgresql-x64-%PG_VERSION%
echo.
echo Step 3: Connect without password
echo   "C:\Program Files\PostgreSQL\%PG_VERSION%\bin\psql.exe" -U postgres
echo.
echo Step 4: Set new password
echo   ALTER USER postgres PASSWORD 'yournewpassword';
echo   \q
echo.
echo Step 5: Change pg_hba.conf back to "md5"
echo.
echo Step 6: Restart PostgreSQL again
echo.
echo ========================================
echo.
pause
