@echo off
title Install PostgreSQL for IMIS
color 0A

echo ========================================
echo PostgreSQL Installation for IMIS
echo ========================================
echo.

echo Step 1: Download PostgreSQL
echo Opening download page...
start https://www.enterprisedb.com/downloads/postgres-postgresql-downloads
echo.
echo Download PostgreSQL 15 or 16 for Windows x86-64
echo.
pause

echo.
echo Step 2: Install PostgreSQL
echo.
echo IMPORTANT DURING INSTALLATION:
echo   - Remember your password!
echo   - Port: 5432 (default)
echo   - Install Stack Builder: YES
echo   - Install PostGIS extension
echo.
echo Press any key after installation completes...
pause

echo.
echo Step 3: Creating IMIS Database
echo.
set /p PGPASSWORD="Enter PostgreSQL password you set: "

echo Creating database...
"C:\Program Files\PostgreSQL\18\bin\createdb.exe" -U postgres imis 2>nul
if errorlevel 1 (
    "C:\Program Files\PostgreSQL\17\bin\createdb.exe" -U postgres imis 2>nul
)
if errorlevel 1 (
    "C:\Program Files\PostgreSQL\16\bin\createdb.exe" -U postgres imis 2>nul
)
if errorlevel 1 (
    "C:\Program Files\PostgreSQL\15\bin\createdb.exe" -U postgres imis
)

echo Installing PostGIS extension...
"C:\Program Files\PostgreSQL\18\bin\psql.exe" -U postgres -d imis -c "CREATE EXTENSION postgis;" 2>nul
if errorlevel 1 (
    "C:\Program Files\PostgreSQL\17\bin\psql.exe" -U postgres -d imis -c "CREATE EXTENSION postgis;" 2>nul
)
if errorlevel 1 (
    "C:\Program Files\PostgreSQL\16\bin\psql.exe" -U postgres -d imis -c "CREATE EXTENSION postgis;" 2>nul
)
if errorlevel 1 (
    "C:\Program Files\PostgreSQL\15\bin\psql.exe" -U postgres -d imis -c "CREATE EXTENSION postgis;"
)

echo.
echo Step 4: Updating Configuration
cd backend

REM URL-encode @ symbol in password
set "ENCODED_PASSWORD=%PGPASSWORD:@=%%40%"

(
echo DATABASE_URL=postgresql://postgres:%ENCODED_PASSWORD%@localhost:5432/imis
echo SECRET_KEY=dev-secret-key-change-in-production-use-openssl-rand-hex-32
echo ALGORITHM=HS256
echo ACCESS_TOKEN_EXPIRE_MINUTES=30
) > .env

cd ..

echo.
echo ========================================
echo PostgreSQL Setup Complete!
echo ========================================
echo.
echo Database: imis
echo User: postgres
echo Port: 5432
echo PostGIS: Installed
echo.
echo Now run: START_WITH_DB.bat
echo.
pause
