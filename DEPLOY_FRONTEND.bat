@echo off
echo ========================================
echo   IMIS Frontend Deployment to Cloudflare
echo ========================================

cd frontend

echo.
echo 1. Installing dependencies...
call npm install

echo.
echo 2. Building for production...
call npm run build

echo.
echo 3. Installing Wrangler CLI...
call npm install -g wrangler

echo.
echo 4. Setting up Cloudflare Pages...
echo.
echo Please follow these steps:
echo.
echo a) Go to https://dash.cloudflare.com
echo b) Sign up/Login
echo c) Go to "Pages" in the sidebar
echo d) Click "Create a project"
echo e) Choose "Upload assets"
echo f) Upload the 'build' folder from this directory
echo g) Project name: imis-frontend
echo h) Click "Deploy site"
echo.
echo Alternative method (GitHub):
echo a) Push frontend to GitHub repository
echo b) Connect GitHub to Cloudflare Pages
echo c) Select repository and deploy
echo.
echo Your frontend will be available at: https://imis-frontend.pages.dev
echo.
pause