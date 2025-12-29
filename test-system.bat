@echo off
echo ========================================
echo IMIS System Health Check
echo ========================================
echo.

echo Checking Backend...
curl -s http://localhost:8000/health >nul 2>&1
if %errorlevel% equ 0 (
    echo [OK] Backend is running on http://localhost:8000
) else (
    echo [ERROR] Backend is not responding
)

echo.
echo Checking Frontend...
curl -s http://localhost:5173 >nul 2>&1
if %errorlevel% equ 0 (
    echo [OK] Frontend is running on http://localhost:5173
) else (
    echo [ERROR] Frontend is not responding
)

echo.
echo Checking API Documentation...
curl -s http://localhost:8000/docs >nul 2>&1
if %errorlevel% equ 0 (
    echo [OK] API docs available at http://localhost:8000/docs
) else (
    echo [ERROR] API docs not accessible
)

echo.
echo ========================================
echo Health Check Complete
echo ========================================
pause
