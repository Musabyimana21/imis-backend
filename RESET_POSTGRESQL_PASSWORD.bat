@echo off
title Reset PostgreSQL Password
color 0C

echo ========================================
echo Reset PostgreSQL Password
echo ========================================
echo.
echo WARNING: This will temporarily disable password authentication
echo.
pause

REM Detect PostgreSQL version
if exist "C:\Program Files\PostgreSQL\18" set PG_VERSION=18
if exist "C:\Program Files\PostgreSQL\17" set PG_VERSION=17
if exist "C:\Program Files\PostgreSQL\16" set PG_VERSION=16
if exist "C:\Program Files\PostgreSQL\15" set PG_VERSION=15

if not defined PG_VERSION (
    echo PostgreSQL not found!
    pause
    exit /b 1
)

set PG_PATH=C:\Program Files\PostgreSQL\%PG_VERSION%
set PG_DATA=%PG_PATH%\data

echo.
echo Step 1: Backing up pg_hba.conf...
copy "%PG_DATA%\pg_hba.conf" "%PG_DATA%\pg_hba.conf.backup"

echo.
echo Step 2: Modifying pg_hba.conf to allow trust authentication...
powershell -Command "(Get-Content '%PG_DATA%\pg_hba.conf') -replace 'md5', 'trust' | Set-Content '%PG_DATA%\pg_hba.conf'"

echo.
echo Step 3: Restarting PostgreSQL...
net stop postgresql-x64-%PG_VERSION%
timeout /t 2 /nobreak >nul
net start postgresql-x64-%PG_VERSION%
timeout /t 3 /nobreak >nul

echo.
echo Step 4: Setting new password...
set /p NEW_PASSWORD="Enter new password for postgres user: "

echo ALTER USER postgres PASSWORD '%NEW_PASSWORD%'; | "%PG_PATH%\bin\psql.exe" -U postgres -d postgres

echo.
echo Step 5: Restoring pg_hba.conf...
copy "%PG_DATA%\pg_hba.conf.backup" "%PG_DATA%\pg_hba.conf" /Y

echo.
echo Step 6: Restarting PostgreSQL with password authentication...
net stop postgresql-x64-%PG_VERSION%
timeout /t 2 /nobreak >nul
net start postgresql-x64-%PG_VERSION%

echo.
echo ========================================
echo Password Reset Complete!
echo ========================================
echo.
echo New password: %NEW_PASSWORD%
echo.
echo Now run: TEST_DATABASE.bat
echo Enter this password when asked.
echo.
pause
