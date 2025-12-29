@echo off
echo ========================================
echo CORRECT PORTS - NO CONFUSION
echo ========================================

echo.
echo ✅ YOUR ACTUAL PORTS:
echo Frontend: http://localhost:5174
echo Backend:  http://localhost:8002
echo.

echo 🧪 TEST THESE EXACT URLS:
echo Report Lost: http://localhost:5174/report-lost
echo Report Found: http://localhost:5174/report-found
echo.

echo 📋 TESTING STEPS:
echo 1. Open: http://localhost:5174/report-lost
echo 2. Fill the form completely
echo 3. Click "Report Lost Item"
echo 4. Should see SUCCESS (no "Failed to fetch")
echo.

echo 🔍 BACKEND STATUS:
curl -s http://localhost:8002/health
echo.

echo 🔍 CORS TEST FOR PORT 5174:
curl -s -I -X OPTIONS http://localhost:8002/api/anonymous/report -H "Origin: http://localhost:5174"
echo.

echo ========================================
echo USE PORT 5174 FOR FRONTEND TESTING!
echo ========================================
pause