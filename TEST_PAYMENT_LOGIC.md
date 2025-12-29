# 🧪 Test Payment Logic - Quick Guide

## ✅ What Was Fixed

### Before (WRONG):
- ❌ Everyone had to pay to see contact info
- ❌ Finders had to pay (unfair!)
- ❌ Confusing payment flow

### After (CORRECT):
- ✅ Finders post for FREE, contact visible to everyone
- ✅ Only lost item owners pay to unlock contact
- ✅ Clear and fair payment flow

---

## 🚀 Quick Test (5 Minutes)

### Test 1: Report Found Item (FREE)

1. **Open Browser**
   ```
   http://localhost:5173
   ```

2. **Click "I Found Something"**

3. **Fill Form**
   ```
   Title: Black iPhone 13 Pro
   Description: Found at Kigali City Market, has blue case
   Category: Phone
   Location: Kigali City Market
   Reporter Name: Marie Uwase
   Reporter Phone: +250 788 123 456
   ```

4. **Submit**
   - You get tracking code
   - Item appears on homepage
   - ✅ No payment required!

5. **View Your Item**
   - Click on your found item
   - See your contact info displayed
   - ✅ Contact visible for FREE!

---

### Test 2: Report Lost Item (PAY 1,000 RWF)

1. **Open New Tab**
   ```
   http://localhost:5173
   ```

2. **Click "I Lost Something"**

3. **Fill Form**
   ```
   Title: Black iPhone 13
   Description: Lost at Kigali Market, blue case
   Category: Phone
   Location: Kigali City Market
   Reporter Name: Jean Mugabo
   Reporter Phone: +250 788 999 888
   ```

4. **Submit**
   - You get tracking code
   - Item appears on homepage
   - ✅ No payment required!

5. **Browse Found Items**
   - Go back to homepage
   - Click on Marie's found item (from Test 1)
   - See item details
   - ❌ Contact info is HIDDEN

6. **Unlock Contact**
   - Click "Pay 1,000 RWF to Unlock Contact"
   - Choose payment method: MTN Mobile Money
   - Enter phone: +250 788 999 888
   - Click "Pay 1,000 RWF"
   - Wait 2 seconds (simulated payment)
   - ✅ Contact unlocked!
   - ✅ See Marie's phone number: +250 788 123 456

7. **Call Finder**
   - Call Marie at +250 788 123 456
   - Arrange pickup
   - Done!

---

## 🎯 Expected Results

### For FOUND Items:
```
✅ Contact info visible immediately
✅ No payment button shown
✅ Green box with contact details
✅ Message: "📞 Call the finder to arrange pickup!"
```

### For LOST Items:
```
❌ Contact info hidden
✅ Payment button shown
✅ Message: "Only the person who lost the item pays to contact the owner"
✅ After payment: Contact unlocked + Chat enabled
```

---

## 🔍 Visual Verification

### Found Item Page Should Show:
```
┌─────────────────────────────────────────┐
│  📱 Black iPhone 13 Pro                 │
│  [FOUND]                                │
│                                         │
│  Description: Found at Kigali Market... │
│  📍 Location: Kigali City Market        │
│  👤 Reporter: Marie Uwase               │
│                                         │
│  ┌───────────────────────────────────┐ │
│  │ ✅ Contact Information            │ │
│  │ Name: Marie Uwase                 │ │
│  │ Phone: +250 788 123 456           │ │
│  │ 📞 Call the finder to arrange     │ │
│  │    pickup!                        │ │
│  └───────────────────────────────────┘ │
└─────────────────────────────────────────┘
```

### Lost Item Page Should Show:
```
┌─────────────────────────────────────────┐
│  📱 Black iPhone 13                     │
│  [LOST]                                 │
│                                         │
│  Description: Lost at Kigali Market...  │
│  📍 Location: Kigali City Market        │
│  👤 Reporter: Jean Mugabo               │
│                                         │
│  ┌───────────────────────────────────┐ │
│  │ 💰 Pay 1,000 RWF to Unlock        │ │
│  │    Contact                        │ │
│  └───────────────────────────────────┘ │
│                                         │
│  Only the person who lost the item      │
│  pays to contact the owner              │
└─────────────────────────────────────────┘
```

---

## ✅ Success Criteria

- [ ] Found items show contact for FREE
- [ ] Lost items require payment
- [ ] Payment button only on lost items
- [ ] Payment flow works (MTN/Airtel)
- [ ] Contact unlocked after payment
- [ ] Chat enabled after payment
- [ ] Clear messaging about who pays

---

## 🐛 Troubleshooting

### Issue: Contact not showing for found items
**Solution:** Clear browser cache and refresh

### Issue: Payment button showing for found items
**Solution:** Check item.status === 'found' condition

### Issue: Payment not processing
**Solution:** Check backend logs: `docker logs imis-backend-1`

### Issue: Frontend not loading
**Solution:** Restart frontend: `docker restart imis-frontend-1`

---

## 📞 Quick Commands

```bash
# Check all containers
docker ps --filter "name=imis"

# Restart frontend
docker restart imis-frontend-1

# Restart backend
docker restart imis-backend-1

# View backend logs
docker logs imis-backend-1 --tail 50

# View frontend logs
docker logs imis-frontend-1 --tail 50

# Stop all
docker-compose down

# Start all
docker-compose up -d
```

---

**Made with ❤️ for Rwanda | Ishakiro - Fair Payment System** 🇷🇼
