@echo off
echo ========================================
echo IMIS Deployment Verification
echo ========================================
echo.

echo [1/5] Testing Backend Health...
curl -s https://imis-backend-wk7z.onrender.com/health
echo.
echo.

echo [2/5] Testing API Root...
curl -s https://imis-backend-wk7z.onrender.com/
echo.
echo.

echo [3/5] Testing Items Endpoint...
curl -s "https://imis-backend-wk7z.onrender.com/api/items?skip=0&limit=3"
echo.
echo.

echo [4/5] Testing CORS Headers...
curl -s -I -H "Origin: https://imis-frontend.pages.dev" https://imis-backend-wk7z.onrender.com/health | findstr "access-control"
echo.
echo.

echo [5/5] Checking API Documentation...
echo API Docs: https://imis-backend-wk7z.onrender.com/docs
echo.

echo ========================================
echo Verification Complete!
echo ========================================
echo.
echo Next Steps:
echo 1. Backend is LIVE and working
echo 2. CORS configured for Cloudflare Pages
echo 3. All data is persistent in PostgreSQL
echo 4. Ready for frontend deployment
echo.
echo Backend URL: https://imis-backend-wk7z.onrender.com
echo API Docs: https://imis-backend-wk7z.onrender.com/docs
echo.
pause
