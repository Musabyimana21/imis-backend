@echo off
echo ========================================
echo   IMIS QUICK DEPLOYMENT GUIDE
echo ========================================
echo.
echo STEP 1: Deploy Backend to Render
echo =====================================
echo 1. Go to https://render.com
echo 2. Sign up with GitHub
echo 3. Click "New +" → "Web Service"
echo 4. Click "Build and deploy from a Git repository"
echo 5. Connect GitHub account
echo 6. Create new repository: imis-backend
echo 7. Upload backend folder contents to GitHub
echo 8. Select the repository in Render
echo 9. Settings:
echo    - Name: imis-backend
echo    - Environment: Python 3
echo    - Build Command: pip install -r requirements.txt
echo    - Start Command: uvicorn app.main:app --host 0.0.0.0 --port $PORT
echo 10. Add Environment Variables (copy from backend/.env)
echo 11. Click "Create Web Service"
echo.
echo STEP 2: Deploy Frontend to Cloudflare
echo =====================================
echo 1. Go to https://dash.cloudflare.com
echo 2. Sign up/Login
echo 3. Go to "Pages"
echo 4. Click "Create a project"
echo 5. Choose "Upload assets"
echo 6. Build frontend first: cd frontend && npm run build
echo 7. Upload the 'build' folder
echo 8. Project name: imis-frontend
echo 9. Click "Deploy site"
echo.
echo STEP 3: Update API URL
echo =====================
echo 1. Get your Render backend URL: https://imis-backend.onrender.com
echo 2. Update frontend/.env with: PUBLIC_API_URL=https://imis-backend.onrender.com
echo 3. Rebuild and redeploy frontend
echo.
echo Your live system will be at:
echo Frontend: https://imis-frontend.pages.dev
echo Backend: https://imis-backend.onrender.com
echo.
pause