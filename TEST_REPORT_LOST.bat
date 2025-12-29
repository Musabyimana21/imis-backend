@echo off
echo ========================================
echo TESTING REPORT LOST FUNCTIONALITY
echo ========================================

echo.
echo 1. Testing Backend API...
curl -s -X GET http://localhost:8001/health
echo.

echo.
echo 2. Testing Anonymous Report Endpoint...
curl -s -X POST http://localhost:8001/api/anonymous/report -H "Content-Type: application/json" -d "{\"reporter_name\":\"Test User\",\"reporter_phone\":\"+250788123456\",\"title\":\"Test Lost Phone\",\"description\":\"Black iPhone lost at market\",\"category\":\"phone\",\"status\":\"lost\",\"location\":{\"province\":\"Kigali\",\"district\":\"Gasabo\",\"sector\":\"Kacyiru\",\"cell\":\"Kamatamu\",\"village\":\"Amajyambere\"}}"
echo.

echo.
echo 3. Testing Frontend Connection...
curl -s -I http://localhost:5173
echo.

echo ========================================
echo TEST COMPLETE
echo ========================================
echo.
echo Frontend: http://localhost:5173/report-lost
echo Backend:  http://localhost:8001/docs
echo.
echo If all tests passed, the "Failed to fetch" error should be fixed!
echo.
pause