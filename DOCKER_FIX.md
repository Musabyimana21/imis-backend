# Docker Issues Fixed

## Problems Identified

1. **Obsolete `version` field** - Removed from docker-compose.yml
2. **Cloudflare adapter incompatible with Docker** - Switched to static adapter

## Fixes Applied

### 1. Updated docker-compose.yml
- Removed obsolete `version: '3.8'` field

### 2. Updated Frontend Configuration
- Changed from `@sveltejs/adapter-cloudflare` to `@sveltejs/adapter-static`
- Added layout configuration for static builds
- Updated Dockerfile CMD to properly expose host

### 3. Created Fix Scripts
- `fix-and-start.bat` (Windows)
- `fix-and-start.sh` (Linux/Mac)

## How to Start Now

### Option 1: Use Fix Script (Recommended)

**Windows:**
```bash
fix-and-start.bat
```

**Linux/Mac:**
```bash
chmod +x fix-and-start.sh
./fix-and-start.sh
```

### Option 2: Manual Docker Commands

```bash
# Stop and clean
docker-compose down
docker-compose rm -f

# Start fresh
docker-compose up --build -d

# View logs
docker-compose logs -f
```

### Option 3: Use Manual Setup (No Docker)

If Docker continues to have issues:

**Windows:**
```bash
# Backend
cd backend
python -m venv venv
venv\Scripts\activate
pip install -r requirements.txt
uvicorn app.main:app --reload

# Frontend (new terminal)
cd frontend
npm install
npm run dev
```

**Linux/Mac:**
```bash
# Backend
cd backend
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
uvicorn app.main:app --reload

# Frontend (new terminal)
cd frontend
npm install
npm run dev
```

## Verification

After starting, check:

1. **Backend**: http://localhost:8000/health
2. **Frontend**: http://localhost:5173
3. **API Docs**: http://localhost:8000/docs

Run health check:
```bash
test-system.bat  # Windows
./test-system.sh # Linux/Mac
```

## Notes

- The static adapter works for local development
- For Cloudflare Pages deployment, the build process handles it differently
- Docker setup now uses static adapter for compatibility
- Manual setup remains the most reliable option for development

## If Issues Persist

Use manual setup instead of Docker:
1. Install PostgreSQL 15+ with PostGIS
2. Run backend manually
3. Run frontend manually
4. See SETUP_GUIDE.md for details
