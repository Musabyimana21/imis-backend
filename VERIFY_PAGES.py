#!/usr/bin/env python3
"""Verify IMIS pages are working correctly"""

import requests
import json

def test_api():
    """Test API endpoints"""
    print("Testing API endpoints...")
    
    try:
        # Test health
        response = requests.get("http://localhost:8001/health", timeout=5)
        print(f"✅ Health check: {response.status_code}")
        
        # Test items
        response = requests.get("http://localhost:8001/api/anonymous/items", timeout=5)
        print(f"✅ Items API: {response.status_code}")
        
        if response.status_code == 200:
            items = response.json()
            print(f"   Found {len(items)} items")
            if items:
                print(f"   Sample item ID: {items[0]['id']}")
                print(f"   Sample item title: {items[0]['title']}")
        
        return True
    except Exception as e:
        print(f"❌ API Error: {e}")
        return False

def test_frontend():
    """Test frontend pages"""
    print("\nTesting frontend pages...")
    
    pages = [
        ("http://localhost:5174/", "Homepage"),
        ("http://localhost:5173/", "Homepage (alt port)"),
    ]
    
    for url, name in pages:
        try:
            response = requests.get(url, timeout=5)
            print(f"✅ {name}: {response.status_code}")
        except Exception as e:
            print(f"❌ {name}: {e}")

def main():
    print("IMIS PAGE VERIFICATION")
    print("=" * 30)
    
    api_ok = test_api()
    test_frontend()
    
    print("\n" + "=" * 30)
    if api_ok:
        print("✅ API is working")
        print("✅ Try: http://localhost:5174/item/8")
        print("✅ Or: http://localhost:5173/item/8")
    else:
        print("❌ API issues detected")
        print("❌ Start backend first!")

if __name__ == "__main__":
    main()