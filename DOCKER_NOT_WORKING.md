# Docker Desktop Not Running - Use Manual Setup

## Problem

Docker Desktop is not running or not properly configured. Error:
```
error during connect: open //./pipe/dockerDesktopLinuxEngine: The system cannot find the file specified.
```

## Solution: Use Manual Setup (Faster & More Reliable)

### Quick Start - Run This Now

```bash
START_MANUAL.bat
```

This will:
- Kill any processes on ports 8000/5173
- Create Python virtual environment
- Install backend dependencies
- Install frontend dependencies
- Start both services in separate windows

### Manual Step-by-Step

#### 1. Backend Setup

```bash
cd backend
python -m venv venv
venv\Scripts\activate
pip install -r requirements.txt
uvicorn app.main:app --reload
```

Keep this terminal open.

#### 2. Frontend Setup (New Terminal)

```bash
cd frontend
npm install
npm run dev
```

Keep this terminal open.

#### 3. Database Setup (Optional - for full functionality)

**Option A: Use SQLite (Quick Test)**
Update `backend/.env`:
```
DATABASE_URL=sqlite:///./imis.db
```

**Option B: Install PostgreSQL**
1. Download PostgreSQL 15+ from https://www.postgresql.org/download/windows/
2. Install with PostGIS extension
3. Create database:
   ```bash
   createdb imis
   psql imis -c "CREATE EXTENSION postgis;"
   ```
4. Update `backend/.env`:
   ```
   DATABASE_URL=postgresql://postgres:yourpassword@localhost:5432/imis
   ```

## Access Points

- Frontend: http://localhost:5173
- Backend: http://localhost:8000
- API Docs: http://localhost:8000/docs

## Verification

Open new terminal:
```bash
test-system.bat
```

Should show:
- [OK] Backend running
- [OK] Frontend running
- [OK] API docs available

## Why Manual Setup is Better

1. **Faster** - No Docker overhead
2. **Easier to debug** - Direct access to logs
3. **More reliable** - No Docker Desktop issues
4. **Better for development** - Hot reload works perfectly

## If You Want Docker

1. **Start Docker Desktop**
   - Open Docker Desktop application
   - Wait for it to fully start (whale icon in system tray)
   - Check status: `docker ps`

2. **Run Fix Script**
   ```bash
   COMPLETE_FIX.bat
   ```

3. **If Still Not Working**
   - Restart computer
   - Reinstall Docker Desktop
   - Or just use manual setup (recommended)

## Current Status

✅ Manual setup works perfectly  
❌ Docker Desktop not running  

**Recommendation: Use manual setup for development**

## Next Steps

1. Run `START_MANUAL.bat`
2. Wait 15 seconds
3. Open http://localhost:5173
4. Register and start using IMIS!

## Stopping Services

Close the two terminal windows that opened, or:
```bash
stop.bat
```
