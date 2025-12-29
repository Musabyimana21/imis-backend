# 🚀 IMIS Backend - Render Deployment Fix Guide

## ✅ Issues Fixed

1. **Python Version**: Updated to 3.11.7 (more stable on Render)
2. **Dependencies**: Downgraded scikit-learn and numpy for compatibility
3. **Startup Command**: Changed to gunicorn with uvicorn workers for production
4. **Error Handling**: Improved startup error handling and logging
5. **Health Checks**: Enhanced health endpoint with database connection test

## 🔧 Steps to Fix Your Render Deployment

### Step 1: Update Your Repository

Push the updated files to your GitHub repository:

```bash
cd f:\IMIS
git add .
git commit -m "Fix Render deployment - stable Python version and improved startup"
git push origin main
```

### Step 2: Check Your Render Database

1. Go to https://dashboard.render.com
2. Make sure you have a PostgreSQL database created
3. If not, create one:
   - Click "New +" → "PostgreSQL"
   - Name: `imis-database`
   - Plan: Free
   - Click "Create Database"
4. Copy the **Internal Database URL** (starts with `postgresql://`)

### Step 3: Update Environment Variables

1. Go to your web service dashboard
2. Click "Environment" tab
3. Ensure these variables are set:

**Required Variables:**
- `DATABASE_URL` = [Your PostgreSQL URL from Step 2]
- `SECRET_KEY` = a8f5f167f44f4964e6c998dee827110c
- `ALGORITHM` = HS256
- `ACCESS_TOKEN_EXPIRE_MINUTES` = 30

**Optional Variables (already in render.yaml):**
- `MTN_MOMO_ENABLED` = false
- `PYTHONPATH` = .
- `PORT` = 10000

### Step 4: Trigger Manual Deploy

1. In your Render service dashboard
2. Click "Manual Deploy" → "Deploy latest commit"
3. Monitor the build logs

### Step 5: Verify Deployment

After deployment completes, test these endpoints:

1. **Root**: https://imis-backend-wk7z.onrender.com/
   - Should return: `{"message": "IMIS API Running", "version": "3.0.0", "status": "healthy"}`

2. **Health Check**: https://imis-backend-wk7z.onrender.com/health
   - Should return: `{"status": "healthy", "database": "connected", "version": "3.0.0"}`

3. **API Docs**: https://imis-backend-wk7z.onrender.com/docs
   - Should show the FastAPI documentation

## 🐛 If Still Failing

### Check Build Logs
1. Go to your service dashboard
2. Click "Logs" tab
3. Look for specific error messages

### Common Issues & Solutions

**"ModuleNotFoundError"**
- Solution: Dependencies issue - the updated requirements.txt should fix this

**"Read-only file system"**
- Solution: Make sure DATABASE_URL points to PostgreSQL, not SQLite

**"Connection refused"**
- Solution: Database not accessible - check DATABASE_URL is correct

**"Port already in use"**
- Solution: Render handles ports automatically - don't worry about this

### Force Restart
If needed, you can force restart your service:
1. Go to service dashboard
2. Click "Settings" tab
3. Click "Restart Service"

## 📊 Expected Timeline

- Build: 3-5 minutes (downloading dependencies)
- Deploy: 30-60 seconds
- Total: ~4-6 minutes

## ✅ Success Indicators

When working correctly, you should see:
- ✅ Build completes without errors
- ✅ Service shows "Live" status
- ✅ Health endpoint returns 200 OK
- ✅ API docs are accessible
- ✅ No error logs in dashboard

## 🆘 Emergency Contact

If you're still having issues:
1. Check the Render logs for specific errors
2. Ensure your PostgreSQL database is running
3. Verify all environment variables are set correctly

The fixes I've implemented should resolve the most common Render deployment issues. Your backend should now start successfully!