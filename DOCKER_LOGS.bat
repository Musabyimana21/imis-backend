@echo off
echo IMIS DOCKER CONTAINER LOGS
echo ==========================

echo Backend logs:
docker logs imis-backend-1 --tail 20

echo.
echo Frontend logs:
docker logs imis-frontend-1 --tail 20

echo.
echo Database logs:
docker logs imis-db-1 --tail 10

pause