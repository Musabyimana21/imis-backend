# IMIS Quick Start Guide

## 🚀 Get Started in 3 Minutes

### Step 1: Setup (30 seconds)
```bash
# Run the setup wizard
SETUP_WIZARD.bat

# Or manually:
START_WITH_DB.bat
```

### Step 2: Seed Data (30 seconds)
```bash
# Add sample data for testing
SEED_DATABASE.bat
```

### Step 3: Access (1 minute)
```
Frontend: http://localhost:5173
Backend:  http://localhost:8000
API Docs: http://localhost:8000/docs
```

## 🎯 Test the System

### 1. Login with Test Account
```
Email:    admin@imis.rw
Password: admin123
```

### 2. Report a Lost Item
1. Click "Report Lost Item"
2. Fill in the form:
   - Title: "My Black Wallet"
   - Description: "Black leather wallet with ID inside"
   - Category: Wallet
   - Location: "Kigali City Market"
3. Click "Use My Current Location" or enter coordinates
4. Submit

### 3. View Matches
1. Go to your item's detail page
2. See "Potential Matches" section
3. View similarity scores and distances
4. Click on matches to see details

### 4. Send Messages
1. On any item page, click "Contact Owner"
2. Type your message
3. Send
4. Check Messages page to see conversation

### 5. Admin Dashboard
1. Login as admin (admin@imis.rw)
2. Click "Admin" in navigation
3. View statistics:
   - Total users
   - Total items
   - Commissions
4. Manage users and commissions

## 📊 Sample Data Included

After running `SEED_DATABASE.bat`:

### Users (11 total)
- 1 Admin: admin@imis.rw / admin123
- 10 Users: user1@imis.rw to user10@imis.rw / password123

### Items (16 total)
- 8 Lost items (phones, wallets, keys, etc.)
- 8 Found items (matching categories)
- All with Kigali locations
- Automatic matching enabled

## 🧪 Test Scenarios

### Scenario 1: Lost & Found Match
1. Login as user1@imis.rw
2. Report lost "Black iPhone"
3. System automatically finds matching found items
4. View matches with similarity scores
5. Contact the finder

### Scenario 2: Messaging
1. Login as user1@imis.rw
2. Find an item
3. Click "Contact Owner"
4. Send message
5. Login as user2@imis.rw
6. Check Messages page
7. Reply to message

### Scenario 3: Admin Functions
1. Login as admin@imis.rw
2. Go to Admin Dashboard
3. View system statistics
4. Check user list
5. Create commission for recovered item

### Scenario 4: Language Switch
1. Click "RW" button in navigation
2. Interface switches to Kinyarwanda
3. Click "EN" to switch back

## 🔍 API Testing

### Using Swagger UI
1. Go to http://localhost:8000/docs
2. Click "Authorize" button
3. Login to get token
4. Test any endpoint interactively

### Using curl
```bash
# Register user
curl -X POST http://localhost:8000/auth/register \
  -H "Content-Type: application/json" \
  -d '{"email":"test@test.com","password":"test123","full_name":"Test User"}'

# Login
curl -X POST http://localhost:8000/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"test@test.com","password":"test123"}'

# Get items
curl http://localhost:8000/items/

# Health check
curl http://localhost:8000/health
```

## 🎨 UI Features to Try

### Homepage
- Filter items by status (All/Lost/Found)
- Click on item cards to view details
- Responsive design (resize browser)

### Item Forms
- Use "Get My Location" button
- Try different categories
- See form validation

### Item Detail Page
- View item information
- See potential matches
- Send messages to owner
- Check match scores and distances

### Messages Page
- View all conversations
- Mark messages as read
- See timestamps

### Admin Dashboard
- Switch between tabs (Stats/Commissions/Users)
- View colorful statistics cards
- Browse user and commission tables

## 🐛 Troubleshooting

### Backend not starting?
```bash
# Check PostgreSQL
CHECK_POSTGRESQL.bat

# Reset password if needed
RESET_PG18_PASSWORD.bat

# Test connection
TEST_DATABASE.bat
```

### Frontend not loading?
```bash
# Check if backend is running
curl http://localhost:8000/health

# Restart frontend
cd frontend
npm run dev
```

### Database errors?
```bash
# Recreate database
SETUP_DB_NO_POSTGIS.bat

# Reseed data
SEED_DATABASE.bat
```

## 📱 Mobile Testing

1. Find your local IP: `ipconfig`
2. Update frontend/.env:
   ```
   PUBLIC_API_URL=http://YOUR_IP:8000
   ```
3. Access from phone: `http://YOUR_IP:5173`

## 🎯 Key Features to Test

- [x] User registration and login
- [x] Report lost items
- [x] Report found items
- [x] AI matching algorithm
- [x] Distance calculation
- [x] Messaging system
- [x] Admin dashboard
- [x] Language switching
- [x] Responsive design
- [x] Form validation
- [x] Error handling

## 📚 Next Steps

1. Read [FEATURES.md](FEATURES.md) for complete feature list
2. Check [README.md](README.md) for deployment guide
3. Explore API docs at http://localhost:8000/docs
4. Customize for your needs

## 💡 Tips

- Use Chrome DevTools to test responsive design
- Check browser console for any errors
- Monitor backend logs in terminal
- Try different user accounts to test messaging
- Use admin account to see full system stats

## 🎉 You're Ready!

Your IMIS system is now fully functional with:
- ✅ Authentication working
- ✅ Items being created
- ✅ Matching algorithm running
- ✅ Messages being sent
- ✅ Admin dashboard active

Start exploring and building your lost & found platform! 🚀

---

**Need Help?** Check the logs in the terminal windows or visit the API docs.
