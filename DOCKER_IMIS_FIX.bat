@echo off
echo ========================================
echo IMIS DOCKER CONTAINER FIX
echo ========================================
echo.

echo 1. Stopping ALL containers (including morning_quiz)...
docker stop $(docker ps -aq) 2>nul
docker rm $(docker ps -aq) 2>nul

echo.
echo 2. Removing old IMIS images...
docker rmi imis-backend imis-frontend 2>nul
docker rmi imis_backend imis_frontend 2>nul

echo.
echo 3. Cleaning Docker system...
docker system prune -f

echo.
echo 4. Building IMIS containers with proper names...
docker-compose -p imis build --no-cache

echo.
echo 5. Starting IMIS containers...
docker-compose -p imis up -d

echo.
echo 6. Waiting for containers to start...
timeout /t 10 /nobreak >nul

echo.
echo 7. Checking IMIS container status...
docker-compose -p imis ps

echo.
echo 8. Testing IMIS backend health...
timeout /t 5 /nobreak >nul
curl -s http://localhost:8000/health

echo.
echo ========================================
echo IMIS DOCKER STATUS
echo ========================================
echo Frontend: http://localhost:5173
echo Backend:  http://localhost:8000
echo API Docs: http://localhost:8000/docs
echo.
echo Container Names:
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"

echo.
echo ========================================
echo IMIS is now running in Docker!
echo ========================================
pause