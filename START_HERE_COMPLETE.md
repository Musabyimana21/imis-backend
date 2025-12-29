# 🚀 ISHAKIRO IMIS - Complete Startup Guide

## ✅ System Ready!

Your ISHAKIRO Information Management System is fully configured and ready to launch!

---

## 🎯 Quick Start (30 Seconds)

### Step 1: Start Everything
```bash
START_EVERYTHING.bat
```

This will:
- ✅ Create/reset database
- ✅ Install all dependencies
- ✅ Seed sample data
- ✅ Start backend API (port 8000)
- ✅ Start frontend (port 5173)
- ✅ Open browser automatically

### Step 2: Verify System
```bash
TEST_ALL.bat
```

---

## 🌐 Access Points

| Service | URL | Description |
|---------|-----|-------------|
| **Frontend** | http://localhost:5173 | Main user interface |
| **Backend API** | http://localhost:8000 | REST API |
| **API Docs** | http://localhost:8000/docs | Interactive API documentation |
| **Health Check** | http://localhost:8000/health | System status |

---

## 👤 Test Accounts

| Role | Email | Password | Purpose |
|------|-------|----------|---------|
| **Admin** | admin@imis.rw | admin123 | Full system access |
| **User 1** | user1@imis.rw | password123 | Regular user |
| **User 2** | user2@imis.rw | password123 | Regular user |

---

## 🎨 Features Available

### Core Features
- ✅ **Report Lost Items** - Quick 30-second reporting
- ✅ **Report Found Items** - Help reunite items with owners
- ✅ **AI Matching** - 70% text + 30% location similarity
- ✅ **Real-Time Messaging** - Chat with finders/owners
- ✅ **Mobile Money** - MTN & Airtel Money integration
- ✅ **Geolocation** - Distance-based matching
- ✅ **Admin Dashboard** - Complete system management
- ✅ **Bilingual** - English & Kinyarwanda support

### Technical Features
- ✅ **JWT Authentication** - Secure user sessions
- ✅ **Role-Based Access** - Admin/User permissions
- ✅ **Payment System** - 1,000 RWF unlock fee
- ✅ **Commission Tracking** - 10% commission system
- ✅ **Audit Logging** - Complete activity tracking
- ✅ **WCAG Compliant** - Fully accessible
- ✅ **Responsive Design** - Mobile-first approach

---

## 🧪 Testing the System

### 1. Report a Lost Item
1. Go to http://localhost:5173
2. Click "I Lost Something"
3. Fill in item details
4. Submit report

### 2. Report a Found Item
1. Click "I Found Something"
2. Fill in item details
3. Submit report

### 3. View AI Matches
1. Login with test account
2. View your items
3. See AI-generated matches
4. Match score shows similarity

### 4. Test Messaging
1. Click on a matched item
2. Send a message
3. Check real-time delivery

### 5. Test Payment System
1. Click "Unlock Contact"
2. Choose payment method
3. Enter phone number
4. Verify payment

### 6. Admin Dashboard
1. Login as admin@imis.rw
2. View system statistics
3. Manage users
4. Track commissions

---

## 📊 System Architecture

```
┌─────────────────────────────────────────┐
│         Frontend (SvelteKit)            │
│         http://localhost:5173           │
└──────────────┬──────────────────────────┘
               │
               │ REST API
               │
┌──────────────▼──────────────────────────┐
│         Backend (FastAPI)               │
│         http://localhost:8000           │
│                                         │
│  ┌─────────────────────────────────┐   │
│  │  AI Matching Engine             │   │
│  │  - TF-IDF Text Analysis         │   │
│  │  - Cosine Similarity            │   │
│  │  - Geolocation Distance         │   │
│  └─────────────────────────────────┘   │
└──────────────┬──────────────────────────┘
               │
               │ SQL
               │
┌──────────────▼──────────────────────────┐
│      PostgreSQL Database                │
│      localhost:5432/imis                │
└─────────────────────────────────────────┘
```

---

## 🔧 Troubleshooting

### Backend Won't Start
```bash
# Check if port 8000 is in use
netstat -ano | findstr :8000

# Kill process if needed
taskkill /F /PID <process_id>

# Restart
START_EVERYTHING.bat
```

### Frontend Won't Start
```bash
# Check if port 5173 is in use
netstat -ano | findstr :5173

# Kill process if needed
taskkill /F /PID <process_id>

# Reinstall dependencies
cd frontend
npm install
npm run dev
```

### Database Connection Failed
```bash
# Check PostgreSQL is running
sc query postgresql-x64-18

# Start if stopped
net start postgresql-x64-18

# Test connection
psql -U postgres -d imis
```

### No Sample Data
```bash
cd backend
python seed_data.py
```

---

## 🛑 Stop Services

Press any key in the START_EVERYTHING.bat window, or:

```bash
# Kill all services
taskkill /F /IM python.exe
taskkill /F /IM node.exe
```

---

## 📱 Mobile Testing

The system is fully responsive. Test on mobile by:

1. Find your local IP: `ipconfig`
2. Access from mobile: `http://YOUR_IP:5173`
3. Ensure firewall allows connections

---

## 🚀 Deployment

Ready to deploy? See:
- **DEPLOYMENT.md** - Complete production guide
- **QUICKSTART.md** - Quick testing guide
- **FEATURES.md** - Full feature documentation

---

## 💡 Tips

1. **Use Chrome/Edge** for best experience
2. **Enable location** for geolocation features
3. **Test on mobile** for responsive design
4. **Check API docs** at /docs for integration
5. **Monitor logs** in terminal windows

---

## 📞 Support

- **Documentation**: Check /docs folder
- **API Docs**: http://localhost:8000/docs
- **Health Check**: http://localhost:8000/health

---

## 🎉 You're All Set!

Run `START_EVERYTHING.bat` and start reuniting lost items with their owners!

**Made with ❤️ for Rwanda 🇷🇼**
