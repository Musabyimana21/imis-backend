FROM python:3.11-slim

# Set environment variables
ENV PYTHONUNBUFFERED=1
ENV PYTHONDONTWRITEBYTECODE=1

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    gcc \
    postgresql-client \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements and install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY . .

# Create startup script
RUN echo '#!/bin/bash\n\
echo "Starting IMIS Backend..."\n\
echo "Waiting for database..."\n\
while ! pg_isready -h imis-db -p 5432 -U imis; do\n\
  echo "Database not ready, waiting..."\n\
  sleep 2\n\
done\n\
echo "Database ready! Starting IMIS API..."\n\
uvicorn app.main:app --host 0.0.0.0 --port 8000 --reload' > /app/start.sh

RUN chmod +x /app/start.sh

EXPOSE 8000

CMD ["/app/start.sh"]
