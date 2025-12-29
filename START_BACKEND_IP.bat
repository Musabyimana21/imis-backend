@echo off
echo Starting IMIS Backend on IP 192.168.61.61...
cd /d "t:\IMIS\backend"

echo Installing requirements...
pip install -r requirements.txt

echo Starting backend server on 192.168.61.61:8001...
uvicorn app.main:app --host 192.168.61.61 --port 8001 --reload

pause