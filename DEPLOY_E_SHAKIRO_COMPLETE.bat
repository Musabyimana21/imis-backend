@echo off
echo ========================================
echo DEPLOYING IMIS TO E-SHAKIRO.COM
echo ========================================
echo.

echo STEP 1: BACKEND DEPLOYMENT (RENDER)
echo ========================================
echo 1. Go to https://render.com and create account
echo 2. Connect your GitHub repository
echo 3. Create new Web Service
echo 4. Set Build Command: pip install -r requirements.txt
echo 5. Set Start Command: uvicorn app.main:app --host 0.0.0.0 --port $PORT
echo 6. Set Environment: Python 3.11
echo 7. Add PostgreSQL database addon
echo 8. Copy your backend URL (e.g., https://your-app.onrender.com)
echo.
pause
echo.

echo STEP 2: UPDATE FRONTEND CONFIG
echo ========================================
set /p BACKEND_URL="Enter your Render backend URL: "
echo PUBLIC_API_URL=%BACKEND_URL% > F:\IMIS\frontend\.env.production
echo PUBLIC_FRONTEND_URL=https://e-shakiro.com >> F:\IMIS\frontend\.env.production
echo PUBLIC_ENVIRONMENT=production >> F:\IMIS\frontend\.env.production
echo Frontend config updated!
echo.

echo STEP 3: BUILD FRONTEND
echo ========================================
cd /d F:\IMIS\frontend

echo [1/3] Installing dependencies...
call npm install
if errorlevel 1 (
    echo ERROR: Failed to install dependencies
    pause
    exit /b 1
)

echo.
echo [2/3] Building production frontend...
call npm run build
if errorlevel 1 (
    echo ERROR: Failed to build frontend
    pause
    exit /b 1
)

echo.
echo [3/3] Build completed successfully!
echo.
echo ========================================
echo CPANEL DEPLOYMENT STEPS:
echo ========================================
echo.
echo 1. Login to cPanel: http://e-shakiro.com:2082
echo 2. Go to File Manager
echo 3. Navigate to public_html folder
echo 4. DELETE all existing files in public_html
echo 5. Upload ALL files from: F:\IMIS\frontend\build
echo 6. Upload .htaccess from: F:\IMIS\.htaccess
echo 7. Set permissions: Files=644, Folders=755
echo 8. Test: https://e-shakiro.com
echo.
echo ========================================
echo FILES TO UPLOAD: F:\IMIS\frontend\build
echo ========================================
echo.

explorer F:\IMIS\frontend\build

pause
