# MANUAL CPANEL DEPLOYMENT GUIDE
# e-shakiro.com - IMIS System

## QUICK DEPLOYMENT STEPS

### STEP 1: BUILD FRONTEND
Run this command in your terminal:
```
F:\IMIS\DEPLOY_TO_CPANEL.bat
```

If that fails, manually run:
```
cd F:\IMIS\frontend
"C:\Program Files\nodejs\npm.cmd" install
"C:\Program Files\nodejs\npm.cmd" run build
```

### STEP 2: ACCESS CPANEL
- URL: http://e-shakiro.com:2082
- OR: http://31.170.162.103:2082
- Login with your cPanel credentials

### STEP 3: UPLOAD FILES
1. Open File Manager
2. Go to public_html folder
3. Delete all existing files
4. Upload ALL files from: F:\IMIS\frontend\build\
5. Upload .htaccess from: F:\IMIS\.htaccess

### STEP 4: SET PERMISSIONS
- Files: 644
- Folders: 755

### STEP 5: DEPLOY BACKEND TO RENDER
1. Go to https://render.com
2. Sign up with GitHub
3. Create PostgreSQL database (free)
4. Create Web Service:
   - Repository: Upload your backend folder
   - Build: pip install -r requirements.txt
   - Start: gunicorn app.main:app -w 4 -k uvicorn.workers.UvicornWorker --bind 0.0.0.0:$PORT

### STEP 6: UPDATE FRONTEND
1. Get your Render backend URL
2. Update F:\IMIS\frontend\.env.production
3. Rebuild and re-upload frontend

## YOUR SYSTEM WILL BE LIVE AT:
https://e-shakiro.com

## SUPPORT:
Created by MUSABYIMANA Gaudence
Phone: +250780460621
Email: gaudencemusabyimana21@gmail.com