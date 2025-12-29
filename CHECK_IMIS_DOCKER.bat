@echo off
title Check IMIS Docker Status
color 0B

echo ╔══════════════════════════════════════════════════════════════╗
echo ║                 IMIS DOCKER STATUS CHECK                    ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.

echo [1] Docker Containers:
docker ps --filter "name=imis" --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"

echo.
echo [2] IMIS Network:
docker network ls | findstr imis

echo.
echo [3] Backend Health Check:
curl -s http://localhost:8000/health

echo.
echo [4] Frontend Accessibility:
curl -s -I http://localhost:5173 | findstr "200\|404"

echo.
echo [5] Database Connection:
docker exec imis-database pg_isready -U imis

echo.
echo [6] Container Logs (last 10 lines):
echo --- Backend Logs ---
docker logs imis-api --tail 10

echo.
echo --- Frontend Logs ---
docker logs imis-web --tail 10

echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║  If all services show as running, IMIS should work properly  ║
echo ║  Access: http://localhost:5173                               ║
echo ╚══════════════════════════════════════════════════════════════╝
pause