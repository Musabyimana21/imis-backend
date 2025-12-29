#!/bin/bash
# Render startup script

# Install dependencies
pip install -r requirements.txt

# Run database setup
python setup_db.py

# Start the application
uvicorn app.main:app --host 0.0.0.0 --port $PORT