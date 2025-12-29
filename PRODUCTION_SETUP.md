# 🚀 MTN Mobile Money Production Setup

## ✅ Your System is Ready for Production!

### 📝 Step 1: Add Your MTN Rwanda API Credentials

Replace these placeholders in `backend/.env`:

```env
# MTN Mobile Money API - PRODUCTION MODE
MTN_MOMO_ENABLED=true
MTN_MOMO_ENVIRONMENT=production
MTN_MOMO_BASE_URL=YOUR_PAYMENT_SERVER_URL_HERE
MTN_MOMO_SUBSCRIPTION_KEY=YOUR_SUBSCRIPTION_KEY_HERE
MTN_MOMO_API_USER=YOUR_API_USER_HERE
MTN_MOMO_API_KEY=YOUR_API_KEY_HERE
MTN_MOMO_TARGET_ENVIRONMENT=YOUR_TARGET_ENVIRONMENT_HERE
MTN_MOMO_CALLBACK_HOST=YOUR_PROVIDER_CALLBACK_HOST_HERE
MTN_MOMO_ACCOUNT=YOUR_ACCOUNT_HERE
```

### 🔧 Step 2: Map Your MTN Credentials

| Your MTN Info | .env Variable | Example |
|---------------|---------------|---------|
| **API User** | `MTN_MOMO_API_USER` | `12345678-1234-1234-1234-123456789012` |
| **API Key** | `MTN_MOMO_API_KEY` | `abcd1234efgh5678ijkl9012mnop3456` |
| **Account** | `MTN_MOMO_ACCOUNT` | `your_account_number` |
| **Provider Callback Host** | `MTN_MOMO_CALLBACK_HOST` | `https://yourdomain.com` |
| **Payment Server URL** | `MTN_MOMO_BASE_URL` | `https://api.mtn.com` |
| **Target Environment** | `MTN_MOMO_TARGET_ENVIRONMENT` | `mtnrwanda` |

### 🌐 Step 3: Production Deployment

#### For Local Testing:
```bash
# Start backend
cd backend
python -m uvicorn app.main:app --reload --host 0.0.0.0 --port 8001

# Start frontend  
cd frontend
npm run dev
```

#### For Production Server:
```bash
# Backend (use gunicorn for production)
cd backend
gunicorn app.main:app -w 4 -k uvicorn.workers.UvicornWorker --bind 0.0.0.0:8001

# Frontend (build for production)
cd frontend
npm run build
npm run preview
```

### 💰 Current Live Pricing

| Item Category | Price (RWF) | System Commission (15%) | Finder Gets (85%) |
|---------------|-------------|-------------------------|-------------------|
| 📱 Phone | 2,000 | 300 | 1,700 |
| 💻 Electronics | 1,800 | 270 | 1,530 |
| 📄 Documents | 1,500 | 225 | 1,275 |
| 💼 Wallet | 1,200 | 180 | 1,020 |
| 💍 Jewelry | 1,000 | 150 | 850 |
| 🎒 Bag | 800 | 120 | 680 |
| 🔑 Keys | 500 | 75 | 425 |
| 📦 Other | 600 | 90 | 510 |

### 🔄 Payment Flow

1. **User reports lost/found item** → System detects category
2. **Someone wants contact info** → System shows dynamic price
3. **Payment initiated** → MTN MoMo request sent to phone
4. **User enters PIN** → Payment processed
5. **Contact unlocked** → Finder gets 85%, System gets 15%

### 🛡️ Security Features

- ✅ **Real MTN MoMo API** integration
- ✅ **Secure payment callbacks**
- ✅ **Transaction tracking**
- ✅ **Automatic commission splits**
- ✅ **Payment status verification**

### 📊 API Endpoints (Live)

- `GET /api/anonymous/pricing` - View all prices
- `POST /api/anonymous/payment/initiate` - Start payment
- `GET /api/anonymous/payment/status/{id}` - Check payment
- `POST /api/anonymous/payment/callback` - MTN callback

### 🚨 Important Notes

1. **Test with small amounts first** (100-500 RWF)
2. **Monitor payment callbacks** in server logs
3. **Verify commission calculations** are correct
4. **Keep API credentials secure** - never commit to git

### 📞 Support

- **MTN MoMo Support**: Contact your MTN account manager
- **System Issues**: Check server logs for errors
- **Payment Problems**: Verify credentials and network connectivity

## 🎉 You're Ready to Go Live!

Once you add your credentials, your IMIS system will process real payments through MTN Mobile Money Rwanda!