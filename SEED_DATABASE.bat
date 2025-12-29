@echo off
echo ========================================
echo IMIS Database Seeding
echo ========================================
echo.
echo This will populate your database with:
echo - 11 sample users (1 admin + 10 regular users)
echo - 16 sample items (8 lost + 8 found)
echo.
echo Test Credentials:
echo   Admin: admin@imis.rw / admin123
echo   User:  user1@imis.rw / password123
echo.
pause

cd backend
python seed_data.py
cd ..

echo.
echo ========================================
echo Seeding Complete!
echo ========================================
echo.
echo You can now:
echo 1. Login with test accounts
echo 2. View sample items on homepage
echo 3. Test matching algorithm
echo 4. Access admin dashboard
echo.
pause
