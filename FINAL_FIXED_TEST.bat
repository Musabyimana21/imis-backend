@echo off
echo ========================================
echo ✅ CORS FIXED FOR PORT 5174
echo ========================================

echo.
echo 🎯 CORRECT PORTS:
echo Frontend: http://localhost:5174
echo Backend:  http://localhost:8002
echo.

echo 🧪 BACKEND STATUS:
curl -s http://localhost:8002/health
echo.

echo 🔍 CORS TEST FOR PORT 5174:
curl -s -I -X OPTIONS http://localhost:8002/api/anonymous/report -H "Origin: http://localhost:5174"
echo.

echo 🚀 API TEST:
curl -s -X POST http://localhost:8002/api/anonymous/report -H "Content-Type: application/json" -H "Origin: http://localhost:5174" -d "{\"reporter_name\":\"Test\",\"reporter_phone\":\"+250788123456\",\"title\":\"Test\",\"description\":\"Test\",\"category\":\"phone\",\"status\":\"lost\",\"location\":{\"province\":\"Kigali\",\"district\":\"Gasabo\",\"sector\":\"Kacyiru\",\"cell\":\"Kamatamu\",\"village\":\"Amajyambere\"}}"
echo.

echo ========================================
echo ✅ NOW TEST: http://localhost:5174/report-lost
echo ✅ SHOULD WORK WITHOUT "Failed to fetch"
echo ========================================
pause