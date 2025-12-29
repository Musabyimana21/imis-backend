@echo off
echo ========================================
echo FINAL WORKING SYSTEM
echo ========================================

echo Starting Backend on Port 9002...
start "Backend" python simple_backend.py

timeout /t 3 /nobreak >nul

echo Testing Backend...
curl -s http://localhost:9002/health

echo.
echo ========================================
echo ✅ SYSTEM IS READY!
echo ========================================
echo Frontend: http://localhost:5174
echo Backend:  http://localhost:9002
echo.
echo 🧪 TEST THESE:
echo Report Lost: http://localhost:5174/report-lost
echo View Item 1: http://localhost:5174/item/1
echo View Item 8: http://localhost:5174/item/8
echo.
echo ✅ Everything should work now!
pause