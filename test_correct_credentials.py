"""Test with CORRECT MTN credentials"""
import requests
import base64
import uuid
import json

print("Testing with CORRECT MTN Credentials")
print("=" * 60)

# Read from .env
from app.core.config import settings

subscription_key = settings.MTN_MOMO_SUBSCRIPTION_KEY
api_user = settings.MTN_MOMO_API_USER
api_key = settings.MTN_MOMO_API_KEY
base_url = settings.MTN_MOMO_BASE_URL

print(f"Username: {api_user}")
print(f"Subscription Key: {subscription_key}")
print(f"Base URL: {base_url}")
print()

# Step 1: Get Token
print("[STEP 1] Getting Access Token...")
print("-" * 60)

auth_string = f"{api_user}:{api_key}"
basic_auth = base64.b64encode(auth_string.encode()).decode()

print(f"Basic Auth: {basic_auth[:50]}...")

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
    
    print(f"Status: {token_response.status_code}")
    
    if token_response.status_code == 200:
        token_data = token_response.json()
        access_token = token_data.get("access_token")
        print(f"[SUCCESS] Token obtained!")
        print(f"Token: {access_token[:50]}...")
    else:
        print(f"[FAILED] {token_response.text}")
        exit(1)
        
except Exception as e:
    print(f"[ERROR] {e}")
    exit(1)

# Step 2: Request Payment
print("\n[STEP 2] Requesting Payment...")
print("-" * 60)

reference_id = str(uuid.uuid4())
phone = "250796888309"  # Use the MSISDN MTN gave you

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
    "externalId": f"IMIS_{uuid.uuid4().hex[:8].upper()}",
    "payer": {
        "partyIdType": "MSISDN",
        "partyId": phone
    },
    "payerMessage": "IMIS Contact Unlock",
    "payeeNote": "Payment for contact information"
}

print(f"Phone: {phone}")
print(f"Amount: 1000 RWF")
print(f"Reference: {reference_id}")

try:
    payment_response = requests.post(
        f"{base_url}/collection/v1_0/requesttopay",
        headers=payment_headers,
        json=payment_body,
        timeout=30
    )
    
    print(f"\nStatus: {payment_response.status_code}")
    
    if payment_response.status_code == 202:
        print(f"[SUCCESS] Payment request sent!")
        print(f"[SUCCESS] Check phone {phone} for payment prompt!")
        print(f"Reference ID: {reference_id}")
        
        # Check status
        print("\n[STEP 3] Checking Status...")
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
        
        print(f"Status: {status_response.status_code}")
        if status_response.status_code == 200:
            status_data = status_response.json()
            print(f"Payment Status: {status_data.get('status')}")
            print(f"Full Response: {json.dumps(status_data, indent=2)}")
        else:
            print(f"Response: {status_response.text}")
        
    else:
        print(f"[FAILED] Status: {payment_response.status_code}")
        print(f"Response: {payment_response.text}")
        
except Exception as e:
    print(f"[ERROR] {e}")

print("\n" + "=" * 60)
