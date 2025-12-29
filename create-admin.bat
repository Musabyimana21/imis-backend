@echo off
echo ========================================
echo Create Admin User
echo ========================================
echo.

set /p email="Enter admin email: "
set /p password="Enter admin password: "
set /p fullname="Enter full name: "

echo.
echo Creating admin user...

curl -X POST http://localhost:8000/auth/register ^
  -H "Content-Type: application/json" ^
  -d "{\"email\":\"%email%\",\"password\":\"%password%\",\"full_name\":\"%fullname%\"}"

echo.
echo.
echo User created. Now updating to admin role...
echo.
echo Please run this SQL command in your database:
echo UPDATE users SET role = 'admin' WHERE email = '%email%';
echo.
pause
