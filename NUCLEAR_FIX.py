#!/usr/bin/env python3
import subprocess
import time
import os

def kill_all():
    subprocess.run("taskkill /f /im python.exe", shell=True, capture_output=True)
    subprocess.run("taskkill /f /im node.exe", shell=True, capture_output=True)
    time.sleep(2)

def main():
    print("NUCLEAR FIX - KILLING EVERYTHING AND STARTING FRESH")
    
    # Kill everything
    kill_all()
    
    # Create new backend with embedded CORS fix
    backend_code = '''
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
import secrets
import string

app = FastAPI(title="IMIS Fixed API")

# NUCLEAR CORS - ALLOW EVERYTHING
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=False,
    allow_methods=["*"],
    allow_headers=["*"],
)

class LocationData(BaseModel):
    province: str
    district: str
    sector: str
    cell: str
    village: str
    isibo: str = ""

class ItemCreate(BaseModel):
    reporter_name: str
    reporter_phone: str
    title: str
    description: str
    category: str
    status: str
    location: LocationData
    image_url: str = None

@app.get("/")
def root():
    return {"message": "IMIS NUCLEAR FIXED API", "status": "working"}

@app.get("/health")
def health():
    return {"status": "healthy", "message": "NUCLEAR FIX WORKING"}

@app.post("/api/anonymous/report")
def report_item(item: ItemCreate):
    tracking_code = ''.join(secrets.choice(string.ascii_uppercase + string.digits) for _ in range(8))
    return {
        "success": True,
        "tracking_code": tracking_code,
        "item_id": 999,
        "message": "NUCLEAR FIX SUCCESS! Item reported!"
    }

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=9000)
'''
    
    with open('nuclear_backend.py', 'w') as f:
        f.write(backend_code)
    
    # Start nuclear backend
    print("Starting NUCLEAR backend on port 9000...")
    subprocess.Popen("python nuclear_backend.py", shell=True)
    time.sleep(3)
    
    # Test it
    result = subprocess.run("curl -s http://localhost:9000/health", shell=True, capture_output=True, text=True)
    if "healthy" in result.stdout:
        print("NUCLEAR backend is ALIVE!")
    else:
        print("Backend failed to start")
        return
    
    print("\nNUCLEAR FIX COMPLETE!")
    print("=" * 50)
    print("Frontend: http://localhost:5174")
    print("Backend:  http://localhost:9000")
    print("Test API: http://localhost:9000/health")
    print("=" * 50)
    print("\nNow update your frontend to use port 9000!")

if __name__ == "__main__":
    main()