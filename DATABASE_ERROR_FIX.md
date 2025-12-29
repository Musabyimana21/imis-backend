# Database Connection Error - Fixed

## Error

```
psycopg2.OperationalError: password authentication failed for user "imis"
```

**Cause:** PostgreSQL is not installed or not configured

## ✅ Quick Solution - Run Without Database

```bash
START_NO_DB.bat
```

This will:
- ✅ Start backend (database optional)
- ✅ Start frontend (full UI works)
- ✅ Show API docs
- ✅ Work for UI testing

## What Works Without Database

- ✅ Frontend UI (all pages)
- ✅ API documentation
- ✅ Backend server
- ❌ User registration (needs DB)
- ❌ Item reporting (needs DB)
- ❌ Data storage (needs DB)

## Full Solution - Install PostgreSQL

### Option 1: Use SQLite (Simple)

1. Edit `backend/.env`:
   ```
   DATABASE_URL=sqlite:///./imis.db
   ```

2. Run:
   ```bash
   START_FAST.bat
   ```

### Option 2: Install PostgreSQL (Full Features)

1. **Download PostgreSQL:**
   - Go to: https://www.postgresql.org/download/windows/
   - Download PostgreSQL 15 or 16
   - Install with default settings

2. **During installation:**
   - Set password (remember it!)
   - Port: 5432 (default)
   - Install Stack Builder: YES
   - Install PostGIS extension

3. **Create Database:**
   ```bash
   # Open Command Prompt
   cd "C:\Program Files\PostgreSQL\15\bin"
   createdb -U postgres imis
   psql -U postgres -d imis -c "CREATE EXTENSION postgis;"
   ```

4. **Update backend/.env:**
   ```
   DATABASE_URL=postgresql://postgres:yourpassword@localhost:5432/imis
   ```

5. **Run:**
   ```bash
   START_FAST.bat
   ```

## Recommended for Now

**Use START_NO_DB.bat to test the UI:**

```bash
START_NO_DB.bat
```

Then:
- Open http://localhost:5173
- See the full UI
- Test navigation
- View design

**Install PostgreSQL later for full functionality.**

## Summary

| Mode | Command | Database | Features |
|------|---------|----------|----------|
| **Demo** | `START_NO_DB.bat` | Not needed | UI only ✅ |
| SQLite | `START_FAST.bat` | SQLite | Basic features |
| Full | `START_FAST.bat` | PostgreSQL | All features ✅ |

**For now: Use `START_NO_DB.bat`**
