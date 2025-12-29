#!/usr/bin/env python3
"""Simple IMIS starter without process killing"""

import subprocess
import time
import os

def main():
    print("SIMPLE IMIS STARTER")
    print("=" * 30)
    
    # Change to backend directory and start
    print("1. Starting backend on port 8001...")
    backend_process = subprocess.Popen(
        "python -m uvicorn app.main:app --reload --host 0.0.0.0 --port 8001",
        shell=True,
        cwd="backend"
    )
    
    time.sleep(3)
    
    # Change to frontend directory and start
    print("2. Starting frontend...")
    frontend_process = subprocess.Popen(
        "npm run dev",
        shell=True,
        cwd="frontend"
    )
    
    print("\n" + "=" * 30)
    print("IMIS STARTED!")
    print("=" * 30)
    print("Frontend: http://localhost:5173")
    print("Backend:  http://localhost:8001")
    print("\nPress Ctrl+C to stop")
    
    try:
        # Keep script running
        while True:
            time.sleep(1)
    except KeyboardInterrupt:
        print("\nStopping services...")
        backend_process.terminate()
        frontend_process.terminate()

if __name__ == "__main__":
    main()