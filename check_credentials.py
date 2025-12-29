"""Check what credentials format works"""
import requests
import base64

subscription_key = "92e0ee9794d34ac8bb166d2cd3b99a69"
api_key = "2ac93c3f60304fdaa6f9ad2f591f0834"
base_url = "https://proxy.momoapi.mtn.co.rw"

print("Testing Different API User Formats")
print("=" * 60)

# Test 1: With IMS.SP
print("\n[TEST 1] Using: IMS.SP")
print("-" * 60)
auth1 = base64.b64encode(f"IMS.SP:{api_key}".encode()).decode()
headers1 = {
    "Ocp-Apim-Subscription-Key": subscription_key,
    "Authorization": f"Basic {auth1}"
}
try:
    r1 = requests.post(f"{base_url}/collection/token/", headers=headers1, timeout=10)
    print(f"Status: {r1.status_code}")
    print(f"Response: {r1.text[:200]}")
except Exception as e:
    print(f"Error: {e}")

# Test 2: With the old UUID (that worked before)
print("\n[TEST 2] Using: 24a14d7b-57b2-46a6-ba5c-4c17f628eb9e")
print("-" * 60)
auth2 = base64.b64encode(f"24a14d7b-57b2-46a6-ba5c-4c17f628eb9e:{api_key}".encode()).decode()
headers2 = {
    "Ocp-Apim-Subscription-Key": subscription_key,
    "Authorization": f"Basic {auth2}"
}
try:
    r2 = requests.post(f"{base_url}/collection/token/", headers=headers2, timeout=10)
    print(f"Status: {r2.status_code}")
    print(f"Response: {r2.text[:200]}")
    if r2.status_code == 200:
        print("\n[SUCCESS] This UUID works!")
except Exception as e:
    print(f"Error: {e}")

print("\n" + "=" * 60)
print("\nQUESTION: When you generated the API key, what was the")
print("X-Reference-Id (UUID) you used? That's your API User!")
print("=" * 60)
