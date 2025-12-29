"""Direct MTN API test - Step by step"""
import requests
import base64
import uuid
import json

print("=" * 60)
print("MTN MoMo API Direct Test")
print("=" * 60)

# Your credentials
subscription_key = "92e0ee9794d34ac8bb166d2cd3b99a69"
api_user = "24a14d7b-57b2-46a6-ba5c-4c17f628eb9e"
api_key = "2ac93c3f60304fdaa6f9ad2f591f0834"
base_url = "https://proxy.momoapi.mtn.co.rw"
phone = "250796014801"

# Step 1: Get Token
print("\n[STEP 1] Getting Access Token...")
print("-" * 60)

auth_string = f"{api_user}:{api_key}"
basic_auth = base64.b64encode(auth_string.encode()).decode()

token_headers = {
    "Ocp-Apim-Subscription-Key": subscription_key,
    "Authorization": f"Basic {basic_auth}"
}

try:
    token_response = requests.post(
        f"{base_url}/collection/token/",
        headers=token_headers,
        timeout=15
    )
    
    print(f"Status Code: {token_response.status_code}")
    print(f"Response: {token_response.text[:200]}")
    
    if token_response.status_code == 200:
        token_data = token_response.json()
        access_token = token_data.get("access_token")
        print(f"[OK] Token obtained: {access_token[:30]}...")
    else:
        print("[FAIL] Token failed!")
        exit(1)
        
except Exception as e:
    print(f"[ERROR] {e}")
    exit(1)

# Step 2: Request Payment
print("\n[STEP 2] Requesting Payment...")
print("-" * 60)

reference_id = str(uuid.uuid4())
print(f"Reference ID: {reference_id}")

payment_headers = {
    "X-Reference-Id": reference_id,
    "X-Target-Environment": "mtnrwanda",
    "Ocp-Apim-Subscription-Key": subscription_key,
    "Authorization": f"Bearer {access_token}",
    "Content-Type": "application/json"
}

payment_body = {
    "amount": "1000",
    "currency": "RWF",
    "externalId": f"TEST_{uuid.uuid4().hex[:8].upper()}",
    "payer": {
        "partyIdType": "MSISDN",
        "partyId": phone
    },
    "payerMessage": "IMIS Test Payment",
    "payeeNote": "Contact unlock fee"
}

print(f"Phone: {phone}")
print(f"Amount: 1000 RWF")
print(f"Body: {json.dumps(payment_body, indent=2)}")

try:
    payment_response = requests.post(
        f"{base_url}/collection/v1_0/requesttopay",
        headers=payment_headers,
        json=payment_body,
        timeout=30
    )
    
    print(f"\nStatus Code: {payment_response.status_code}")
    print(f"Response Headers: {dict(payment_response.headers)}")
    print(f"Response Body: {payment_response.text[:500]}")
    
    if payment_response.status_code == 202:
        print("\n[SUCCESS] Payment request sent!")
        print(f"[SUCCESS] Check phone {phone} for payment prompt!")
        print(f"[SUCCESS] Reference ID: {reference_id}")
        
        # Step 3: Check Status
        print("\n[STEP 3] Checking Payment Status...")
        print("-" * 60)
        
        import time
        time.sleep(3)
        
        status_headers = {
            "X-Target-Environment": "mtnrwanda",
            "Ocp-Apim-Subscription-Key": subscription_key,
            "Authorization": f"Bearer {access_token}"
        }
        
        status_response = requests.get(
            f"{base_url}/collection/v1_0/requesttopay/{reference_id}",
            headers=status_headers,
            timeout=15
        )
        
        print(f"Status Code: {status_response.status_code}")
        print(f"Status: {status_response.text}")
        
    else:
        print(f"\n[FAILED] Status: {payment_response.status_code}")
        print("This is the error MTN needs to fix!")
        
except Exception as e:
    print(f"[ERROR] {e}")

print("\n" + "=" * 60)
print("Test Complete")
print("=" * 60)
