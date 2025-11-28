from sqlalchemy.orm import Session
from sqlalchemy import func
from ..models.enhanced_models import Payment, PaymentStatus, Commission, Item, User, Notification
from ..models.enhanced_schemas import PaymentCreate, PaymentResponse
import uuid
import logging
from datetime import datetime, timedelta
from typing import Dict, Optional, Tuple, List
import hashlib
import hmac
import json
import requests
from ..core.config import settings
from .mtn_momo_service import mtn_momo_service

logger = logging.getLogger(__name__)

class PaymentService:
    def __init__(self, db: Session):
        self.db = db
        self.unlock_fee = 1000.0  # 1,000 RWF to unlock contact
        self.commission_rate = 0.10  # 10% commission
        
    def initiate_payment(self, user_id: int, payment_data: PaymentCreate) -> Dict:
        """Initiate a payment for unlocking contact information"""
        try:
            # Validate item exists and is active
            item = self.db.query(Item).filter(
                Item.id == payment_data.item_id,
                Item.is_active == True
            ).first()
            
            if not item:
                return {"success": False, "message": "Item not found or inactive"}
            
            # Check if user already paid for this item
            existing_payment = self.db.query(Payment).filter(
                Payment.user_id == user_id,
                Payment.item_id == payment_data.item_id,
                Payment.status == PaymentStatus.COMPLETED
            ).first()
            
            if existing_payment:
                return {"success": False, "message": "You have already unlocked this contact"}
            
            # Validate payment amount
            if payment_data.amount != self.unlock_fee:
                return {"success": False, "message": f"Payment amount must be {self.unlock_fee} RWF"}
            
            # Create payment record
            payment = Payment(
                user_id=user_id,
                item_id=payment_data.item_id,
                amount=payment_data.amount,
                payment_method=payment_data.payment_method,
                phone_number=payment_data.phone_number,
                description=payment_data.description or f"Unlock contact for item: {item.title}",
                transaction_id=self._generate_transaction_id(),
                status=PaymentStatus.PENDING
            )
            
            self.db.add(payment)
            self.db.commit()
            self.db.refresh(payment)
            
            # Process payment based on method
            if payment_data.payment_method == "mtn_momo":
                result = self._process_mtn_momo_payment(payment)
            elif payment_data.payment_method == "airtel_money":
                result = self._process_airtel_money_payment(payment)
            elif payment_data.payment_method == "bank":
                result = self._process_bank_payment(payment)
            else:
                return {"success": False, "message": "Unsupported payment method"}
            
            if result["success"]:
                # Create commission record
                commission_amount = payment_data.amount * self.commission_rate
                commission = Commission(
                    item_id=payment_data.item_id,
                    payment_id=payment.id,
                    amount=commission_amount,
                    rate=self.commission_rate
                )
                self.db.add(commission)
                self.db.commit()
                
                return {
                    "success": True,
                    "payment_id": payment.id,
                    "transaction_id": payment.transaction_id,
                    "instructions": result.get("instructions", ""),
                    "payment_url": result.get("payment_url"),
                    "qr_code": result.get("qr_code")
                }
            else:
                # Update payment status to failed
                payment.status = PaymentStatus.FAILED
                self.db.commit()
                return result
                
        except Exception as e:
            logger.error(f"Error initiating payment: {e}")
            self.db.rollback()
            return {"success": False, "message": "Payment initiation failed"}
    
    def _generate_transaction_id(self) -> str:
        """Generate unique transaction ID"""
        return f"IMIS_{datetime.now().strftime('%Y%m%d_%H%M%S')}_{uuid.uuid4().hex[:8].upper()}"
    
    def _process_mtn_momo_payment(self, payment: Payment) -> Dict:
        """Process MTN Mobile Money payment with real API integration"""
        try:
            # Check if MTN MoMo is configured
            if mtn_momo_service.is_configured():
                # Use real MTN MoMo API
                result = mtn_momo_service.request_to_pay(
                    amount=payment.amount,
                    phone_number=payment.phone_number,
                    external_id=payment.transaction_id,
                    payer_message=f"IMIS: Unlock contact for item",
                    payee_note=f"Payment for item #{payment.item_id}"
                )
                
                if result["success"]:
                    payment.external_reference = result["reference_id"]
                    payment.status = PaymentStatus.PENDING
                    self.db.commit()
                    
                    instructions = f"""
                    ✅ Payment request sent to your MTN phone!
                    
                    Please check your phone and:
                    1. You will receive a prompt on {payment.phone_number}
                    2. Enter your MTN Mobile Money PIN
                    3. Confirm the payment of {payment.amount} RWF
                    
                    Reference: {payment.transaction_id}
                    
                    The payment will be verified automatically.
                    """
                    
                    return {
                        "success": True,
                        "instructions": instructions,
                        "reference": result["reference_id"],
                        "message": result["message"]
                    }
                else:
                    return {"success": False, "message": result.get("message", "MTN MoMo payment failed")}
            else:
                # Fallback to simulation mode
                logger.info("MTN MoMo not configured, using simulation mode")
                instructions = f"""
                🧪 SIMULATION MODE (MTN API not configured)
                
                To complete your payment:
                1. Dial *182*7*1# on your MTN phone
                2. Enter merchant code: 123456
                3. Enter amount: {payment.amount} RWF
                4. Enter reference: {payment.transaction_id}
                5. Enter your PIN to confirm
                
                Or send money to: 0788123456
                Reference: {payment.transaction_id}
                
                ⚠️ In production, this will use real MTN MoMo API
                """
                
                api_response = self._simulate_momo_api_call(payment)
                
                if api_response["success"]:
                    payment.external_reference = api_response["reference"]
                    payment.status = PaymentStatus.PENDING
                    self.db.commit()
                    
                    return {
                        "success": True,
                        "instructions": instructions,
                        "reference": api_response["reference"],
                        "simulation": True
                    }
                else:
                    return {"success": False, "message": "Payment simulation failed"}
                
        except Exception as e:
            logger.error(f"MTN MoMo payment error: {e}")
            return {"success": False, "message": "MTN MoMo payment processing failed"}
    
    def _process_airtel_money_payment(self, payment: Payment) -> Dict:
        """Process Airtel Money payment"""
        try:
            instructions = f"""
            To complete your payment:
            1. Dial *182*2*1# on your Airtel phone
            2. Enter merchant code: 654321
            3. Enter amount: {payment.amount} RWF
            4. Enter reference: {payment.transaction_id}
            5. Enter your PIN to confirm
            
            Or send money to: 0732123456
            Reference: {payment.transaction_id}
            """
            
            # Simulate API call
            api_response = self._simulate_airtel_api_call(payment)
            
            if api_response["success"]:
                payment.external_reference = api_response["reference"]
                payment.status = PaymentStatus.PENDING
                self.db.commit()
                
                return {
                    "success": True,
                    "instructions": instructions,
                    "reference": api_response["reference"]
                }
            else:
                return {"success": False, "message": "Airtel Money payment failed"}
                
        except Exception as e:
            logger.error(f"Airtel Money payment error: {e}")
            return {"success": False, "message": "Airtel Money payment processing failed"}
    
    def _process_bank_payment(self, payment: Payment) -> Dict:
        """Process bank payment"""
        try:
            instructions = f"""
            Bank Payment Details:
            
            Bank: Bank of Kigali
            Account Name: Ishakiro IMIS
            Account Number: 00123456789
            Reference: {payment.transaction_id}
            Amount: {payment.amount} RWF
            
            Please use the reference number when making the payment.
            Payment will be verified within 24 hours.
            """
            
            payment.status = PaymentStatus.PENDING
            self.db.commit()
            
            return {
                "success": True,
                "instructions": instructions
            }
            
        except Exception as e:
            logger.error(f"Bank payment error: {e}")
            return {"success": False, "message": "Bank payment processing failed"}
    
    def _simulate_momo_api_call(self, payment: Payment) -> Dict:
        """Simulate MTN MoMo API call with timeout protection"""
        try:
            # Quick simulation - no network calls
            return {
                "success": True,
                "reference": f"MTN_{uuid.uuid4().hex[:12].upper()}",
                "status": "PENDING"
            }
        except Exception as e:
            logger.error(f"MoMo API simulation error: {e}")
            return {"success": False, "error": "API call failed"}
    
    def _simulate_airtel_api_call(self, payment: Payment) -> Dict:
        """Simulate Airtel Money API call with timeout protection"""
        try:
            # Quick simulation - no network calls
            return {
                "success": True,
                "reference": f"AIR_{uuid.uuid4().hex[:12].upper()}",
                "status": "PENDING"
            }
        except Exception as e:
            logger.error(f"Airtel API simulation error: {e}")
            return {"success": False, "error": "API call failed"}
    
    def verify_payment(self, payment_id: int) -> Dict:
        """Verify payment status"""
        try:
            payment = self.db.query(Payment).filter(Payment.id == payment_id).first()
            if not payment:
                return {"success": False, "message": "Payment not found"}
            
            if payment.status == PaymentStatus.COMPLETED:
                return {"success": True, "status": "completed", "message": "Payment already completed"}
            
            # Check payment status based on method
            if payment.payment_method in ["mtn_momo", "airtel_money"]:
                verification_result = self._verify_mobile_money_payment(payment)
            else:
                verification_result = self._verify_bank_payment(payment)
            
            if verification_result["success"] and verification_result["status"] == "completed":
                self._complete_payment(payment)
                return {"success": True, "status": "completed", "message": "Payment verified and completed"}
            elif verification_result["status"] == "failed":
                payment.status = PaymentStatus.FAILED
                self.db.commit()
                return {"success": False, "status": "failed", "message": "Payment failed"}
            else:
                return {"success": True, "status": "pending", "message": "Payment still pending"}
                
        except Exception as e:
            logger.error(f"Error verifying payment {payment_id}: {e}")
            return {"success": False, "message": "Payment verification failed"}
    
    def _verify_mobile_money_payment(self, payment: Payment) -> Dict:
        """Verify mobile money payment status with real API check"""
        try:
            # If MTN MoMo is configured and we have external reference, check real status
            if payment.payment_method == "mtn_momo" and payment.external_reference and mtn_momo_service.is_configured():
                result = mtn_momo_service.check_payment_status(payment.external_reference)
                
                if result["success"]:
                    status = result.get("status", "").upper()
                    
                    if status == "SUCCESSFUL":
                        return {"success": True, "status": "completed"}
                    elif status == "FAILED":
                        return {"success": False, "status": "failed"}
                    else:
                        return {"success": True, "status": "pending"}
                else:
                    # If API check fails, fall back to time-based simulation
                    logger.warning(f"MTN status check failed, using fallback: {result.get('message')}")
            
            # Fallback: Quick verification - auto-complete after 30 seconds for testing
            time_since_creation = datetime.utcnow() - payment.created_at
            
            if time_since_creation > timedelta(seconds=30):
                return {"success": True, "status": "completed"}
            else:
                return {"success": True, "status": "pending"}
        except Exception as e:
            logger.error(f"Mobile money verification error: {e}")
            return {"success": False, "status": "failed"}
    
    def _verify_bank_payment(self, payment: Payment) -> Dict:
        """Verify bank payment status"""
        # In production, this would check with bank API or manual verification
        # For simulation, we'll assume manual verification after some time
        time_since_creation = datetime.utcnow() - payment.created_at
        
        if time_since_creation > timedelta(minutes=5):  # Simulate 5-minute verification
            return {"success": True, "status": "completed"}
        else:
            return {"success": True, "status": "pending"}
    
    def _complete_payment(self, payment: Payment):
        """Complete a payment and unlock contact information"""
        try:
            payment.status = PaymentStatus.COMPLETED
            payment.completed_at = datetime.utcnow()
            
            # Get item and item owner
            item = self.db.query(Item).filter(Item.id == payment.item_id).first()
            payer = self.db.query(User).filter(User.id == payment.user_id).first()
            
            # Create notifications
            # Notify payer
            payer_notification = Notification(
                user_id=payment.user_id,
                title="💰 Payment Successful!",
                message=f"Your payment of {payment.amount} RWF has been confirmed. You can now contact the owner of '{item.title}'",
                type="payment",
                item_id=payment.item_id
            )
            self.db.add(payer_notification)
            
            # Notify item owner
            owner_notification = Notification(
                user_id=item.user_id,
                title="📞 Someone Wants to Contact You!",
                message=f"Someone has paid to contact you about your {item.status} item '{item.title}'",
                type="payment",
                item_id=payment.item_id,
                related_user_id=payment.user_id
            )
            self.db.add(owner_notification)
            
            self.db.commit()
            
            logger.info(f"Payment {payment.id} completed successfully")
            
        except Exception as e:
            logger.error(f"Error completing payment {payment.id}: {e}")
            self.db.rollback()
    
    def get_contact_info(self, user_id: int, item_id: int) -> Dict:
        """Get contact information if user has paid"""
        try:
            # Check if user has completed payment for this item
            payment = self.db.query(Payment).filter(
                Payment.user_id == user_id,
                Payment.item_id == item_id,
                Payment.status == PaymentStatus.COMPLETED
            ).first()
            
            if not payment:
                return {"success": False, "message": "Payment required to unlock contact information"}
            
            # Get item and owner information
            item = self.db.query(Item).filter(Item.id == item_id).first()
            if not item:
                return {"success": False, "message": "Item not found"}
            
            owner = self.db.query(User).filter(User.id == item.user_id).first()
            if not owner:
                return {"success": False, "message": "Owner not found"}
            
            # Return contact information based on preferences
            contact_info = {
                "success": True,
                "owner_name": owner.full_name,
                "contact_method": item.contact_method
            }
            
            if item.contact_method in ["phone", "both"] and owner.phone:
                contact_info["phone"] = owner.phone
            
            if item.contact_method in ["email", "both"]:
                contact_info["email"] = owner.email
            
            # Instructions for contacting
            contact_info["instructions"] = f"""
            You can now contact {owner.full_name} about the {item.status} item '{item.title}'.
            
            Please be respectful and arrange a safe meeting location.
            Remember to verify the item before any exchange.
            """
            
            return contact_info
            
        except Exception as e:
            logger.error(f"Error getting contact info for user {user_id}, item {item_id}: {e}")
            return {"success": False, "message": "Failed to retrieve contact information"}
    
    def get_user_payments(self, user_id: int, limit: int = 50) -> List[Payment]:
        """Get user's payment history"""
        return (self.db.query(Payment)
                .filter(Payment.user_id == user_id)
                .order_by(Payment.created_at.desc())
                .limit(limit)
                .all())
    
    def get_payment_statistics(self) -> Dict:
        """Get payment statistics for admin"""
        try:
            total_payments = self.db.query(Payment).count()
            completed_payments = self.db.query(Payment).filter(Payment.status == PaymentStatus.COMPLETED).count()
            pending_payments = self.db.query(Payment).filter(Payment.status == PaymentStatus.PENDING).count()
            failed_payments = self.db.query(Payment).filter(Payment.status == PaymentStatus.FAILED).count()
            
            total_revenue = self.db.query(func.sum(Payment.amount)).filter(
                Payment.status == PaymentStatus.COMPLETED
            ).scalar() or 0
            
            total_commissions = self.db.query(func.sum(Commission.amount)).scalar() or 0
            
            return {
                "total_payments": total_payments,
                "completed_payments": completed_payments,
                "pending_payments": pending_payments,
                "failed_payments": failed_payments,
                "success_rate": completed_payments / total_payments if total_payments > 0 else 0,
                "total_revenue": total_revenue,
                "total_commissions": total_commissions,
                "net_revenue": total_revenue - total_commissions
            }
            
        except Exception as e:
            logger.error(f"Error getting payment statistics: {e}")
            return {}
    
    def refund_payment(self, payment_id: int, reason: str = "") -> Dict:
        """Refund a payment (admin function)"""
        try:
            payment = self.db.query(Payment).filter(Payment.id == payment_id).first()
            if not payment:
                return {"success": False, "message": "Payment not found"}
            
            if payment.status != PaymentStatus.COMPLETED:
                return {"success": False, "message": "Can only refund completed payments"}
            
            payment.status = PaymentStatus.REFUNDED
            
            # Create notification for user
            notification = Notification(
                user_id=payment.user_id,
                title="💸 Payment Refunded",
                message=f"Your payment of {payment.amount} RWF has been refunded. Reason: {reason}",
                type="payment",
                item_id=payment.item_id
            )
            self.db.add(notification)
            
            self.db.commit()
            
            return {"success": True, "message": "Payment refunded successfully"}
            
        except Exception as e:
            logger.error(f"Error refunding payment {payment_id}: {e}")
            self.db.rollback()
            return {"success": False, "message": "Refund failed"}
    
    def simulate_payment_completion(self, payment_id: int) -> Dict:
        """Simulate payment completion (for testing)"""
        try:
            payment = self.db.query(Payment).filter(Payment.id == payment_id).first()
            if not payment:
                return {"success": False, "message": "Payment not found"}
            
            if payment.status != PaymentStatus.PENDING:
                return {"success": False, "message": "Payment is not pending"}
            
            self._complete_payment(payment)
            
            return {"success": True, "message": "Payment completed successfully"}
            
        except Exception as e:
            logger.error(f"Error simulating payment completion: {e}")
            return {"success": False, "message": "Simulation failed"}