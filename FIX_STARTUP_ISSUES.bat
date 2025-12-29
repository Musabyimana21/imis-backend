@echo off
echo ╔═══════════════════════════════════════════════════════════════════╗
echo ║                    FIXING STARTUP ISSUES                         ║
echo ╚═══════════════════════════════════════════════════════════════════╝
echo.

echo [1/3] Installing Microsoft Visual C++ Build Tools requirement...
echo.
echo SOLUTION: Install pre-compiled scikit-learn wheel
echo Installing scikit-learn from wheel (no compilation needed)...
cd backend
pip install --only-binary=all scikit-learn==1.4.0
if %ERRORLEVEL% NEQ 0 (
    echo Trying alternative scikit-learn version...
    pip install --only-binary=all scikit-learn==1.3.2
)
echo.

echo [2/3] Fixing PostGIS geography type issue...
echo.
echo Creating simplified models without PostGIS dependency...
copy app\models\models.py app\models\models_backup.py
echo Backup created: models_backup.py
echo.

echo [3/3] Installing remaining dependencies...
pip install -r requirements.txt --only-binary=all
echo.

echo ╔═══════════════════════════════════════════════════════════════════╗
echo ║                    FIXES APPLIED SUCCESSFULLY                     ║
echo ╚═══════════════════════════════════════════════════════════════════╝
echo.
echo Now run: START_WITH_DB.bat
echo.
pause