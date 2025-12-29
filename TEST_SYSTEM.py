#!/usr/bin/env python3
"""Test IMIS system to ensure everything is working"""

import requests
import time
import json

def test_backend():
    """Test backend endpoints"""
    print("Testing Backend...")
    
    try:
        # Test health endpoint
        response = requests.get("http://localhost:8001/health", timeout=5)
        if response.status_code == 200:
            print("✅ Backend health check: OK")
            return True
        else:
            print(f"❌ Backend health check failed: {response.status_code}")
            return False
    except Exception as e:
        print(f"❌ Backend not responding: {e}")
        return False

def test_cors():
    """Test CORS configuration"""
    print("Testing CORS...")
    
    try:
        # Test anonymous items endpoint
        response = requests.get("http://localhost:8001/api/anonymous/items", timeout=5)
        print(f"✅ Anonymous items API: {response.status_code}")
        
        # Check CORS headers
        headers = response.headers
        if 'access-control-allow-origin' in headers:
            print(f"✅ CORS header: {headers['access-control-allow-origin']}")
        
        return response.status_code == 200
    except Exception as e:
        print(f"❌ CORS test failed: {e}")
        return False

def test_frontend():
    """Test frontend accessibility"""
    print("Testing Frontend...")
    
    ports = [5173, 5174]
    for port in ports:
        try:
            response = requests.get(f"http://localhost:{port}", timeout=5)
            if response.status_code == 200:
                print(f"✅ Frontend accessible on port {port}")
                return port
        except:
            continue
    
    print("❌ Frontend not accessible")
    return None

def test_report_endpoint():
    """Test report endpoint"""
    print("Testing Report Endpoint...")
    
    test_data = {
        "reporter_name": "Test User",
        "reporter_phone": "+250788123456",
        "title": "Test Item",
        "description": "Test description",
        "category": "phone",
        "status": "lost",
        "location": {
            "province": "Kigali",
            "district": "Gasabo",
            "sector": "Kacyiru",
            "cell": "Kamatamu",
            "village": "Test",
            "isibo": ""
        }
    }
    
    try:
        response = requests.post(
            "http://localhost:8001/api/anonymous/report",
            json=test_data,
            timeout=10
        )
        if response.status_code == 200:
            result = response.json()
            print(f"✅ Report endpoint working: {result.get('message', 'Success')}")
            return True
        else:
            print(f"❌ Report endpoint failed: {response.status_code}")
            print(f"Response: {response.text}")
            return False
    except Exception as e:
        print(f"❌ Report test failed: {e}")
        return False

def main():
    print("IMIS SYSTEM TEST")
    print("=" * 30)
    
    # Test backend
    backend_ok = test_backend()
    
    # Test CORS
    cors_ok = test_cors()
    
    # Test frontend
    frontend_port = test_frontend()
    
    # Test report endpoint
    report_ok = test_report_endpoint()
    
    print("\n" + "=" * 30)
    print("TEST RESULTS")
    print("=" * 30)
    
    if backend_ok and cors_ok and frontend_port and report_ok:
        print("🎉 ALL TESTS PASSED!")
        print(f"✅ Backend: http://localhost:8001")
        print(f"✅ Frontend: http://localhost:{frontend_port}")
        print(f"✅ Report Lost: http://localhost:{frontend_port}/report-lost")
        print(f"✅ Report Found: http://localhost:{frontend_port}/report-found")
        print("\n🚀 SYSTEM IS FULLY WORKING!")
    else:
        print("❌ SOME TESTS FAILED")
        if not backend_ok:
            print("- Backend not working")
        if not cors_ok:
            print("- CORS not configured properly")
        if not frontend_port:
            print("- Frontend not accessible")
        if not report_ok:
            print("- Report endpoint not working")

if __name__ == "__main__":
    main()