@echo off
echo ========================================
echo SIMPLE REPORT TEST
echo ========================================

cd /d "%~dp0"

echo Starting backend...
start "Backend" cmd /k "cd backend && python -m uvicorn app.main:app --reload --port 8000"

echo Waiting 5 seconds...
timeout /t 5 /nobreak >nul

echo Starting frontend...
start "Frontend" cmd /k "cd frontend && npm run dev -- --port 5173"

echo Waiting 8 seconds...
timeout /t 8 /nobreak >nul

echo Opening test pages...
start "" "http://localhost:5173/report-lost"
start "" "http://localhost:5173/report-found"

echo.
echo ========================================
echo MANUAL TEST CHECKLIST:
echo ========================================
echo.
echo 1. Report Lost Item page should load
echo 2. Location selector should show Rwanda provinces
echo 3. Fill form and submit - should work
echo 4. Report Found Item page should work same way
echo.
echo Press any key when done testing...
pause