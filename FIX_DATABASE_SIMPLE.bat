@echo off
title Fix Database Issues

echo 🔧 Fixing database issues...
echo.

echo Step 1: Testing current connection...
cd backend
python test_db.py
if %errorlevel% equ 0 (
    echo ✅ Database connection is working!
    echo No fixes needed.
    pause
    exit /b 0
)

echo.
echo Step 2: Attempting to reset PostgreSQL password...
cd ..
call RESET_PG18_PASSWORD.bat

echo.
echo Step 3: Testing connection again...
cd backend
python test_db.py
if %errorlevel% equ 0 (
    echo ✅ Database connection fixed!
    echo.
    echo Step 4: Setting up database...
    python setup_db.py
    echo.
    echo Step 5: Initializing tables...
    python init_db.py
    if %errorlevel% equ 0 (
        echo.
        echo 🚀 Database is ready!
        echo You can now run START_SIMPLE.bat
    ) else (
        echo ❌ Table initialization failed
    )
) else (
    echo ❌ Database connection still failing
    echo.
    echo Please check:
    echo 1. PostgreSQL is installed and running
    echo 2. Password is correct (should be: password123)
    echo 3. Database server is accessible
)

echo.
pause