@echo off
echo ╔═══════════════════════════════════════════════════════════════════╗
echo ║                    🔄 RESET DATABASE                              ║
echo ║                                                                   ║
echo ║  This will completely reset the IMIS database                     ║
echo ║  All existing data will be lost!                                  ║
echo ╚═══════════════════════════════════════════════════════════════════╝
echo.

set /p confirm="Are you sure you want to reset the database? (y/N): "
if /i not "%confirm%"=="y" (
    echo Operation cancelled.
    pause
    exit /b 0
)

echo.
echo 🔄 Resetting database...

REM Drop and recreate database
psql -U postgres -h localhost -p 5432 -c "DROP DATABASE IF EXISTS imis;" 2>nul
psql -U postgres -h localhost -p 5432 -c "CREATE DATABASE imis;" 2>nul

if %errorlevel% neq 0 (
    echo ❌ Failed to reset database. Trying with password...
    echo.
    echo Please enter PostgreSQL password when prompted (default: password123)
    set PGPASSWORD=password123
    psql -U postgres -h localhost -p 5432 -c "DROP DATABASE IF EXISTS imis;"
    psql -U postgres -h localhost -p 5432 -c "CREATE DATABASE imis;"
)

echo ✅ Database reset complete!
echo.
echo 📝 Next steps:
echo    1. Run START_WITH_DB.bat to start the system
echo    2. Run SEED_DATABASE.bat to add sample data
echo.
pause