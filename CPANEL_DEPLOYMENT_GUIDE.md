# cPanel Deployment Guide for IMIS (e-shakiro.com)

## Overview
Your domain: **e-shakiro.com**
Server IP: **31.170.162.103**

## Deployment Strategy

### Option 1: Hybrid Deployment (RECOMMENDED)
- **Frontend**: Deploy to cPanel (e-shakiro.com)
- **Backend**: Deploy to Render/Railway (free tier)
- **Database**: PostgreSQL on Render/Railway

### Option 2: Full cPanel (if Python support available)
- Both frontend and backend on cPanel
- Requires cPanel Python app support

---

## STEP 1: Build Frontend for Production

### 1.1 Update Frontend Environment
Create `frontend/.env.production`:
```env
PUBLIC_API_URL=https://your-backend-url.onrender.com
```

### 1.2 Build Frontend
```bash
cd frontend
npm install
npm run build
```

This creates a `build` folder with static files.

---

## STEP 2: Deploy Frontend to cPanel

### 2.1 Access File Manager
1. Login to cPanel: http://e-shakiro.com:2082
2. Go to **Files → File Manager**
3. Navigate to `public_html` folder

### 2.2 Upload Frontend Files
1. Delete default files in `public_html` (index.html, etc.)
2. Upload ALL files from `frontend/build` folder to `public_html`
3. Your structure should be:
```
public_html/
├── _app/
├── images/
├── favicon.ico
├── index.html
└── other files...
```

### 2.3 Configure .htaccess
Create `public_html/.htaccess`:
```apache
<IfModule mod_rewrite.c>
  RewriteEngine On
  RewriteBase /
  
  # Redirect all requests to index.html for SPA routing
  RewriteCond %{REQUEST_FILENAME} !-f
  RewriteCond %{REQUEST_FILENAME} !-d
  RewriteRule . /index.html [L]
</IfModule>

# Enable CORS
<IfModule mod_headers.c>
  Header set Access-Control-Allow-Origin "*"
  Header set Access-Control-Allow-Methods "GET, POST, PUT, DELETE, OPTIONS"
  Header set Access-Control-Allow-Headers "Content-Type, Authorization"
</IfModule>
```

---

## STEP 3: Deploy Backend (Render - Free Tier)

### 3.1 Create Render Account
1. Go to https://render.com
2. Sign up with GitHub
3. Connect your GitHub repository (or create one)

### 3.2 Create PostgreSQL Database
1. In Render Dashboard → **New → PostgreSQL**
2. Name: `imis-database`
3. Plan: **Free**
4. Create Database
5. Copy the **Internal Database URL**

### 3.3 Create Web Service
1. In Render Dashboard → **New → Web Service**
2. Connect repository or use manual deploy
3. Settings:
   - **Name**: `imis-backend`
   - **Environment**: `Python 3`
   - **Build Command**: `pip install -r backend/requirements.txt`
   - **Start Command**: `cd backend && gunicorn app.main:app -w 4 -k uvicorn.workers.UvicornWorker --bind 0.0.0.0:$PORT`
   - **Plan**: Free

### 3.4 Add Environment Variables
In Render service settings, add:
```
DATABASE_URL=<your-postgres-internal-url>
SECRET_KEY=<generate-random-string>
ALGORITHM=HS256
ACCESS_TOKEN_EXPIRE_MINUTES=30
MTN_API_USER=<your-mtn-api-user>
MTN_API_KEY=<your-mtn-api-key>
MTN_SUBSCRIPTION_KEY=<your-mtn-subscription-key>
```

### 3.5 Deploy
Click **Deploy** - wait 5-10 minutes for first deployment.

---

## STEP 4: Update Frontend with Backend URL

### 4.1 Get Backend URL
After Render deployment, copy your backend URL:
Example: `https://imis-backend-xyz.onrender.com`

### 4.2 Update Frontend Environment
Edit `frontend/.env.production`:
```env
PUBLIC_API_URL=https://imis-backend-xyz.onrender.com
```

### 4.3 Rebuild and Re-upload
```bash
cd frontend
npm run build
```
Upload new build files to cPanel `public_html` again.

---

## STEP 5: Update Backend CORS

Add your domain to backend CORS:
Edit `backend/app/main.py` - add to `allow_origins`:
```python
"https://e-shakiro.com",
"https://www.e-shakiro.com",
"http://e-shakiro.com",
"http://www.e-shakiro.com"
```

Redeploy backend on Render.

---

## STEP 6: Configure Domain SSL (Optional but Recommended)

### In cPanel:
1. Go to **Security → SSL/TLS Status**
2. Enable AutoSSL for e-shakiro.com
3. Wait for certificate installation

---

## STEP 7: Test Your Deployment

1. Visit: **https://e-shakiro.com**
2. Test registration/login
3. Test reporting lost/found items
4. Check browser console for errors

---

## Alternative: Full cPanel Deployment (If Python Support Available)

### Check Python Support:
1. cPanel → **Software → Select PHP Version** or **Python Selector**
2. If Python 3.9+ available, proceed:

### Setup Python App:
1. cPanel → **Software → Setup Python App**
2. Python version: 3.9+
3. Application root: `/home/eshakiro/imis-backend`
4. Application URL: `api.e-shakiro.com` or `/api`
5. Application startup file: `app/main.py`
6. Application Entry point: `app`

### Upload Backend:
1. Upload `backend` folder to `/home/eshakiro/imis-backend`
2. Install dependencies via SSH or cPanel terminal
3. Configure database (MySQL or PostgreSQL if available)

---

## Database Setup (If using cPanel MySQL)

### Create Database:
1. cPanel → **Databases → MySQL Database Wizard**
2. Database name: `eshakiro_imis`
3. Create user with all privileges

### Update Backend:
Change `DATABASE_URL` to MySQL format:
```
mysql+pymysql://username:password@localhost/eshakiro_imis
```

Add to `requirements.txt`:
```
pymysql
```

---

## Troubleshooting

### Frontend not loading:
- Check `.htaccess` file exists
- Verify all files uploaded correctly
- Check browser console for errors

### Backend connection failed:
- Verify backend URL in frontend `.env.production`
- Check CORS settings in backend
- Ensure backend is running on Render

### Database connection failed:
- Verify `DATABASE_URL` in Render environment variables
- Check database is running

---

## Quick Commands Reference

### Build Frontend:
```bash
cd frontend
npm install
npm run build
```

### Test Backend Locally:
```bash
cd backend
python -m uvicorn app.main:app --reload
```

### Generate Secret Key:
```bash
python -c "import secrets; print(secrets.token_urlsafe(32))"
```

---

## Support
- cPanel: http://e-shakiro.com:2082
- Domain: e-shakiro.com
- Server IP: 31.170.162.103

**Created by MUSABYIMANA Gaudence**
