# MTN Mobile Money Integration Setup Guide

## 🚀 Quick Setup for Sandbox Testing

### Step 1: Get MTN MoMo Developer Account
1. Visit: https://momodeveloper.mtn.com/
2. Click "Sign Up" and create account
3. Verify your email
4. Login to developer portal

### Step 2: Create API User (Sandbox)
1. Go to "Sandbox" section
2. Click "Create API User"
3. Copy the **API User ID** (UUID format)
4. Generate **API Key** for this user
5. Copy the **API Key**

### Step 3: Get Subscription Key
1. Go to "Products" → "Collection"
2. Subscribe to "Collection" product
3. Copy your **Primary Subscription Key**

### Step 4: Update Your .env File
Replace these placeholders in `backend/.env`:

```env
# Replace with your actual credentials
MTN_MOMO_SUBSCRIPTION_KEY=YOUR_PRIMARY_SUBSCRIPTION_KEY_HERE
MTN_MOMO_API_USER=YOUR_API_USER_ID_HERE  
MTN_MOMO_API_KEY=YOUR_API_KEY_HERE
```

### Step 5: Test the Integration

#### Test Pricing System:
```bash
# Get all category prices
curl http://localhost:8001/api/anonymous/pricing

# Get specific category price
curl http://localhost:8001/api/anonymous/pricing/phone
```

#### Test Payment Flow:
1. Report a lost/found item
2. Try to unlock contact info
3. System will show dynamic price based on category
4. Payment request will be sent to MTN MoMo

### Step 6: Sandbox Test Numbers
Use these test numbers in sandbox:
- **Valid**: 25078XXXXXXX (any 8 digits)
- **Test Amount**: Any amount works in sandbox
- **PIN**: 0000 (default sandbox PIN)

## 🏭 Production Setup

### When Ready for Production:
Update `.env` file:
```env
MTN_MOMO_ENVIRONMENT=production
MTN_MOMO_BASE_URL=https://momodeveloper.mtn.com
MTN_MOMO_TARGET_ENVIRONMENT=mtnrwanda
```

### Production Requirements:
1. **Business Registration** with MTN Rwanda
2. **Production API Keys** (different from sandbox)
3. **Compliance Review** by MTN
4. **Go-Live Approval**

## 💰 Current Pricing Structure

| Category | Price (RWF) | System (15%) | Finder (85%) |
|----------|-------------|--------------|--------------|
| Phone | 2,000 | 300 | 1,700 |
| Electronics | 1,800 | 270 | 1,530 |
| Documents | 1,500 | 225 | 1,275 |
| Wallet | 1,200 | 180 | 1,020 |
| Jewelry | 1,000 | 150 | 850 |
| Bag | 800 | 120 | 680 |
| Keys | 500 | 75 | 425 |
| Other | 600 | 90 | 510 |

## 🔧 API Endpoints

- `GET /api/anonymous/pricing` - All category prices
- `POST /api/anonymous/payment/initiate` - Start payment
- `GET /api/anonymous/payment/status/{transaction_id}` - Check status
- `POST /api/anonymous/payment/confirm/{transaction_id}` - Confirm payment

## 🐛 Troubleshooting

### Common Issues:
1. **401 Unauthorized**: Check subscription key
2. **403 Forbidden**: Check API user/key
3. **400 Bad Request**: Check phone number format (25078XXXXXXX)
4. **500 Internal Error**: Check if all credentials are set

### Debug Mode:
Set `MTN_MOMO_ENABLED=false` to use simulation mode for testing.

## 📞 Support
- MTN MoMo Developer Portal: https://momodeveloper.mtn.com/
- Documentation: https://momodeveloper.mtn.com/docs/
- Support: developer@mtn.com