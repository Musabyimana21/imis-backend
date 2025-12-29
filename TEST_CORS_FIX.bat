@echo off
echo TESTING CORS FIX
echo ================

echo 1. Testing backend health...
curl -s http://localhost:8000/health

echo.
echo 2. Testing anonymous items endpoint...
curl -s http://localhost:8000/api/anonymous/items

echo.
echo 3. Testing CORS with OPTIONS request...
curl -s -X OPTIONS -H "Origin: http://localhost:5173" -H "Access-Control-Request-Method: POST" http://localhost:8000/api/anonymous/report

echo.
echo 4. Testing POST to anonymous report...
curl -s -X POST -H "Content-Type: application/json" -H "Origin: http://localhost:5173" -d "{\"reporter_name\":\"Test\",\"reporter_phone\":\"+250123456789\",\"title\":\"Test Item\",\"description\":\"Test Description\",\"category\":\"Electronics\",\"status\":\"lost\",\"location\":{\"province\":\"Kigali\",\"district\":\"Gasabo\",\"sector\":\"Kimisagara\",\"cell\":\"Kimisagara\",\"village\":\"Kimisagara\"}}" http://localhost:8000/api/anonymous/report

echo.
echo If you see JSON responses above, CORS is working!
pause