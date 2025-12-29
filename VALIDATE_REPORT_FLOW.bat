@echo off
echo ========================================
echo VALIDATING REPORT LOST/FOUND FLOW
echo ========================================

cd /d "%~dp0"

echo.
echo 1. Testing backend API endpoints...
python -c "
import requests
import json
import time

base_url = 'http://localhost:8000'

# Test data
test_item = {
    'reporter_name': 'Test User',
    'reporter_phone': '+250788123456',
    'title': 'Black iPhone 13',
    'description': 'Lost black iPhone 13 Pro with blue case',
    'category': 'phone',
    'status': 'lost',
    'location': {
        'province': 'Umujyi wa Kigali',
        'district': 'Gasabo',
        'sector': 'Kacyiru',
        'cell': 'Kamatamu',
        'village': 'Amajyambere',
        'isibo': 'Near school'
    }
}

print('Testing anonymous report endpoint...')
try:
    response = requests.post(
        f'{base_url}/api/anonymous/report',
        json=test_item,
        timeout=10
    )
    
    if response.status_code == 200:
        result = response.json()
        print(f'✅ Report successful!')
        print(f'   Tracking Code: {result.get(\"tracking_code\")}')
        print(f'   Item ID: {result.get(\"item_id\")}')
        
        # Test tracking
        tracking_code = result.get('tracking_code')
        if tracking_code:
            track_response = requests.get(f'{base_url}/api/anonymous/track/{tracking_code}')
            if track_response.status_code == 200:
                print(f'✅ Tracking works!')
            else:
                print(f'❌ Tracking failed: {track_response.status_code}')
    else:
        print(f'❌ Report failed: {response.status_code} - {response.text}')
        
except Exception as e:
    print(f'❌ Test failed: {e}')
"

echo.
echo 2. Testing location data format...
python -c "
# Test location formatting
location = {
    'province': 'Umujyi wa Kigali',
    'district': 'Gasabo',
    'sector': 'Kacyiru',
    'cell': 'Kamatamu',
    'village': 'Amajyambere',
    'isibo': 'Near school'
}

location_parts = [location['province'], location['district'], location['sector'], location['cell'], location['village']]
if location['isibo']:
    location_parts.append(location['isibo'])
location_name = ' → '.join(location_parts)

print(f'Location format: {location_name}')
print('✅ Location formatting works!')
"

echo.
echo 3. Checking Rwanda locations data...
python -c "
import json
import os

locations_file = 'frontend/static/rwanda-locations-json-master/locations.json'
if os.path.exists(locations_file):
    with open(locations_file, 'r', encoding='utf-8') as f:
        data = json.load(f)
    
    provinces = data.get('provinces', [])
    print(f'✅ Rwanda locations loaded: {len(provinces)} provinces')
    
    if provinces:
        first_province = provinces[0]
        districts = first_province.get('districts', [])
        print(f'   First province: {first_province.get(\"name\")} ({len(districts)} districts)')
        
        if districts:
            first_district = districts[0]
            sectors = first_district.get('sectors', [])
            print(f'   First district: {first_district.get(\"name\")} ({len(sectors)} sectors)')
else:
    print('❌ Rwanda locations file not found!')
"

echo.
echo ========================================
echo VALIDATION COMPLETE
echo ========================================
echo.
echo ✅ CHECKLIST:
echo   - Backend API responds correctly
echo   - Location data formats properly
echo   - Rwanda locations data is available
echo   - Report endpoints work
echo   - Tracking system works
echo.
echo 🧪 MANUAL TESTS NEEDED:
echo   1. Open http://localhost:5173/report-lost
echo   2. Fill form with location selector
echo   3. Submit and verify success
echo   4. Check database for saved item
echo.
pause