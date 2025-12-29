@echo off
title IMIS - MTN Integration Readiness Check
color 0B

echo ========================================
echo   IMIS MTN INTEGRATION READINESS CHECK
echo ========================================
echo.

set ERRORS=0

echo [1/8] Checking Backend Structure...
if exist "backend\app\services\mtn_momo_service.py" (
    echo ✓ MTN MoMo service found
) else (
    echo ✗ MTN MoMo service missing
    set /a ERRORS+=1
)

echo.
echo [2/8] Checking Configuration Files...
if exist "backend\.env" (
    echo ✓ .env file exists
) else (
    echo ✗ .env file missing
    set /a ERRORS+=1
)

if exist "backend\.env.mtn" (
    echo ✓ .env.mtn template exists
) else (
    echo ✗ .env.mtn template missing
    set /a ERRORS+=1
)

echo.
echo [3/8] Checking Core Config...
if exist "backend\app\core\config.py" (
    echo ✓ Config file exists
    findstr /C:"MTN_MOMO" "backend\app\core\config.py" >nul
    if errorlevel 1 (
        echo ✗ MTN config missing in config.py
        set /a ERRORS+=1
    ) else (
        echo ✓ MTN config present
    )
) else (
    echo ✗ Config file missing
    set /a ERRORS+=1
)

echo.
echo [4/8] Checking Payment Service...
if exist "backend\app\services\payment_service.py" (
    echo ✓ Payment service exists
    findstr /C:"mtn_momo_service" "backend\app\services\payment_service.py" >nul
    if errorlevel 1 (
        echo ✗ MTN integration missing in payment service
        set /a ERRORS+=1
    ) else (
        echo ✓ MTN integration present
    )
) else (
    echo ✗ Payment service missing
    set /a ERRORS+=1
)

echo.
echo [5/8] Checking PostgreSQL...
"C:\Program Files\PostgreSQL\18\bin\pg_isready.exe" -U postgres >nul 2>&1
if errorlevel 1 (
    echo ✗ PostgreSQL not running
    set /a ERRORS+=1
) else (
    echo ✓ PostgreSQL is running
)

echo.
echo [6/8] Checking Python Dependencies...
cd backend
python -c "import requests; import uuid; import json" 2>nul
if errorlevel 1 (
    echo ✗ Required Python packages missing
    set /a ERRORS+=1
) else (
    echo ✓ Python dependencies OK
)
cd ..

echo.
echo [7/8] Checking Documentation...
if exist "MTN_MOMO_SETUP_GUIDE.md" (
    echo ✓ MTN setup guide exists
) else (
    echo ✗ MTN setup guide missing
    set /a ERRORS+=1
)

echo.
echo [8/8] Checking Frontend...
if exist "frontend\package.json" (
    echo ✓ Frontend structure OK
) else (
    echo ✗ Frontend missing
    set /a ERRORS+=1
)

echo.
echo ========================================
if %ERRORS%==0 (
    echo   ✓ ALL CHECKS PASSED!
    echo ========================================
    echo.
    echo Your IMIS system is READY for MTN API!
    echo.
    echo Next Steps:
    echo   1. Get MTN MoMo API credentials
    echo   2. Update backend\.env with credentials
    echo   3. Run COMPLETE_RESTART_CLEAN.bat
    echo   4. Test payment flow
    echo.
    echo Read MTN_MOMO_SETUP_GUIDE.md for details
) else (
    echo   ✗ %ERRORS% ISSUES FOUND
    echo ========================================
    echo.
    echo Please fix the issues above before proceeding
)

echo.
echo Current Configuration Status:
echo.
cd backend
python -c "from app.core.config import settings; print(f'MTN Enabled: {settings.MTN_MOMO_ENABLED}'); print(f'Environment: {settings.MTN_MOMO_ENVIRONMENT}'); print(f'Configured: {\"Yes\" if settings.MTN_MOMO_SUBSCRIPTION_KEY else \"No - Add credentials to .env\"}')" 2>nul
cd ..

echo.
echo ========================================
echo.
pause
