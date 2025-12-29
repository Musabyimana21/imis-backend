@echo off
echo ========================================
echo    RENDER DATABASE CONNECTION TEST
echo ========================================
echo.

cd /d "F:\IMIS\backend"

echo Checking if .env.render exists...
if not exist ".env.render" (
    echo ERROR: .env.render file not found!
    echo Please create .env.render with your Render database URL
    pause
    exit /b 1
)

echo Loading environment variables from .env.render...
for /f "usebackq tokens=1,2 delims==" %%a in (".env.render") do (
    if not "%%a"=="" if not "%%a"=="rem" if not "%%a"=="#" (
        set "%%a=%%b"
    )
)

echo.
echo Testing database connection...
python test_render_db.py

echo.
echo ========================================
if %ERRORLEVEL% EQU 0 (
    echo ✅ SUCCESS: Database connection works!
    echo Your backend should now start properly on Render.
) else (
    echo ❌ FAILED: Database connection failed!
    echo.
    echo TROUBLESHOOTING STEPS:
    echo 1. Check your DATABASE_URL in .env.render
    echo 2. Make sure you copied the INTERNAL Database URL from Render
    echo 3. Verify the database is running in Render dashboard
    echo 4. Check if you set the environment variables correctly in Render
)
echo ========================================
echo.
pause