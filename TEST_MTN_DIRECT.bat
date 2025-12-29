@echo off
echo ========================================
echo   DIRECT MTN API TESTING WITH CURL
echo ========================================

echo.
echo Step 1: Testing Token Request...
echo ================================

curl -X POST "https://proxy.momoapi.mtn.co.rw/collection/token/" ^
  -H "Authorization: Basic MjRhMTRkN2ItNTdiMi00NmE2LWJhNWMtNGMxN2Y2MjhlYjllOjJhYzkzYzNmNjAzMDRmZGFhNmY5YWQyZjU5MWYwODM0" ^
  -H "Ocp-Apim-Subscription-Key: 92e0ee9794d34ac8bb166d2cd3b99a69" ^
  -H "X-Target-Environment: mtnrwanda" ^
  -v

echo.
echo.
echo Step 2: Testing Payment Request...
echo ==================================
echo (This will likely fail with IP whitelisting error)

curl -X POST "https://proxy.momoapi.mtn.co.rw/collection/v1_0/requesttopay" ^
  -H "Authorization: Bearer REPLACE_WITH_TOKEN_FROM_STEP1" ^
  -H "X-Reference-Id: 12345678-1234-1234-1234-123456789012" ^
  -H "X-Target-Environment: mtnrwanda" ^
  -H "Ocp-Apim-Subscription-Key: 92e0ee9794d34ac8bb166d2cd3b99a69" ^
  -H "Content-Type: application/json" ^
  -d "{\"amount\":\"1000\",\"currency\":\"RWF\",\"externalId\":\"TEST123\",\"payer\":{\"partyIdType\":\"MSISDN\",\"partyId\":\"250788123456\"},\"payerMessage\":\"Test payment\",\"payeeNote\":\"IMIS test\"}" ^
  -v

echo.
echo.
echo Analysis:
echo =========
echo 1. If Step 1 works: Your credentials are valid
echo 2. If Step 2 fails with "Request Rejected": IP whitelisting issue
echo 3. If both fail: Credential or environment issue
echo.
pause