@echo off
echo RESTARTING BACKEND WITH CORS FIX
echo ================================

echo 1. Stopping all Python processes...
taskkill /f /im python.exe 2>nul

echo 2. Waiting...
timeout /t 3 /nobreak >nul

echo 3. Starting backend on port 8000...
cd backend
start cmd /k "python -m uvicorn app.main:app --reload --host 0.0.0.0 --port 8000"

echo 4. Waiting for backend to start...
timeout /t 8 /nobreak >nul

echo 5. Testing backend...
curl -s http://localhost:8000/health

echo 6. Testing anonymous endpoint...
curl -s http://localhost:8000/api/anonymous/items

echo.
echo ✅ Backend restarted with CORS fix!
echo Backend: http://localhost:8000
echo API Docs: http://localhost:8000/docs
echo Test: http://localhost:8000/api/anonymous/items
pause