@echo off
echo ========================================
echo   DEPLOYING IMIS TO CLOUDFLARE PAGES
echo ========================================
echo.

cd frontend

echo [1/4] Installing dependencies...
call npm install
if errorlevel 1 (
    echo ERROR: npm install failed
    pause
    exit /b 1
)

echo.
echo [2/4] Building production bundle...
call npm run build
if errorlevel 1 (
    echo ERROR: Build failed
    pause
    exit /b 1
)

echo.
echo [3/4] Installing Wrangler CLI...
call npm install -g wrangler

echo.
echo [4/4] Deploying to Cloudflare Pages...
echo.
echo IMPORTANT: You'll need to login to Cloudflare first
echo.
pause

call wrangler pages deploy build --project-name=imis-frontend

echo.
echo ========================================
echo   DEPLOYMENT COMPLETE!
echo ========================================
echo.
echo Your site is now live on Cloudflare Pages
echo.
echo Next steps:
echo 1. Go to Cloudflare Dashboard
echo 2. Pages -^> imis-frontend -^> Custom domains
echo 3. Add: ishakiro.ac.rw
echo.
pause
