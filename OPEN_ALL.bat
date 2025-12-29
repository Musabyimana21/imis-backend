@echo off
title Opening IMIS Resources
color 0C

echo.
echo Opening all IMIS resources...
echo.

REM Open documentation
start notepad QUICK_REFERENCE.txt
timeout /t 1 /nobreak >nul

start notepad SYSTEM_READY.md
timeout /t 1 /nobreak >nul

REM Open browser tabs
start http://localhost:5173
timeout /t 1 /nobreak >nul

start http://localhost:8000/docs
timeout /t 1 /nobreak >nul

start http://localhost:8000/health
timeout /t 1 /nobreak >nul

echo.
echo All resources opened!
echo.
echo If services aren't running, run START_EVERYTHING.bat first
echo.
pause
