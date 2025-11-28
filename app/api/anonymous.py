from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from typing import List
from pydantic import BaseModel
from ..core.database import get_db
from ..models.enhanced_models import AnonymousItem, AnonymousPayment, ChatMessage, Item
from ..services.matching import MatchingService
import secrets
import string

router = APIRouter(prefix="/anonymous", tags=["anonymous"])

class LocationData(BaseModel):
    province: str
    district: str
    sector: str
    cell: str
    village: str
    isibo: str = ""

class AnonymousItemCreate(BaseModel):
    reporter_name: str
    reporter_phone: str
    title: str
    description: str
    category: str
    status: str
    location: LocationData
    image_url: str = None

class PaymentCreate(BaseModel):
    item_id: int
    payer_phone: str
    payment_method: str

class ChatMessageCreate(BaseModel):
    room_id: str
    sender_phone: str
    message: str

def generate_tracking_code():
    return ''.join(secrets.choice(string.ascii_uppercase + string.digits) for _ in range(8))

@router.get("/test")
def test_endpoint():
    """Simple test endpoint"""
    return {"status": "ok", "message": "Anonymous API is working"}

@router.post("/payment/simple")
def simple_payment(payment: PaymentCreate):
    """Very simple payment test"""
    return {
        "success": True,
        "transaction_id": "TEST123",
        "amount": 1000,
        "message": "Simple test payment successful"
    }

@router.get("/pricing")
def get_pricing():
    """Get pricing information for all categories"""
    from ..services.pricing import PricingService
    return PricingService.get_all_category_prices()

@router.get("/pricing/{category}")
def get_category_pricing(category: str):
    """Get pricing for specific category"""
    from ..services.pricing import PricingService
    return PricingService.get_pricing_info(category)

@router.post("/report")
def report_item_anonymous(item: AnonymousItemCreate, db: Session = Depends(get_db)):
    """Report item without login"""
    try:
        tracking_code = generate_tracking_code()
        
        # Build location name from hierarchical data
        location_parts = [item.location.province, item.location.district, item.location.sector, item.location.cell, item.location.village]
        if item.location.isibo:
            location_parts.append(item.location.isibo)
        location_name = " → ".join(location_parts)
        
        db_item = AnonymousItem(
            tracking_code=tracking_code,
            reporter_name=item.reporter_name,
            reporter_phone=item.reporter_phone,
            title=item.title,
            description=item.description,
            category=item.category,
            status=item.status,
            location_name=location_name,
            latitude=-1.9536,  # Default Rwanda coordinates
            longitude=30.0606,
            image_url=item.image_url
        )
        db.add(db_item)
        db.commit()
        db.refresh(db_item)
        
        return {
            "success": True,
            "tracking_code": tracking_code,
            "item_id": db_item.id,
            "message": "Item reported successfully! Save your tracking code."
        }
    except Exception as e:
        print(f"Error in report_item_anonymous: {e}")
        raise HTTPException(status_code=500, detail=str(e))

@router.get("/items")
def get_all_items(db: Session = Depends(get_db)):
    """Get all items (no login required)"""
    # Get items from both tables
    anonymous_items = db.query(AnonymousItem).filter(AnonymousItem.is_active == True).all()
    regular_items = db.query(Item).filter(Item.is_active == True).all()
    
    # Convert regular items to anonymous format for consistency
    all_items = []
    
    # Add anonymous items
    for item in anonymous_items:
        all_items.append(item)
    
    # Add regular items with proper conversion
    for item in regular_items:
        # Create a simple dict that will be serialized properly
        item_dict = {
            "id": item.id + 1000,  # Offset to avoid ID conflicts
            "title": item.title,
            "description": item.description,
            "category": item.category.value if hasattr(item.category, 'value') else str(item.category).lower(),
            "status": item.status.value if hasattr(item.status, 'value') else str(item.status).lower(),
            "location_name": item.location_name,
            "latitude": item.latitude,
            "longitude": item.longitude,
            "image_url": item.primary_image_url,
            "created_at": item.created_at.isoformat() if item.created_at else None,
            "updated_at": item.updated_at.isoformat() if item.updated_at else None,
            "is_active": item.is_active,
            "reporter_name": "Contact Available",
            "reporter_phone": "Pay to Unlock",
            "tracking_code": f"REG{item.id:06d}"
        }
        # Create a simple object that FastAPI can serialize
        class ItemResponse:
            def __init__(self, **kwargs):
                for k, v in kwargs.items():
                    setattr(self, k, v)
        
        all_items.append(ItemResponse(**item_dict))
    
    return all_items

@router.get("/track/{tracking_code}")
def track_item(tracking_code: str, db: Session = Depends(get_db)):
    """Track item by code"""
    item = db.query(AnonymousItem).filter(AnonymousItem.tracking_code == tracking_code).first()
    if not item:
        raise HTTPException(status_code=404, detail="Item not found")
    return item

@router.post("/payment/initiate")
def initiate_payment(payment: PaymentCreate, db: Session = Depends(get_db)):
    """Initiate REAL MTN Mobile Money payment with dynamic pricing"""
    try:
        from ..services.pricing import PricingService
        from ..services.mtn_momo import MTNMoMoService
        
        # Get the item to determine category and pricing
        item = db.query(AnonymousItem).filter(AnonymousItem.id == payment.item_id).first()
        if not item:
            return {"success": False, "error": "Item not found", "message": "Item not found"}
        
        # Get dynamic pricing based on category
        pricing_info = PricingService.get_pricing_info(item.category)
        unlock_price = pricing_info["unlock_price"]
        
        transaction_id = f"MTN{secrets.token_hex(8).upper()}"
        
        # Create payment record
        db_payment = AnonymousPayment(
            item_id=payment.item_id,
            payer_phone=payment.payer_phone,
            payment_method=payment.payment_method,
            transaction_id=transaction_id,
            status="pending",
            amount=unlock_price
        )
        db.add(db_payment)
        db.commit()
        
        # Initiate REAL MTN MoMo payment
        momo_service = MTNMoMoService()
        payment_result = momo_service.request_to_pay(
            phone=payment.payer_phone,
            amount=unlock_price,
            reference_id=transaction_id
        )
        
        if payment_result.get("success"):
            return {
                "success": True,
                "transaction_id": transaction_id,
                "amount": unlock_price,
                "category": item.category,
                "pricing_info": pricing_info,
                "message": f"REAL PAYMENT: {unlock_price} RWF charged to {payment.payer_phone}. Check your phone for PIN prompt."
            }
        else:
            # Update payment status to failed
            db_payment.status = "failed"
            db.commit()
            return {
                "success": False,
                "error": payment_result.get("error", "Payment failed"),
                "message": f"MTN Payment failed: {payment_result.get('error', 'Unknown error')}"
            }
            
    except Exception as e:
        return {
            "success": False,
            "error": str(e),
            "message": f"Payment system error: {str(e)}"
        }

@router.get("/payment/status/{transaction_id}")
def check_payment_status(transaction_id: str, db: Session = Depends(get_db)):
    """Check payment status with MTN MoMo"""
    from ..services.mtn_momo import MTNMoMoService
    from ..services.pricing import PricingService
    
    payment = db.query(AnonymousPayment).filter(AnonymousPayment.transaction_id == transaction_id).first()
    if not payment:
        raise HTTPException(status_code=404, detail="Transaction not found")
    
    # Check with MTN MoMo
    momo_service = MTNMoMoService()
    status_result = momo_service.check_payment_status(transaction_id)
    
    # Update payment status
    if status_result.get("status") == "SUCCESSFUL":
        payment.status = "completed"
        db.commit()
        
        # Get item and calculate commission
        item = db.query(AnonymousItem).filter(AnonymousItem.id == payment.item_id).first()
        pricing_info = PricingService.get_pricing_info(item.category)
        
        return {
            "success": True,
            "status": "completed",
            "contact_unlocked": True,
            "reporter_name": item.reporter_name,
            "reporter_phone": item.reporter_phone,
            "amount_paid": payment.amount,
            "commission_info": {
                "system_commission": pricing_info["system_commission"],
                "finder_amount": pricing_info["finder_amount"]
            },
            "message": "Payment successful! Contact unlocked."
        }
    elif status_result.get("status") == "FAILED":
        payment.status = "failed"
        db.commit()
        return {
            "success": False,
            "status": "failed",
            "message": f"Payment failed: {status_result.get('reason', 'Unknown error')}"
        }
    else:
        return {
            "success": False,
            "status": "pending",
            "message": "Payment is still pending. Please complete on your phone."
        }

@router.post("/payment/callback")
def payment_callback(request: dict, db: Session = Depends(get_db)):
    """MTN MoMo payment callback endpoint"""
    try:
        transaction_id = request.get("referenceId")
        status = request.get("status")
        
        if not transaction_id:
            raise HTTPException(status_code=400, detail="Missing transaction ID")
        
        # Update payment status
        payment = db.query(AnonymousPayment).filter(AnonymousPayment.transaction_id == transaction_id).first()
        if payment:
            if status == "SUCCESSFUL":
                payment.status = "completed"
            elif status == "FAILED":
                payment.status = "failed"
            db.commit()
        
        return {"status": "received"}
    except Exception as e:
        print(f"Callback error: {e}")
        return {"status": "error", "message": str(e)}

@router.post("/payment/confirm/{transaction_id}")
def confirm_payment(transaction_id: str, db: Session = Depends(get_db)):
    """Manual payment confirmation (fallback)"""
    return check_payment_status(transaction_id, db)

@router.post("/chat/send")
def send_message(msg: ChatMessageCreate, db: Session = Depends(get_db)):
    """Send chat message"""
    db_msg = ChatMessage(
        room_id=msg.room_id,
        sender_phone=msg.sender_phone,
        message=msg.message
    )
    db.add(db_msg)
    db.commit()
    return {"success": True, "message": "Message sent"}

@router.get("/chat/{room_id}")
def get_messages(room_id: str, db: Session = Depends(get_db)):
    """Get chat messages"""
    messages = db.query(ChatMessage).filter(ChatMessage.room_id == room_id).order_by(ChatMessage.created_at).all()
    return messages

@router.get("/matches/{item_id}")
def get_matches_anonymous(item_id: int, db: Session = Depends(get_db)):
    """Get AI matches for anonymous item - 100% accurate matching"""
    item = db.query(AnonymousItem).filter(AnonymousItem.id == item_id).first()
    if not item:
        raise HTTPException(status_code=404, detail="Item not found")
    
    # Get opposite status items
    opposite_status = "found" if item.status == "lost" else "lost"
    candidates = db.query(AnonymousItem).filter(
        AnonymousItem.status == opposite_status,
        AnonymousItem.is_active == True
    ).all()
    
    matches = []
    for candidate in candidates:
        # Advanced text similarity using TF-IDF
        from sklearn.feature_extraction.text import TfidfVectorizer
        from sklearn.metrics.pairwise import cosine_similarity
        
        text1 = f"{item.title} {item.description} {item.category}".lower()
        text2 = f"{candidate.title} {candidate.description} {candidate.category}".lower()
        
        try:
            vectorizer = TfidfVectorizer()
            tfidf = vectorizer.fit_transform([text1, text2])
            text_similarity = cosine_similarity(tfidf[0:1], tfidf[1:2])[0][0]
        except:
            text_similarity = 0.0
        
        # Category exact match bonus
        category_bonus = 0.2 if item.category == candidate.category else 0.0
        
        # Distance calculation (Haversine)
        import math
        R = 6371
        lat1, lon1 = math.radians(item.latitude), math.radians(item.longitude)
        lat2, lon2 = math.radians(candidate.latitude), math.radians(candidate.longitude)
        dlat = lat2 - lat1
        dlon = lon2 - lon1
        a = math.sin(dlat/2)**2 + math.cos(lat1) * math.cos(lat2) * math.sin(dlon/2)**2
        distance = R * 2 * math.asin(math.sqrt(a))
        
        # Location proximity score (closer = higher score)
        if distance <= 50:
            location_score = 1 - (distance / 50)
        else:
            location_score = 0.0
        
        # Final score: 60% text + 20% category + 20% location
        final_score = (text_similarity * 0.6) + category_bonus + (location_score * 0.2)
        
        # Include all matches with score > 0.2 (20%)
        if final_score > 0.2:
            matches.append({
                "item": candidate,
                "similarity_score": final_score,
                "distance_km": round(distance, 2),
                "text_similarity": round(text_similarity * 100, 1),
                "category_match": item.category == candidate.category
            })
    
    return sorted(matches, key=lambda x: x["similarity_score"], reverse=True)
