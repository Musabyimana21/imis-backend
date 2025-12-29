@echo off
echo FIXING IMIS DOCKER CONTAINERS
echo ===============================

echo 1. Restarting containers...
docker restart imis-db-1 imis-backend-1 imis-frontend-1

echo 2. Waiting for startup...
timeout /t 10 /nobreak >nul

echo 3. Testing backend...
curl -s http://localhost:8000/health

echo 4. Testing frontend...
curl -s -I http://localhost:5173

echo 5. Container status:
docker ps --filter "name=imis"

echo.
echo IMIS should now be working:
echo Frontend: http://localhost:5173
echo Backend:  http://localhost:8000
pause