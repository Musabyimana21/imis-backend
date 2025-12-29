@echo off
echo ========================================
echo DEPLOY E-SHAKIRO.COM - UPDATED CONFIG
echo ========================================
echo.

echo [STEP 1] Configuration Updated:
echo ✅ Frontend: wrangler.toml updated for e-shakiro.com
echo ✅ Backend: CORS updated to allow e-shakiro.com
echo ✅ Environment: Production settings configured
echo.

echo [STEP 2] Current Deployment Status:
echo - Backend: https://imis-backend-wk7z.onrender.com (LIVE)
echo - Frontend: https://imis-frontend.pages.dev (LIVE)
echo - Target: https://e-shakiro.com (READY TO CONFIGURE)
echo.

echo [STEP 3] Next Actions Required:
echo.
echo 1. CLOUDFLARE PAGES SETUP:
echo    - Go to: https://dash.cloudflare.com
echo    - Navigate to Workers & Pages
echo    - Click on 'imis-frontend' project
echo    - Go to Custom domains tab
echo    - Add: e-shakiro.com
echo.
echo 2. DNS CONFIGURATION:
echo    - Point e-shakiro.com to Cloudflare
echo    - Or add CNAME: e-shakiro.com → imis-frontend.pages.dev
echo.
echo 3. BACKEND DEPLOYMENT:
echo    - Push updated CORS settings to GitHub
echo    - Render will auto-deploy the backend
echo.

echo [STEP 4] Verification:
echo After DNS setup, test:
echo - https://e-shakiro.com (should load your site)
echo - Check browser console for CORS errors
echo - Test all functionality
echo.

echo ========================================
echo CONFIGURATION READY FOR E-SHAKIRO.COM!
echo ========================================
echo.
echo Files updated:
echo - frontend/wrangler.toml
echo - frontend/.env.production  
echo - backend/app/main.py
echo.
echo Next: Follow the Cloudflare Pages custom domain setup
echo Guide: E_SHAKIRO_DOMAIN_SETUP.md
echo.
pause