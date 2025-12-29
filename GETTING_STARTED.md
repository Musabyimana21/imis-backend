# Getting Started with IMIS

## The Easiest Way to Start

### Windows Users
1. Double-click `START_HERE.bat`
2. Select option 1 to start IMIS
3. Wait for services to start
4. Access at http://localhost:5173

### Linux/Mac Users
1. Open terminal in IMIS folder
2. Run: `chmod +x *.sh && ./START_HERE.sh`
3. Select option 1 to start IMIS
4. Wait for services to start
5. Access at http://localhost:5173

## What the Automated Setup Does

1. **Detects Your Environment**
   - Checks if Docker is available
   - Falls back to manual setup if needed

2. **Sets Up Everything**
   - Creates configuration files
   - Installs all dependencies
   - Starts database (Docker mode)
   - Starts backend API
   - Starts frontend

3. **Verifies Installation**
   - Tests backend connectivity
   - Tests frontend accessibility
   - Shows access URLs

## Interactive Menu Options

The `START_HERE` script provides:

1. **Start IMIS** - Automated setup and launch
2. **Stop IMIS** - Stop all services
3. **Test System** - Health check
4. **Create Admin** - Create admin user
5. **View Logs** - See Docker logs
6. **Open Frontend** - Launch in browser
7. **Open API Docs** - View API documentation
8. **Exit** - Close menu

## First Time Setup

### Step 1: Start the System
```bash
# Windows
START_HERE.bat

# Linux/Mac
./START_HERE.sh
```

### Step 2: Create Your Account
1. Open http://localhost:5173
2. Click "Login" → "Register"
3. Fill in your details
4. Click "Register"

### Step 3: Create Admin User (Optional)
1. Use option 4 in START_HERE menu
2. Enter admin credentials
3. Follow SQL instructions to promote user

### Step 4: Test the System
1. Report a lost item
2. Report a found item
3. Check for AI matches
4. Send a message
5. View admin dashboard (if admin)

## Quick Commands

### Start Everything
```bash
setup.bat        # Windows
./setup.sh       # Linux/Mac
```

### Stop Everything
```bash
stop.bat         # Windows
./stop.sh        # Linux/Mac
```

### Test Everything
```bash
test-system.bat  # Windows
./test-system.sh # Linux/Mac
```

## Access URLs

After starting:
- **Frontend**: http://localhost:5173
- **Backend**: http://localhost:8000
- **API Docs**: http://localhost:8000/docs
- **Database**: localhost:5432 (Docker mode)

## System Requirements

### Docker Mode (Recommended)
- Docker Desktop installed
- 4GB RAM minimum
- 10GB disk space

### Manual Mode
- Python 3.11+
- Node.js 18+
- PostgreSQL 15+ with PostGIS
- 4GB RAM minimum

## Troubleshooting

### Services Won't Start
1. Check if ports 5173, 8000, 5432 are free
2. Restart Docker Desktop (if using Docker)
3. Run test-system script to diagnose

### Can't Access Frontend
1. Wait 30 seconds after starting
2. Check if backend is running (port 8000)
3. Clear browser cache

### Database Connection Error
1. Ensure PostgreSQL is running
2. Check .env file in backend folder
3. Verify PostGIS extension is installed

### Permission Denied (Linux/Mac)
```bash
chmod +x *.sh
```

## Next Steps

1. **Explore Features**
   - Report lost/found items
   - Test AI matching
   - Try messaging system
   - Check admin dashboard

2. **Customize**
   - Update translations in `frontend/src/lib/i18n/`
   - Modify colors in `frontend/tailwind.config.js`
   - Adjust commission rates in admin panel

3. **Deploy to Production**
   - See `DEPLOYMENT.md` for instructions
   - Use Cloudflare Pages + Render
   - Configure production environment variables

## Getting Help

- Check `AUTOMATION_GUIDE.md` for script details
- Read `SETUP_GUIDE.md` for manual setup
- See `API_DOCUMENTATION.md` for API reference
- Review `FEATURES.md` for feature list

## Summary

**Absolute quickest way:**
1. Run `START_HERE.bat` (Windows) or `./START_HERE.sh` (Linux/Mac)
2. Select option 1
3. Open http://localhost:5173
4. Start using IMIS!

Everything is automated. No manual configuration needed.
