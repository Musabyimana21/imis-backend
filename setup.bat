@echo off
echo ========================================
echo IMIS Automated Setup Script
echo ========================================
echo.

REM Check if Docker is available
docker --version >nul 2>&1
if %errorlevel% equ 0 (
    echo Docker detected. Using Docker setup...
    echo.
    call :docker_setup
) else (
    echo Docker not found. Using manual setup...
    echo.
    call :manual_setup
)

goto :end

:docker_setup
echo Starting Docker Compose...
docker-compose up -d --build
echo.
echo Waiting for services to start...
timeout /t 10 /nobreak >nul
echo.
echo ========================================
echo IMIS is running!
echo Frontend: http://localhost:5173
echo Backend: http://localhost:8000
echo API Docs: http://localhost:8000/docs
echo ========================================
echo.
echo To stop: docker-compose down
echo To view logs: docker-compose logs -f
goto :eof

:manual_setup
echo Setting up backend...
cd backend

REM Create .env if not exists
if not exist .env (
    copy .env.example .env
    echo Created backend .env file
)

REM Create virtual environment
if not exist venv (
    python -m venv venv
    echo Created Python virtual environment
)

REM Activate and install dependencies
call venv\Scripts\activate
pip install -r requirements.txt >nul 2>&1
echo Backend dependencies installed

REM Start backend in background
start /B cmd /c "venv\Scripts\activate && uvicorn app.main:app --reload"
echo Backend starting on http://localhost:8000

cd ..

echo.
echo Setting up frontend...
cd frontend

REM Create .env if not exists
if not exist .env (
    copy .env.example .env
    echo Created frontend .env file
)

REM Install dependencies
if not exist node_modules (
    call npm install
    echo Frontend dependencies installed
)

REM Start frontend
start /B cmd /c "npm run dev"
echo Frontend starting on http://localhost:5173

cd ..

echo.
echo Waiting for services to start...
timeout /t 5 /nobreak >nul

echo.
echo ========================================
echo IMIS is running!
echo Frontend: http://localhost:5173
echo Backend: http://localhost:8000
echo API Docs: http://localhost:8000/docs
echo ========================================
echo.
echo Press Ctrl+C to stop services
goto :eof

:end
pause
