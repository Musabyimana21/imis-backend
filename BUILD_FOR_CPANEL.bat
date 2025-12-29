@echo off
echo ========================================
echo IMIS - cPanel Deployment Builder
echo ========================================
echo.

echo Checking for Node.js...
npm --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Node.js/npm not found!
    echo Please install Node.js from: https://nodejs.org/
    echo Then run this script again.
    echo.
    echo OR if you already have a build folder, skip to upload step.
    goto :upload_instructions
)

echo Step 1: Building Frontend...
cd frontend
call npm install
call npm run build
cd ..

:upload_instructions

echo.
echo ========================================
echo BUILD COMPLETE!
echo ========================================
echo.
echo Next Steps:
echo 1. Go to cPanel File Manager: http://e-shakiro.com:2082
echo 2. Navigate to public_html folder
echo 3. Delete all existing files
echo 4. Upload ALL files from: frontend\build folder
echo 5. Upload .htaccess file from root folder
echo.
echo Your frontend will be live at: https://e-shakiro.com
echo.
pause
