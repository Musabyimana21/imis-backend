@echo off
echo ========================================
echo STARTING FIXED IMIS SYSTEM
echo ========================================

echo.
echo 1. Starting Backend on Port 8002...
cd backend
start "IMIS Backend" python -m uvicorn app.main:app --reload --host 0.0.0.0 --port 8002

echo Waiting for backend to start...
timeout /t 5 /nobreak > nul

echo.
echo 2. Starting Frontend on Port 5173...
cd ..\frontend
start "IMIS Frontend" npm run dev

echo Waiting for frontend to start...
timeout /t 5 /nobreak > nul

echo.
echo ========================================
echo ✅ SYSTEM STARTED SUCCESSFULLY!
echo ========================================
echo.
echo 🌐 OPEN THESE URLS:
echo Frontend: http://localhost:5173
echo Report Lost: http://localhost:5173/report-lost
echo Report Found: http://localhost:5173/report-found
echo Backend API: http://localhost:8002/docs
echo.
echo 🧪 TEST STEPS:
echo 1. Go to http://localhost:5173/report-lost
echo 2. Fill out the form completely
echo 3. Click "Report Lost Item"
echo 4. Should see success message (no "Failed to fetch")
echo.
pause