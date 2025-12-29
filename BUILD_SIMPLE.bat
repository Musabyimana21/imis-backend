@echo off
echo ========================================
echo IMIS - Simple Build Script
echo ========================================

cd frontend

echo Checking Node.js installation...
where node
if %errorlevel% neq 0 (
    echo Node.js not found in PATH. Trying common locations...
    if exist "C:\Program Files\nodejs\npm.cmd" (
        set "PATH=%PATH%;C:\Program Files\nodejs"
        echo Found Node.js in Program Files
    ) else if exist "C:\Program Files (x86)\nodejs\npm.cmd" (
        set "PATH=%PATH%;C:\Program Files (x86)\nodejs"
        echo Found Node.js in Program Files (x86)
    ) else (
        echo Please restart your computer after Node.js installation
        pause
        exit /b 1
    )
)

echo Installing dependencies...
npm install

echo Building project...
npm run build

echo.
echo Build complete! Upload files from frontend\build to cPanel public_html
pause