import base64
import requests

print("=" * 60)
print("CREDENTIAL VERIFICATION")
print("=" * 60)

# Your credentials
subscription_key = "92e0ee9794d34ac8bb166d2cd3b99a69"
api_user = "24a14d7b-57b2-46a6-ba5c-4c17f628eb9e"
api_key = "2ac93c3f60304fdaa6f9ad2f591f0834"

print("\nFrom MTN Email:")
print(f"Subscription Key: {subscription_key}")
print(f"Username: IMS.SP")
print(f"MSISDN: 250796888309")

print("\nYour Generated:")
print(f"API User: {api_user}")
print(f"API Key: {api_key}")

# Generate Basic Auth
auth = base64.b64encode(f"{api_user}:{api_key}".encode()).decode()
print(f"\nBasic Auth: {auth}")

# Test token generation
print("\n" + "=" * 60)
print("TESTING CREDENTIALS")
print("=" * 60)

try:
    response = requests.post(
        "https://proxy.momoapi.mtn.co.rw/collection/token/",
        headers={
            "Ocp-Apim-Subscription-Key": subscription_key,
            "Authorization": f"Basic {auth}"
        },
        timeout=15
    )
    
    print(f"\nToken Request Status: {response.status_code}")
    
    if response.status_code == 200:
        print("\n[SUCCESS] All credentials are CORRECT!")
        print("Token generation works = credentials are valid")
        print("\nYour credentials are NOT the problem.")
        print("The issue is MTN's backend processing.")
    else:
        print(f"\n[FAILED] Credentials might be wrong")
        print(f"Response: {response.text}")
        
except Exception as e:
    print(f"\n[ERROR] {e}")

print("\n" + "=" * 60)
