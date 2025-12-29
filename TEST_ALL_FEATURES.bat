@echo off
color 0A
cls
echo ╔══════════════════════════════════════════════════════════╗
echo ║     ISHAKIRO - COMPLETE FEATURE TEST                    ║
echo ╚══════════════════════════════════════════════════════════╝
echo.

echo [TEST 1] Backend Health...
curl -s http://localhost:8000/health
echo.
echo.

echo [TEST 2] API Root...
curl -s http://localhost:8000/
echo.
echo.

echo [TEST 3] Register User...
curl -s -X POST http://localhost:8000/auth/register -H "Content-Type: application/json" -d "{\"email\":\"test@imis.rw\",\"password\":\"test123\",\"full_name\":\"Test User\",\"phone\":\"+250788123456\"}"
echo.
echo.

echo [TEST 4] Login User...
curl -s -X POST http://localhost:8000/auth/login -H "Content-Type: application/json" -d "{\"email\":\"test@imis.rw\",\"password\":\"test123\"}"
echo.
echo.

echo [TEST 5] Get Items...
curl -s http://localhost:8000/items/
echo.
echo.

echo [TEST 6] Frontend...
curl -s http://localhost:5173 >nul
if %errorlevel% equ 0 (
    echo ✅ Frontend is running
) else (
    echo ❌ Frontend not responding
)
echo.

echo ╔══════════════════════════════════════════════════════════╗
echo ║              ALL FEATURES TESTED!                        ║
echo ╚══════════════════════════════════════════════════════════╝
echo.
echo 🌐 Open: http://localhost:5173
echo 📚 API Docs: http://localhost:8000/docs
echo.
pause
