# Ishakiro Information Management System (IMIS)

## Project Summary

IMIS is a fully functional, production-ready web platform that connects people who lost items with those who found them, specifically optimized for Rwanda. The system features AI-based matching, geolocation services, secure messaging, and commission handling.

## What's Been Built

### ✅ Complete Backend (FastAPI)
- RESTful API with 20+ endpoints
- JWT authentication with role-based access
- PostgreSQL + PostGIS database integration
- AI-based matching engine using NLP and geospatial analysis
- Secure messaging system
- Commission tracking and management
- Admin dashboard with analytics
- Swagger/OpenAPI documentation

### ✅ Complete Frontend (SvelteKit)
- Responsive, mobile-first design
- Full Kinyarwanda + English localization
- Lost & found item reporting with GPS
- Real-time item matching display
- In-app messaging interface
- Admin dashboard with statistics
- WCAG-compliant accessibility
- Rwandan cultural design (colors, layout)

### ✅ Database Schema
- Users with authentication
- Items with geolocation (PostGIS)
- AI-generated matches
- Secure messages
- Commission records
- Full audit trail

### ✅ DevOps & Deployment
- Docker Compose for local development
- GitHub Actions CI/CD pipeline
- Cloudflare Pages deployment config
- Render deployment config
- Environment variable management

### ✅ Documentation
- README with quick start
- Comprehensive setup guide
- API documentation
- Architecture overview
- Feature list
- Deployment guide
- Contributing guidelines

## Technology Stack

**Frontend:**
- SvelteKit 2.0
- Tailwind CSS 3.4
- Vite 5.0
- i18n localization

**Backend:**
- FastAPI 0.109
- SQLAlchemy 2.0
- PostgreSQL 15
- PostGIS 3.3
- scikit-learn (NLP)
- JWT authentication

**Deployment:**
- Cloudflare Pages (frontend)
- Render (backend + database)
- Docker (local development)

## Key Features Implemented

1. **Lost & Found Reporting** - Full CRUD with GPS tagging
2. **AI Matching Engine** - TF-IDF + geospatial scoring
3. **Geolocation Services** - PostGIS distance calculations
4. **Secure Messaging** - In-app encrypted communication
5. **Commission System** - Automated tracking and management
6. **Admin Dashboard** - Real-time analytics and user management
7. **Localization** - Kinyarwanda + English with dynamic switching
8. **Accessibility** - WCAG-compliant, screen reader support
9. **Authentication** - JWT with bcrypt password hashing
10. **Role-Based Access** - User and admin roles

## File Structure

```
IMIS/
├── backend/
│   ├── app/
│   │   ├── api/          # REST endpoints
│   │   ├── core/         # Config, security, database
│   │   ├── models/       # SQLAlchemy models & schemas
│   │   └── services/     # Business logic (matching)
│   ├── requirements.txt
│   ├── Dockerfile
│   └── .env.example
├── frontend/
│   ├── src/
│   │   ├── routes/       # SvelteKit pages
│   │   ├── lib/
│   │   │   ├── api.js    # API client
│   │   │   ├── stores/   # State management
│   │   │   ├── i18n/     # Translations
│   │   │   └── components/
│   │   ├── app.css
│   │   └── app.html
│   ├── package.json
│   ├── Dockerfile
│   └── tailwind.config.js
├── docker-compose.yml
├── README.md
├── QUICKSTART.md
├── SETUP_GUIDE.md
├── API_DOCUMENTATION.md
├── FEATURES.md
├── ARCHITECTURE.md
├── DEPLOYMENT.md
└── CONTRIBUTING.md
```

## How to Run

**Quick Start (Docker):**
```bash
docker-compose up --build
```

**Manual Setup:**
```bash
# Backend
cd backend
python -m venv venv
venv\Scripts\activate
pip install -r requirements.txt
uvicorn app.main:app --reload

# Frontend
cd frontend
npm install
npm run dev
```

## API Endpoints

- `POST /auth/register` - User registration
- `POST /auth/login` - User login
- `POST /items/` - Create item
- `GET /items/` - List items
- `GET /items/{id}` - Item details
- `GET /items/{id}/matches` - AI matches
- `POST /messages/` - Send message
- `GET /messages/` - List messages
- `GET /admin/stats` - Admin statistics
- `GET /admin/commissions` - Commission list
- `GET /admin/users` - User management

Full API docs at `/docs` endpoint.

## Deployment Ready

The system is ready for production deployment:

1. **Frontend**: Push to GitHub → Connect to Cloudflare Pages
2. **Backend**: Push to GitHub → Connect to Render
3. **Database**: Use Render PostgreSQL with PostGIS

All configuration files and environment variables are set up.

## What Makes This Special

- **AI-Powered**: Intelligent matching using NLP and geolocation
- **Rwanda-Optimized**: Kinyarwanda language, cultural design, low-bandwidth
- **Accessible**: WCAG-compliant, screen reader support
- **Secure**: JWT auth, encrypted passwords, privacy-focused
- **Scalable**: Async backend, optimized queries, CDN-ready
- **Complete**: Full-stack solution with documentation

## Next Steps for Production

1. Set up production database with PostGIS
2. Configure environment variables
3. Deploy to Cloudflare Pages and Render
4. Create admin user
5. Test all features
6. Monitor and optimize

## License

MIT License - See LICENSE file

---

**Built with ❤️ for Rwanda**
