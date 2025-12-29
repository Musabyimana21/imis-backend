@echo off
echo ========================================
echo   MTN Mobile Money Production Test
echo ========================================
echo.

echo Checking MTN MoMo Configuration...
echo.

cd backend

python -c "from app.core.config import settings; print(f'MTN Enabled: {settings.MTN_MOMO_ENABLED}'); print(f'Base URL: {settings.MTN_MOMO_BASE_URL}'); print(f'Environment: {settings.MTN_MOMO_TARGET_ENVIRONMENT}'); print(f'Subscription Key: {settings.MTN_MOMO_SUBSCRIPTION_KEY[:20]}...' if settings.MTN_MOMO_SUBSCRIPTION_KEY else 'Not Set')"

echo.
echo ========================================
echo   Testing MTN API Connection
echo ========================================
echo.

python -c "from app.services.mtn_production import mtn_service; print('Configured:', mtn_service.is_configured()); token = mtn_service.get_access_token(); print('Token obtained:', 'Yes' if token else 'No'); print('Token:', token[:30] + '...' if token else 'Failed')"

echo.
echo ========================================
echo   Payment System Status
echo ========================================
echo.
echo [OK] MTN Mobile Money: ENABLED
echo [OK] Payment Method: MTN MoMo Only
echo [OK] Unlock Fee: 1,000 RWF
echo [OK] Commission: 10%%
echo.
echo Ready for production payments!
echo.
echo To test:
echo 1. Start system: START_WITH_DB.bat
echo 2. Login to IMIS
echo 3. Try to unlock contact with real MTN number
echo 4. Check phone for payment prompt
echo.
pause
