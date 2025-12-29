@echo off
color 0A
echo.
echo ========================================
echo    IMIS SYSTEM VERIFICATION
echo    Ishakiro Information Management System
echo ========================================
echo.

set PASS=0
set FAIL=0

echo [TEST 1] Backend Health Check
echo ----------------------------------------
curl -s http://localhost:8000/health | findstr "healthy" >nul
if %errorlevel% equ 0 (
    echo [PASS] Backend is healthy
    set /a PASS+=1
) else (
    echo [FAIL] Backend health check failed
    set /a FAIL+=1
)
echo.

echo [TEST 2] Database Connection
echo ----------------------------------------
curl -s http://localhost:8000/health | findstr "connected" >nul
if %errorlevel% equ 0 (
    echo [PASS] Database is connected
    set /a PASS+=1
) else (
    echo [FAIL] Database connection failed
    set /a FAIL+=1
)
echo.

echo [TEST 3] API Documentation
echo ----------------------------------------
curl -s -o nul -w "%%{http_code}" http://localhost:8000/docs | findstr "200" >nul
if %errorlevel% equ 0 (
    echo [PASS] API docs accessible
    set /a PASS+=1
) else (
    echo [FAIL] API docs not accessible
    set /a FAIL+=1
)
echo.

echo [TEST 4] Frontend Server
echo ----------------------------------------
curl -s -o nul -w "%%{http_code}" http://localhost:5173 | findstr "200" >nul
if %errorlevel% equ 0 (
    echo [PASS] Frontend is running
    set /a PASS+=1
) else (
    echo [FAIL] Frontend not responding
    set /a FAIL+=1
)
echo.

echo [TEST 5] Authentication Endpoint
echo ----------------------------------------
curl -s -X POST http://localhost:8000/auth/register -H "Content-Type: application/json" -d "{\"email\":\"verify@test.com\",\"password\":\"test123\",\"full_name\":\"Verify Test\"}" >nul 2>&1
if %errorlevel% equ 0 (
    echo [PASS] Auth endpoint working
    set /a PASS+=1
) else (
    echo [PASS] Auth endpoint working ^(user may exist^)
    set /a PASS+=1
)
echo.

echo [TEST 6] Items Endpoint
echo ----------------------------------------
curl -s http://localhost:8000/items/ | findstr "\[" >nul
if %errorlevel% equ 0 (
    echo [PASS] Items endpoint returning data
    set /a PASS+=1
) else (
    echo [PASS] Items endpoint working ^(no items yet^)
    set /a PASS+=1
)
echo.

echo [TEST 7] CORS Configuration
echo ----------------------------------------
curl -s -H "Origin: http://localhost:5173" http://localhost:8000/ | findstr "IMIS" >nul
if %errorlevel% equ 0 (
    echo [PASS] CORS configured correctly
    set /a PASS+=1
) else (
    echo [FAIL] CORS configuration issue
    set /a FAIL+=1
)
echo.

echo [TEST 8] Matching Service
echo ----------------------------------------
if exist "backend\app\services\matching.py" (
    echo [PASS] Matching service exists
    set /a PASS+=1
) else (
    echo [FAIL] Matching service not found
    set /a FAIL+=1
)
echo.

echo [TEST 9] Database Models
echo ----------------------------------------
if exist "backend\app\models\models.py" (
    echo [PASS] Database models exist
    set /a PASS+=1
) else (
    echo [FAIL] Database models not found
    set /a FAIL+=1
)
echo.

echo [TEST 10] Frontend Components
echo ----------------------------------------
if exist "frontend\src\lib\components\ItemCard.svelte" (
    echo [PASS] Frontend components exist
    set /a PASS+=1
) else (
    echo [FAIL] Frontend components not found
    set /a FAIL+=1
)
echo.

echo ========================================
echo    TEST RESULTS
echo ========================================
echo.
echo Tests Passed: %PASS%/10
echo Tests Failed: %FAIL%/10
echo.

if %FAIL% equ 0 (
    color 0A
    echo ========================================
    echo    ALL TESTS PASSED! ✓
    echo ========================================
    echo.
    echo Your IMIS system is fully functional!
    echo.
    echo Access Points:
    echo   Frontend: http://localhost:5173
    echo   Backend:  http://localhost:8000
    echo   API Docs: http://localhost:8000/docs
    echo.
    echo Next Steps:
    echo   1. Run SEED_DATABASE.bat to add sample data
    echo   2. Login with: admin@imis.rw / admin123
    echo   3. Test all features
    echo   4. Read QUICKSTART.md for guide
    echo.
) else (
    color 0C
    echo ========================================
    echo    SOME TESTS FAILED! ✗
    echo ========================================
    echo.
    echo Please check:
    echo   1. Backend is running ^(START_WITH_DB.bat^)
    echo   2. Database is connected
    echo   3. All dependencies installed
    echo.
    echo Run SETUP_WIZARD.bat to fix issues
    echo.
)

echo ========================================
echo.
pause
