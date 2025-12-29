@echo off
echo ========================================
echo Testing Frontend Design Updates
echo ========================================
echo.
echo Changes Made:
echo [1] Header - Modern gradient background (purple)
echo [2] Header buttons - Glass morphism style
echo [3] Hero buttons - Compact with gradients and icons
echo [4] Reduced spacing between sections
echo.
echo Starting frontend...
cd frontend
start cmd /k "npm run dev"
echo.
echo Frontend starting on http://localhost:5173
echo.
echo Check these features:
echo - Header has purple gradient background
echo - Navigation links have hover effects
echo - "I Lost Something" button is orange gradient
echo - "I Found Something" button is green gradient
echo - Less space between hero and items section
echo.
pause
