#!/bin/bash

echo "========================================"
echo "IMIS System Health Check"
echo "========================================"
echo ""

echo "Checking Backend..."
if curl -s http://localhost:8000/health > /dev/null 2>&1; then
    echo "[OK] Backend is running on http://localhost:8000"
else
    echo "[ERROR] Backend is not responding"
fi

echo ""
echo "Checking Frontend..."
if curl -s http://localhost:5173 > /dev/null 2>&1; then
    echo "[OK] Frontend is running on http://localhost:5173"
else
    echo "[ERROR] Frontend is not responding"
fi

echo ""
echo "Checking API Documentation..."
if curl -s http://localhost:8000/docs > /dev/null 2>&1; then
    echo "[OK] API docs available at http://localhost:8000/docs"
else
    echo "[ERROR] API docs not accessible"
fi

echo ""
echo "========================================"
echo "Health Check Complete"
echo "========================================"
