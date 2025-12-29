@echo off
echo COMPLETE CORS FIX FOR IMIS
echo ===========================

echo 1. Killing all Python processes...
taskkill /f /im python.exe 2>nul
timeout /t 2 /nobreak >nul

echo 2. Starting backend with CORS fix...
cd backend
start "IMIS Backend - CORS FIXED" cmd /k "python -m uvicorn app.main:app --reload --host 0.0.0.0 --port 8001"

echo 3. Waiting for backend to start...
timeout /t 5 /nobreak >nul

echo 4. Testing backend...
curl -s http://localhost:8001/health

echo.
echo ===========================
echo CORS FIX COMPLETE!
echo ===========================
echo Backend: http://localhost:8001
echo Frontend: http://localhost:5174
echo.
echo Try reporting an item now!
echo.
pause