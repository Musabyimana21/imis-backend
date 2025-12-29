@echo off
echo Stopping IMIS services...

REM Check if Docker is running
docker ps >nul 2>&1
if %errorlevel% equ 0 (
    echo Stopping Docker containers...
    docker-compose down
) else (
    echo Stopping manual services...
    for /f "tokens=5" %%a in ('netstat -ano ^| findstr ":8001" 2^>nul') do taskkill /F /PID %%a 2>nul
    for /f "tokens=5" %%a in ('netstat -ano ^| findstr ":5173" 2^>nul') do taskkill /F /PID %%a 2>nul
)

echo IMIS services stopped.
pause
