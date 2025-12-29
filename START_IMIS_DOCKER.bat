@echo off
title IMIS Docker Startup
color 0A

echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║                    IMIS DOCKER STARTUP                      ║
echo ║              Ishakiro Information Management System          ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.

echo [1/8] Checking Docker Desktop...
docker --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Docker not found! Please install Docker Desktop.
    pause
    exit /b 1
)
echo ✅ Docker is available

echo.
echo [2/8] Stopping any existing containers...
docker stop imis-web imis-api imis-database 2>nul
docker rm imis-web imis-api imis-database 2>nul

echo.
echo [3/8] Cleaning up old IMIS images...
docker rmi imis-backend imis-frontend imis_backend imis_frontend 2>nul

echo.
echo [4/8] Building IMIS containers (this may take a few minutes)...
docker-compose -p imis build --no-cache
if %errorlevel% neq 0 (
    echo ❌ Build failed! Check the error above.
    pause
    exit /b 1
)
echo ✅ Build completed successfully

echo.
echo [5/8] Starting IMIS services...
docker-compose -p imis up -d
if %errorlevel% neq 0 (
    echo ❌ Failed to start services!
    pause
    exit /b 1
)

echo.
echo [6/8] Waiting for services to initialize...
echo     Database starting...
timeout /t 15 /nobreak >nul
echo     Backend starting...
timeout /t 10 /nobreak >nul
echo     Frontend starting...
timeout /t 5 /nobreak >nul

echo.
echo [7/8] Checking service health...
echo.
echo Container Status:
docker ps --filter "name=imis" --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"

echo.
echo Testing Backend Health:
for /l %%i in (1,1,5) do (
    curl -s http://localhost:8000/health >nul 2>&1
    if !errorlevel! equ 0 (
        echo ✅ Backend is healthy
        goto :backend_ready
    )
    echo ⏳ Waiting for backend... (attempt %%i/5)
    timeout /t 3 /nobreak >nul
)
echo ⚠️ Backend may still be starting...

:backend_ready
echo.
echo [8/8] IMIS Docker Setup Complete!
echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║                      ACCESS POINTS                          ║
echo ╠══════════════════════════════════════════════════════════════╣
echo ║  🌐 Frontend:    http://localhost:5173                      ║
echo ║  🔧 Backend API: http://localhost:8000                      ║
echo ║  📚 API Docs:    http://localhost:8000/docs                 ║
echo ║  🗄️ Database:    localhost:5433 (imis/imis123)              ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║                     TEST ACCOUNTS                           ║
echo ╠══════════════════════════════════════════════════════════════╣
echo ║  👨‍💼 Admin:  admin@imis.rw / admin123                        ║
echo ║  😢 Loser:  loser@imis.rw / lost123                         ║
echo ║  😊 Finder: finder@imis.rw / found123                       ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.

echo Opening IMIS in your browser...
timeout /t 3 /nobreak >nul
start http://localhost:5173

echo.
echo 🎉 IMIS is now running in Docker containers!
echo.
echo To stop IMIS: docker-compose -p imis down
echo To view logs: docker-compose -p imis logs -f
echo.
pause