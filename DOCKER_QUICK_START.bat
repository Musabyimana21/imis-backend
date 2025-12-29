@echo off
title IMIS Docker Quick Start
color 0E

echo ╔══════════════════════════════════════════════════════════════╗
echo ║                 IMIS DOCKER QUICK START                     ║
echo ║         Complete Setup in 3 Steps - 2 Minutes               ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.

echo Step 1: Starting IMIS Docker containers...
call START_IMIS_DOCKER.bat

echo.
echo Step 2: Adding test data...
call SEED_IMIS_DOCKER.bat

echo.
echo Step 3: Opening IMIS...
start http://localhost:5173

echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║                    IMIS IS READY!                           ║
echo ╠══════════════════════════════════════════════════════════════╣
echo ║  🌐 Frontend: http://localhost:5173                         ║
echo ║  🔧 Backend:  http://localhost:8000                         ║
echo ║  📚 API Docs: http://localhost:8000/docs                    ║
echo ║                                                              ║
echo ║  👨💼 Admin:   admin@imis.rw / admin123                       ║
echo ║  😢 Loser:   loser@imis.rw / lost123                        ║
echo ║  😊 Finder:  finder@imis.rw / found123                      ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.
echo 🎉 IMIS Docker setup complete! No more "Failed to fetch" errors!
pause