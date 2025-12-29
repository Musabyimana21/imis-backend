# Complete Deployment Guide for e-shakiro.com

## Overview
Your IMIS application consists of:
- **Frontend**: Svelte + TailwindCSS (will be hosted on e-shakiro.com)
- **Backend**: FastAPI + PostgreSQL (will be hosted on Render.com - free)
- **Database**: PostgreSQL (provided by Render)

## Part 1: Deploy Backend to Render (FREE)

### 1.1 Create Render Account
1. Go to https://render.com
2. Sign up with GitHub account
3. Connect your GitHub repository

### 1.2 Create PostgreSQL Database
1. In Render dashboard, click "New +"
2. Select "PostgreSQL"
3. Name: `imis-database`
4. Plan: Free
5. Click "Create Database"
6. **SAVE** the connection details (Internal Database URL)

### 1.3 Deploy Backend Service
1. Click "New +" → "Web Service"
2. Connect your GitHub repo containing the backend
3. Configure:
   - **Name**: `imis-backend`
   - **Environment**: `Python 3`
   - **Build Command**: `pip install -r requirements.txt`
   - **Start Command**: `uvicorn app.main:app --host 0.0.0.0 --port $PORT`
   - **Plan**: Free

### 1.4 Set Environment Variables
In Render service settings, add these environment variables:

**IMPORTANT**: Replace `<your-postgresql-internal-url-from-step-1.2>` with your actual PostgreSQL Internal Database URL from step 1.2

```
DATABASE_URL=<your-postgresql-internal-url-from-step-1.2>
SECRET_KEY=your-super-secret-key-change-this
FRONTEND_URL=https://e-shakiro.com
ALLOWED_ORIGINS=https://e-shakiro.com,http://e-shakiro.com
MTN_MOMO_ENABLED=true
MTN_MOMO_ENVIRONMENT=production
MTN_MOMO_BASE_URL=https://proxy.momoapi.mtn.co.rw
MTN_MOMO_SUBSCRIPTION_KEY=92e0ee9794d34ac8bb166d2cd3b99a69
MTN_MOMO_API_USER=24a14d7b-57b2-46a6-ba5c-4c17f628eb9e
MTN_MOMO_API_KEY=2ac93c3f60304fdaa6f9ad2f591f0834
MTN_MOMO_TARGET_ENVIRONMENT=mtnrwanda
MTN_MOMO_CALLBACK_URL=https://e-shakiro.com/api/anonymous/payment/callback
MTN_MOMO_CALLBACK_HOST=e-shakiro.com
```

**Steps to add environment variables:**
1. In your Render service dashboard, click "Environment" tab
2. Click "Add Environment Variable" for each variable above
3. Enter the Key and Value exactly as shown
4. **IMPORTANT**: Change `SECRET_KEY` to a secure random string
5. **IMPORTANT**: Replace `DATABASE_URL` with your actual PostgreSQL URL
6. Click "Save Changes"

### 1.5 Deploy
1. Click "Create Web Service"
2. Wait for deployment (5-10 minutes)
3. **SAVE** your backend URL: `https://your-app-name.onrender.com`

## Part 2: Deploy Frontend to cPanel

### 2.1 Update Frontend Configuration
1. Open `F:\\IMIS\\frontend\\.env.production`
2. Update with your Render backend URL:
```
PUBLIC_API_URL=https://your-app-name.onrender.com
PUBLIC_FRONTEND_URL=https://e-shakiro.com
PUBLIC_ENVIRONMENT=production
```

### 2.2 Build Frontend
1. Run: `F:\\IMIS\\DEPLOY_E_SHAKIRO_COMPLETE.bat`
2. Or manually:
```bash
cd F:\\IMIS\\frontend
npm install
npm run build
```

### 2.3 Upload to cPanel
1. Login to cPanel: http://e-shakiro.com:2082
2. Open **File Manager**
3. Navigate to `public_html` folder
4. **DELETE** all existing files in public_html
5. **Upload** ALL files from `F:\\IMIS\\frontend\\build\\`
6. **Upload** `.htaccess` from `F:\\IMIS\\.htaccess`
7. Set permissions:
   - Files: 644
   - Folders: 755

## Part 3: Test Deployment

### 3.1 Test Frontend
- Visit: https://e-shakiro.com
- Should load your application

### 3.2 Test Backend API
- Visit: https://your-app-name.onrender.com/docs
- Should show FastAPI documentation

### 3.3 Test Full Integration
1. Try registering a new account
2. Try logging in
3. Test reporting lost items
4. Test payment flow

## Part 4: Domain Configuration (Optional)

### 4.1 SSL Certificate
- cPanel usually provides free SSL
- Go to cPanel → SSL/TLS → Let's Encrypt
- Enable for e-shakiro.com

### 4.2 Custom Domain for Backend (Optional)
- In Render, you can add custom domain
- Point subdomain like `api.e-shakiro.com` to Render
- Update frontend config to use `https://api.e-shakiro.com`

## Troubleshooting

### Frontend Issues
- Check browser console for errors
- Verify API URL in network tab
- Check .htaccess file is uploaded

### Backend Issues
- Check Render logs in dashboard
- Verify environment variables
- Test database connection

### CORS Issues
- Ensure ALLOWED_ORIGINS includes your domain
- Check backend CORS configuration

## Cost Breakdown
- **Domain**: Already paid
- **Hosting**: Already paid (cPanel)
- **Backend**: FREE (Render)
- **Database**: FREE (Render PostgreSQL)
- **Total Additional Cost**: $0/month

## Support
- Render Documentation: https://render.com/docs
- FastAPI Documentation: https://fastapi.tiangolo.com
- Svelte Documentation: https://svelte.dev

Your application will be live at: **https://e-shakiro.com**