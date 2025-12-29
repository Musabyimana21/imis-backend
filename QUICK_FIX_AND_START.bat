@echo off
echo ╔═══════════════════════════════════════════════════════════════════╗
echo ║                    QUICK FIX AND START                           ║
echo ╚═══════════════════════════════════════════════════════════════════╝
echo.

echo [1/4] Fixing PostGIS issue...
echo Models updated to use simple location storage
echo.

echo [2/4] Installing minimal dependencies (no compilation)...
cd backend
pip install --only-binary=all -r requirements_minimal.txt
echo.

echo [3/4] Creating database tables...
python -c "
from app.core.database import engine, Base
from app.models.models import *
print('Creating tables...')
Base.metadata.create_all(bind=engine)
print('Tables created successfully!')
"
echo.

echo [4/4] Starting services...
echo.
echo Starting Backend API...
start "IMIS Backend" cmd /k "cd /d T:\IMIS\backend && python -m uvicorn app.main:app --reload --host 0.0.0.0 --port 8000"

timeout /t 3 /nobreak >nul

echo Starting Frontend...
cd ..\frontend
start "IMIS Frontend" cmd /k "npm run dev"

echo.
echo ╔═══════════════════════════════════════════════════════════════════╗
echo ║                    SYSTEM STARTING...                            ║
echo ╚═══════════════════════════════════════════════════════════════════╝
echo.
echo Frontend: http://localhost:5173
echo Backend:  http://localhost:8000
echo API Docs: http://localhost:8000/docs
echo.
echo Press any key to stop all services...
pause >nul

echo Stopping services...
taskkill /f /im "node.exe" 2>nul
taskkill /f /im "python.exe" 2>nul
echo Services stopped.