@echo off
echo Killing Node and Python processes...

REM Kill Node processes
taskkill /f /im node.exe >nul 2>&1
if %errorlevel% equ 0 echo Node processes killed

REM Kill Python processes  
taskkill /f /im python.exe >nul 2>&1
if %errorlevel% equ 0 echo Python processes killed

REM Kill any remaining uvicorn processes
taskkill /f /im uvicorn.exe >nul 2>&1

echo Done! Processes should be stopped.
timeout /t 2 >nul