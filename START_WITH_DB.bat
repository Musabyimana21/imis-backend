@echo off
title IMIS with Database
color 0A

echo ========================================
echo IMIS Start with PostgreSQL Database
echo ========================================
echo.

echo Installing Backend packages...
cd backend
python -m pip install --default-timeout=100 fastapi uvicorn[standard] sqlalchemy psycopg2-binary geoalchemy2 pydantic pydantic-settings email-validator python-jose[cryptography] passlib[bcrypt] python-multipart scikit-learn numpy
cd ..

echo.
echo Installing Frontend packages...
cd frontend
call npm install
cd ..

echo.
echo Starting Backend with Database...
cd backend
start "IMIS Backend" cmd /k "python -m uvicorn app.main:app --reload --port 8001"
cd ..

timeout /t 5 /nobreak >nul

echo.
echo Starting Frontend...
cd frontend
start "IMIS Frontend" cmd /k "npm run dev"
cd ..

echo.
echo ========================================
echo IMIS Started with Full Database!
echo ========================================
echo.
echo Frontend: http://localhost:5173
echo Backend:  http://localhost:8001
echo API Docs: http://localhost:8001/docs
echo Database: PostgreSQL on localhost:5432
echo.
echo All features enabled!
echo.
pause
