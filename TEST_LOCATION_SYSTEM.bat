@echo off
title Test Location System
echo Testing the new Rwanda location system...

echo.
echo 1. Starting backend (if not running)...
cd backend
start /min "Backend" python -m uvicorn app.main:app --host 0.0.0.0 --port 8001 --reload
timeout /t 3 >nul

echo 2. Starting frontend (if not running)...
cd ..\frontend
start /min "Frontend" npm run dev -- --port 5173
timeout /t 5 >nul

echo 3. Testing API health...
curl -s http://localhost:8001/health

echo.
echo 4. Opening test pages...
start http://localhost:5173/report-lost
timeout /t 2 >nul
start http://localhost:5173/report-found

echo.
echo ✅ Location system ready for testing!
echo.
echo Test the new location selector:
echo - Select Province → District → Sector → Cell → Village
echo - No more map interface
echo - All Rwanda administrative units available
echo.
pause