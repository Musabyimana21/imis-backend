# ISHAKIRO - Simple Workflow for Rwandans

## 🎯 How It Works (3 Simple Steps)

### For People Who LOST Items:
1. **Report** - Click "Report Lost", describe item, add location (FREE)
2. **Browse** - AI shows matching found items automatically
3. **Pay & Connect** - Pay 1,000 RWF to unlock finder's contact, arrange pickup

### For People Who FOUND Items:
1. **Report** - Click "Report Found", describe item, add location (FREE)
2. **Wait** - Your item is visible to everyone, no payment needed
3. **Get Called** - Owner will contact you directly to arrange return

### For Admin:
1. **Monitor** - View all items and users
2. **Manage** - Track commissions (10% on returns)
3. **Support** - Help users reunite items

---

## 🔐 Test Credentials

### Admin Account
```
Email:    admin@imis.rw
Password: admin123
Role:     Full system access
```

### Item Loser (Lost Phone)
```
Email:    loser@imis.rw
Password: lost123
Name:     Jean Mugabo
Item:     Lost Black iPhone 13
```

### Item Finder (Found Phone)
```
Email:    finder@imis.rw
Password: found123
Name:     Marie Uwase
Item:     Found Black iPhone
```

### Regular User
```
Email:    user1@imis.rw
Password: password123
Name:     User One
```

---

## 📱 Complete System Logic

### 1. USER REGISTRATION (30 seconds)
```
Step 1: Go to http://localhost:5173/login
Step 2: Click "Register"
Step 3: Enter: Name, Email, Phone, Password
Step 4: Click "Create Account"
✅ Done! You're logged in
```

### 2. REPORT LOST ITEM (1 minute)
```
Step 1: Click "Report Lost Item"
Step 2: Fill form:
   - Title: "Black iPhone 13"
   - Description: "Lost at Kigali Market, has blue case"
   - Category: Phone
   - Location: "Kigali City Market"
   - Click "Use My Location" (auto-fills coordinates)
Step 3: Click "Submit"
✅ AI starts searching for matches!
```

### 3. REPORT FOUND ITEM (1 minute)
```
Step 1: Click "Report Found Item"
Step 2: Fill form:
   - Title: "Black iPhone"
   - Description: "Found at market, blue case"
   - Category: Phone
   - Location: "Kigali City Market"
   - Click "Use My Location"
Step 3: Click "Submit"
✅ AI matches with lost items!
```

### 4. VIEW MATCHES (Automatic)
```
AI Matching Algorithm:
- 70% Text Similarity (title + description + category)
- 30% Location Proximity (within 50km)
- Shows top 10 matches
- Updates in real-time

Example Match:
Lost: "Black iPhone 13 with blue case"
Found: "Black iPhone with blue case"
Result: 85% match, 2.3km away ✅
```

### 5. SEND MESSAGE (30 seconds)
```
Step 1: Click on matched item
Step 2: Click "Contact Owner"
Step 3: Type message: "Hi, is this your phone?"
Step 4: Click "Send Message"
✅ Owner gets notification!
```

### 6. ARRANGE PICKUP
```
For LOST item owner:
Step 1: Browse found items (FREE)
Step 2: Click on matching item
Step 3: Pay 1,000 RWF via Mobile Money
Step 4: Get finder's phone number
Step 5: Call finder to arrange pickup

For FOUND item reporter:
Step 1: Post found item (FREE)
Step 2: Wait for owner to contact you
Step 3: No payment required!
Step 4: Arrange safe meetup location
Step 5: Return item to owner
```

---

## 🤖 AI Matching Logic

### How AI Finds Matches:

**Text Similarity (70%)**
```python
Lost: "Black iPhone 13 Pro with cracked screen"
Found: "Black iPhone 13 with broken screen"

AI Analysis:
- "Black iPhone" = Match ✅
- "13" = Match ✅
- "cracked/broken screen" = Similar ✅
Result: 92% text similarity
```

**Location Proximity (30%)**
```python
Lost Location: Kigali City Market (-1.9536, 30.0606)
Found Location: Kimironko Market (-1.9447, 30.1131)

AI Calculation:
Distance = 5.2 km
Proximity Score = 90% (within 50km)
```

**Final Score**
```
Total = (92% × 0.7) + (90% × 0.3)
Total = 64.4% + 27% = 91.4% match ✅
```

---

## 📊 Admin Dashboard

### What Admin Can Do:
1. **View Statistics**
   - Total users
   - Total items (lost/found/recovered)
   - Total commissions earned

2. **Manage Users**
   - View all registered users
   - See user activity
   - Block suspicious accounts

3. **Track Commissions**
   - See all successful returns
   - Calculate 10% commission
   - Mark as paid/unpaid

4. **Monitor System**
   - Check AI matching performance
   - View message activity
   - Generate reports

---

## 🎯 Quick Test Scenario

### Scenario: Lost Phone Recovery

**Step 1: Jean (Loser) Reports**
```
Login: loser@imis.rw / lost123
Report Lost:
- Title: "Black iPhone 13 Pro"
- Description: "Lost at Kigali Market, blue case, cracked screen"
- Location: Kigali City Market
Submit ✅
```

**Step 2: AI Searches**
```
System automatically:
- Scans all "found" items
- Calculates text similarity
- Checks location proximity
- Ranks matches
- Shows top results
```

**Step 3: Marie (Finder) Reports**
```
Login: finder@imis.rw / found123
Report Found:
- Title: "Black iPhone"
- Description: "Found at market, blue case, screen damaged"
- Location: Kigali City Market
Submit ✅
```

**Step 4: AI Matches**
```
Match Found! 🎉
- Text Similarity: 88%
- Distance: 0.5 km
- Overall Score: 89%
Jean sees Marie's item as top match!
```

**Step 5: Communication**
```
Jean clicks "Contact Owner"
Jean: "Hi Marie, is this my phone? It has a blue case"
Marie: "Yes! It has a blue case and cracked screen"
Jean: "That's mine! Can we meet at City Market?"
Marie: "Yes, tomorrow at 2pm"
```

**Step 6: Recovery**
```
- They meet at City Market
- Jean verifies phone (checks photos, contacts)
- Jean pays Marie 10% commission (optional)
- Admin marks item as "Recovered"
✅ Success!
```

---

## 💡 Key Features for Rwandans

### 1. **No Login Required**
```
Report items in 30 seconds
No registration needed
Get tracking code instantly
```

### 2. **Mobile Money Integration**
```
Lost item owners pay 1,000 RWF to unlock contact:
- MTN Mobile Money
- Airtel Money
Finders post for FREE!
```

### 3. **Location Auto-Detect**
```
Click "Use My Location"
System gets GPS coordinates
No manual entry needed
```

### 5. **Category Icons**
```
📱 Phone
💼 Wallet
🔑 Keys
🎒 Bag
📄 Documents
💻 Electronics
💍 Jewelry
📦 Other
```

---

## 🚀 Getting Started (Right Now!)

### Option 1: Use Test Accounts
```bash
1. Open: http://localhost:5173
2. Click "Login"
3. Use: loser@imis.rw / lost123
4. Report a lost item
5. Logout
6. Login as: finder@imis.rw / found123
7. Report a found item
8. See the AI match! 🎉
```

### Option 2: Create New Account
```bash
1. Open: http://localhost:5173
2. Click "Register"
3. Fill your details
4. Start reporting items!
```

---

## 📞 Support

**For Users:**
- Email: support@ishakiro.rw
- Phone: +250 788 000 000
- WhatsApp: +250 788 000 000

**For Admin:**
- Dashboard: http://localhost:5173/admin
- Login: admin@imis.rw / admin123

---

## ✅ System Status

- ✅ User Registration: Working
- ✅ Login/Logout: Working
- ✅ Report Lost: Working
- ✅ Report Found: Working
- ✅ AI Matching: Working (70% text + 30% location)
- ✅ Messaging: Working
- ✅ Admin Dashboard: Working
- ✅ Bilingual: Working (EN/RW)
- ✅ Modern UI: Working (Glassmorphism)

---

**Made with ❤️ for Rwanda | Ishakiro - Reuniting Lost Items** 🇷🇼
