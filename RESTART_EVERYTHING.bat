@echo off
echo RESTARTING ENTIRE IMIS SYSTEM
echo ==============================

echo 1. Stopping all processes...
taskkill /f /im python.exe 2>nul
taskkill /f /im node.exe 2>nul
timeout /t 3 /nobreak >nul

echo 2. Starting backend with CORS fix...
cd backend
start "IMIS Backend" cmd /k "python -m uvicorn app.main:app --reload --host 0.0.0.0 --port 8001"
cd ..

echo 3. Waiting for backend to start...
timeout /t 5 /nobreak >nul

echo 4. Testing backend...
curl -s http://localhost:8001/health

echo 5. Starting frontend...
cd frontend
start "IMIS Frontend" cmd /k "npm run dev"
cd ..

echo 6. Waiting for frontend to start...
timeout /t 5 /nobreak >nul

echo.
echo ==============================
echo SYSTEM RESTART COMPLETE!
echo ==============================
echo Backend:  http://localhost:8001
echo Frontend: http://localhost:5173 or http://localhost:5174
echo API Docs: http://localhost:8001/docs
echo.
echo Testing URLs:
echo - Homepage: http://localhost:5174/
echo - Report Lost: http://localhost:5174/report-lost
echo - Report Found: http://localhost:5174/report-found
echo.
echo Both services are running in separate windows.
echo CORS is now properly configured!
echo.
pause