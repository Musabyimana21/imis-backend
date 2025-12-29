# E-SHAKIRO.COM Custom Domain Setup Guide

## 🌐 Current Deployment Status

✅ **Backend**: https://imis-backend-wk7z.onrender.com (LIVE)
✅ **Frontend**: https://imis-frontend.pages.dev (LIVE)
⏳ **Custom Domain**: e-shakiro.com (PENDING SETUP)

## 🚀 Steps to Deploy e-shakiro.com

### Step 1: Configure Custom Domain in Cloudflare Pages

1. Go to [Cloudflare Dashboard](https://dash.cloudflare.com)
2. Navigate to **Workers & Pages**
3. Click on your **imis-frontend** project
4. Go to **Custom domains** tab
5. Click **Set up a custom domain**
6. Enter: `e-shakiro.com`
7. Click **Continue**

### Step 2: DNS Configuration

You have two options:

#### Option A: Use Cloudflare as DNS Provider (Recommended)
1. In Cloudflare, add your domain: `e-shakiro.com`
2. Change nameservers at your domain registrar to Cloudflare's
3. DNS records will be configured automatically

#### Option B: Keep Current DNS Provider
Add these DNS records at your current DNS provider:
```
Type: CNAME
Name: e-shakiro.com (or @)
Value: imis-frontend.pages.dev
```

### Step 3: Update Backend CORS Settings

Update the backend to allow your custom domain:

1. Edit `backend/app/main.py`
2. Update CORS origins:
```python
app.add_middleware(
    CORSMiddleware,
    allow_origins=[
        "http://localhost:5173",
        "https://imis-frontend.pages.dev",
        "https://e-shakiro.com",  # Add this line
        "https://*.pages.dev",
    ],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)
```

### Step 4: Update Environment Variables

Update frontend environment variables in Cloudflare Pages:

1. Go to **Settings** → **Environment variables**
2. Update or add:
   - `PUBLIC_API_URL`: `https://imis-backend-wk7z.onrender.com`
   - `PUBLIC_SITE_URL`: `https://e-shakiro.com`

### Step 5: SSL Certificate

Cloudflare will automatically provision SSL certificate for e-shakiro.com.
This usually takes 5-15 minutes.

## 🔧 Configuration Files to Update

### Frontend Configuration

Update `frontend/wrangler.toml`:
```toml
name = "imis-frontend"
compatibility_date = "2024-01-01"

[env.production]
vars = { 
  PUBLIC_API_URL = "https://imis-backend-wk7z.onrender.com",
  PUBLIC_SITE_URL = "https://e-shakiro.com"
}
```

### Backend Configuration

Update `backend/render.yaml` environment variables:
```yaml
- key: FRONTEND_URL
  value: https://e-shakiro.com
- key: ALLOWED_ORIGINS
  value: https://e-shakiro.com,https://imis-frontend.pages.dev
```

## 🧪 Testing Checklist

After setup, test these features on e-shakiro.com:

- [ ] Homepage loads correctly
- [ ] User registration works
- [ ] User login works
- [ ] Item reporting works
- [ ] Item search works
- [ ] Map functionality works
- [ ] Payment simulation works
- [ ] Admin dashboard accessible
- [ ] API calls work (no CORS errors)
- [ ] SSL certificate is valid

## 📊 Expected Timeline

- DNS propagation: 5-60 minutes
- SSL certificate: 5-15 minutes
- Total setup time: 15-75 minutes

## 🔍 Verification Commands

Test your deployment:

```bash
# Test domain resolution
nslookup e-shakiro.com

# Test SSL certificate
curl -I https://e-shakiro.com

# Test API connectivity
curl https://imis-backend-wk7z.onrender.com/health
```

## 🚨 Troubleshooting

### Domain not resolving
- Check DNS records are correct
- Wait for DNS propagation (up to 24 hours)
- Use DNS checker tools

### SSL certificate issues
- Wait 15 minutes for automatic provisioning
- Check Cloudflare SSL settings
- Ensure domain is properly verified

### CORS errors
- Verify backend CORS settings include e-shakiro.com
- Check browser console for specific errors
- Ensure API URL is correct in frontend

## 📞 Support

If you encounter issues:
1. Check Cloudflare Pages deployment logs
2. Check Render backend logs
3. Verify all environment variables
4. Test API endpoints directly

## 🎉 Success!

Once complete, your IMIS platform will be live at:
- **Website**: https://e-shakiro.com
- **API**: https://imis-backend-wk7z.onrender.com
- **Documentation**: https://imis-backend-wk7z.onrender.com/docs

Your lost and found platform for Rwanda will be fully operational!