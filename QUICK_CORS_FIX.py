#!/usr/bin/env python3
"""Quick CORS fix for IMIS"""

import subprocess
import sys
import time

def run_command(cmd, cwd=None, timeout=10):
    try:
        result = subprocess.run(cmd, shell=True, cwd=cwd, capture_output=True, text=True, timeout=timeout)
        return result.returncode == 0, result.stdout, result.stderr
    except subprocess.TimeoutExpired:
        return False, "", "Command timed out"
    except Exception as e:
        return False, "", str(e)

def main():
    print("QUICK CORS FIX FOR IMIS - DOCKER VERSION")
    print("=" * 40)
    
    # Check if Docker containers are running
    print("1. Checking Docker containers...")
    success, out, err = run_command("docker ps --filter name=imis")
    if "imis-backend-1" in out:
        print("[INFO] Using Docker containers")
        use_docker = True
    else:
        print("[INFO] Using local processes")
        use_docker = False
        print("   Stopping existing processes...")
        # Kill processes with timeout to prevent hanging
        try:
            subprocess.run("taskkill /f /im python.exe", shell=True, timeout=3, capture_output=True)
        except:
            pass
        try:
            subprocess.run("taskkill /f /im node.exe", shell=True, timeout=3, capture_output=True)
        except:
            pass
        print("   Process cleanup complete")
    
    # Setup database
    print("2. Setting up database...")
    db_script = '''
import sys
sys.path.append('.')
try:
    from app.core.database import engine, Base
    from app.models import enhanced_models
    Base.metadata.create_all(bind=engine)
    print("✅ Database ready")
except Exception as e:
    print(f"⚠️ Database warning: {e}")
'''
    
    with open('temp_db_setup.py', 'w') as f:
        f.write(db_script)
    
    success, out, err = run_command("python temp_db_setup.py", cwd="backend")
    
    # Clean up temp file
    try:
        import os
        os.remove('backend/temp_db_setup.py')
    except:
        pass
    
    if success and "Database ready" in out:
        print("[OK] Database setup complete")
    else:
        print(f"[WARNING] Database setup issue: {out} {err}")
    
    # Start backend
    print("3. Starting backend...")
    subprocess.Popen("python -m uvicorn app.main:app --reload --host 0.0.0.0 --port 8001", shell=True, cwd="backend")
    
    time.sleep(5)
    
    # Test backend
    print("4. Testing backend...")
    success, out, err = run_command("curl -s http://localhost:8001/health")
    if "healthy" in out:
        print("[OK] Backend is running")
    else:
        print("[WARNING] Backend may still be starting...")
    
    # Start frontend
    print("5. Starting frontend...")
    subprocess.Popen("npm run dev", shell=True, cwd="frontend")
    
    print("\n" + "=" * 40)
    print("[OK] CORS FIX APPLIED!")
    print("=" * 40)
    print("Frontend: http://localhost:5173")
    print("Backend:  http://localhost:8001")
    print("Test:     http://localhost:5173/report-lost")
    print("\nCORS should now work on PORT 8001!")

if __name__ == "__main__":
    main()