from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
import uvicorn

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=False,
    allow_methods=["*"],
    allow_headers=["*"],
)

class LocationData(BaseModel):
    province: str
    district: str
    sector: str
    cell: str
    village: str
    isibo: str = ""

class ItemCreate(BaseModel):
    reporter_name: str
    reporter_phone: str
    title: str
    description: str
    category: str
    status: str
    location: LocationData
    image_url: str = None

@app.get("/")
def root():
    return {"message": "WORKING API"}

@app.get("/health")
def health():
    return {"status": "healthy"}

@app.post("/api/anonymous/report")
def report_item(item: ItemCreate):
    return {
        "success": True,
        "tracking_code": "ABC123",
        "item_id": 999,
        "message": "SUCCESS! Item reported!"
    }

@app.get("/api/items/{item_id}")
def get_item(item_id: int):
    return {
        "id": item_id,
        "title": f"Lost Item #{item_id}",
        "description": "Black iPhone lost at market",
        "category": "phone",
        "status": "lost",
        "location_name": "Kigali → Gasabo → Kacyiru",
        "latitude": -1.9536,
        "longitude": 30.0606,
        "brand": "Apple",
        "model": "iPhone 13",
        "color": "Black",
        "size": "Medium",
        "distinctive_features": "Cracked screen",
        "primary_image_url": "",
        "image_urls": [],
        "date_lost_found": "2025-11-25T13:00:00",
        "created_at": "2025-11-25T13:00:00",
        "is_active": True,
        "is_featured": False,
        "is_urgent": False,
        "reward_amount": 50000,
        "reward_currency": "RWF",
        "contact_method": "both",
        "allow_public_contact": False,
        "view_count": 10,
        "match_count": 2,
        "message_count": 1,
        "user": {
            "id": 1,
            "full_name": "Test User",
            "avatar_url": None,
            "bio": None,
            "location": "Kigali",
            "items_found": 0,
            "items_recovered": 0,
            "reputation_score": 5.0
        }
    }

@app.get("/api/anonymous/items")
def get_all_items():
    return [
        {
            "id": 1,
            "title": "Lost iPhone 13",
            "description": "Black iPhone lost at market",
            "category": "phone",
            "status": "lost",
            "location_name": "Kigali → Gasabo → Kacyiru",
            "reporter_name": "John Doe",
            "reporter_phone": "+250788123456",
            "tracking_code": "ABC123",
            "created_at": "2025-11-25T13:00:00",
            "image_url": ""
        },
        {
            "id": 8,
            "title": "Found Wallet",
            "description": "Brown leather wallet found near bus station",
            "category": "wallet",
            "status": "found",
            "location_name": "Kigali → Nyarugenge → Nyamirambo",
            "reporter_name": "Jane Smith",
            "reporter_phone": "+250788654321",
            "tracking_code": "XYZ789",
            "created_at": "2025-11-25T14:00:00",
            "image_url": ""
        },
        {
            "id": 999,
            "title": "Test Lost Phone",
            "description": "Black iPhone lost at market",
            "category": "phone",
            "status": "lost",
            "location_name": "Kigali → Gasabo → Kacyiru",
            "reporter_name": "Test User",
            "reporter_phone": "+250788123456",
            "tracking_code": "ABC123",
            "created_at": "2025-11-25T13:00:00",
            "image_url": ""
        }
    ]

if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=9002)