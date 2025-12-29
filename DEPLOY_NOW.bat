@echo off
echo ========================================
echo   IMIS INSTANT DEPLOYMENT - 5 MINUTES
echo ========================================

echo.
echo STEP 1: Backend to Render (2 minutes)
echo =====================================
echo 1. Go to: https://render.com
echo 2. Sign up with GitHub
echo 3. Click "New +" → "Web Service"
echo 4. Click "Build and deploy from a Git repository"
echo 5. Connect GitHub and create repository: imis-backend
echo 6. Upload ONLY the backend folder contents to GitHub
echo 7. In Render, select the repository and use:
echo    - Name: imis-backend
echo    - Environment: Python 3
echo    - Build Command: pip install -r requirements.txt
echo    - Start Command: uvicorn app.main:app --host 0.0.0.0 --port $PORT
echo 8. Deploy (takes 2-3 minutes)
echo.
echo STEP 2: Frontend to Cloudflare (2 minutes)
echo ==========================================
echo 1. Go to: https://dash.cloudflare.com/pages
echo 2. Sign up/Login
echo 3. Click "Create a project" → "Upload assets"
echo 4. Drag and drop the frontend/build folder
echo 5. Project name: imis-frontend
echo 6. Deploy (takes 1 minute)
echo.
echo STEP 3: Connect Frontend to Backend (1 minute)
echo ==============================================
echo 1. Get your Render URL: https://imis-backend.onrender.com
echo 2. In Cloudflare Pages, go to Settings → Environment variables
echo 3. Add: PUBLIC_API_URL = https://imis-backend.onrender.com
echo 4. Redeploy
echo.
echo DONE! Your system will be live at:
echo Frontend: https://imis-frontend.pages.dev
echo Backend: https://imis-backend.onrender.com
echo.
echo Test the payment simulation and chat system!
echo.
pause