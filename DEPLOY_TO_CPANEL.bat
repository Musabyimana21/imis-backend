@echo off
echo ========================================
echo IMIS - cPanel Deployment for e-shakiro.com
echo ========================================
echo.

echo Step 1: Setting up Node.js PATH...
set PATH=%PATH%;"C:\Program Files\nodejs"

echo Step 2: Checking Node.js installation...
node --version
if %errorlevel% neq 0 (
    echo ERROR: Node.js not found!
    echo Please ensure Node.js is installed at: C:\Program Files\nodejs
    pause
    exit /b 1
)

echo Step 3: Building Frontend for Production...
cd frontend

echo Installing dependencies...
"C:\Program Files\nodejs\npm.cmd" install
if %errorlevel% neq 0 (
    echo ERROR: Failed to install dependencies!
    pause
    exit /b 1
)

echo Building for production...
"C:\Program Files\nodejs\npm.cmd" run build
if %errorlevel% neq 0 (
    echo ERROR: Build failed!
    pause
    exit /b 1
)

cd ..

echo.
echo ========================================
echo BUILD COMPLETE!
echo ========================================
echo.
echo Your frontend is now ready for cPanel deployment!
echo.
echo DEPLOYMENT INSTRUCTIONS:
echo ========================================
echo.
echo 1. LOGIN TO CPANEL:
echo    URL: http://e-shakiro.com:2082
echo    OR:  http://31.170.162.103:2082
echo.
echo 2. OPEN FILE MANAGER:
echo    - Click "File Manager" in Files section
echo    - Navigate to "public_html" folder
echo.
echo 3. CLEAR EXISTING FILES:
echo    - Select all files in public_html
echo    - Delete them (keep .htaccess if exists)
echo.
echo 4. UPLOAD FRONTEND FILES:
echo    - Upload ALL files from: frontend\build folder
echo    - Upload .htaccess from root folder
echo.
echo 5. SET PERMISSIONS:
echo    - Select all uploaded files
echo    - Set permissions to 644 for files, 755 for folders
echo.
echo 6. TEST YOUR SITE:
echo    - Visit: https://e-shakiro.com
echo    - Test registration and login
echo.
echo BACKEND DEPLOYMENT:
echo ========================================
echo.
echo Your backend needs to be deployed to Render.com:
echo 1. Go to https://render.com
echo 2. Create account and connect GitHub
echo 3. Create PostgreSQL database (free tier)
echo 4. Create Web Service with these settings:
echo    - Build Command: pip install -r backend/requirements.txt
echo    - Start Command: cd backend && gunicorn app.main:app -w 4 -k uvicorn.workers.UvicornWorker --bind 0.0.0.0:$PORT
echo.
echo 5. Add environment variables:
echo    - DATABASE_URL (from PostgreSQL service)
echo    - SECRET_KEY (generate random string)
echo    - MTN_API_USER, MTN_API_KEY, MTN_SUBSCRIPTION_KEY
echo.
echo 6. Update frontend/.env.production with your backend URL
echo 7. Rebuild and re-upload frontend
echo.
echo ========================================
echo DEPLOYMENT READY!
echo ========================================
echo.
pause