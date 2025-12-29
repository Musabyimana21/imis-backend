@echo off
title IMIS - Complete System Restart
color 0A

echo ========================================
echo   IMIS COMPLETE SYSTEM RESTART
echo   Ishakiro Information Management System
echo ========================================
echo.

echo [1/5] Stopping all running services...
taskkill /F /IM python.exe 2>nul
taskkill /F /IM node.exe 2>nul
timeout /t 2 /nobreak >nul
echo ✓ All services stopped

echo.
echo [2/5] Checking PostgreSQL...
"C:\Program Files\PostgreSQL\18\bin\pg_isready.exe" -U postgres >nul 2>&1
if errorlevel 1 (
    echo ✗ PostgreSQL not running. Starting...
    net start postgresql-x64-18
    timeout /t 3 /nobreak >nul
)
echo ✓ PostgreSQL is ready

echo.
echo [3/5] Setting up database...
cd /d "%~dp0backend"
python -c "from app.core.database import engine, Base; from app.models import enhanced_models; Base.metadata.create_all(bind=engine); print('✓ Database tables created')"

echo.
echo [4/5] Starting Backend (FastAPI)...
start "IMIS Backend" cmd /k "cd /d %~dp0backend && python -m uvicorn app.main:app --host 0.0.0.0 --port 8001 --reload"
timeout /t 5 /nobreak >nul
echo ✓ Backend started on http://localhost:8001

echo.
echo [5/5] Starting Frontend (SvelteKit)...
cd /d "%~dp0frontend"
start "IMIS Frontend" cmd /k "cd /d %~dp0frontend && npm run dev -- --host 0.0.0.0 --port 5173"
timeout /t 5 /nobreak >nul
echo ✓ Frontend started on http://localhost:5173

echo.
echo ========================================
echo   ✓ IMIS SYSTEM READY!
echo ========================================
echo.
echo Access Points:
echo   Frontend:  http://localhost:5173
echo   Backend:   http://localhost:8001
echo   API Docs:  http://localhost:8001/docs
echo   Health:    http://localhost:8001/health
echo.
echo Test Accounts:
echo   Admin:  admin@imis.rw / admin123
echo   User:   user1@imis.rw / password123
echo.
echo Next Steps:
echo   1. Open http://localhost:5173 in browser
echo   2. Add MTN API credentials to backend\.env
echo   3. Test payment system
echo.
echo Press any key to open browser...
pause >nul
start http://localhost:5173
start http://localhost:8001/docs
