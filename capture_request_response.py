"""Capture complete request and response for MTN"""
import requests
import base64
import uuid
import json
from datetime import datetime

print("=" * 80)
print("MTN MoMo API - Complete Request/Response Capture")
print("=" * 80)

# Credentials
subscription_key = "92e0ee9794d34ac8bb166d2cd3b99a69"
api_user = "24a14d7b-57b2-46a6-ba5c-4c17f628eb9e"
api_key = "2ac93c3f60304fdaa6f9ad2f591f0834"
base_url = "https://proxy.momoapi.mtn.co.rw"

print(f"\nTimestamp: {datetime.now().isoformat()}")
print(f"Merchant: IMS.SP (250796888309)")

# STEP 1: Get Token
print("\n" + "=" * 80)
print("STEP 1: GET ACCESS TOKEN")
print("=" * 80)

auth_string = f"{api_user}:{api_key}"
basic_auth = base64.b64encode(auth_string.encode()).decode()

token_request = {
    "method": "POST",
    "url": f"{base_url}/collection/token/",
    "headers": {
        "Ocp-Apim-Subscription-Key": subscription_key,
        "Authorization": f"Basic {basic_auth}"
    }
}

print("\nREQUEST:")
print(f"Method: {token_request['method']}")
print(f"URL: {token_request['url']}")
print("Headers:")
for key, value in token_request['headers'].items():
    print(f"  {key}: {value}")

token_response = requests.post(
    token_request['url'],
    headers=token_request['headers'],
    timeout=15
)

print("\nRESPONSE:")
print(f"Status Code: {token_response.status_code}")
print(f"Headers:")
for key, value in dict(token_response.headers).items():
    print(f"  {key}: {value}")
print(f"Body: {token_response.text}")

if token_response.status_code != 200:
    print("\n[ERROR] Token generation failed!")
    exit(1)

access_token = token_response.json()['access_token']
print(f"\n[SUCCESS] Token obtained: {access_token[:50]}...")

# STEP 2: Request Payment
print("\n" + "=" * 80)
print("STEP 2: REQUEST TO PAY")
print("=" * 80)

reference_id = str(uuid.uuid4())
external_id = f"IMIS_{uuid.uuid4().hex[:8].upper()}"
phone = "250796014801"

payment_request = {
    "method": "POST",
    "url": f"{base_url}/collection/v1_0/requesttopay",
    "headers": {
        "X-Reference-Id": reference_id,
        "X-Target-Environment": "mtnrwanda",
        "Ocp-Apim-Subscription-Key": subscription_key,
        "Authorization": f"Bearer {access_token}",
        "Content-Type": "application/json"
    },
    "body": {
        "amount": "1000",
        "currency": "RWF",
        "externalId": external_id,
        "payer": {
            "partyIdType": "MSISDN",
            "partyId": phone
        },
        "payerMessage": "IMIS Contact Unlock Payment",
        "payeeNote": "Payment for contact information"
    }
}

print("\nREQUEST:")
print(f"Method: {payment_request['method']}")
print(f"URL: {payment_request['url']}")
print("Headers:")
for key, value in payment_request['headers'].items():
    if key == "Authorization":
        print(f"  {key}: Bearer {access_token[:30]}...")
    else:
        print(f"  {key}: {value}")
print("Body:")
print(json.dumps(payment_request['body'], indent=2))

payment_response = requests.post(
    payment_request['url'],
    headers=payment_request['headers'],
    json=payment_request['body'],
    timeout=30
)

print("\nRESPONSE:")
print(f"Status Code: {payment_response.status_code}")
print(f"Headers:")
for key, value in dict(payment_response.headers).items():
    print(f"  {key}: {value}")
print(f"Body: {payment_response.text if payment_response.text else '(Empty - 202 Accepted)'}")

# STEP 3: Check Status
print("\n" + "=" * 80)
print("STEP 3: CHECK PAYMENT STATUS")
print("=" * 80)

import time
print("\nWaiting 5 seconds...")
time.sleep(5)

status_request = {
    "method": "GET",
    "url": f"{base_url}/collection/v1_0/requesttopay/{reference_id}",
    "headers": {
        "X-Target-Environment": "mtnrwanda",
        "Ocp-Apim-Subscription-Key": subscription_key,
        "Authorization": f"Bearer {access_token}"
    }
}

print("\nREQUEST:")
print(f"Method: {status_request['method']}")
print(f"URL: {status_request['url']}")
print("Headers:")
for key, value in status_request['headers'].items():
    if key == "Authorization":
        print(f"  {key}: Bearer {access_token[:30]}...")
    else:
        print(f"  {key}: {value}")

status_response = requests.get(
    status_request['url'],
    headers=status_request['headers'],
    timeout=15
)

print("\nRESPONSE:")
print(f"Status Code: {status_response.status_code}")
print(f"Headers:")
for key, value in dict(status_response.headers).items():
    print(f"  {key}: {value}")
print(f"Body:")
print(json.dumps(status_response.json(), indent=2))

# SUMMARY
print("\n" + "=" * 80)
print("SUMMARY FOR MTN")
print("=" * 80)

result = status_response.json()
payment_status = result.get('status')
reason = result.get('reason', 'N/A')

print(f"\nReference ID: {reference_id}")
print(f"External ID: {external_id}")
print(f"Phone Number: {phone}")
print(f"Amount: 1000 RWF")
print(f"\nPayment Status: {payment_status}")
print(f"Failure Reason: {reason}")
print(f"\nDid phone {phone} receive popup? NO")

print("\n" + "=" * 80)
print("SHARE THIS ENTIRE OUTPUT WITH MTN")
print("=" * 80)
