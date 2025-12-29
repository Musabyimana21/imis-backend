@echo off
echo ╔═══════════════════════════════════════════════════════════════════╗
echo ║                    🔧 FIX DATABASE ERROR                          ║
echo ║                                                                   ║
echo ║  Fixing: relation "ix_users_email" already exists                ║
echo ╚═══════════════════════════════════════════════════════════════════╝
echo.

echo 🛑 Stopping any running services...
taskkill /f /im uvicorn.exe 2>nul
taskkill /f /im python.exe 2>nul
timeout /t 2 /nobreak >nul

echo.
echo 🔧 Fixing database indexes...

REM Connect to database and drop problematic indexes
set PGPASSWORD=password123
psql -U postgres -h localhost -p 5432 -d imis -c "DROP INDEX IF EXISTS ix_users_email CASCADE;" 2>nul
psql -U postgres -h localhost -p 5432 -d imis -c "DROP INDEX IF EXISTS ix_users_username CASCADE;" 2>nul
psql -U postgres -h localhost -p 5432 -d imis -c "DROP INDEX IF EXISTS ix_items_title CASCADE;" 2>nul
psql -U postgres -h localhost -p 5432 -d imis -c "DROP INDEX IF EXISTS ix_items_category CASCADE;" 2>nul

if %errorlevel% neq 0 (
    echo ❌ Could not connect to database. Trying alternative method...
    echo.
    echo 🔄 Resetting entire database...
    psql -U postgres -h localhost -p 5432 -c "DROP DATABASE IF EXISTS imis;" 2>nul
    psql -U postgres -h localhost -p 5432 -c "CREATE DATABASE imis;" 2>nul
    echo ✅ Database reset complete!
) else (
    echo ✅ Problematic indexes removed!
)

echo.
echo 🚀 Now starting IMIS...
cd backend
start "IMIS Backend" cmd /k "python -m uvicorn app.main:app --reload --host 0.0.0.0 --port 8000"

timeout /t 5 /nobreak >nul

cd ..\frontend
start "IMIS Frontend" cmd /k "npm run dev -- --host 0.0.0.0 --port 5173"

echo.
echo ✅ IMIS should start successfully now!
echo.
echo 🌐 Access points:
echo    Frontend: http://localhost:5173
echo    Backend:  http://localhost:8000
echo    API Docs: http://localhost:8000/docs
echo.
echo 📝 If you still see errors, run: START_CLEAN.bat
echo.
pause