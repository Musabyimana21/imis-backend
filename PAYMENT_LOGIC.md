# 💰 ISHAKIRO Payment Logic

## ✅ Correct Payment Flow

### WHO PAYS?
**ONLY the person who LOST the item pays!**

### WHO DOESN'T PAY?
**The person who FOUND the item posts for FREE!**

---

## 📋 Step-by-Step Logic

### Scenario 1: You LOST Something (e.g., Phone)

1. **Report Lost Item** (FREE)
   - Go to homepage
   - Click "I Lost Something"
   - Fill form: Title, Description, Location
   - Submit → Get tracking code
   - ✅ No payment required!

2. **Browse Found Items** (FREE)
   - AI automatically shows matching found items
   - See similarity scores and distances
   - Click on any found item to view details
   - ✅ No payment required!

3. **View Found Item Details** (FREE)
   - See item description, location, photos
   - See reporter name (e.g., "Marie Uwase")
   - Contact info is HIDDEN 🔒
   - ✅ No payment required!

4. **Unlock Contact** (💰 1,000 RWF)
   - Click "Pay 1,000 RWF to Unlock Contact"
   - Choose payment method (MTN/Airtel)
   - Enter your phone number
   - Confirm payment
   - ✅ Contact unlocked! Get finder's phone number

5. **Call Finder**
   - Call the finder directly
   - Verify item ownership
   - Arrange safe meetup location
   - Pick up your item!

---

### Scenario 2: You FOUND Something (e.g., Phone)

1. **Report Found Item** (FREE)
   - Go to homepage
   - Click "I Found Something"
   - Fill form: Title, Description, Location
   - Submit → Get tracking code
   - ✅ No payment required!

2. **Your Item is Now Visible** (FREE)
   - Your found item appears on homepage
   - Anyone can see it
   - Your contact info is visible to everyone
   - ✅ No payment required!

3. **Wait for Owner to Contact You** (FREE)
   - Owner will see your item
   - Owner will pay to unlock your contact
   - Owner will call you
   - ✅ No payment required!

4. **Arrange Return**
   - Answer owner's call
   - Verify ownership (ask security questions)
   - Agree on safe meetup location
   - Return item to owner
   - ✅ No payment required!

---

## 🎯 Key Rules

### Rule 1: Finders Post for FREE
```
✅ Found item reporter = NO PAYMENT
✅ Contact info visible to everyone
✅ Just wait for owner to call
```

### Rule 2: Losers Pay to Unlock
```
💰 Lost item owner = PAY 1,000 RWF
💰 Only when viewing FOUND items
💰 Payment unlocks finder's contact
```

### Rule 3: Item Type Determines Payment
```
Item Status = "FOUND" → Contact visible for FREE
Item Status = "LOST" → Contact requires payment
```

---

## 💡 Why This Logic?

### Fair System
- **Finders are heroes** → They should NOT pay
- **Losers need help** → They pay small fee (1,000 RWF)
- **Prevents spam** → Payment filters serious requests

### Encourages Reporting
- Finders post for FREE → More found items reported
- Simple process → No barriers to helping others
- Direct contact → Fast reunification

---

## 🔍 Visual Flow

```
┌─────────────────────────────────────────────────────────────┐
│                    FOUND ITEM (FREE)                        │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  1. Marie finds phone → Reports for FREE                    │
│  2. System shows Marie's contact to everyone                │
│  3. Marie waits for owner to call                           │
│  4. No payment required! ✅                                  │
│                                                             │
└─────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────┐
│                    LOST ITEM (PAY 1,000 RWF)                │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  1. Jean lost phone → Reports for FREE                      │
│  2. Jean sees Marie's found item (match!)                   │
│  3. Jean clicks "Pay 1,000 RWF to Unlock Contact"          │
│  4. Jean pays via MTN/Airtel                                │
│  5. Jean gets Marie's phone number                          │
│  6. Jean calls Marie to arrange pickup                      │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

---

## 🧪 Test Scenarios

### Test 1: Found Item (No Payment)
```bash
1. Go to http://localhost:5173
2. Click "I Found Something"
3. Fill form:
   - Title: "Black iPhone 13"
   - Description: "Found at Kigali Market"
   - Location: "Kigali City Market"
4. Submit
5. View your item → Contact visible ✅
6. No payment required! ✅
```

### Test 2: Lost Item (Payment Required)
```bash
1. Go to http://localhost:5173
2. Click "I Lost Something"
3. Fill form:
   - Title: "Black iPhone 13"
   - Description: "Lost at Kigali Market"
   - Location: "Kigali City Market"
4. Submit
5. Browse found items
6. Click on matching found item
7. See "Pay 1,000 RWF to Unlock Contact" button
8. Click button → Enter phone → Pay
9. Get finder's contact! ✅
```

---

## ✅ Implementation Checklist

- [x] Found items show contact for FREE
- [x] Lost items require payment to unlock contact
- [x] Payment button only shows for lost item owners
- [x] Mobile Money integration (MTN/Airtel)
- [x] Contact unlocked after payment
- [x] Clear messaging about who pays
- [x] No payment required for finders

---

**Made with ❤️ for Rwanda | Ishakiro - Fair & Simple** 🇷🇼
