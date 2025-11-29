#!/bin/bash
# Production startup script for Render

# Run database migrations (if needed)
# alembic upgrade head

# Start the application
uvicorn app.main:app --host 0.0.0.0 --port ${PORT:-8001}
