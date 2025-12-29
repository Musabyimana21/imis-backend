@echo off
title Test IMIS Backend

echo Testing IMIS Backend...
echo.

cd backend

echo Checking Python imports...
python -c "from app.main import app; print('Backend imports OK')"
if %errorlevel% neq 0 (
    echo Error: Backend import failed!
    pause
    exit /b 1
)

echo.
echo Checking database connection...
python -c "from app.core.database import engine; engine.connect(); print('Database connection OK')"
if %errorlevel% neq 0 (
    echo Warning: Database connection failed - make sure PostgreSQL is running
    echo You can run: CHECK_POSTGRESQL.bat
)

echo.
echo Backend test complete!
echo You can now run: START_SIMPLE.bat
pause