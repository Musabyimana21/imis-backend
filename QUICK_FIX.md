# Quick Fix for Docker Issues

## Issues Fixed

1. ✅ Removed obsolete `version` from docker-compose.yml
2. ✅ Changed Cloudflare adapter to static adapter
3. ✅ Changed database port from 5432 to 5433 (avoid conflicts)
4. ✅ Added process cleanup for ports 8000 and 5173

## Quick Start (Run This)

```bash
COMPLETE_FIX.bat
```

This script will:
- Kill any processes on ports 8000 and 5173
- Stop existing Docker containers
- Start fresh containers
- Wait for services to start
- Show status

## If Docker Desktop Issues Persist

### Option 1: Restart Docker Desktop
1. Close Docker Desktop completely
2. Restart Docker Desktop
3. Wait for it to fully start
4. Run: `COMPLETE_FIX.bat`

### Option 2: Use Manual Setup (Recommended if Docker problems continue)

**Backend:**
```bash
cd backend
python -m venv venv
venv\Scripts\activate
pip install -r requirements.txt
uvicorn app.main:app --reload
```

**Frontend (new terminal):**
```bash
cd frontend
npm install
npm run dev
```

**Database:**
- Use existing PostgreSQL installation
- Or install PostgreSQL 15+ with PostGIS
- Update DATABASE_URL in backend/.env

## Access Points

- Frontend: http://localhost:5173
- Backend: http://localhost:8000
- API Docs: http://localhost:8000/docs
- Database: localhost:5433 (Docker) or localhost:5432 (manual)

## Verification

Run health check:
```bash
test-system.bat
```

Should show:
- [OK] Backend running
- [OK] Frontend running
- [OK] API docs available

## Common Issues

### "Port already allocated"
- Run `COMPLETE_FIX.bat` - it kills processes automatically

### "Docker Desktop not running"
- Start Docker Desktop
- Wait for it to fully initialize
- Run `COMPLETE_FIX.bat`

### "Cannot connect to Docker daemon"
- Restart Docker Desktop
- Check Docker Desktop is running
- Try manual setup instead

## Manual Setup is Reliable

If Docker continues to have issues, manual setup works perfectly:

1. Install Python 3.11+
2. Install Node.js 18+
3. Install PostgreSQL 15+ with PostGIS
4. Follow SETUP_GUIDE.md

Manual setup is actually faster for development!
