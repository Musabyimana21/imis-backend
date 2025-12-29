@echo off
echo Installing missing email-validator package...
cd backend
python -m pip install email-validator pydantic[email]
cd ..
echo.
echo Fixed! Now close the backend window and run QUICK_START.bat again.
pause
