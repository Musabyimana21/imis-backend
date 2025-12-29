@echo off
echo Fixed DATABASE_URL in backend\.env
echo.
echo The @ symbol in your password was breaking the connection.
echo It's now URL-encoded as %%40
echo.
echo Close the backend window and run START_WITH_DB.bat again
pause
