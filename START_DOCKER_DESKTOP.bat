@echo off
echo STARTING DOCKER DESKTOP
echo ======================

echo Starting Docker Desktop...
start "" "C:\Program Files\Docker\Docker\Docker Desktop.exe"

echo Waiting for Docker Desktop to start...
timeout /t 30 /nobreak >nul

echo Testing Docker...
docker --version

echo.
echo Docker Desktop should now be running.
echo Run RESTART_IMIS_DOCKER.bat again.
pause