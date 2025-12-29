@echo off
echo ========================================
echo   IMIS Backend Deployment to Render
echo ========================================

cd backend

echo.
echo 1. Installing Git (if not installed)...
where git >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo Git not found. Please install Git first.
    echo Download from: https://git-scm.com/download/win
    pause
    exit /b 1
)

echo.
echo 2. Initializing Git repository...
if not exist .git (
    git init
    git add .
    git commit -m "Initial commit - IMIS Backend"
)

echo.
echo 3. Creating GitHub repository...
echo Please follow these steps:
echo.
echo a) Go to https://github.com/new
echo b) Repository name: imis-backend
echo c) Make it PUBLIC
echo d) Do NOT initialize with README
echo e) Click "Create repository"
echo.
echo f) Copy the repository URL (https://github.com/yourusername/imis-backend.git)
echo.
set /p REPO_URL="Enter your GitHub repository URL: "

echo.
echo 4. Adding remote and pushing...
git remote add origin %REPO_URL%
git branch -M main
git push -u origin main

echo.
echo 5. Now deploy on Render:
echo.
echo a) Go to https://render.com
echo b) Sign up/Login with GitHub
echo c) Click "New +" → "Web Service"
echo d) Connect your GitHub repository: imis-backend
echo e) Use these settings:
echo    - Name: imis-backend
echo    - Environment: Python 3
echo    - Build Command: pip install -r requirements.txt
echo    - Start Command: uvicorn app.main:app --host 0.0.0.0 --port $PORT
echo f) Click "Create Web Service"
echo.
echo Your backend will be available at: https://imis-backend.onrender.com
echo.
pause