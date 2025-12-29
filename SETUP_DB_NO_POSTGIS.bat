@echo off
title Setup Database (No PostGIS)
color 0A

echo ========================================
echo Setup IMIS Database (Without PostGIS)
echo ========================================
echo.

set /p DBPASS="Enter PostgreSQL password: "

echo.
echo Creating IMIS database...
set PGPASSWORD=%DBPASS%
"C:\Program Files\PostgreSQL\18\bin\createdb.exe" -U postgres imis 2>nul
if errorlevel 1 (
    echo Database already exists, continuing...
)

echo.
echo Testing connection...
set PGPASSWORD=%DBPASS%
"C:\Program Files\PostgreSQL\18\bin\psql.exe" -U postgres -d imis -c "SELECT version();"

if errorlevel 1 (
    echo.
    echo ERROR: Could not connect
    pause
    exit /b 1
)

echo.
echo Updating backend configuration...
cd backend

REM URL-encode password
set "ENC_PASS=%DBPASS:@=%%40%"

(
echo DATABASE_URL=postgresql://postgres:%ENC_PASS%@localhost:5432/imis
echo SECRET_KEY=dev-secret-key-change-in-production-use-openssl-rand-hex-32
echo ALGORITHM=HS256
echo ACCESS_TOKEN_EXPIRE_MINUTES=30
) > .env

cd ..

echo.
echo ========================================
echo Database Setup Complete!
echo ========================================
echo.
echo Database: imis
echo PostGIS: Skipped (not needed for basic features)
echo Configuration: Updated
echo.
echo Now run: START_WITH_DB.bat
echo.
pause
