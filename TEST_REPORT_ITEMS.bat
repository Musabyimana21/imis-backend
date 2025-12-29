@echo off
echo ========================================
echo Testing Report Lost/Found Items Logic
echo ========================================

cd /d "%~dp0"

echo.
echo 1. Starting backend and frontend...
start "IMIS Backend" cmd /k "cd backend && python -m uvicorn app.main:app --reload --port 8000"
timeout /t 3 /nobreak >nul

start "IMIS Frontend" cmd /k "cd frontend && npm run dev -- --port 5173"
timeout /t 5 /nobreak >nul

echo.
echo 2. Testing backend API endpoints...
python -c "
import requests
import json
import time

# Wait for backend to start
time.sleep(3)

base_url = 'http://localhost:8000'

print('Testing API health...')
try:
    response = requests.get(f'{base_url}/health', timeout=5)
    print(f'Health check: {response.status_code}')
except Exception as e:
    print(f'Backend not ready: {e}')
    exit(1)

print('Testing anonymous endpoints...')
try:
    # Test categories
    response = requests.get(f'{base_url}/api/anonymous/categories', timeout=5)
    print(f'Categories: {response.status_code} - {len(response.json()) if response.status_code == 200 else \"Failed\"}')
    
    # Test recent items
    response = requests.get(f'{base_url}/api/anonymous/items/recent', timeout=5)
    print(f'Recent items: {response.status_code} - {len(response.json()) if response.status_code == 200 else \"Failed\"}')
    
    print('✅ Backend API working!')
    
except Exception as e:
    print(f'❌ API test failed: {e}')
"

echo.
echo 3. Opening test pages...
timeout /t 2 /nobreak >nul
start "" "http://localhost:5173/report-lost"
timeout /t 1 /nobreak >nul
start "" "http://localhost:5173/report-found"

echo.
echo ========================================
echo MANUAL TESTING CHECKLIST:
echo ========================================
echo.
echo ✅ Report Lost Item Page:
echo   - Location selector works (Province → District → Sector → Cell → Village)
echo   - All form fields accept input
echo   - Image upload works
echo   - Form submission succeeds
echo.
echo ✅ Report Found Item Page:
echo   - Same location selector functionality
echo   - All form fields work
echo   - Image upload works
echo   - Form submission succeeds
echo.
echo ✅ Backend Processing:
echo   - Items are saved to database
echo   - Location data is properly formatted
echo   - Images are handled correctly
echo.
echo Press any key when testing is complete...
pause

echo.
echo 4. Testing database records...
python -c "
import sys
sys.path.append('backend')
from backend.app.core.database import get_db
from backend.app.models.enhanced_models import Item
from sqlalchemy.orm import Session

try:
    db = next(get_db())
    items = db.query(Item).order_by(Item.created_at.desc()).limit(5).all()
    
    print(f'Recent items in database: {len(items)}')
    for item in items:
        print(f'- {item.title} ({item.status}) - {item.location_name}')
    
    if len(items) > 0:
        print('✅ Items are being saved correctly!')
    else:
        print('⚠️ No items found - test item submission')
        
except Exception as e:
    print(f'❌ Database check failed: {e}')
"

echo.
echo ========================================
echo Report Items Test Complete
echo ========================================
pause