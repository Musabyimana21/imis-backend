@echo off
echo Starting IMIS Backend...
cd backend
start "IMIS Backend" cmd /k "python -m venv venv & venv\Scripts\activate & pip install -r requirements.txt & uvicorn app.main:app --reload"
cd ..

timeout /t 3 /nobreak >nul

echo Starting IMIS Frontend...
cd frontend
start "IMIS Frontend" cmd /k "npm install & npm run dev"
cd ..

echo.
echo IMIS is starting...
echo Backend: http://localhost:8000
echo Frontend: http://localhost:5173
echo.
echo Two windows opened. Close them to stop services.
pause
