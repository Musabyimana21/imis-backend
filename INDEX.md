# IMIS Complete File Index

## 🚀 START HERE

**First Time Users:**
1. Read: `README_FIRST.txt`
2. Run: `START_HERE.bat` (Windows) or `./START_HERE.sh` (Linux/Mac)
3. Read: `GETTING_STARTED.md`

## 📜 Automation Scripts

### Interactive Menu
- `START_HERE.bat` - Windows interactive menu
- `START_HERE.sh` - Linux/Mac interactive menu

### Core Scripts
- `setup.bat` / `setup.sh` - Automated setup and start
- `stop.bat` / `stop.sh` - Stop all services
- `test-system.bat` / `test-system.sh` - Health check
- `create-admin.bat` / `create-admin.sh` - Create admin user
- `run-docker.bat` / `run-docker.sh` - Docker-only start

## 📚 Documentation

### Getting Started
- `README_FIRST.txt` - Quick start (plain text)
- `GETTING_STARTED.md` - Comprehensive getting started guide
- `QUICKSTART.md` - 5-minute quick start
- `README.md` - Main project overview

### Automation
- `AUTOMATION_COMPLETE.md` - Automation summary
- `AUTOMATION_GUIDE.md` - Script documentation

### Technical Documentation
- `SETUP_GUIDE.md` - Detailed manual setup
- `API_DOCUMENTATION.md` - REST API reference
- `FEATURES.md` - Feature list and descriptions
- `ARCHITECTURE.md` - System architecture
- `PROJECT_SUMMARY.md` - Complete project overview

### Deployment & Contributing
- `DEPLOYMENT.md` - Production deployment guide
- `CONTRIBUTING.md` - Contribution guidelines
- `LICENSE` - MIT License

## 🏗️ Project Structure

### Backend (FastAPI)
```
backend/
├── app/
│   ├── api/              # REST endpoints
│   │   ├── auth.py       # Authentication
│   │   ├── items.py      # Item management
│   │   ├── messages.py   # Messaging
│   │   └── admin.py      # Admin dashboard
│   ├── core/             # Core functionality
│   │   ├── config.py     # Configuration
│   │   ├── security.py   # JWT & passwords
│   │   └── database.py   # Database connection
│   ├── models/           # Data models
│   │   ├── models.py     # SQLAlchemy models
│   │   └── schemas.py    # Pydantic schemas
│   ├── services/         # Business logic
│   │   └── matching.py   # AI matching engine
│   └── main.py           # FastAPI app
├── .env                  # Environment variables
├── .env.example          # Environment template
├── Dockerfile            # Docker configuration
└── requirements.txt      # Python dependencies
```

### Frontend (SvelteKit)
```
frontend/
├── src/
│   ├── routes/           # Pages
│   │   ├── +layout.svelte       # Main layout
│   │   ├── +page.svelte         # Homepage
│   │   ├── login/               # Login/register
│   │   ├── lost/                # Report lost
│   │   ├── found/               # Report found
│   │   ├── messages/            # Messaging
│   │   ├── admin/               # Admin dashboard
│   │   └── items/[id]/          # Item details
│   ├── lib/
│   │   ├── api.js               # API client
│   │   ├── stores/              # State management
│   │   │   ├── auth.js          # Auth store
│   │   │   └── locale.js        # i18n store
│   │   ├── i18n/                # Translations
│   │   │   └── translations.js  # RW/EN translations
│   │   └── components/          # Reusable components
│   │       └── ItemCard.svelte
│   ├── app.css           # Global styles
│   └── app.html          # HTML template
├── static/               # Static assets
├── .env                  # Environment variables
├── .env.example          # Environment template
├── Dockerfile            # Docker configuration
├── package.json          # Node dependencies
├── svelte.config.js      # SvelteKit config
├── tailwind.config.js    # Tailwind config
├── postcss.config.js     # PostCSS config
└── vite.config.js        # Vite config
```

### DevOps
```
.github/
└── workflows/
    └── deploy.yml        # CI/CD pipeline

docker-compose.yml        # Docker Compose config
.gitignore               # Git ignore rules
```

## 🎯 Quick Reference

### To Start Everything
```bash
START_HERE.bat           # Windows (interactive)
./START_HERE.sh          # Linux/Mac (interactive)

# Or directly:
setup.bat                # Windows
./setup.sh               # Linux/Mac
```

### To Stop Everything
```bash
stop.bat                 # Windows
./stop.sh                # Linux/Mac
```

### To Test System
```bash
test-system.bat          # Windows
./test-system.sh         # Linux/Mac
```

### To Create Admin
```bash
create-admin.bat         # Windows
./create-admin.sh        # Linux/Mac
```

## 🌐 Access URLs

- Frontend: http://localhost:5173
- Backend API: http://localhost:8000
- API Docs: http://localhost:8000/docs
- Database: localhost:5432 (Docker mode)

## 📦 Key Technologies

**Backend:**
- FastAPI 0.109
- SQLAlchemy 2.0
- PostgreSQL 15 + PostGIS 3.3
- scikit-learn (AI matching)
- JWT authentication

**Frontend:**
- SvelteKit 2.0
- Tailwind CSS 3.4
- Vite 5.0
- i18n (Kinyarwanda + English)

**DevOps:**
- Docker & Docker Compose
- GitHub Actions
- Cloudflare Pages
- Render

## 🎨 Features

1. Lost & Found item reporting
2. AI-based matching (NLP + geolocation)
3. GPS geolocation services
4. Secure in-app messaging
5. Commission handling (10% default)
6. Admin dashboard with analytics
7. Kinyarwanda + English localization
8. WCAG-compliant accessibility
9. Mobile-responsive design
10. Role-based access control

## 🔐 Security

- JWT token authentication
- Bcrypt password hashing
- Role-based access (user/admin)
- CORS protection
- SQL injection prevention
- XSS protection

## 📊 Database Schema

- **users** - User accounts and authentication
- **items** - Lost/found items with geolocation
- **matches** - AI-generated item matches
- **messages** - Secure user communications
- **commissions** - Transaction records

## 🚀 Deployment

**Frontend:** Cloudflare Pages
**Backend:** Render
**Database:** Render PostgreSQL

See `DEPLOYMENT.md` for details.

## 📖 Learning Path

1. **Beginner:** Start with `README_FIRST.txt`
2. **User:** Read `GETTING_STARTED.md`
3. **Developer:** Review `SETUP_GUIDE.md` and `ARCHITECTURE.md`
4. **API User:** Check `API_DOCUMENTATION.md`
5. **Contributor:** See `CONTRIBUTING.md`
6. **DevOps:** Read `DEPLOYMENT.md`

## 🆘 Troubleshooting

1. Check `AUTOMATION_GUIDE.md` for script issues
2. Review `SETUP_GUIDE.md` for setup problems
3. Run `test-system` script for diagnostics
4. Check Docker logs: `docker-compose logs -f`

## ✨ Summary

**Everything you need is automated.**

Just run `START_HERE` and select option 1.

The system will:
- ✅ Detect your environment
- ✅ Install dependencies
- ✅ Configure services
- ✅ Start everything
- ✅ Show access URLs

**No manual configuration required!**

---

**Built with ❤️ for Rwanda**
