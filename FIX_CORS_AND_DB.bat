@echo off
echo Fixing CORS and Database Issues...

cd /d "%~dp0"

echo 1. Stopping all services...
taskkill /f /im python.exe 2>nul
taskkill /f /im node.exe 2>nul

echo 2. Updating database schema...
cd backend
python -c "
from app.core.database import engine, Base
from app.models.enhanced_models import AnonymousItem
try:
    Base.metadata.create_all(bind=engine)
    print('✅ Database updated')
except Exception as e:
    print(f'Database update: {e}')
"

echo 3. Starting backend with CORS fix...
start "Backend" cmd /k "python -m uvicorn app.main:app --reload --port 8000 --host 0.0.0.0"

timeout /t 5 /nobreak >nul

echo 4. Starting frontend...
cd ../frontend
start "Frontend" cmd /k "npm run dev -- --port 5173 --host 0.0.0.0"

echo.
echo ✅ Services restarted with fixes
echo Backend: http://localhost:8000
echo Frontend: http://localhost:5173
pause