@echo off
title IMIS - No Database Mode
color 0A

echo ========================================
echo IMIS Start (No Database Required)
echo ========================================
echo.

echo Installing packages...
cd backend
python -m pip install --default-timeout=100 fastapi uvicorn[standard] pydantic pydantic-settings email-validator python-jose[cryptography] passlib[bcrypt] python-multipart
cd ..

echo.
echo Installing Frontend...
cd frontend
call npm install
cd ..

echo.
echo Starting Backend (No Database)...
cd backend
start "IMIS Backend" cmd /k "python -m uvicorn app.main:app --reload"
cd ..

timeout /t 5 /nobreak >nul

echo.
echo Starting Frontend...
cd frontend
start "IMIS Frontend" cmd /k "npm run dev"
cd ..

echo.
echo ========================================
echo IMIS Started (Demo Mode)
echo ========================================
echo.
echo Frontend: http://localhost:5173
echo Backend:  http://localhost:8000
echo API Docs: http://localhost:8000/docs
echo.
echo NOTE: Database features disabled
echo      Frontend will work for UI testing
echo.
pause
