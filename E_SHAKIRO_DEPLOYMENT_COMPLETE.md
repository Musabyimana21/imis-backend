# 🚀 COMPLETE DEPLOYMENT GUIDE FOR E-SHAKIRO.COM
## IMIS System - Lost & Found Platform

---

## 📋 OVERVIEW

**Your Domain:** e-shakiro.com  
**Backend:** Already deployed on Render (https://imis-backend-wk7z.onrender.com)  
**Database:** PostgreSQL on Render  
**Frontend:** Will be deployed to cPanel  

---

## ✅ STEP 1: BUILD FRONTEND FOR PRODUCTION

### Option A: Use Automated Script (RECOMMENDED)
1. Double-click: `DEPLOY_E_SHAKIRO_COMPLETE.bat`
2. Wait for build to complete
3. Build folder will open automatically

### Option B: Manual Build
```bash
cd F:\IMIS\frontend
npm install
npm run build
```

**Build Output Location:** `F:\IMIS\frontend\build`

---

## ✅ STEP 2: ACCESS YOUR CPANEL

### Login Methods:
- **Primary:** http://e-shakiro.com:2082
- **Alternative:** http://31.170.162.103:2082

**Credentials:** Use the credentials provided by your hosting provider

---

## ✅ STEP 3: UPLOAD FRONTEND TO CPANEL

### 3.1 Open File Manager
1. Login to cPanel
2. Click **"File Manager"** (under Files section)
3. Navigate to **`public_html`** folder

### 3.2 Clean public_html
1. Select ALL existing files in `public_html`
2. Click **"Delete"** button
3. Confirm deletion

### 3.3 Upload Your Build Files
1. Click **"Upload"** button
2. Navigate to: `F:\IMIS\frontend\build`
3. Select ALL files and folders:
   - `_app/` folder
   - `images/` folder
   - `favicon.ico`
   - `index.html`
   - All other files
4. Upload everything (may take 2-5 minutes)

### 3.4 Upload .htaccess File
1. In File Manager, still in `public_html`
2. Click **"Upload"**
3. Upload: `F:\IMIS\.htaccess`
4. This file handles routing for your SPA

### 3.5 Verify File Structure
Your `public_html` should look like:
```
public_html/
├── _app/
│   ├── immutable/
│   └── version.json
├── images/
├── .htaccess
├── favicon.ico
├── index.html
└── robots.txt
```

---

## ✅ STEP 4: SET FILE PERMISSIONS

### In cPanel File Manager:
1. Select ALL files in `public_html`
2. Click **"Permissions"** button
3. Set:
   - **Files:** 644
   - **Folders:** 755
4. Check **"Recurse into subdirectories"**
5. Click **"Change Permissions"**

---

## ✅ STEP 5: CONFIGURE SSL (HTTPS)

### Enable Free SSL Certificate:
1. In cPanel, go to **"Security"** section
2. Click **"SSL/TLS Status"**
3. Find **e-shakiro.com**
4. Click **"Run AutoSSL"**
5. Wait 5-10 minutes for certificate installation

**After SSL:** Your site will be accessible at `https://e-shakiro.com`

---

## ✅ STEP 6: VERIFY BACKEND IS RUNNING

### Check Backend Status:
1. Open browser
2. Visit: https://imis-backend-wk7z.onrender.com/docs
3. You should see FastAPI documentation page

### If Backend is Down:
1. Login to Render.com
2. Go to your backend service
3. Click **"Manual Deploy"** → **"Deploy latest commit"**
4. Wait 5-10 minutes

---

## ✅ STEP 7: UPDATE BACKEND CORS (IMPORTANT!)

Your backend needs to allow requests from e-shakiro.com.

### 7.1 Check Current CORS Settings
Open: `F:\IMIS\backend\app\main.py`

Look for the `allow_origins` section around line 20-30.

### 7.2 Add Your Domain
Make sure these origins are included:
```python
allow_origins=[
    "http://localhost:5173",
    "http://localhost:4173",
    "http://127.0.0.1:5173",
    "https://imis-frontend.pages.dev",
    "https://e-shakiro.com",           # ADD THIS
    "https://www.e-shakiro.com",       # ADD THIS
    "http://e-shakiro.com",            # ADD THIS
    "http://www.e-shakiro.com",        # ADD THIS
]
```

### 7.3 Redeploy Backend
1. Commit changes to Git
2. Push to GitHub
3. Render will auto-deploy (or manually deploy)

---

## ✅ STEP 8: TEST YOUR DEPLOYMENT

### 8.1 Visit Your Site
Open: **https://e-shakiro.com**

### 8.2 Test Features:
1. ✅ Homepage loads
2. ✅ Register new account
3. ✅ Login with account
4. ✅ Report lost item
5. ✅ Report found item
6. ✅ View items list
7. ✅ Search functionality

### 8.3 Check Browser Console
1. Press **F12** to open Developer Tools
2. Go to **Console** tab
3. Look for errors (should be none)

---

## 🔧 TROUBLESHOOTING

### Problem: "Failed to fetch" or CORS errors
**Solution:**
- Update backend CORS settings (Step 7)
- Redeploy backend
- Clear browser cache (Ctrl+Shift+Delete)

### Problem: 404 errors on page refresh
**Solution:**
- Verify `.htaccess` file is uploaded
- Check `.htaccess` permissions (644)

### Problem: Images not loading
**Solution:**
- Verify `images/` folder uploaded correctly
- Check file permissions (644 for files, 755 for folders)

### Problem: Backend not responding
**Solution:**
- Check Render backend status
- Render free tier sleeps after 15 min inactivity
- First request may take 30-60 seconds to wake up

### Problem: SSL certificate not working
**Solution:**
- Wait 10-15 minutes after enabling AutoSSL
- Contact hosting support if still not working

---

## 📊 MONITORING YOUR SITE

### Check Backend Logs:
1. Login to Render.com
2. Go to your backend service
3. Click **"Logs"** tab
4. Monitor for errors

### Check Frontend:
1. Visit: https://e-shakiro.com
2. Open browser console (F12)
3. Check for JavaScript errors

---

## 🔄 UPDATING YOUR SITE

### When You Make Changes:

#### Frontend Changes:
1. Run: `DEPLOY_E_SHAKIRO_COMPLETE.bat`
2. Upload new build files to cPanel
3. Clear browser cache

#### Backend Changes:
1. Commit to Git
2. Push to GitHub
3. Render auto-deploys
4. Or manually deploy on Render

---

## 📱 MOBILE TESTING

Test on mobile devices:
- Visit: https://e-shakiro.com
- Test all features
- Check responsive design

---

## 🎯 PERFORMANCE OPTIMIZATION

### Already Configured:
- ✅ Static file caching (1 year)
- ✅ GZIP compression
- ✅ Optimized images
- ✅ Minified CSS/JS

### Additional Tips:
- Use Cloudflare for CDN (optional)
- Enable cPanel caching features
- Monitor with Google PageSpeed Insights

---

## 📞 SUPPORT INFORMATION

**Developer:** MUSABYIMANA Gaudence  
**Email:** gaudencemusabyimana21@gmail.com  
**Phone:** +250780460621  

**Hosting Support:**
- cPanel: http://e-shakiro.com:2082
- Contact your hosting provider for server issues

---

## 🎉 DEPLOYMENT CHECKLIST

Before going live, verify:

- [ ] Frontend built successfully
- [ ] All files uploaded to public_html
- [ ] .htaccess file uploaded
- [ ] File permissions set correctly
- [ ] SSL certificate installed
- [ ] Backend is running on Render
- [ ] CORS configured for e-shakiro.com
- [ ] Database connected and working
- [ ] Test registration works
- [ ] Test login works
- [ ] Test reporting items works
- [ ] Test search works
- [ ] Mobile responsive works
- [ ] No console errors

---

## 🚀 QUICK REFERENCE

**Frontend Build:** `DEPLOY_E_SHAKIRO_COMPLETE.bat`  
**cPanel Login:** http://e-shakiro.com:2082  
**Your Site:** https://e-shakiro.com  
**Backend API:** https://imis-backend-wk7z.onrender.com  
**API Docs:** https://imis-backend-wk7z.onrender.com/docs  

---

## 📝 NOTES

- Render free tier sleeps after 15 min inactivity
- First request after sleep takes 30-60 seconds
- Consider upgrading to paid tier for production
- Keep your cPanel password secure
- Regular backups recommended

---

**Last Updated:** January 2025  
**Version:** 1.0  
**Status:** Production Ready ✅
