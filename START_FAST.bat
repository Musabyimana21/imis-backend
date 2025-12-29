@echo off
echo IMIS Fast Start

:: Cleanup
taskkill /f /im python.exe /im node.exe >nul 2>&1

:: Backend
cd backend && start "IMIS-API" cmd /k "uvicorn app.main:app --port 8001" && timeout /t 1 >nul

:: Frontend  
cd ..\frontend && start "IMIS-Web" cmd /k "npm run dev" && cd ..

:: Open browser
timeout /t 3 >nul && start http://localhost:5173

echo ✅ IMIS Started! Check terminal windows.
pause