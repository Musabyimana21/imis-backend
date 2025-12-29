# POSTMAN Visual Guide

## What You'll See:

### Request Setup Screen:
```
┌─────────────────────────────────────────────────────────────┐
│ POST  https://proxy.momoapi.mtn.co.rw/collection/token/     │
├─────────────────────────────────────────────────────────────┤
│ Params | Authorization | Headers | Body | Pre-req | Tests   │
├─────────────────────────────────────────────────────────────┤
│ Headers Tab:                                                │
│ ┌─────────────────────────┬─────────────────────────────────┐│
│ │ Key                     │ Value                           ││
│ ├─────────────────────────┼─────────────────────────────────┤│
│ │ Authorization           │ Basic MjRhMTRkN2ItNTdiMi00Nm... ││
│ │ Ocp-Apim-Subscription-  │ 92e0ee9794d34ac8bb166d2cd3b99a69││
│ │ X-Target-Environment    │ mtnrwanda                       ││
│ └─────────────────────────┴─────────────────────────────────┘│
├─────────────────────────────────────────────────────────────┤
│                    [Send] Button                            │
└─────────────────────────────────────────────────────────────┘
```

### Success Response (Test 1):
```
Status: 200 OK
Time: 1.2s
Size: 245 B

{
  "access_token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJSMjU2In0...",
  "token_type": "access_token",
  "expires_in": 3600
}
```

### Failure Response (Test 2):
```
Status: 200 OK (but HTML error page)
Time: 0.8s
Size: 180 B

<html>
<head><title>Request Rejected</title></head>
<body>
The requested URL was rejected. Please consult with your administrator.
<br><br>Your support ID is: 10819531211778814161
</body>
</html>
```

## Key Areas in Postman:

1. **URL Bar**: Top area where you enter the API endpoint
2. **Method Dropdown**: Left of URL (GET, POST, PUT, etc.)
3. **Headers Tab**: Where you add authentication headers
4. **Body Tab**: Where you add JSON data for POST requests
5. **Send Button**: Blue button to execute the request
6. **Response Area**: Bottom half shows the API response
7. **Status Code**: Shows 200, 400, 500, etc.

## Common Mistakes to Avoid:

❌ **Wrong Method**: Using GET instead of POST
❌ **Missing Headers**: Forgetting Authorization header
❌ **Wrong URL**: Typos in the endpoint URL
❌ **Invalid JSON**: Syntax errors in request body
❌ **Wrong Token**: Not copying full access token

✅ **Correct Setup**: Follow the exact steps above