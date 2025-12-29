@echo off
color 0A
cls
echo.
echo ╔══════════════════════════════════════════════════════════╗
echo ║     ISHAKIRO - DOCKER COMPLETE REBUILD                  ║
echo ║     Building from Scratch                                ║
echo ╚══════════════════════════════════════════════════════════╝
echo.

echo [1/6] Stopping all containers...
docker-compose down -v
echo ✅ Containers stopped
echo.

echo [2/6] Removing old images...
docker-compose rm -f
docker system prune -f
echo ✅ Old images removed
echo.

echo [3/6] Building fresh images...
docker-compose build --no-cache
echo ✅ Images built
echo.

echo [4/6] Starting containers...
docker-compose up -d
echo ✅ Containers starting
echo.

echo [5/6] Waiting for services (30 seconds)...
timeout /t 30 >nul
echo.

echo [6/6] Checking status...
docker-compose ps
echo.

echo ╔══════════════════════════════════════════════════════════╗
echo ║              🎉 DOCKER REBUILD COMPLETE! 🎉             ║
echo ╚══════════════════════════════════════════════════════════╝
echo.
echo 🌐 Access Points:
echo    Frontend:  http://localhost:5173
echo    Backend:   http://localhost:8000
echo    Database:  localhost:5433
echo.
echo 📋 View Logs:
echo    docker-compose logs -f
echo.
echo 🛑 Stop Containers:
echo    docker-compose down
echo.
pause
