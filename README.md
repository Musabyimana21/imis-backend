# Ishakiro Information Management System (IMIS)

> **🚀 USE SETUP WIZARD!** Run `SETUP_WIZARD.bat` for guided setup

A complete web platform connecting people who lost items with those who found them, optimized for Rwanda. Features AI-powered matching, secure messaging, geolocation services, and commission handling.

## 🌟 Key Features
- ✅ **AI-Powered Matching** - Intelligent algorithm matches lost & found items
- ✅ **Interactive Map** - Leaflet.js with OpenStreetMap for Rwanda location selection
- ✅ **Secure Messaging** - In-app communication between users
- ✅ **Geolocation** - GPS auto-detect, click-to-select, drag marker
- ✅ **Admin Dashboard** - Complete system management and analytics
- ✅ **Bilingual** - English & Kinyarwanda support
- ✅ **Commission System** - 10% commission on recovered items
- ✅ **WCAG Compliant** - Fully accessible interface
- ✅ **Production Ready** - Deployment guides included

## 🛠️ Tech Stack
- **Frontend**: SvelteKit + Tailwind CSS
- **Backend**: FastAPI (Python) + SQLAlchemy
- **Database**: PostgreSQL (PostGIS optional)
- **AI/ML**: scikit-learn (TF-IDF, Cosine Similarity)
- **Hosting**: Cloudflare Pages (frontend), Render (backend)

## 📋 Complete Feature List

### Core Features
- 🔐 User authentication with JWT tokens
- 📝 Report lost/found items with detailed info
- 🤖 AI matching engine (70% text + 30% location)
- 💬 Secure in-app messaging system
- 📍 Geolocation with auto-detect
- 💰 Commission tracking (10% default)
- 👨‍💼 Admin dashboard with analytics
- 🌍 English & Kinyarwanda languages
- ♿ WCAG 2.1 accessibility compliant
- 📱 Fully responsive design

### Technical Features
- RESTful API with OpenAPI docs
- Database migrations support
- Role-based access control
- Password hashing with bcrypt
- CORS configuration
- Health check endpoints
- Error handling & validation
- Pagination support

See [FEATURES.md](FEATURES.md) for complete details.

## 🚀 Quick Start (3 Minutes)

### Option 1: Automated Setup (Recommended)
```bash
# Run setup wizard
SETUP_WIZARD.bat

# Add sample data
SEED_DATABASE.bat

# Verify everything works
VERIFY_SYSTEM.bat
```

### Option 2: Manual Setup
```bash
# 1. Check PostgreSQL
CHECK_POSTGRESQL.bat

# 2. Reset password if needed
RESET_PG18_PASSWORD.bat

# 3. Test connection
TEST_DATABASE.bat

# 4. Start IMIS
START_WITH_DB.bat

# 5. Seed data (optional)
SEED_DATABASE.bat
```

### Linux/Mac
```bash
chmod +x *.sh
./START_MANUAL.sh
```

### What Happens
- ✅ Installs all dependencies automatically
- ✅ Creates database tables
- ✅ Starts backend (FastAPI) on port 8001
- ✅ Starts frontend (SvelteKit) on port 5173
- ✅ Opens in separate terminal windows
- ✅ Ready in 30 seconds!

### 🌐 Access Points
- **Frontend**: http://localhost:5173
- **Backend API**: http://localhost:8001
- **API Docs**: http://localhost:8001/docs (Interactive Swagger UI)
- **ReDoc**: http://localhost:8001/redoc (Alternative docs)
- **Health Check**: http://localhost:8001/health

### 🧪 Test Accounts (After Seeding)
```
Admin:  admin@imis.rw / admin123
User:   user1@imis.rw / password123
```

### 🛑 Stop Services
```bash
stop.bat        # Windows
./stop.sh       # Linux/Mac
```

### 🐳 Docker Setup (Optional)
```bash
docker-compose up --build
```

## ⚙️ Configuration

### Backend (.env)
```env
DATABASE_URL=postgresql://postgres:password123@localhost:5432/imis
SECRET_KEY=your-secret-key-here
ALGORITHM=HS256
ACCESS_TOKEN_EXPIRE_MINUTES=30
```

### Frontend (.env)
```env
PUBLIC_API_URL=http://localhost:8001
```

### Generate Secret Key
```bash
python -c "import secrets; print(secrets.token_urlsafe(32))"
```

## 🚀 Deployment

Complete deployment guides available:
- 📘 [DEPLOYMENT.md](DEPLOYMENT.md) - Full production deployment guide
- 📗 [QUICKSTART.md](QUICKSTART.md) - Quick testing guide
- 📙 [FEATURES.md](FEATURES.md) - Complete feature documentation

### Quick Deploy
1. **Database**: Render PostgreSQL (free tier)
2. **Backend**: Render Web Service (free tier)
3. **Frontend**: Cloudflare Pages (free tier)

**Total Cost**: $0/month for development, $14-34/month for production

See [DEPLOYMENT.md](DEPLOYMENT.md) for step-by-step instructions.

## 📚 Documentation

- [README.md](README.md) - This file (overview & setup)
- [QUICKSTART.md](QUICKSTART.md) - 3-minute testing guide
- [FEATURES.md](FEATURES.md) - Complete feature list
- [LOCATION_FEATURE.md](LOCATION_FEATURE.md) - Interactive map documentation
- [DEPLOYMENT.md](DEPLOYMENT.md) - Production deployment
- API Docs - http://localhost:8001/docs (when running)

## 🧪 Available Scripts

| Script | Purpose |
|--------|--------|
| `SETUP_WIZARD.bat` | Interactive setup wizard |
| `START_WITH_DB.bat` | Start backend + frontend |
| `TEST_LOCATION_FEATURE.bat` | Test new map location picker |
| `SEED_DATABASE.bat` | Add sample data |
| `VERIFY_SYSTEM.bat` | Run all tests |
| `TEST_IMIS.bat` | Test API endpoints |
| `CHECK_POSTGRESQL.bat` | Check PostgreSQL installation |
| `RESET_PG18_PASSWORD.bat` | Reset PostgreSQL password |
| `STOP.bat` | Stop all services |

## 🎯 Quick Test

```bash
# 1. Start system
START_WITH_DB.bat

# 2. Add sample data
SEED_DATABASE.bat

# 3. Verify everything
VERIFY_SYSTEM.bat

# 4. Open browser
http://localhost:5173

# 5. Login
admin@imis.rw / admin123
```

## 🤝 Contributing

Contributions welcome! Please:
1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

## 📄 License

MIT License - See LICENSE file for details

## 👨‍💻 Developer

**MUSABYIMANA Gaudence**
- 📧 Email: gaudencemusabyimana21@gmail.com
- 📞 Phone: +250780460621
- 🇷🇼 Location: Kigali, Rwanda
- 📅 Year: 2025

## 🙏 Acknowledgments

- Built by MUSABYIMANA Gaudence for Rwanda 🇷🇼
- Powered by FastAPI & SvelteKit
- AI matching with scikit-learn
- Hosted on Cloudflare & Render

## 📞 Support

For issues or questions:
1. Contact: MUSABYIMANA Gaudence (+250780460621)
2. Email: gaudencemusabyimana21@gmail.com
3. Check documentation in `/docs`
4. Review API docs at `/docs` endpoint
5. Run `VERIFY_SYSTEM.bat` for diagnostics

---

**Built with ❤️ by MUSABYIMANA Gaudence | Made for Rwanda 🇷🇼 | 2025**
