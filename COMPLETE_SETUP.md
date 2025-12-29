# Complete IMIS Setup with Database

## ✅ Full Setup Process

### Step 1: Install PostgreSQL (Required)

**Run:**
```bash
INSTALL_POSTGRESQL.bat
```

**What it does:**
1. Opens PostgreSQL download page
2. Guides you through installation
3. Creates `imis` database
4. Installs PostGIS extension
5. Configures backend/.env automatically

**Time:** 10-15 minutes

**During Installation:**
- Set a password (remember it!)
- Port: 5432 (default)
- Install Stack Builder: YES
- Install PostGIS extension

### Step 2: Start IMIS

**Run:**
```bash
START_WITH_DB.bat
```

**What it does:**
1. Installs all Python packages (including database drivers)
2. Installs frontend packages
3. Starts backend with database connection
4. Starts frontend
5. Creates database tables automatically

**Time:** 2-3 minutes

### Step 3: Access IMIS

**Open browser:**
```
http://localhost:5173
```

## ✅ What You Get

### Full Features:
- ✅ User registration and authentication
- ✅ Lost item reporting with GPS
- ✅ Found item reporting with GPS
- ✅ AI-based matching (NLP + geolocation)
- ✅ Distance calculations (PostGIS)
- ✅ Secure in-app messaging
- ✅ Commission tracking
- ✅ Admin dashboard with analytics
- ✅ Kinyarwanda + English localization
- ✅ Mobile-responsive design

### Database Features:
- ✅ PostgreSQL 15/16
- ✅ PostGIS for geospatial queries
- ✅ Full-text search
- ✅ ACID compliance
- ✅ Production-ready

## 🔧 Verification

### Check PostgreSQL is Running:

**Windows Services:**
```bash
services.msc
```
Look for: `postgresql-x64-15` or `postgresql-x64-16`
Status: Running

**Command Line:**
```bash
psql -U postgres -d imis -c "SELECT version();"
```

### Check Database:
```bash
psql -U postgres -d imis -c "\dt"
```
Should show: users, items, matches, messages, commissions

### Check Backend:
```
http://localhost:8000/docs
```
Should show API documentation

### Check Frontend:
```
http://localhost:5173
```
Should show IMIS homepage

## 📋 Configuration

### Backend (.env):
```
DATABASE_URL=postgresql://postgres:yourpassword@localhost:5432/imis
SECRET_KEY=dev-secret-key-change-in-production
ALGORITHM=HS256
ACCESS_TOKEN_EXPIRE_MINUTES=30
```

### Frontend (.env):
```
PUBLIC_API_URL=http://localhost:8000
```

## 🚀 Quick Start Commands

```bash
# First time setup
INSTALL_POSTGRESQL.bat

# Start IMIS
START_WITH_DB.bat

# Stop IMIS
stop.bat

# Test system
test-system.bat
```

## 🎯 First Use

1. **Register Account:**
   - Go to http://localhost:5173
   - Click "Login" → "Register"
   - Fill in details
   - Submit

2. **Report Lost Item:**
   - Click "Report Lost"
   - Fill in details
   - Use GPS location
   - Submit

3. **Report Found Item:**
   - Click "Report Found"
   - Fill in details
   - Use GPS location
   - Submit

4. **View Matches:**
   - Click on any item
   - See AI-generated matches
   - View similarity scores
   - Check distances

5. **Send Messages:**
   - Click "Contact Owner"
   - Send message
   - Secure in-app chat

## 🛠️ Troubleshooting

### PostgreSQL not starting:
```bash
# Check service
services.msc

# Restart service
net stop postgresql-x64-15
net start postgresql-x64-15
```

### Database connection error:
- Verify PostgreSQL is running
- Check password in backend/.env
- Verify port 5432 is not blocked

### PostGIS not installed:
```bash
psql -U postgres -d imis -c "CREATE EXTENSION postgis;"
```

## 📖 Summary

**Complete setup:**
1. `INSTALL_POSTGRESQL.bat` (10 minutes)
2. `START_WITH_DB.bat` (2 minutes)
3. Open http://localhost:5173
4. Register and use!

**Total time:** 15 minutes for full setup

**Result:** Complete IMIS system with all features!
