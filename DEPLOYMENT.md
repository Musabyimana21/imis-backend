# IMIS Deployment Guide

## 🚀 Production Deployment

This guide covers deploying IMIS to production using Cloudflare Pages (frontend) and Render (backend + database).

## 📋 Prerequisites

- GitHub account
- Cloudflare account (free tier works)
- Render account (free tier works)
- Domain name (optional)

## 🗄️ Database Deployment (Render PostgreSQL)

### Step 1: Create PostgreSQL Database

1. Go to [Render Dashboard](https://dashboard.render.com/)
2. Click "New +" → "PostgreSQL"
3. Configure:
   - **Name**: `imis-database`
   - **Database**: `imis`
   - **User**: `imis_user`
   - **Region**: Choose closest to your users
   - **Plan**: Free (or paid for production)
4. Click "Create Database"
5. Wait for provisioning (2-3 minutes)
6. Copy the **Internal Database URL** (starts with `postgresql://`)

### Step 2: Initialize Database

```bash
# Connect to database
psql <INTERNAL_DATABASE_URL>

# Tables will be created automatically by FastAPI on first run
```

## 🔧 Backend Deployment (Render Web Service)

### Step 1: Prepare Repository

1. Push your code to GitHub:
```bash
git init
git add .
git commit -m "Initial commit"
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/imis.git
git push -u origin main
```

### Step 2: Create Web Service

1. Go to [Render Dashboard](https://dashboard.render.com/)
2. Click "New +" → "Web Service"
3. Connect your GitHub repository
4. Configure:
   - **Name**: `imis-backend`
   - **Region**: Same as database
   - **Branch**: `main`
   - **Root Directory**: `backend`
   - **Runtime**: `Python 3`
   - **Build Command**: `pip install -r requirements.txt`
   - **Start Command**: `uvicorn app.main:app --host 0.0.0.0 --port $PORT`
   - **Plan**: Free (or paid for production)

### Step 3: Environment Variables

Add these environment variables in Render:

```env
DATABASE_URL=<YOUR_INTERNAL_DATABASE_URL>
SECRET_KEY=<GENERATE_RANDOM_SECRET_KEY>
ALGORITHM=HS256
ACCESS_TOKEN_EXPIRE_MINUTES=30
PYTHON_VERSION=3.11.0
```

Generate SECRET_KEY:
```bash
python -c "import secrets; print(secrets.token_urlsafe(32))"
```

### Step 4: Deploy

1. Click "Create Web Service"
2. Wait for deployment (5-10 minutes)
3. Your API will be at: `https://imis-backend.onrender.com`
4. Test: `https://imis-backend.onrender.com/health`

## 🌐 Frontend Deployment (Cloudflare Pages)

### Step 1: Prepare Frontend

1. Update `frontend/.env`:
```env
PUBLIC_API_URL=https://imis-backend.onrender.com
```

2. Update `frontend/svelte.config.js`:
```javascript
import adapter from '@sveltejs/adapter-static';

export default {
  kit: {
    adapter: adapter({
      pages: 'build',
      assets: 'build',
      fallback: 'index.html'
    })
  }
};
```

3. Commit changes:
```bash
git add .
git commit -m "Configure for production"
git push
```

### Step 2: Create Cloudflare Pages Project

1. Go to [Cloudflare Dashboard](https://dash.cloudflare.com/)
2. Click "Pages" → "Create a project"
3. Connect to GitHub
4. Select your repository
5. Configure:
   - **Project name**: `imis`
   - **Production branch**: `main`
   - **Framework preset**: `SvelteKit`
   - **Build command**: `cd frontend && npm install && npm run build`
   - **Build output directory**: `frontend/build`

### Step 3: Environment Variables

Add in Cloudflare Pages settings:

```env
PUBLIC_API_URL=https://imis-backend.onrender.com
NODE_VERSION=20
```

### Step 4: Deploy

1. Click "Save and Deploy"
2. Wait for build (3-5 minutes)
3. Your site will be at: `https://imis.pages.dev`
4. Test the deployment

## 🔒 Security Configuration

### Backend (Render)

1. **CORS Settings** - Update `backend/app/main.py`:
```python
app.add_middleware(
    CORSMiddleware,
    allow_origins=[
        "https://imis.pages.dev",
        "https://yourdomain.com"  # Add your custom domain
    ],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)
```

2. **HTTPS Only** - Render provides automatic HTTPS

3. **Environment Variables** - Never commit secrets to Git

### Frontend (Cloudflare)

1. **HTTPS** - Automatic with Cloudflare
2. **DDoS Protection** - Built-in
3. **CDN** - Global distribution

## 🌍 Custom Domain Setup

### Backend Domain

1. In Render dashboard, go to your service
2. Click "Settings" → "Custom Domain"
3. Add: `api.yourdomain.com`
4. Update DNS records as instructed
5. Wait for SSL certificate (automatic)

### Frontend Domain

1. In Cloudflare Pages, go to your project
2. Click "Custom domains" → "Set up a custom domain"
3. Add: `yourdomain.com` or `www.yourdomain.com`
4. Follow DNS configuration steps
5. SSL is automatic

### Update API URL

After setting up custom domains, update frontend:

```env
PUBLIC_API_URL=https://api.yourdomain.com
```

Redeploy frontend.

## 📊 Database Management

### Backup Database

```bash
# Using Render dashboard
# Go to Database → Backups → Create Backup

# Or using pg_dump
pg_dump <DATABASE_URL> > backup.sql
```

### Restore Database

```bash
psql <DATABASE_URL> < backup.sql
```

### Seed Production Data

```bash
# SSH into Render service (paid plans only)
# Or run locally with production DATABASE_URL

python -m backend.seed_data
```

## 🔍 Monitoring & Logging

### Render Monitoring

1. Go to your service dashboard
2. View:
   - Logs (real-time)
   - Metrics (CPU, Memory, Requests)
   - Events (deployments, restarts)

### Cloudflare Analytics

1. Go to Pages project
2. View:
   - Page views
   - Bandwidth
   - Requests
   - Geographic distribution

### Health Checks

Set up monitoring with:
- [UptimeRobot](https://uptimerobot.com/) (free)
- [Pingdom](https://www.pingdom.com/)
- [StatusCake](https://www.statuscake.com/)

Monitor:
- `https://imis-backend.onrender.com/health`
- `https://imis.pages.dev`

## 🚨 Troubleshooting

### Backend Issues

**Problem**: 502 Bad Gateway
```bash
# Check logs in Render dashboard
# Verify DATABASE_URL is correct
# Check if service is running
```

**Problem**: Database connection failed
```bash
# Verify DATABASE_URL format
# Check database is running
# Verify network connectivity
```

**Problem**: Slow cold starts (free tier)
```bash
# Render free tier sleeps after 15 min inactivity
# Consider paid plan for production
# Or use cron job to keep alive
```

### Frontend Issues

**Problem**: API calls failing
```bash
# Check PUBLIC_API_URL is correct
# Verify CORS settings in backend
# Check browser console for errors
```

**Problem**: Build failing
```bash
# Check build logs in Cloudflare
# Verify Node version
# Check package.json dependencies
```

## 📈 Performance Optimization

### Backend

1. **Database Indexing**
```sql
CREATE INDEX idx_items_status ON items(status);
CREATE INDEX idx_items_category ON items(category);
CREATE INDEX idx_items_user_id ON items(user_id);
```

2. **Connection Pooling** - Already configured in SQLAlchemy

3. **Caching** - Add Redis for session storage (optional)

### Frontend

1. **Image Optimization** - Use Cloudflare Images
2. **Code Splitting** - Already handled by SvelteKit
3. **CDN** - Automatic with Cloudflare

## 💰 Cost Estimation

### Free Tier (Development/Testing)
- Render PostgreSQL: Free (1GB storage)
- Render Web Service: Free (750 hours/month)
- Cloudflare Pages: Free (unlimited requests)
- **Total: $0/month**

### Production Tier
- Render PostgreSQL: $7/month (10GB storage)
- Render Web Service: $7/month (always on)
- Cloudflare Pages: Free (or $20/month for Pro)
- **Total: $14-34/month**

## 🔄 CI/CD Pipeline

### Automatic Deployments

Both Render and Cloudflare Pages support automatic deployments:

1. Push to `main` branch
2. Automatic build and deploy
3. Zero downtime deployment
4. Rollback capability

### Manual Deployments

```bash
# Trigger manual deploy in dashboard
# Or use CLI tools

# Render CLI
render deploy

# Cloudflare Wrangler
wrangler pages publish frontend/build
```

## 📝 Post-Deployment Checklist

- [ ] Backend health check passing
- [ ] Frontend loading correctly
- [ ] Database connected
- [ ] User registration working
- [ ] Item creation working
- [ ] Matching algorithm running
- [ ] Messages sending
- [ ] Admin dashboard accessible
- [ ] HTTPS enabled
- [ ] Custom domain configured (optional)
- [ ] Monitoring set up
- [ ] Backups configured
- [ ] Error tracking enabled

## 🎉 You're Live!

Your IMIS platform is now deployed and accessible worldwide!

### Share Your Platform

- Frontend: `https://imis.pages.dev` or `https://yourdomain.com`
- API: `https://imis-backend.onrender.com` or `https://api.yourdomain.com`
- Docs: `https://imis-backend.onrender.com/docs`

## 📞 Support

- Render Docs: https://render.com/docs
- Cloudflare Docs: https://developers.cloudflare.com/pages
- SvelteKit Docs: https://kit.svelte.dev/docs
- FastAPI Docs: https://fastapi.tiangolo.com

---

**Congratulations on deploying IMIS! 🚀**
