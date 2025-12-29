# Render Environment Variables Setup Guide

## Step 1: Access Your Render Service

1. Go to https://render.com and log into your account
2. Find your `imis-backend` service in the dashboard
3. Click on your service name to open the service details

## Step 2: Navigate to Environment Variables

1. In your service dashboard, click on the **"Environment"** tab in the left sidebar
2. You'll see a section called **"Environment Variables"**

## Step 3: Add Environment Variables

Click **"Add Environment Variable"** and add each of the following variables one by one:

### Required Environment Variables

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

### How to Add Each Variable:

For each variable above:
1. Click **"Add Environment Variable"**
2. Enter the **Key** (e.g., `DATABASE_URL`)
3. Enter the **Value** (e.g., your actual database URL)
4. Click **"Add"**

### Important Notes:

- **DATABASE_URL**: Replace `<your-postgresql-internal-url-from-step-1.2>` with your actual PostgreSQL internal URL from Render
- **SECRET_KEY**: Change `your-super-secret-key-change-this` to a secure random string
- All other values can be used exactly as shown above

## Step 4: Get Your Database URL

If you don't have your database URL:

1. Go to your Render dashboard
2. Find your PostgreSQL database service
3. Click on it to open the database details
4. Look for **"Internal Database URL"** - this is what you need for `DATABASE_URL`
5. It will look like: `postgresql://username:password@hostname:5432/database_name`

## Step 5: Generate a Secure Secret Key

Replace `your-super-secret-key-change-this` with a secure random string. You can generate one using:

```python
import secrets
print(secrets.token_urlsafe(32))
```

Or use an online generator like: https://randomkeygen.com/

## Step 6: Save and Deploy

1. After adding all environment variables, click **"Save Changes"**
2. Render will automatically redeploy your service with the new environment variables
3. Wait for the deployment to complete (5-10 minutes)

## Step 7: Verify Configuration

1. Once deployed, visit your backend URL: `https://your-app-name.onrender.com/docs`
2. Check the logs in Render dashboard to ensure no environment variable errors
3. Test the API endpoints to ensure everything is working

## Troubleshooting

### If deployment fails:
- Check the logs in Render dashboard
- Ensure all environment variable names are spelled correctly
- Verify your database URL is correct

### If MTN payments don't work:
- Verify all MTN_MOMO_* variables are set correctly
- Check that callback URLs match your domain exactly

### If CORS errors occur:
- Ensure ALLOWED_ORIGINS includes both http and https versions of your domain
- Verify FRONTEND_URL matches your actual frontend domain

## Environment Variables Checklist

- [ ] DATABASE_URL (with your actual PostgreSQL URL)
- [ ] SECRET_KEY (changed to a secure random string)
- [ ] FRONTEND_URL=https://e-shakiro.com
- [ ] ALLOWED_ORIGINS=https://e-shakiro.com,http://e-shakiro.com
- [ ] MTN_MOMO_ENABLED=true
- [ ] MTN_MOMO_ENVIRONMENT=production
- [ ] MTN_MOMO_BASE_URL=https://proxy.momoapi.mtn.co.rw
- [ ] MTN_MOMO_SUBSCRIPTION_KEY=92e0ee9794d34ac8bb166d2cd3b99a69
- [ ] MTN_MOMO_API_USER=24a14d7b-57b2-46a6-ba5c-4c17f628eb9e
- [ ] MTN_MOMO_API_KEY=2ac93c3f60304fdaa6f9ad2f591f0834
- [ ] MTN_MOMO_TARGET_ENVIRONMENT=mtnrwanda
- [ ] MTN_MOMO_CALLBACK_URL=https://e-shakiro.com/api/anonymous/payment/callback
- [ ] MTN_MOMO_CALLBACK_HOST=e-shakiro.com

## Next Steps

After configuring environment variables:
1. Update your frontend configuration to point to your Render backend URL
2. Deploy your frontend to cPanel
3. Test the complete system integration
4. Monitor logs for any issues

Your backend will be accessible at: `https://your-app-name.onrender.com`