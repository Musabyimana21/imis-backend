@echo off
echo ========================================
echo   RENDER BACKEND KEEP-ALIVE SERVICE
echo ========================================
echo.
echo This will ping your backend every 10 minutes
echo to prevent Render from spinning it down.
echo.
echo Backend: https://imis-backend-wk7z.onrender.com
echo.
echo Press Ctrl+C to stop
echo.
pause

cd backend
python ..\keep_alive.py
