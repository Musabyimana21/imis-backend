@echo off
echo FIXING PORT MISMATCH
echo ===================

echo 1. Stopping frontend...
taskkill /f /im node.exe 2>nul

echo 2. Fixed frontend .env to use port 8000
echo 3. Restarting frontend...
cd frontend
start cmd /k "npm run dev"

echo 4. Testing connection...
timeout /t 5 /nobreak >nul
curl -s http://localhost:8000/health

echo.
echo ✅ Fixed! Frontend now connects to backend on port 8000
echo Frontend: http://localhost:5173
echo Backend:  http://localhost:8000
start http://localhost:5173
pause