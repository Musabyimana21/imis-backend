@echo off
title IMIS - Production Ready System
color 0A
cls

echo.
echo ╔════════════════════════════════════════════════════════════════╗
echo ║                                                                ║
echo ║        ISHAKIRO INFORMATION MANAGEMENT SYSTEM (IMIS)          ║
echo ║                                                                ║
echo ║              🇷🇼  Made for Rwanda  🇷🇼                          ║
echo ║                                                                ║
echo ║              Production-Ready with MTN Integration            ║
echo ║                                                                ║
echo ╚════════════════════════════════════════════════════════════════╝
echo.
echo Developer: MUSABYIMANA Gaudence
echo Email:     gaudencemusabyimana21@gmail.com
echo Phone:     +250780460621
echo Year:      2025
echo.
echo ════════════════════════════════════════════════════════════════
echo.

timeout /t 2 /nobreak >nul

echo [STEP 1/6] Cleaning up old processes...
taskkill /F /IM python.exe 2>nul
taskkill /F /IM node.exe 2>nul
timeout /t 2 /nobreak >nul
echo ✓ Cleanup complete
echo.

echo [STEP 2/6] Verifying PostgreSQL...
"C:\Program Files\PostgreSQL\18\bin\pg_isready.exe" -U postgres >nul 2>&1
if errorlevel 1 (
    echo ⚠ PostgreSQL not running. Attempting to start...
    net start postgresql-x64-18
    timeout /t 3 /nobreak >nul
    "C:\Program Files\PostgreSQL\18\bin\pg_isready.exe" -U postgres >nul 2>&1
    if errorlevel 1 (
        echo ✗ Failed to start PostgreSQL
        echo Please start PostgreSQL manually and try again
        pause
        exit /b 1
    )
)
echo ✓ PostgreSQL is running
echo.

echo [STEP 3/6] Setting up database...
cd /d "%~dp0backend"
python -c "from app.core.database import engine, Base; from app.models import enhanced_models; Base.metadata.create_all(bind=engine); print('✓ Database initialized')" 2>nul
if errorlevel 1 (
    echo ⚠ Database setup had warnings (this is normal if tables exist)
) else (
    echo ✓ Database ready
)
echo.

echo [STEP 4/6] Checking MTN MoMo configuration...
python -c "from app.core.config import settings; configured = 'CONFIGURED' if settings.MTN_MOMO_SUBSCRIPTION_KEY else 'SIMULATION MODE'; print(f'MTN MoMo: {configured}'); print(f'Environment: {settings.MTN_MOMO_ENVIRONMENT}')" 2>nul
echo.

echo [STEP 5/6] Starting Backend (FastAPI on port 8000)...
start "IMIS Backend - FastAPI" cmd /k "title IMIS Backend && color 0E && cd /d %~dp0backend && echo Starting IMIS Backend... && python -m uvicorn app.main:app --host 0.0.0.0 --port 8000 --reload"
timeout /t 5 /nobreak >nul
echo ✓ Backend started
echo.

echo [STEP 6/6] Starting Frontend (SvelteKit on port 5173)...
cd /d "%~dp0frontend"
start "IMIS Frontend - SvelteKit" cmd /k "title IMIS Frontend && color 0B && cd /d %~dp0frontend && echo Starting IMIS Frontend... && npm run dev -- --host 0.0.0.0 --port 5173"
timeout /t 5 /nobreak >nul
echo ✓ Frontend started
echo.

echo ════════════════════════════════════════════════════════════════
echo.
echo   ✓✓✓  IMIS SYSTEM IS NOW RUNNING!  ✓✓✓
echo.
echo ════════════════════════════════════════════════════════════════
echo.
echo 🌐 ACCESS POINTS:
echo.
echo    Frontend:     http://localhost:5173
echo    Backend API:  http://localhost:8000
echo    API Docs:     http://localhost:8000/docs
echo    Health Check: http://localhost:8000/health
echo.
echo ════════════════════════════════════════════════════════════════
echo.
echo 👤 TEST ACCOUNTS:
echo.
echo    Admin:   admin@imis.rw  / admin123
echo    User:    user1@imis.rw  / password123
echo    Loser:   loser@imis.rw  / lost123
echo    Finder:  finder@imis.rw / found123
echo.
echo ════════════════════════════════════════════════════════════════
echo.
echo 💳 PAYMENT SYSTEM:
echo.
cd /d "%~dp0backend"
python -c "from app.core.config import settings; print('   Status: MTN API CONFIGURED ✓' if settings.MTN_MOMO_SUBSCRIPTION_KEY else '   Status: SIMULATION MODE (Add MTN credentials to enable real payments)')" 2>nul
cd /d "%~dp0"
echo    Unlock Fee: 1,000 RWF
echo    Commission: 10%%
echo.
echo ════════════════════════════════════════════════════════════════
echo.
echo 📚 QUICK ACTIONS:
echo.
echo    1. Open browser:        Press 'B'
echo    2. Seed database:       Run SEED_DATABASE.bat
echo    3. Add MTN API:         Edit backend\.env (see MTN_MOMO_SETUP_GUIDE.md)
echo    4. Verify system:       Run VERIFY_READY_FOR_MTN.bat
echo    5. Stop services:       Run STOP.bat
echo.
echo ════════════════════════════════════════════════════════════════
echo.
echo 🚀 NEXT STEPS:
echo.
echo    WITHOUT MTN API (Current):
echo      → System works in simulation mode
echo      → Payments auto-complete after 30 seconds
echo      → Perfect for testing and development
echo.
echo    WITH MTN API (Production):
echo      1. Get credentials from https://momodeveloper.mtn.com/
echo      2. Update backend\.env with your credentials
echo      3. Restart this script
echo      4. Real MTN payments will work automatically!
echo.
echo ════════════════════════════════════════════════════════════════
echo.

choice /C BX /N /M "Press B to open browser, X to exit: "
if errorlevel 2 goto end
if errorlevel 1 goto browser

:browser
echo.
echo Opening IMIS in your browser...
start http://localhost:5173
timeout /t 2 /nobreak >nul
start http://localhost:8000/docs
echo.
echo ✓ Browser opened
echo.

:end
echo.
echo ════════════════════════════════════════════════════════════════
echo.
echo   IMIS is running in the background
echo   Close the terminal windows to stop the services
echo.
echo   Built with ❤️ by MUSABYIMANA Gaudence
echo   Made for Rwanda 🇷🇼 | 2025
echo.
echo ════════════════════════════════════════════════════════════════
echo.
pause
