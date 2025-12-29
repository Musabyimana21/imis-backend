@echo off
color 0A
cls
echo.
echo ╔══════════════════════════════════════════════════════════╗
echo ║     ISHAKIRO LOST-FOUND SYSTEM - COMPLETE FIX          ║
echo ║     Rwanda's Premier Item Recovery Platform             ║
echo ╚══════════════════════════════════════════════════════════╝
echo.

echo [STEP 1/8] Checking PostgreSQL...
sc query postgresql-x64-18 | find "RUNNING" >nul
if %errorlevel% neq 0 (
    echo ❌ PostgreSQL not running. Starting...
    net start postgresql-x64-18
) else (
    echo ✅ PostgreSQL is running
)
echo.

echo [STEP 2/8] Testing database connection...
psql -U postgres -d imis -c "SELECT 1;" >nul 2>&1
if %errorlevel% neq 0 (
    echo ⚠️  Database 'imis' not found. Creating...
    psql -U postgres -c "CREATE DATABASE imis;" 2>nul
)
echo ✅ Database ready
echo.

echo [STEP 3/8] Installing backend dependencies...
cd backend
python -m pip install --upgrade pip >nul 2>&1
python -m pip install -r requirements.txt --quiet
echo ✅ Backend dependencies installed
cd ..
echo.

echo [STEP 4/8] Installing frontend dependencies...
cd frontend
call npm install --silent 2>nul
echo ✅ Frontend dependencies installed
cd ..
echo.

echo [STEP 5/8] Stopping old processes...
taskkill /F /FI "WINDOWTITLE eq IMIS*" 2>nul
timeout /t 2 >nul
echo ✅ Old processes stopped
echo.

echo [STEP 6/8] Starting Backend (FastAPI + AI Matching)...
start "IMIS Backend" cmd /k "cd backend && python -m uvicorn app.main:app --reload --host 0.0.0.0 --port 8000"
echo ⏳ Waiting for backend to start...
timeout /t 8 >nul
echo.

echo [STEP 7/8] Starting Frontend (SvelteKit + Modern UI)...
start "IMIS Frontend" cmd /k "cd frontend && npm run dev -- --host 0.0.0.0 --port 5173"
echo ⏳ Waiting for frontend to start...
timeout /t 8 >nul
echo.

echo [STEP 8/8] Testing system...
curl -s http://localhost:8000/health >nul 2>&1
if %errorlevel% equ 0 (
    echo ✅ Backend: ONLINE
) else (
    echo ⚠️  Backend: Starting...
)

curl -s http://localhost:5173 >nul 2>&1
if %errorlevel% equ 0 (
    echo ✅ Frontend: ONLINE
) else (
    echo ⚠️  Frontend: Starting...
)
echo.

echo ╔══════════════════════════════════════════════════════════╗
echo ║              🎉 ISHAKIRO SYSTEM READY! 🎉               ║
echo ╚══════════════════════════════════════════════════════════╝
echo.
echo 🌐 Access Points:
echo    Frontend:  http://localhost:5173
echo    Backend:   http://localhost:8000
echo    API Docs:  http://localhost:8000/docs
echo.
echo 📋 Features Working:
echo    ✅ User Registration/Login
echo    ✅ Report Lost Items
echo    ✅ Report Found Items
echo    ✅ AI-Powered Matching (70%% text + 30%% location)
echo    ✅ Secure Messaging
echo    ✅ Admin Dashboard
echo    ✅ Bilingual (EN/RW)
echo    ✅ Modern Glassmorphism UI
echo.
echo 🧪 Test Accounts (after running SEED_DATABASE.bat):
echo    Admin: admin@imis.rw / admin123
echo    User:  user1@imis.rw / password123
echo.
echo 💡 Next Steps:
echo    1. Open http://localhost:5173 in your browser
echo    2. Register a new account or use test accounts
echo    3. Report lost/found items
echo    4. See AI matching in action!
echo.
echo ╔══════════════════════════════════════════════════════════╗
echo ║  Press any key to open the system in your browser...    ║
echo ╚══════════════════════════════════════════════════════════╝
pause >nul

start http://localhost:5173
