# MTN MoMo POSTMAN Testing Guide

## 📋 Your Credentials

```
Base URL: https://proxy.momoapi.mtn.co.rw
Subscription Key: 92e0ee9794d34ac8bb166d2cd3b99a69
API User: 24a14d7b-57b2-46a6-ba5c-4c17f628eb9e
API Key: 2ac93c3f60304fdaa6f9ad2f591f0834
Target Environment: mtnrwanda
```

## 🧪 POSTMAN Tests

### Test 1: Get Access Token ✅

**Request:**
```
POST https://proxy.momoapi.mtn.co.rw/collection/token/
```

**Headers:**
```
Ocp-Apim-Subscription-Key: 92e0ee9794d34ac8bb166d2cd3b99a69
Authorization: Basic MjRhMTRkN2ItNTdiMi00NmE2LWJhNWMtNGMxN2Y2MjhlYjllOjJhYzkzYzNmNjAzMDRmZGFhNmY5YWQyZjU5MWYwODM0
```

**Expected:** Status 200, returns access_token

---

### Test 2: Request to Pay (CRITICAL)

**Request:**
```
POST https://proxy.momoapi.mtn.co.rw/collection/v1_0/requesttopay
```

**Headers:**
```
X-Reference-Id: {{$guid}}
X-Target-Environment: mtnrwanda
Ocp-Apim-Subscription-Key: 92e0ee9794d34ac8bb166d2cd3b99a69
Authorization: Bearer {{access_token}}
Content-Type: application/json
```

**Body (JSON):**
```json
{
  "amount": "1000",
  "currency": "RWF",
  "externalId": "TEST123456",
  "payer": {
    "partyIdType": "MSISDN",
    "partyId": "250796014801"
  },
  "payerMessage": "Test Payment",
  "payeeNote": "IMIS Test"
}
```

**Expected:** Status 202 Accepted

---

### Test 3: Check Payment Status

**Request:**
```
GET https://proxy.momoapi.mtn.co.rw/collection/v1_0/requesttopay/{{reference_id}}
```

**Headers:**
```
X-Target-Environment: mtnrwanda
Ocp-Apim-Subscription-Key: 92e0ee9794d34ac8bb166d2cd3b99a69
Authorization: Bearer {{access_token}}
```

**Expected:** Status 200, returns payment status

---

## 🔑 Generate Basic Auth

Your Basic Auth string:
```
MjRhMTRkN2ItNTdiMi00NmE2LWJhNWMtNGMxN2Y2MjhlYjllOjJhYzkzYzNmNjAzMDRmZGFhNmY5YWQyZjU5MWYwODM0
```

This is base64 of: `24a14d7b-57b2-46a6-ba5c-4c17f628eb9e:2ac93c3f60304fdaa6f9ad2f591f0834`

---

## 📝 Step-by-Step POSTMAN Test

### Step 1: Get Token
1. Open Postman
2. Create new POST request
3. URL: `https://proxy.momoapi.mtn.co.rw/collection/token/`
4. Add headers:
   - `Ocp-Apim-Subscription-Key: 92e0ee9794d34ac8bb166d2cd3b99a69`
   - `Authorization: Basic MjRhMTRkN2ItNTdiMi00NmE2LWJhNWMtNGMxN2Y2MjhlYjllOjJhYzkzYzNmNjAzMDRmZGFhNmY5YWQyZjU5MWYwODM0`
5. Send
6. Copy the `access_token` from response

### Step 2: Request Payment
1. Create new POST request
2. URL: `https://proxy.momoapi.mtn.co.rw/collection/v1_0/requesttopay`
3. Add headers:
   - `X-Reference-Id: ` (generate UUID - use {{$guid}} in Postman)
   - `X-Target-Environment: mtnrwanda`
   - `Ocp-Apim-Subscription-Key: 92e0ee9794d34ac8bb166d2cd3b99a69`
   - `Authorization: Bearer YOUR_ACCESS_TOKEN_HERE`
   - `Content-Type: application/json`
4. Body (raw JSON):
```json
{
  "amount": "1000",
  "currency": "RWF",
  "externalId": "TEST123",
  "payer": {
    "partyIdType": "MSISDN",
    "partyId": "250796014801"
  },
  "payerMessage": "Test Payment",
  "payeeNote": "IMIS Test"
}
```
5. Send
6. **Expected: 202 Accepted**
7. **Check your phone for prompt!**

### Step 3: Check Status
1. Create new GET request
2. URL: `https://proxy.momoapi.mtn.co.rw/collection/v1_0/requesttopay/YOUR_REFERENCE_ID`
3. Add headers:
   - `X-Target-Environment: mtnrwanda`
   - `Ocp-Apim-Subscription-Key: 92e0ee9794d34ac8bb166d2cd3b99a69`
   - `Authorization: Bearer YOUR_ACCESS_TOKEN`
4. Send
5. Check status: PENDING, SUCCESSFUL, or FAILED

---

## 🎯 What to Tell MTN

If Test 2 fails with firewall error:

**Say to MTN:**
> "I tested in Postman. Token generation works (Test 1 passes). But requesttopay endpoint returns firewall rejection. I need Collection API permissions enabled for my subscription key: 92e0ee9794d34ac8bb166d2cd3b99a69"

**Show them:**
- ✅ Test 1 passes (token works)
- ❌ Test 2 fails (payment blocked)
- Error: "Request Rejected" with support ID

---

## 🔍 Common Issues

**Issue 1: "Request Rejected"**
→ Account needs Collection API permissions
→ Contact MTN to enable

**Issue 2: "Invalid Subscription Key"**
→ Check subscription key is correct
→ Verify it's for production, not sandbox

**Issue 3: "Unauthorized"**
→ Token expired, get new one
→ Check Basic Auth is correct

**Issue 4: "Invalid Target Environment"**
→ Should be "mtnrwanda" not "sandbox"

---

## 📞 MTN Contact Info

If Postman test fails:
- Show MTN the exact error
- Provide Support ID from error
- Request Collection API access
- Ask for production credentials if needed

---

## ✅ Success Criteria

**If all 3 tests pass in Postman:**
→ Your code is correct
→ IMIS will work immediately
→ No code changes needed

**If Test 2 fails:**
→ MTN needs to enable permissions
→ Not a code issue
→ Wait for MTN to fix

---

Test in Postman now and share the results!
