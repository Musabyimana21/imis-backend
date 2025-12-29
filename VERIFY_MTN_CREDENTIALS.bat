@echo off
echo ========================================
echo   MTN MoMo Credentials Verification
echo ========================================
echo.

cd backend

echo Testing MTN API with your credentials...
echo.

python -c "import requests; import base64; subscription_key='92e0ee9794d34ac8bb166d2cd3b99a69'; api_user='24a14d7b-57b2-46a6-ba5c-4c17f628eb9e'; api_key='2ac93c3f60304fdaa6f9ad2f591f0834'; base_url='https://proxy.momoapi.mtn.co.rw'; auth=base64.b64encode(f'{api_user}:{api_key}'.encode()).decode(); headers={'Ocp-Apim-Subscription-Key': subscription_key, 'Authorization': f'Basic {auth}'}; print('Requesting token from MTN...'); r=requests.post(f'{base_url}/collection/token/', headers=headers, timeout=15); print(f'Status: {r.status_code}'); print(f'Response: {r.text[:200]}'); print('SUCCESS - Token obtained!' if r.status_code==200 else 'FAILED - Check credentials')"

echo.
echo ========================================
pause
