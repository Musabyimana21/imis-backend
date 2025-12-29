@echo off
title Test PostgreSQL Connection
color 0A

echo ========================================
echo Test PostgreSQL Connection
echo ========================================
echo.

set /p PGPASS="Enter your PostgreSQL password: "
set PGPASSWORD=%PGPASS%

echo.
echo Testing connection...
set PGPASSWORD=%PGPASS%
"C:\Program Files\PostgreSQL\18\bin\psql.exe" -U postgres -d postgres -c "SELECT version();"
if errorlevel 1 (
    "C:\Program Files\PostgreSQL\17\bin\psql.exe" -U postgres -d postgres -c "SELECT version();" 2>nul
)
if errorlevel 1 (
    "C:\Program Files\PostgreSQL\16\bin\psql.exe" -U postgres -d postgres -c "SELECT version();" 2>nul
)
if errorlevel 1 (
    "C:\Program Files\PostgreSQL\15\bin\psql.exe" -U postgres -d postgres -c "SELECT version();"
)

if errorlevel 1 (
    echo.
    echo ERROR: Cannot connect to PostgreSQL
    echo.
    echo Possible issues:
    echo   1. PostgreSQL not installed
    echo   2. Wrong password
    echo   3. PostgreSQL service not running
    echo.
    echo Check PostgreSQL service in services.msc
    pause
    exit /b 1
)

echo.
echo SUCCESS! PostgreSQL is working.
echo.
echo Now updating backend\.env with correct password...

cd backend

REM Escape special characters for URL
set "ENCODED_PASSWORD=%PGPASS%"
set "ENCODED_PASSWORD=%ENCODED_PASSWORD:@=%%40%"
set "ENCODED_PASSWORD=%ENCODED_PASSWORD:#=%%23%"
set "ENCODED_PASSWORD=%ENCODED_PASSWORD::=%%3A%"
set "ENCODED_PASSWORD=%ENCODED_PASSWORD:/=%%2F%"

(
echo DATABASE_URL=postgresql://postgres:%ENCODED_PASSWORD%@localhost:5432/imis
echo SECRET_KEY=dev-secret-key-change-in-production-use-openssl-rand-hex-32
echo ALGORITHM=HS256
echo ACCESS_TOKEN_EXPIRE_MINUTES=30
) > .env

cd ..

echo.
echo Configuration updated!
echo.
echo Now run: START_WITH_DB.bat
echo.
pause
