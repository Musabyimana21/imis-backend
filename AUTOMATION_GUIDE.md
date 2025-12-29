# IMIS Automation Guide

All setup and management tasks are automated with simple scripts.

## Quick Start (One Command)

### Windows
```bash
setup.bat
```

### Linux/Mac
```bash
chmod +x setup.sh
./setup.sh
```

This will:
- Detect if Docker is available
- Set up all services automatically
- Create environment files
- Install dependencies
- Start frontend and backend
- Display access URLs

## Available Scripts

### Setup & Run

**Windows:**
- `setup.bat` - Automated setup (Docker or manual)
- `run-docker.bat` - Run with Docker only
- `stop.bat` - Stop all services

**Linux/Mac:**
- `./setup.sh` - Automated setup (Docker or manual)
- `./run-docker.sh` - Run with Docker only
- `./stop.sh` - Stop all services

### Testing

**Windows:**
- `test-system.bat` - Health check all services

**Linux/Mac:**
- `./test-system.sh` - Health check all services

### Admin Management

**Windows:**
- `create-admin.bat` - Create admin user interactively

**Linux/Mac:**
- `./create-admin.sh` - Create admin user interactively

## What Gets Automated

### 1. Environment Setup
- Creates `.env` files automatically
- Sets default configuration values
- Configures database connection

### 2. Dependency Installation
- Python virtual environment creation
- Backend dependencies (pip)
- Frontend dependencies (npm)

### 3. Service Management
- Starts backend on port 8000
- Starts frontend on port 5173
- Starts database (Docker mode)

### 4. Health Checks
- Verifies backend is responding
- Verifies frontend is accessible
- Checks API documentation

## Docker Mode (Recommended)

If Docker is installed, the system automatically uses Docker Compose:

```bash
# Windows
setup.bat

# Linux/Mac
./setup.sh
```

**Advantages:**
- No manual dependency installation
- Isolated environment
- PostgreSQL + PostGIS included
- One-command setup

**Services:**
- Database: PostgreSQL 15 + PostGIS 3.3
- Backend: FastAPI on port 8000
- Frontend: SvelteKit on port 5173

## Manual Mode

If Docker is not available, scripts automatically fall back to manual setup:

**Requirements:**
- Python 3.11+
- Node.js 18+
- PostgreSQL 15+ with PostGIS

**What happens:**
- Creates Python virtual environment
- Installs Python dependencies
- Installs Node.js dependencies
- Starts services in background

## Access Points

After running setup:

- **Frontend**: http://localhost:5173
- **Backend API**: http://localhost:8000
- **API Docs**: http://localhost:8000/docs
- **Database**: localhost:5432 (Docker mode)

## Stopping Services

### Windows
```bash
stop.bat
```

### Linux/Mac
```bash
./stop.sh
```

This stops all IMIS services (Docker or manual).

## Creating Admin User

### Windows
```bash
create-admin.bat
```

### Linux/Mac
```bash
./create-admin.sh
```

Follow the prompts to create an admin user.

## Testing System Health

### Windows
```bash
test-system.bat
```

### Linux/Mac
```bash
./test-system.sh
```

Checks if all services are running correctly.

## Troubleshooting

### Script Permission Denied (Linux/Mac)
```bash
chmod +x *.sh
```

### Port Already in Use
Stop other services using ports 5173, 8000, or 5432.

### Docker Not Starting
Ensure Docker Desktop is running.

### Database Connection Error
In Docker mode, wait 10 seconds for database initialization.

## Environment Variables

Pre-configured in `.env` files:

**Backend:**
- `DATABASE_URL`: Database connection string
- `SECRET_KEY`: JWT secret key
- `ALGORITHM`: HS256
- `ACCESS_TOKEN_EXPIRE_MINUTES`: 30

**Frontend:**
- `PUBLIC_API_URL`: Backend API URL

## Production Deployment

For production, use the deployment guides:
- See `DEPLOYMENT.md` for Cloudflare + Render setup
- Update environment variables for production
- Use strong SECRET_KEY
- Enable HTTPS

## Summary

**To start everything:**
```bash
setup.bat        # Windows
./setup.sh       # Linux/Mac
```

**To stop everything:**
```bash
stop.bat         # Windows
./stop.sh        # Linux/Mac
```

**To test everything:**
```bash
test-system.bat  # Windows
./test-system.sh # Linux/Mac
```

That's it! Everything is automated.
