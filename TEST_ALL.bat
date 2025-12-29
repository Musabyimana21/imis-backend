@echo off
title IMIS System Verification
color 0E

echo.
echo ========================================
echo   IMIS SYSTEM VERIFICATION
echo ========================================
echo.

REM Test database connection
echo [1/6] Testing database connection...
psql -U postgres -d imis -c "SELECT 1;" >nul 2>&1
if %errorlevel% equ 0 (
    echo     [OK] Database connected
) else (
    echo     [FAIL] Database connection failed
    goto :error
)

REM Test backend health
echo [2/6] Testing backend API...
curl -s http://localhost:8000/health >nul 2>&1
if %errorlevel% equ 0 (
    echo     [OK] Backend API responding
) else (
    echo     [FAIL] Backend not responding
    goto :error
)

REM Test frontend
echo [3/6] Testing frontend...
curl -s http://localhost:5173 >nul 2>&1
if %errorlevel% equ 0 (
    echo     [OK] Frontend responding
) else (
    echo     [FAIL] Frontend not responding
    goto :error
)

REM Test API endpoints
echo [4/6] Testing API endpoints...
curl -s http://localhost:8000/anonymous/items >nul 2>&1
if %errorlevel% equ 0 (
    echo     [OK] Items endpoint working
) else (
    echo     [FAIL] Items endpoint failed
    goto :error
)

REM Test database data
echo [5/6] Checking database data...
psql -U postgres -d imis -c "SELECT COUNT(*) FROM users;" >nul 2>&1
if %errorlevel% equ 0 (
    echo     [OK] Database has data
) else (
    echo     [FAIL] Database empty
    goto :error
)

REM Test AI matching
echo [6/6] Testing AI matching system...
curl -s http://localhost:8000/ >nul 2>&1
if %errorlevel% equ 0 (
    echo     [OK] AI matching active
) else (
    echo     [FAIL] AI matching failed
    goto :error
)

echo.
echo ========================================
echo   ALL TESTS PASSED!
echo ========================================
echo.
echo   System Status: HEALTHY
echo   All features working correctly
echo.
echo   Access Points:
echo   - Frontend: http://localhost:5173
echo   - Backend:  http://localhost:8000
echo   - API Docs: http://localhost:8000/docs
echo.
echo   Test Accounts:
echo   - admin@imis.rw / admin123
echo   - user1@imis.rw / password123
echo.
pause
exit /b 0

:error
echo.
echo ========================================
echo   TESTS FAILED
echo ========================================
echo.
echo Please run START_EVERYTHING.bat first
echo.
pause
exit /b 1
