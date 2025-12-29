@echo off
echo ========================================
echo RENDER ENVIRONMENT VARIABLES CHECKER
echo ========================================
echo.

echo Checking .env.render file...
if exist "backend\.env.render" (
    echo ✓ .env.render file exists
    echo.
    echo Environment Variables in .env.render:
    echo ----------------------------------------
    type "backend\.env.render"
    echo.
    echo ----------------------------------------
) else (
    echo ✗ .env.render file not found!
    echo Please ensure the file exists in the backend folder.
)

echo.
echo ========================================
echo NEXT STEPS:
echo ========================================
echo 1. Go to https://render.com
echo 2. Open your imis-backend service
echo 3. Click on "Environment" tab
echo 4. Add each variable from .env.render file above
echo 5. Replace DATABASE_URL with your actual PostgreSQL URL
echo 6. Replace SECRET_KEY with a secure random string
echo 7. Save changes and wait for deployment
echo ========================================
echo.
pause