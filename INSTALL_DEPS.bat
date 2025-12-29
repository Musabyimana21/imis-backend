@echo off
echo Installing IMIS Dependencies...
echo.

echo Step 1: Backend Dependencies
cd backend
if not exist venv (
    echo Creating virtual environment...
    python -m venv venv
)
call venv\Scripts\activate
echo Installing Python packages...
pip install -r requirements.txt
cd ..

echo.
echo Step 2: Frontend Dependencies
cd frontend
echo Installing Node packages...
npm install
cd ..

echo.
echo ========================================
echo Dependencies installed successfully!
echo ========================================
echo.
echo Now run: RUN_NOW.bat
pause
