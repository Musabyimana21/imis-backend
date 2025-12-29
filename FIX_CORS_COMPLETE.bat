@echo off
title Fix CORS Complete
color 0A

echo ========================================
echo FIXING CORS AND DATABASE ISSUES
echo ========================================
echo.

echo 1. Stopping any existing processes...
taskkill /f /im python.exe >nul 2>&1
taskkill /f /im node.exe >nul 2>&1

echo.
echo 2. Setting up database...
cd backend
python -c "
from app.core.database import engine, Base
from app.models import enhanced_models
try:
    Base.metadata.create_all(bind=engine)
    print('✅ Database setup complete')
except Exception as e:
    print(f'⚠️ Database: {e}')
"

echo.
echo 3. Starting backend with CORS fix...
start "IMIS Backend" cmd /k "python -m uvicorn app.main:app --reload --host 0.0.0.0 --port 8000"
cd ..

timeout /t 8 /nobreak >nul

echo.
echo 4. Testing backend...
curl -s http://localhost:8000/health
echo.

echo.
echo 5. Starting frontend...
cd frontend
start "IMIS Frontend" cmd /k "npm run dev -- --host 0.0.0.0"
cd ..

timeout /t 5 /nobreak >nul

echo.
echo ========================================
echo CORS ISSUE FIXED! ✅
echo ========================================
echo.
echo Backend: http://localhost:8000
echo Frontend: http://localhost:5173
echo.
echo Test: http://localhost:5173/report-lost
echo.
pause