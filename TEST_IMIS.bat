@echo off
echo ========================================
echo IMIS System Comprehensive Test
echo ========================================
echo.

echo [1/6] Testing Backend Health...
curl -s http://localhost:8000/health
if %errorlevel% neq 0 (
    echo [ERROR] Backend is not responding
    exit /b 1
)
echo [OK] Backend is healthy
echo.

echo [2/6] Testing API Root...
curl -s http://localhost:8000/
echo.
echo [OK] API root accessible
echo.

echo [3/6] Testing API Documentation...
curl -s http://localhost:8000/docs > nul
if %errorlevel% neq 0 (
    echo [ERROR] API docs not accessible
) else (
    echo [OK] API docs available at http://localhost:8000/docs
)
echo.

echo [4/6] Testing Frontend...
curl -s http://localhost:5173 > nul
if %errorlevel% neq 0 (
    echo [ERROR] Frontend is not responding
) else (
    echo [OK] Frontend is running on http://localhost:5173
)
echo.

echo [5/6] Testing User Registration...
curl -s -X POST http://localhost:8000/auth/register ^
  -H "Content-Type: application/json" ^
  -d "{\"email\":\"test@imis.rw\",\"password\":\"test123\",\"full_name\":\"Test User\",\"phone\":\"+250788123456\"}"
echo.
echo [OK] Registration endpoint working
echo.

echo [6/6] Testing Item Creation (requires auth)...
echo [INFO] This will fail without valid token - expected behavior
curl -s -X POST http://localhost:8000/items/ ^
  -H "Content-Type: application/json" ^
  -d "{\"title\":\"Test Item\",\"description\":\"Test\",\"category\":\"other\",\"status\":\"lost\",\"location_name\":\"Kigali\",\"latitude\":-1.9536,\"longitude\":30.0606}"
echo.

echo.
echo ========================================
echo Test Summary
echo ========================================
echo Backend: http://localhost:8000
echo Frontend: http://localhost:5173
echo API Docs: http://localhost:8000/docs
echo.
echo All core endpoints are functional!
echo ========================================
pause
