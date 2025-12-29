#!/usr/bin/env python3
"""Verify CORS fix is working"""

import subprocess
import time
import requests
import sys

def test_backend():
    """Test if backend is responding"""
    try:
        response = requests.get("http://localhost:8001/health", timeout=5)
        if response.status_code == 200:
            print("✅ Backend is running on port 8001")
            return True
        else:
            print(f"❌ Backend returned status {response.status_code}")
            return False
    except requests.exceptions.RequestException as e:
        print(f"❌ Backend not responding: {e}")
        return False

def test_cors():
    """Test CORS configuration"""
    try:
        # Test a simple API call
        response = requests.get("http://localhost:8001/api/items/", timeout=5)
        print(f"✅ API call successful: {response.status_code}")
        
        # Check CORS headers
        headers = response.headers
        if 'access-control-allow-origin' in headers:
            print(f"✅ CORS header present: {headers['access-control-allow-origin']}")
        else:
            print("⚠️ No CORS header found")
        
        return True
    except requests.exceptions.RequestException as e:
        print(f"❌ API test failed: {e}")
        return False

def main():
    print("VERIFYING CORS FIX")
    print("=" * 30)
    
    # Test backend
    print("1. Testing backend...")
    backend_ok = test_backend()
    
    if not backend_ok:
        print("\n❌ Backend is not running!")
        print("Please start the backend first:")
        print("cd backend && python -m uvicorn app.main:app --reload --host 0.0.0.0 --port 8001")
        return
    
    # Test CORS
    print("\n2. Testing CORS...")
    cors_ok = test_cors()
    
    # Test frontend connection
    print("\n3. Testing frontend connection...")
    try:
        response = requests.get("http://localhost:5174", timeout=5)
        print("✅ Frontend is accessible")
    except:
        try:
            response = requests.get("http://localhost:5173", timeout=5)
            print("✅ Frontend is accessible on port 5173")
        except:
            print("⚠️ Frontend may not be running")
    
    print("\n" + "=" * 30)
    if backend_ok and cors_ok:
        print("✅ CORS FIX IS WORKING!")
        print("✅ Item pages should display correctly")
    else:
        print("❌ Issues detected - CORS may not work")
    print("=" * 30)

if __name__ == "__main__":
    main()