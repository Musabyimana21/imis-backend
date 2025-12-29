@echo off
echo Seeding Docker database...
docker-compose exec -T backend python seed_data.py
echo.
echo Done! Test accounts:
echo   Admin: admin@imis.rw / admin123
echo   User:  user1@imis.rw / password123
pause
