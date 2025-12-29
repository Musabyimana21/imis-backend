# IMIS Docker Setup Guide

## 🚀 Quick Start (2 Minutes)

### One-Click Setup
```bash
DOCKER_QUICK_START.bat
```
This will:
- ✅ Start all IMIS containers with proper naming
- ✅ Seed database with test accounts
- ✅ Open IMIS in your browser
- ✅ Fix all "Failed to fetch" errors

## 📋 Available Scripts

| Script | Purpose |
|--------|---------|
| `DOCKER_QUICK_START.bat` | Complete setup in one click |
| `START_IMIS_DOCKER.bat` | Start IMIS containers |
| `STOP_IMIS_DOCKER.bat` | Stop IMIS containers |
| `SEED_IMIS_DOCKER.bat` | Add test data |
| `CHECK_IMIS_DOCKER.bat` | Check container status |

## 🐳 Container Details

### IMIS Containers (NOT morning_quiz!)
- **imis-database**: PostgreSQL database on port 5433
- **imis-api**: FastAPI backend on port 8000  
- **imis-web**: SvelteKit frontend on port 5173

### Network
- **imis-network**: Isolated network for IMIS containers

## 🌐 Access Points

- **Frontend**: http://localhost:5173
- **Backend API**: http://localhost:8000
- **API Documentation**: http://localhost:8000/docs
- **Database**: localhost:5433 (user: imis, password: imis123)

## 👥 Test Accounts

```
Admin:  admin@imis.rw / admin123
Loser:  loser@imis.rw / lost123  
Finder: finder@imis.rw / found123
```

## 🔧 Manual Commands

### Start IMIS
```bash
docker-compose -p imis up -d
```

### Stop IMIS
```bash
docker-compose -p imis down
```

### View Logs
```bash
docker-compose -p imis logs -f
```

### Check Status
```bash
docker ps --filter "name=imis"
```

## ❌ Troubleshooting

### "Failed to fetch" Error
- ✅ **FIXED**: Enhanced CORS configuration
- ✅ **FIXED**: Proper container networking
- ✅ **FIXED**: Health checks and startup scripts

### Container Conflicts
- ✅ **FIXED**: Unique container names (imis-*)
- ✅ **FIXED**: Isolated network (imis-network)
- ✅ **FIXED**: No conflicts with morning_quiz

### Database Issues
- ✅ **FIXED**: Health checks ensure DB is ready
- ✅ **FIXED**: Automatic table creation
- ✅ **FIXED**: Test data seeding

## 🎯 Key Improvements

1. **Proper Naming**: All containers prefixed with `imis-`
2. **CORS Fixed**: Enhanced configuration for Docker networking
3. **Health Checks**: Ensures services start in correct order
4. **Isolated Network**: No conflicts with other projects
5. **Startup Scripts**: Proper initialization sequence
6. **Test Data**: Automatic seeding with realistic accounts

## 🚀 Production Notes

For production deployment:
- Change default passwords in docker-compose.yml
- Use environment-specific CORS origins
- Enable SSL/TLS certificates
- Use production database credentials

---

**Built for Rwanda 🇷🇼 | IMIS Docker Setup | 2025**