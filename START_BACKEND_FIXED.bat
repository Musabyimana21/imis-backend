@echo off
echo Starting Backend with Fixed CORS for Port 5174...
cd backend
python -m uvicorn app.main:app --reload --host 0.0.0.0 --port 8002