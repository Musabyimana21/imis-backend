@echo off
cls
echo.
echo ========================================
echo    ISHAKIRO - COMPLETE SYSTEM STARTUP
echo ========================================
echo.
echo 🚀 Starting Complete Lost & Found System for Rwanda
echo.

REM Check if Python is installed
python --version >nul 2>&1
if errorlevel 1 (
    echo ❌ Python is not installed or not in PATH
    echo Please install Python 3.8+ from https://python.org
    pause
    exit /b 1
)

REM Check if Node.js is installed
node --version >nul 2>&1
if errorlevel 1 (
    echo ❌ Node.js is not installed or not in PATH
    echo Please install Node.js from https://nodejs.org
    pause
    exit /b 1
)

REM Check PostgreSQL
echo 🔍 Checking PostgreSQL...
pg_isready -h localhost -p 5432 >nul 2>&1
if errorlevel 1 (
    echo ❌ PostgreSQL is not running
    echo Please start PostgreSQL service or run SETUP_WIZARD.bat
    pause
    exit /b 1
)

echo ✅ PostgreSQL is running

REM Install backend dependencies
echo.
echo 📦 Installing backend dependencies...
cd backend
if not exist "venv" (
    echo Creating virtual environment...
    python -m venv venv
)

call venv\Scripts\activate
pip install -r requirements.txt

REM Install frontend dependencies
echo.
echo 📦 Installing frontend dependencies...
cd ..\frontend
if not exist "node_modules" (
    echo Installing Node.js packages...
    npm install
)

REM Create enhanced seed data
echo.
echo 🌱 Creating enhanced seed data...
cd ..\backend
call venv\Scripts\activate
python enhanced_seed_data.py

REM Start backend in new window
echo.
echo 🔧 Starting backend server...
start "IMIS Backend" cmd /k "cd /d %cd% && call venv\Scripts\activate && echo ✅ Backend starting on http://localhost:8000 && echo 📚 API Docs: http://localhost:8000/docs && echo. && uvicorn app.main:app --reload --host 0.0.0.0 --port 8000"

REM Wait a moment for backend to start
timeout /t 3 /nobreak >nul

REM Start frontend in new window
echo 🎨 Starting frontend server...
cd ..\frontend
start "IMIS Frontend" cmd /k "cd /d %cd% && echo ✅ Frontend starting on http://localhost:5173 && echo 🌐 Opening browser in 10 seconds... && echo. && npm run dev"

REM Wait for services to start
echo.
echo ⏳ Waiting for services to start...
timeout /t 10 /nobreak >nul

REM Open browser
echo 🌐 Opening browser...
start http://localhost:5173

echo.
echo ========================================
echo    🎉 SYSTEM STARTED SUCCESSFULLY!
echo ========================================
echo.
echo 📍 Access Points:
echo    Frontend:  http://localhost:5173
echo    Backend:   http://localhost:8000  
echo    API Docs:  http://localhost:8000/docs
echo    Health:    http://localhost:8000/health
echo.
echo 🔐 Test Credentials:
echo    Admin:     admin@imis.rw / admin123
echo    Loser:     loser@imis.rw / lost123
echo    Finder:    finder@imis.rw / found123
echo    User:      user1@imis.rw / password123
echo.
echo 🧪 Test Scenario:
echo    1. Login as 'loser' and report a lost item
echo    2. Login as 'finder' and report a found item  
echo    3. See AI matching in action (70%% text + 30%% location)
echo    4. Test messaging between users
echo    5. Test payment system (1,000 RWF to unlock contact)
echo    6. Use admin dashboard for system management
echo.
echo 💡 Features Available:
echo    ✅ AI-Powered Matching
echo    ✅ Real-Time Messaging  
echo    ✅ Mobile Money Payments (MTN MoMo, Airtel Money)
echo    ✅ Commission Tracking (10%%)
echo    ✅ Admin Dashboard
echo    ✅ Bilingual Support (EN/RW)
echo    ✅ WCAG Accessibility
echo    ✅ Production Ready
echo.
echo 🛑 To stop services: Close the terminal windows or run STOP.bat
echo.
pause