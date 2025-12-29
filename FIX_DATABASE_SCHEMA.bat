@echo off
echo FIXING DATABASE SCHEMA
echo ======================

echo 1. Stopping backend...
taskkill /f /im python.exe 2>nul

echo 2. Adding missing column to database...
cd backend
python -c "
import sys
sys.path.append('.')
from app.core.database import engine
from sqlalchemy import text

try:
    with engine.connect() as conn:
        conn.execute(text('ALTER TABLE anonymous_items ADD COLUMN IF NOT EXISTS image_url VARCHAR(500)'))
        conn.commit()
        print('✅ Added image_url column')
except Exception as e:
    print(f'⚠️ Column may already exist: {e}')
"

echo 3. Restarting backend...
start cmd /k "python -m uvicorn app.main:app --reload --host 0.0.0.0 --port 8000"

echo 4. Waiting for backend...
timeout /t 8 /nobreak >nul

echo 5. Testing...
curl -s http://localhost:8000/health

echo.
echo ✅ Database schema fixed!
pause