@echo off
title Restart IMIS Services
echo Restarting IMIS (Backend + Frontend)...

echo 1. Stopping services...
taskkill /f /im python.exe >nul 2>&1
taskkill /f /im node.exe >nul 2>&1
timeout /t 2 >nul

echo 2. Starting backend...
cd backend
start "IMIS-Backend" cmd /k "python -m uvicorn app.main:app --host 0.0.0.0 --port 8001 --reload"
timeout /t 3 >nul

echo 3. Starting frontend...
cd ..\frontend
start "IMIS-Frontend" cmd /k "npm run dev -- --port 5173"
timeout /t 3 >nul

echo 4. Testing health...
curl -s http://localhost:8001/health

echo.
echo ✅ IMIS Restarted!
echo 🌐 Frontend: http://localhost:5173
echo 🔧 Backend: http://localhost:8001
echo 📚 API Docs: http://localhost:8001/docs
echo.
echo Opening browser...
start http://localhost:5173