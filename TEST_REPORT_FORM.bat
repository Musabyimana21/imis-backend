@echo off
echo ========================================
echo TESTING IMIS REPORT FORM
echo ========================================
echo.

echo Testing backend health...
curl -s http://192.168.61.61:8001/health
echo.
echo.

echo Testing CORS preflight...
curl -s -H "Origin: http://192.168.61.61:5173" -H "Access-Control-Request-Method: POST" -H "Access-Control-Request-Headers: Content-Type" -X OPTIONS http://192.168.61.61:8001/api/anonymous/report
echo.
echo.

echo Testing items endpoint...
curl -s "http://192.168.61.61:8001/api/anonymous/items" | python -c "import sys, json; data=json.load(sys.stdin); print(f'Total items: {len(data)}'); print(f'First item: {data[0][\"title\"] if data else \"None\"}')"
echo.

echo ========================================
echo If all tests pass, the report form should work!
echo Open: http://192.168.61.61:5173/report-lost
echo ========================================
pause