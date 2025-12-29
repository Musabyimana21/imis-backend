@echo off
color 0A
cls
echo ╔══════════════════════════════════════════════════════════╗
echo ║     ISHAKIRO - DOCKER REBUILD FROM SCRATCH              ║
echo ╚══════════════════════════════════════════════════════════╝
echo.

echo [1/5] Stopping all containers...
docker-compose down -v
echo.

echo [2/5] Removing old images...
docker system prune -af --volumes
echo.

echo [3/5] Building fresh containers...
docker-compose build --no-cache
echo.

echo [4/5] Starting all services...
docker-compose up -d
echo.

echo [5/5] Waiting for services...
timeout /t 15 >nul

echo.
echo ╔══════════════════════════════════════════════════════════╗
echo ║              ISHAKIRO DOCKER READY!                      ║
echo ╚══════════════════════════════════════════════════════════╝
echo.
echo Frontend:  http://localhost:5173
echo Backend:   http://localhost:8000
echo Database:  localhost:5433
echo.
echo View logs: docker-compose logs -f
echo.
pause
