"""Test with NEW MTN credentials - IMS.SP"""
import requests
import base64
import uuid
import json

print("Testing with NEW MTN Credentials")
print("=" * 60)

# NEW credentials from MTN
subscription_key = "92e0ee9794d34ac8bb166d2cd3b99a69"
api_user = "IMS.SP"
api_key = "2ac93c3f60304fdaa6f9ad2f591f0834"
base_url = "https://proxy.momoapi.mtn.co.rw"
merchant_phone = "250796888309"

print(f"Username: {api_user}")
print(f"Merchant Phone: {merchant_phone}")
print()

# Step 1: Get Token
print("[STEP 1] Getting Access Token...")
print("-" * 60)

auth_string = f"{api_user}:{api_key}"
basic_auth = base64.b64encode(auth_string.encode()).decode()

print(f"Basic Auth: {basic_auth}")

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
    print(f"Response: {token_response.text[:300]}")
    
    if token_response.status_code == 200:
        token_data = token_response.json()
        access_token = token_data.get("access_token")
        print(f"\n[SUCCESS] Token obtained!")
    else:
        print(f"\n[FAILED] Cannot get token")
        exit(1)
        
except Exception as e:
    print(f"[ERROR] {e}")
    exit(1)

# Step 2: Request Payment to YOUR phone
print("\n[STEP 2] Requesting Payment...")
print("-" * 60)

reference_id = str(uuid.uuid4())
test_phone = "250796014801"  # Your phone to receive payment

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
        "partyId": test_phone
    },
    "payerMessage": "IMIS Contact Unlock Fee",
    "payeeNote": "Payment for contact information"
}

print(f"Sending payment request to: {test_phone}")
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
    print(f"Response: {payment_response.text[:500]}")
    
    if payment_response.status_code == 202:
        print(f"\n[SUCCESS] Payment request ACCEPTED!")
        print(f"[SUCCESS] Check phone {test_phone} for payment prompt!")
        print(f"Reference ID: {reference_id}")
        
        # Check status
        print("\n[STEP 3] Checking Payment Status...")
        print("-" * 60)
        
        import time
        time.sleep(5)
        
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
        if status_response.status_code == 200:
            status_data = status_response.json()
            payment_status = status_data.get('status')
            print(f"\nPayment Status: {payment_status}")
            print(f"Full Response:\n{json.dumps(status_data, indent=2)}")
            
            if payment_status == "SUCCESSFUL":
                print("\n[SUCCESS] PAYMENT COMPLETED!")
            elif payment_status == "PENDING":
                print("\n[PENDING] Waiting for user to confirm...")
            elif payment_status == "FAILED":
                print(f"\n[FAILED] Reason: {status_data.get('reason')}")
        else:
            print(f"Response: {status_response.text}")
        
    else:
        print(f"\n[FAILED] Payment request rejected")
        print("Show this error to MTN worker")
        
except Exception as e:
    print(f"[ERROR] {e}")

print("\n" + "=" * 60)
print("Test Complete")
print("=" * 60)
