@echo off
echo ========================================
echo SIMPLE FIX - USE EXISTING PORTS
echo ========================================

echo Your frontend is running on: http://localhost:5174
echo Your backend is running on:  http://localhost:8003

echo Testing connection...
curl -s http://localhost:8003/health

echo.
echo ========================================
echo ✅ USE THESE EXACT URLS:
echo Frontend: http://localhost:5174
echo Test:     http://localhost:5174/report-lost
echo Backend:  http://localhost:8003/docs
echo ========================================

echo.
echo The system should work now!
echo If still failing, restart your browser completely.
pause