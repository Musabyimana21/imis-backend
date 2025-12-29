@echo off
title Stop IMIS Docker
color 0C

echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║                    STOP IMIS DOCKER                         ║
echo ║              Ishakiro Information Management System          ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.

echo [1/3] Stopping IMIS containers...
docker-compose -p imis down

echo.
echo [2/3] Removing IMIS containers...
docker rm imis-web imis-api imis-database 2>nul

echo.
echo [3/3] Cleaning up IMIS network...
docker network rm imis-network 2>nul

echo.
echo ✅ IMIS Docker containers stopped successfully!
echo.
echo To start again: START_IMIS_DOCKER.bat
echo.
pause