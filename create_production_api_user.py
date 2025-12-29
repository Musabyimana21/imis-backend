"""Create Production API User with MTN's production subscription key"""
import requests
import uuid

print("=" * 60)
print("Creating Production API User")
print("=" * 60)

# MTN's PRODUCTION subscription key
subscription_key = "92e0ee9794d34ac8bb166d2cd3b99a69"
base_url = "https://proxy.momoapi.mtn.co.rw"

# Generate new UUID for production API user
api_user_uuid = str(uuid.uuid4())

print(f"\nNew API User UUID: {api_user_uuid}")
print("SAVE THIS UUID!")

# Step 1: Create API User
print("\n[STEP 1] Creating API User...")
print("-" * 60)

headers = {
    "X-Reference-Id": api_user_uuid,
    "Ocp-Apim-Subscription-Key": subscription_key,
    "Content-Type": "application/json"
}

body = {
    "providerCallbackHost": "www.imis.sp"
}

try:
    response = requests.post(
        f"{base_url}/v1_0/apiuser",
        headers=headers,
        json=body,
        timeout=15
    )
    
    print(f"Status: {response.status_code}")
    print(f"Response: {response.text}")
    
    if response.status_code == 201:
        print("[SUCCESS] API User created!")
    elif response.status_code == 409:
        print("[INFO] API User already exists")
    else:
        print("[FAILED] Could not create API user")
        print("Try with MTN support")
        exit(1)
        
except Exception as e:
    print(f"[ERROR] {e}")
    exit(1)

# Step 2: Generate API Key
print("\n[STEP 2] Generating API Key...")
print("-" * 60)

key_headers = {
    "Ocp-Apim-Subscription-Key": subscription_key
}

try:
    response = requests.post(
        f"{base_url}/v1_0/apiuser/{api_user_uuid}/apikey",
        headers=key_headers,
        timeout=15
    )
    
    print(f"Status: {response.status_code}")
    
    if response.status_code == 201:
        api_key_data = response.json()
        api_key = api_key_data.get("apiKey")
        
        print(f"[SUCCESS] API Key generated!")
        print("\n" + "=" * 60)
        print("SAVE THESE CREDENTIALS:")
        print("=" * 60)
        print(f"MTN_MOMO_API_USER={api_user_uuid}")
        print(f"MTN_MOMO_API_KEY={api_key}")
        print("=" * 60)
        print("\nUpdate your .env file with these values!")
        
    else:
        print(f"[FAILED] {response.text}")
        print("Contact MTN support")
        
except Exception as e:
    print(f"[ERROR] {e}")

print("\n" + "=" * 60)
