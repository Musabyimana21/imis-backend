@echo off
title Test Location Feature - IMIS
color 0A

echo ========================================
echo   IMIS - Location Feature Test
echo ========================================
echo.
echo This will start IMIS to test the new
echo Leaflet.js location picker feature.
echo.
echo Features:
echo  - Interactive Rwanda map
echo  - Click to select location
echo  - Drag marker to adjust
echo  - GPS auto-detect
echo  - Reverse geocoding
echo.
echo ========================================
echo.

echo Starting backend...
cd backend
start "IMIS-Backend" cmd /k "python -m uvicorn app.main:app --port 8001 --reload"
timeout /t 3 >nul

echo Starting frontend...
cd ..\frontend
start "IMIS-Frontend" cmd /k "npm run dev -- --port 5173"
timeout /t 3 >nul

cd ..

echo.
echo ========================================
echo   IMIS Started Successfully!
echo ========================================
echo.
echo Access Points:
echo  Frontend:  http://localhost:5173
echo  Backend:   http://localhost:8001
echo  API Docs:  http://localhost:8001/docs
echo.
echo Test the Location Feature:
echo  1. Go to "Report Lost Item"
echo  2. Click "Select on Map" button
echo  3. Click anywhere on Rwanda map
echo  4. Or drag the marker
echo  5. Or use GPS button
echo.
echo ========================================
echo.
echo Opening browser in 3 seconds...
timeout /t 3 >nul
start http://localhost:5173/report-lost

echo.
echo Press any key to stop all services...
pause >nul

echo.
echo Stopping services...
taskkill /f /im python.exe >nul 2>&1
taskkill /f /im node.exe >nul 2>&1

echo.
echo All services stopped.
echo.
pause
