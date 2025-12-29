#!/bin/bash

echo "Stopping IMIS services..."

# Check if Docker is running
if docker ps &> /dev/null; then
    echo "Stopping Docker containers..."
    docker-compose down
else
    echo "Stopping manual services..."
    pkill -f "uvicorn app.main:app"
    pkill -f "npm run dev"
fi

echo "IMIS services stopped."
