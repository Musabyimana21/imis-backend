@echo off
echo FORCE KILLING ALL PROCESSES...
echo ================================

REM Kill Python processes more aggressively
wmic process where "name='python.exe'" delete
timeout /t 2 /nobreak >nul

REM Kill Node processes
wmic process where "name='node.exe'" delete
timeout /t 2 /nobreak >nul

REM Kill any remaining processes by port
for /f "tokens=5" %%a in ('netstat -aon ^| find ":8001" ^| find "LISTENING"') do taskkill /f /pid %%a 2>nul
for /f "tokens=5" %%a in ('netstat -aon ^| find ":8001" ^| find "LISTENING"') do taskkill /f /pid %%a 2>nul
for /f "tokens=5" %%a in ('netstat -aon ^| find ":5173" ^| find "LISTENING"') do taskkill /f /pid %%a 2>nul

echo [OK] All processes killed
timeout /t 3 /nobreak >nul