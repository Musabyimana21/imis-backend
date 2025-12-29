# EXACT Postman Test - Copy/Paste

## Test 1: Get Token

**Method:** POST

**URL:**
```
https://proxy.momoapi.mtn.co.rw/collection/token/
```

**Headers:**
```
Ocp-Apim-Subscription-Key: 92e0ee9794d34ac8bb166d2cd3b99a69
Authorization: Basic MjRhMTRkN2ItNTdiMi00NmE2LWJhNWMtNGMxN2Y2MjhlYjllOjJhYzkzYzNmNjAzMDRmZGFhNmY5YWQyZjU5MWYwODM0
```

**Click Send**

**Copy the access_token from response**

---

## Test 2: Request Payment

**Method:** POST

**URL:**
```
https://proxy.momoapi.mtn.co.rw/collection/v1_0/requesttopay
```

**Headers:**
```
X-Reference-Id: 12345678-abcd-1234-abcd-123456789abc
X-Target-Environment: mtnrwanda
Ocp-Apim-Subscription-Key: 92e0ee9794d34ac8bb166d2cd3b99a69
Authorization: Bearer PASTE_YOUR_TOKEN_HERE
Content-Type: application/json
```

**Body (raw JSON):**
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

**Click Send**

**Expected:** Status 202

---

## Test 3: Check Status

**Method:** GET

**URL:**
```
https://proxy.momoapi.mtn.co.rw/collection/v1_0/requesttopay/12345678-abcd-1234-abcd-123456789abc
```

**Headers:**
```
X-Target-Environment: mtnrwanda
Ocp-Apim-Subscription-Key: 92e0ee9794d34ac8bb166d2cd3b99a69
Authorization: Bearer PASTE_YOUR_TOKEN_HERE
```

**Click Send**

**What does it return?**

---

## Share Results with MTN

After Test 3, share the EXACT response with MTN:
- What is the "status"?
- What is the "reason"?
- Did phone receive prompt?

If status = FAILED with INTERNAL_PROCESSING_ERROR, show MTN this proves it's their backend issue.
