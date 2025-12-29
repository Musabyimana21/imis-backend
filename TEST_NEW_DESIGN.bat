@echo off
echo ========================================
echo Testing New Item Card Design
echo ========================================

cd /d "%~dp0"

echo Restarting backend...
taskkill /f /im python.exe 2>nul
timeout /t 2 /nobreak >nul

cd backend
start "Backend" cmd /k "python -m uvicorn app.main:app --reload --port 8000"
timeout /t 5 /nobreak >nul

cd ..
echo Opening test pages...
start "" "http://localhost:5173/report-lost"
timeout /t 2 /nobreak >nul
start "" "http://localhost:5173"

echo.
echo ========================================
echo NEW DESIGN FEATURES:
echo ========================================
echo.
echo ✅ Centered beautiful card layout
echo ✅ Item image display (if uploaded)
echo ✅ Fallback to category icons
echo ✅ Gradient backgrounds
echo ✅ Better typography and spacing
echo ✅ Responsive design
echo.
echo Test by:
echo 1. Report a lost item
echo 2. View the item detail page
echo 3. Check the new card design
echo.
pause