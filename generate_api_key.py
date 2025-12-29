"""Generate API Key for IMS.SP user"""
import requests
import uuid

print("=" * 60)
print("Generate API Key for MTN User: IMS.SP")
print("=" * 60)

subscription_key = "92e0ee9794d34ac8bb166d2cd3b99a69"
api_user = "IMS.SP"
base_url = "https://proxy.momoapi.mtn.co.rw"

# Step 1: Create API User (if not exists)
print("\n[STEP 1] Creating/Verifying API User...")
print("-" * 60)

user_reference_id = str(uuid.uuid4())
print(f"User Reference ID: {user_reference_id}")

create_user_headers = {
    "X-Reference-Id": user_reference_id,
    "Ocp-Apim-Subscription-Key": subscription_key,
    "Content-Type": "application/json"
}

create_user_body = {
    "providerCallbackHost": "www.IMIS.sp"
}

try:
    # Try to create user
    response = requests.post(
        f"{base_url}/v1_0/apiuser",
        headers=create_user_headers,
        json=create_user_body,
        timeout=15
    )
    
    print(f"Status: {response.status_code}")
    print(f"Response: {response.text}")
    
    if response.status_code in [201, 409]:  # 201 = created, 409 = already exists
        print("[OK] API User ready")
    else:
        print("[INFO] User might already exist or different error")
        
except Exception as e:
    print(f"[ERROR] {e}")

# Step 2: Generate API Key
print("\n[STEP 2] Generating API Key...")
print("-" * 60)

api_key_headers = {
    "Ocp-Apim-Subscription-Key": subscription_key
}

try:
    response = requests.post(
        f"{base_url}/v1_0/apiuser/{user_reference_id}/apikey",
        headers=api_key_headers,
        timeout=15
    )
    
    print(f"Status: {response.status_code}")
    print(f"Response: {response.text}")
    
    if response.status_code == 201:
        api_key_data = response.json()
        api_key = api_key_data.get("apiKey")
        print(f"\n[SUCCESS] API Key Generated!")
        print(f"API Key: {api_key}")
        print(f"\nUpdate your .env file:")
        print(f"MTN_MOMO_API_USER={user_reference_id}")
        print(f"MTN_MOMO_API_KEY={api_key}")
    else:
        print("[FAILED] Could not generate API key")
        
except Exception as e:
    print(f"[ERROR] {e}")

print("\n" + "=" * 60)
print("\nNOTE: If this doesn't work, you need to:")
print("1. Contact MTN support")
print("2. Ask them to provide the API key for username: IMS.SP")
print("3. Or ask them how to generate it for production")
print("=" * 60)
