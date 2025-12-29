@echo off
echo Searching for PostgreSQL installation...
echo.

REM Check common locations
for %%d in (C D E F) do (
    if exist "%%d:\Program Files\PostgreSQL" (
        echo [FOUND] %%d:\Program Files\PostgreSQL
        dir "%%d:\Program Files\PostgreSQL" /b
    )
    if exist "%%d:\PostgreSQL" (
        echo [FOUND] %%d:\PostgreSQL
        dir "%%d:\PostgreSQL" /b
    )
)

echo.
echo Checking services...
sc query | findstr /i "postgres"

echo.
echo Checking psql command...
where psql

echo.
pause
