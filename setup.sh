#!/bin/bash

echo "========================================"
echo "IMIS Automated Setup Script"
echo "========================================"
echo ""

# Check if Docker is available
if command -v docker &> /dev/null; then
    echo "Docker detected. Using Docker setup..."
    echo ""
    docker_setup
else
    echo "Docker not found. Using manual setup..."
    echo ""
    manual_setup
fi

docker_setup() {
    echo "Starting Docker Compose..."
    docker-compose up -d --build
    
    echo ""
    echo "Waiting for services to start..."
    sleep 10
    
    echo ""
    echo "========================================"
    echo "IMIS is running!"
    echo "Frontend: http://localhost:5173"
    echo "Backend: http://localhost:8000"
    echo "API Docs: http://localhost:8000/docs"
    echo "========================================"
    echo ""
    echo "To stop: docker-compose down"
    echo "To view logs: docker-compose logs -f"
}

manual_setup() {
    echo "Setting up backend..."
    cd backend
    
    # Create .env if not exists
    if [ ! -f .env ]; then
        cp .env.example .env
        echo "Created backend .env file"
    fi
    
    # Create virtual environment
    if [ ! -d venv ]; then
        python3 -m venv venv
        echo "Created Python virtual environment"
    fi
    
    # Activate and install dependencies
    source venv/bin/activate
    pip install -r requirements.txt > /dev/null 2>&1
    echo "Backend dependencies installed"
    
    # Start backend in background
    nohup uvicorn app.main:app --reload > backend.log 2>&1 &
    echo "Backend starting on http://localhost:8000"
    
    cd ..
    
    echo ""
    echo "Setting up frontend..."
    cd frontend
    
    # Create .env if not exists
    if [ ! -f .env ]; then
        cp .env.example .env
        echo "Created frontend .env file"
    fi
    
    # Install dependencies
    if [ ! -d node_modules ]; then
        npm install
        echo "Frontend dependencies installed"
    fi
    
    # Start frontend in background
    nohup npm run dev > frontend.log 2>&1 &
    echo "Frontend starting on http://localhost:5173"
    
    cd ..
    
    echo ""
    echo "Waiting for services to start..."
    sleep 5
    
    echo ""
    echo "========================================"
    echo "IMIS is running!"
    echo "Frontend: http://localhost:5173"
    echo "Backend: http://localhost:8000"
    echo "API Docs: http://localhost:8000/docs"
    echo "========================================"
    echo ""
    echo "To stop: ./stop.sh"
}
