@echo off
echo RESTARTING IMIS DOCKER CONTAINERS
echo =================================

echo Stopping containers...
docker stop imis-backend-1 imis-frontend-1 imis-db-1

echo Starting containers...
docker start imis-db-1
timeout /t 5 /nobreak >nul
docker start imis-backend-1
timeout /t 5 /nobreak >nul
docker start imis-frontend-1

echo Waiting for services...
timeout /t 10 /nobreak >nul

echo Testing backend:
curl -s http://localhost:8000/health

echo.
echo IMIS Docker restarted!
echo Frontend: http://localhost:5173
echo Backend:  http://localhost:8000
start http://localhost:5173
pause