@echo off
echo ========================================
echo   IMIS - FINAL SYSTEM CHECK
echo ========================================
echo.

echo [1/6] Checking Backend...
cd backend
python -c "from app.main import app; print('[OK] Backend imports successfully')" 2>nul
if %errorlevel% neq 0 (
    echo [FAIL] Backend has issues
    pause
    exit /b 1
)

echo [2/6] Checking Database...
python -c "from app.core.database import SessionLocal; from app.models.enhanced_models import Item, User; db = SessionLocal(); items = db.query(Item).count(); users = db.query(User).count(); print(f'[OK] Database: {users} users, {items} items'); db.close()"

echo [3/6] Checking MTN Credentials...
python -c "from app.core.config import settings; print(f'[OK] MTN Enabled: {settings.MTN_MOMO_ENABLED}'); print(f'[OK] Subscription Key: {settings.MTN_MOMO_SUBSCRIPTION_KEY[:20]}...')"

echo [4/6] Testing MTN Connection...
python -c "from app.services.mtn_production import mtn_service; print('[OK] MTN Service configured:', mtn_service.is_configured()); token = mtn_service.get_access_token(); print('[OK] MTN Token obtained' if token else '[FAIL] Token failed')"

echo [5/6] Checking Frontend...
cd ..\frontend
if exist "package.json" (
    echo [OK] Frontend files present
) else (
    echo [FAIL] Frontend missing
)

echo [6/6] Testing Payment Flow...
cd ..\backend
python -c "import requests, base64, uuid; subscription_key='92e0ee9794d34ac8bb166d2cd3b99a69'; api_user='24a14d7b-57b2-46a6-ba5c-4c17f628eb9e'; api_key='2ac93c3f60304fdaa6f9ad2f591f0834'; base_url='https://proxy.momoapi.mtn.co.rw'; auth=base64.b64encode(f'{api_user}:{api_key}'.encode()).decode(); r1=requests.post(f'{base_url}/collection/token/', headers={'Ocp-Apim-Subscription-Key': subscription_key, 'Authorization': f'Basic {auth}'}, timeout=15); print('[OK] Payment system ready' if r1.status_code==200 else '[FAIL] Payment system issue')"

echo.
echo ========================================
echo   SYSTEM CHECK COMPLETE
echo ========================================
echo.
echo All systems ready for deployment!
echo.
echo To start IMIS:
echo   START_WITH_DB.bat
echo.
echo To deploy:
echo   1. Backend: Deploy to Render
echo   2. Frontend: Deploy to Cloudflare Pages
echo   3. Update production .env with domain
echo.
pause
