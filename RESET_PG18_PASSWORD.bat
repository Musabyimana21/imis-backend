@echo off
title Reset PostgreSQL 18 Password
color 0C

echo ========================================
echo Reset PostgreSQL 18 Password
echo ========================================
echo.
echo This will reset your PostgreSQL password
echo.
pause

echo.
echo Step 1: Backing up pg_hba.conf...
copy "C:\Program Files\PostgreSQL\18\data\pg_hba.conf" "C:\Program Files\PostgreSQL\18\data\pg_hba.conf.backup"

echo.
echo Step 2: Allowing trust authentication...
powershell -Command "(Get-Content 'C:\Program Files\PostgreSQL\18\data\pg_hba.conf') -replace 'scram-sha-256', 'trust' | Set-Content 'C:\Program Files\PostgreSQL\18\data\pg_hba.conf'"

echo.
echo Step 3: Restarting PostgreSQL...
net stop postgresql-x64-18
timeout /t 2 /nobreak >nul
net start postgresql-x64-18
timeout /t 3 /nobreak >nul

echo.
set /p NEWPASS="Enter NEW password (simple, no special characters): "

echo.
echo Step 4: Setting new password...
echo ALTER USER postgres PASSWORD '%NEWPASS%'; | "C:\Program Files\PostgreSQL\18\bin\psql.exe" -U postgres -d postgres

echo.
echo Step 5: Restoring security...
copy "C:\Program Files\PostgreSQL\18\data\pg_hba.conf.backup" "C:\Program Files\PostgreSQL\18\data\pg_hba.conf" /Y

echo.
echo Step 6: Restarting PostgreSQL...
net stop postgresql-x64-18
timeout /t 2 /nobreak >nul
net start postgresql-x64-18

echo.
echo ========================================
echo Password Reset Complete!
echo ========================================
echo.
echo New password: %NEWPASS%
echo.
echo IMPORTANT: Remember this password!
echo.
echo Now run: QUICK_DB_SETUP.bat
echo Use this new password: %NEWPASS%
echo.
pause
