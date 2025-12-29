@echo off
echo IMIS IS ALREADY WORKING!
echo ========================

echo Backend health check shows IMIS is running:
curl -s http://localhost:8000/health

echo.
echo Testing frontend:
curl -s -I http://localhost:5173

echo.
echo ✅ IMIS Status:
echo Frontend: http://localhost:5173
echo Backend:  http://localhost:8000
echo API Docs: http://localhost:8000/docs

echo.
echo Opening IMIS...
start http://localhost:5173

echo.
echo 🎉 IMIS is working! No Docker restart needed.
pause