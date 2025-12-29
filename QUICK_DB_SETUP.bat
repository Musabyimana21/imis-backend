@echo off
title Quick Database Setup
color 0A

echo ========================================
echo Quick Database Setup for IMIS
echo ========================================
echo.

set /p DBPASS="Enter PostgreSQL password: "

echo.
echo Creating IMIS database...
set PGPASSWORD=%DBPASS%
"C:\Program Files\PostgreSQL\18\bin\createdb.exe" -U postgres imis 2>nul
if errorlevel 1 (
    echo Database might already exist, continuing...
)

echo.
echo Installing PostGIS extension...
set PGPASSWORD=%DBPASS%
"C:\Program Files\PostgreSQL\18\bin\psql.exe" -U postgres -d imis -c "CREATE EXTENSION IF NOT EXISTS postgis;"

if errorlevel 1 (
    echo.
    echo ERROR: Could not connect to PostgreSQL
    echo Please check your password
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
echo PostGIS: Installed
echo Configuration: Updated
echo.
echo Now run: START_WITH_DB.bat
echo.
pause
