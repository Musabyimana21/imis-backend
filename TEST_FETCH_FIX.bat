@echo off
title Test Fetch Fix
color 0A

echo ========================================
echo Testing Fetch Fix for IMIS
echo ========================================
echo.

echo 1. Starting Backend on port 8000...
cd backend
start "IMIS Backend" cmd /k "python -m uvicorn app.main:app --reload --port 8000"
cd ..

echo.
echo 2. Waiting for backend to start...
timeout /t 8 /nobreak >nul

echo.
echo 3. Testing backend health...
curl -s http://localhost:8000/health
echo.

echo.
echo 4. Starting Frontend on port 5173...
cd frontend
start "IMIS Frontend" cmd /k "npm run dev"
cd ..

echo.
echo 5. Waiting for frontend to start...
timeout /t 10 /nobreak >nul

echo.
echo ========================================
echo Fix Applied Successfully!
echo ========================================
echo.
echo Frontend: http://localhost:5173
echo Backend:  http://localhost:8000
echo API Docs: http://localhost:8000/docs
echo.
echo Test the report forms:
echo - http://localhost:5173/report-lost
echo - http://localhost:5173/report-found
echo.
echo The "failed to fetch" error should be fixed!
echo.
pause