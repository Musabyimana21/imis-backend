# IMIS Backend - Render Deployment Guide

## ✅ Pre-Deployment Checklist

### 1. Files Ready
- [x] `requirements.txt` - All dependencies included
- [x] `.python-version` - Python 3.11.10 specified
- [x] `runtime.txt` - Python 3.11.10 specified
- [x] `render.yaml` - Service configuration
- [x] `start.sh` - Startup script

### 2. Dependencies Verified
```
✅ fastapi==0.104.1
✅ uvicorn[standard]==0.24.0
✅ sqlalchemy==2.0.23
✅ psycopg2-binary==2.9.9
✅ python-multipart==0.0.6
✅ python-jose[cryptography]==3.3.0
✅ passlib[bcrypt]==1.7.4
✅ python-dotenv==1.0.0
✅ requests==2.31.0
✅ pydantic==2.5.0
✅ pydantic-settings==2.1.0
✅ email-validator==2.1.0
✅ scikit-learn==1.4.0
✅ numpy==1.26.4
✅ gunicorn==21.2.0
```

## 🚀 Deployment Steps

### Step 1: Create PostgreSQL Database on Render

1. Go to https://dashboard.render.com
2. Click "New +" → "PostgreSQL"
3. Name: `imis-database`
4. Plan: Free
5. Click "Create Database"
6. **COPY the Internal Database URL** (starts with `postgresql://`)

### Step 2: Configure Web Service

1. Go to your web service: https://dashboard.render.com/web/srv-d4l3o22li9vc73e2rmm0
2. Click "Environment" tab
3. Add/Update environment variable:
   - Key: `DATABASE_URL`
   - Value: **[Paste the PostgreSQL URL from Step 1]**
4. Click "Save Changes"

### Step 3: Deploy

1. Push your code to GitHub:
   ```bash
   git add .
   git commit -m "Production-ready deployment"
   git push origin main
   ```

2. Render will auto-deploy

3. Monitor logs at: https://dashboard.render.com/web/srv-d4l3o22li9vc73e2rmm0/logs

## 🔍 Verification

After deployment succeeds:

1. **Health Check**: https://imis-backend-wk7z.onrender.com/health
2. **API Docs**: https://imis-backend-wk7z.onrender.com/docs
3. **Root**: https://imis-backend-wk7z.onrender.com/

Expected response from health check:
```json
{
  "status": "healthy",
  "database": "connected"
}
```

## ⚠️ Important Notes

### Database
- **DO NOT use SQLite on Render** - filesystem is ephemeral
- **MUST use PostgreSQL** - data persists across deployments
- Free PostgreSQL tier: 256MB storage, 97 hours/month

### Python Version
- **MUST be 3.11.10** (not 3.13.x)
- scikit-learn 1.4.0 requires Python ≤ 3.12

### Environment Variables
All these MUST be set in Render dashboard:
- `DATABASE_URL` - PostgreSQL connection string
- `SECRET_KEY` - Your secret key
- `ALGORITHM` - HS256
- `ACCESS_TOKEN_EXPIRE_MINUTES` - 30
- MTN MoMo settings (if enabled)

## 🐛 Troubleshooting

### Build Fails with "ModuleNotFoundError"
- Check `requirements.txt` has all dependencies
- Verify Python version is 3.11.10

### "Read-only file system" Error
- You're trying to use SQLite - switch to PostgreSQL

### "Connection refused" to Database
- Check DATABASE_URL is correct
- Ensure PostgreSQL database is running
- Verify database is in same region

### App Starts but Crashes
- Check logs for specific error
- Verify all environment variables are set
- Test database connection

## 📊 Expected Deployment Time

- Build: 2-3 minutes
- Deploy: 30 seconds
- Total: ~3-4 minutes

## 🎯 Success Criteria

✅ Build completes without errors
✅ Service starts successfully
✅ Health endpoint returns 200 OK
✅ API docs accessible
✅ Database connection works

## 📞 Support

If deployment fails:
1. Check logs in Render dashboard
2. Verify all environment variables
3. Ensure PostgreSQL database is created
4. Contact: gaudencemusabyimana21@gmail.com
