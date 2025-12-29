"""
Keep Render backend alive by pinging every 10 minutes
Run this on your local machine or deploy to a free service
"""
import requests
import time
from datetime import datetime

BACKEND_URL = "https://imis-backend-wk7z.onrender.com/health"
PING_INTERVAL = 600  # 10 minutes (600 seconds)

def ping_backend():
    """Ping the backend to keep it alive"""
    try:
        response = requests.get(BACKEND_URL, timeout=30)
        if response.status_code == 200:
            print(f"✅ [{datetime.now()}] Backend alive: {response.json()}")
        else:
            print(f"⚠️ [{datetime.now()}] Backend responded with: {response.status_code}")
    except Exception as e:
        print(f"❌ [{datetime.now()}] Error pinging backend: {e}")

if __name__ == "__main__":
    print(f"🚀 Starting keep-alive service for {BACKEND_URL}")
    print(f"⏰ Pinging every {PING_INTERVAL} seconds (10 minutes)")
    print("Press Ctrl+C to stop\n")
    
    while True:
        ping_backend()
        time.sleep(PING_INTERVAL)
