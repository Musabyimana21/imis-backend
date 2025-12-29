@echo off
echo ╔═══════════════════════════════════════════════════════════════════╗
echo ║                    🚀 START IMIS (CLEAN)                          ║
echo ║                                                                   ║
echo ║  This will start IMIS with a clean database                      ║
echo ╚═══════════════════════════════════════════════════════════════════╝
echo.

echo 🔄 Step 1: Resetting database...
call RESET_DATABASE.bat

echo.
echo 🚀 Step 2: Starting IMIS...
call START_WITH_DB.bat

echo.
echo 📊 Step 3: Adding sample data...
timeout /t 5 /nobreak >nul
call SEED_DATABASE.bat

echo.
echo ✅ IMIS started successfully with clean database!
echo.
echo 🌐 Access points:
echo    Frontend: http://localhost:5173
echo    Backend:  http://localhost:8000
echo    API Docs: http://localhost:8000/docs
echo.
pause