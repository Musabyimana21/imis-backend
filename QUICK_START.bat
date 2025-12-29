@echo off
title IMIS Quick Start
echo Starting IMIS...

echo 1. Killing existing processes...
taskkill /f /im python.exe >nul 2>&1
taskkill /f /im node.exe >nul 2>&1

echo 2. Starting backend in new window...
start "IMIS Backend" START_BACKEND_ONLY.bat

echo 3. Waiting 3 seconds...
timeout /t 3 >nul

echo 4. Starting frontend in new window...
start "IMIS Frontend" START_FRONTEND_ONLY.bat

echo.
echo ✅ IMIS Started!
echo 🌐 Frontend: http://localhost:5173
echo 🔧 Backend: http://localhost:8001
echo 📚 API Docs: http://localhost:8001/docs
echo.
echo Wait 10 seconds then open: http://localhost:5173
timeout /t 10 >nul
start http://localhost:5173