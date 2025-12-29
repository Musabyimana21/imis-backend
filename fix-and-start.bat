@echo off
echo Fixing Docker configuration and starting IMIS...
echo.

echo Stopping any running containers...
docker-compose down

echo.
echo Removing old containers and volumes...
docker-compose rm -f
docker volume prune -f

echo.
echo Starting fresh containers...
docker-compose up --build -d

echo.
echo Waiting for services to start...
timeout /t 15 /nobreak >nul

echo.
echo Checking service status...
docker-compose ps

echo.
echo ========================================
echo IMIS should now be running!
echo Frontend: http://localhost:5173
echo Backend: http://localhost:8000
echo API Docs: http://localhost:8000/docs
echo ========================================
echo.
echo To view logs: docker-compose logs -f
echo To stop: docker-compose down
echo.
pause
