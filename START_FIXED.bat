@echo off
title IMIS - Fixed Start
color 0A

echo ========================================
echo IMIS Fixed Start (All Dependencies)
echo ========================================
echo.

echo Installing ALL required packages...
cd backend
python -m pip install --upgrade pip
python -m pip install fastapi==0.109.0 uvicorn[standard]==0.27.0 sqlalchemy==2.0.25 psycopg2-binary==2.9.9 geoalchemy2==0.14.3 pydantic==2.5.3 pydantic-settings==2.1.0 email-validator==2.1.0 python-jose[cryptography]==3.3.0 passlib[bcrypt]==1.7.4 python-multipart==0.0.6 scikit-learn==1.4.0 numpy==1.26.3
cd ..

echo.
echo Installing Frontend packages...
cd frontend
call npm install
cd ..

echo.
echo Starting Backend...
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
echo IMIS Started Successfully!
echo ========================================
echo.
echo Frontend: http://localhost:5173
echo Backend:  http://localhost:8000
echo API Docs: http://localhost:8000/docs
echo.
echo Two windows opened. Backend should work now!
echo.
pause
