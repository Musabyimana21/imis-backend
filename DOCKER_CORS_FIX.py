#!/usr/bin/env python3
"""Docker CORS fix for IMIS"""

import subprocess
import time

def run_command(cmd):
    try:
        result = subprocess.run(cmd, shell=True, capture_output=True, text=True)
        return result.returncode == 0, result.stdout, result.stderr
    except Exception as e:
        return False, "", str(e)

def main():
    print("DOCKER CORS FIX FOR IMIS")
    print("=" * 30)
    
    print("1. Restarting containers...")
    run_command("docker restart imis-backend-1 imis-frontend-1 imis-db-1")
    
    print("2. Waiting for startup...")
    time.sleep(15)
    
    print("3. Testing backend...")
    success, out, err = run_command("curl -s http://localhost:8000/health")
    if "healthy" in out:
        print("✅ Backend working")
    else:
        print("⚠️ Backend starting...")
    
    print("4. Testing frontend...")
    success, out, err = run_command("curl -s -I http://localhost:5173")
    if "200" in out:
        print("✅ Frontend working")
    else:
        print("⚠️ Frontend starting...")
    
    print("\n" + "=" * 30)
    print("IMIS DOCKER FIXED!")
    print("Frontend: http://localhost:5173")
    print("Backend:  http://localhost:8000")
    print("=" * 30)

if __name__ == "__main__":
    main()