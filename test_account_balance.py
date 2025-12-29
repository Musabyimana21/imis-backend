"""Test if account balance works - proves account is active"""
import requests
import base64

subscription_key = "92e0ee9794d34ac8bb166d2cd3b99a69"
api_user = "24a14d7b-57b2-46a6-ba5c-4c17f628eb9e"
api_key = "2ac93c3f60304fdaa6f9ad2f591f0834"
base_url = "https://proxy.momoapi.mtn.co.rw"

print("Testing MTN Account Status")
print("=" * 60)

# Get token
auth = base64.b64encode(f"{api_user}:{api_key}".encode()).decode()
token_resp = requests.post(
    f"{base_url}/collection/token/",
    headers={
        "Ocp-Apim-Subscription-Key": subscription_key,
        "Authorization": f"Basic {auth}"
    },
    timeout=15
)

if token_resp.status_code == 200:
    token = token_resp.json()["access_token"]
    print("[OK] Token obtained")
    
    # Check account balance
    print("\n[TEST] Checking Account Balance...")
    balance_resp = requests.get(
        f"{base_url}/collection/v1_0/account/balance",
        headers={
            "X-Target-Environment": "mtnrwanda",
            "Ocp-Apim-Subscription-Key": subscription_key,
            "Authorization": f"Bearer {token}"
        },
        timeout=15
    )
    
    print(f"Status: {balance_resp.status_code}")
    print(f"Response: {balance_resp.text}")
    
    if balance_resp.status_code == 200:
        print("\n[SUCCESS] Account is active and configured!")
        print("The issue is with requesttopay, not your account.")
    else:
        print("\n[FAILED] Account not properly configured")
        print("This proves the merchant account needs activation")
else:
    print("[FAILED] Cannot get token")

print("\n" + "=" * 60)
