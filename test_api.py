import requests
import json
import time

print("Testing IMIS Report API...")

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

try:
    print("Testing report endpoint...")
    response = requests.post(f'{base_url}/api/anonymous/report', json=test_item, timeout=10)
    
    if response.status_code == 200:
        result = response.json()
        print(f"✅ Success! Tracking: {result.get('tracking_code')}")
    else:
        print(f"❌ Failed: {response.status_code}")
        
except Exception as e:
    print(f"❌ Error: {e}")
    print("Make sure backend is running on port 8000")