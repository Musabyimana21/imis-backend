@echo off
echo SIMPLE DATABASE FIX
echo ===================

echo 1. Stopping backend...
taskkill /f /im python.exe 2>nul

echo 2. Fixing database schema...
cd backend
python ..\fix_db_schema.py

echo 3. Starting backend on port 8000...
start cmd /k "python -m uvicorn app.main:app --reload --host 0.0.0.0 --port 8000"

echo 4. Waiting...
timeout /t 8 /nobreak >nul

echo 5. Testing backend...
curl -s http://localhost:8000/health

echo.
echo ✅ Database fixed! Try http://localhost:5173 now
pause