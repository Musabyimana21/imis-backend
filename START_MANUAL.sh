#!/bin/bash

echo "========================================"
echo "IMIS Manual Setup (No Docker Required)"
echo "========================================"
echo ""

echo "Killing any existing processes..."
pkill -f "uvicorn app.main:app" 2>/dev/null
pkill -f "npm run dev" 2>/dev/null

echo ""
echo "Starting Backend..."
cd backend
if [ ! -d venv ]; then
    echo "Creating Python virtual environment..."
    python3 -m venv venv
fi
source venv/bin/activate
pip install -q -r requirements.txt
nohup uvicorn app.main:app --reload > ../backend.log 2>&1 &
echo "Backend started (PID: $!)"
cd ..

echo ""
echo "Starting Frontend..."
cd frontend
if [ ! -d node_modules ]; then
    echo "Installing Node dependencies..."
    npm install
fi
nohup npm run dev > ../frontend.log 2>&1 &
echo "Frontend started (PID: $!)"
cd ..

echo ""
echo "Waiting for services to start (15 seconds)..."
sleep 15

echo ""
echo "========================================"
echo "IMIS is now running!"
echo "========================================"
echo ""
echo "Frontend: http://localhost:5173"
echo "Backend:  http://localhost:8000"
echo "API Docs: http://localhost:8000/docs"
echo ""
echo "Logs:"
echo "  Backend: tail -f backend.log"
echo "  Frontend: tail -f frontend.log"
echo ""
echo "To stop: ./stop.sh"
echo ""
