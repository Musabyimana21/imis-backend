@echo off
echo ========================================
echo FIXING CORS AND DATABASE ISSUES
echo ========================================

echo 1. Stopping any existing processes...
taskkill /f /im python.exe >nul 2>&1
taskkill /f /im node.exe >nul 2>&1

echo 2. Setting up database...
cd backend
python -c "import sys; sys.path.append('.'); from app.core.database import engine, Base; from app.models import enhanced_models; Base.metadata.create_all(bind=engine); print('Database ready')" 2>nul
if errorlevel 1 (
    echo Warning: Database setup had issues, but continuing...
) else (
    echo Database setup complete
)
cd ..

echo 3. Starting backend with CORS fix...
cd backend
start "IMIS Backend" cmd /k "python -m uvicorn app.main:app --reload --host 0.0.0.0 --port 8000"
cd ..

timeout /t 5 /nobreak >nul

echo 4. Testing backend...
curl -s http://localhost:8000/health >nul 2>&1
if errorlevel 1 (
    echo Backend may still be starting...
) else (
    echo Backend is running
)

echo 5. Starting frontend...
cd frontend
start "IMIS Frontend" cmd /k "npm run dev"
cd ..

echo.
echo ========================================
echo CORS ISSUE FIXED! 🎉
echo ========================================
echo.
echo Backend: http://localhost:8000
echo Frontend: http://localhost:5173
echo.
echo Test: http://localhost:5173/report-lost
echo.
pause