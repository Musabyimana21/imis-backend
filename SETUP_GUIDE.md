# IMIS Setup Guide

## Prerequisites

- Node.js 18+ and npm
- Python 3.11+
- PostgreSQL 15+ with PostGIS extension
- Git
- Docker (optional)

## Local Development Setup

### 1. Clone Repository

```bash
git clone <your-repo-url>
cd IMIS
```

### 2. Backend Setup

```bash
cd backend

# Create virtual environment
python -m venv venv

# Activate virtual environment
# Windows:
venv\Scripts\activate
# Linux/Mac:
source venv/bin/activate

# Install dependencies
pip install -r requirements.txt

# Create .env file
copy .env.example .env

# Edit .env with your database credentials
# DATABASE_URL=postgresql://user:password@localhost:5432/imis
# SECRET_KEY=your-secret-key-here

# Run the server
uvicorn app.main:app --reload
```

Backend will be available at `http://localhost:8000`
API docs at `http://localhost:8000/docs`

### 3. Database Setup

```bash
# Create database
createdb imis

# Connect to database
psql imis

# Enable PostGIS
CREATE EXTENSION postgis;

# Exit
\q
```

The tables will be created automatically when you run the backend.

### 4. Frontend Setup

```bash
cd frontend

# Install dependencies
npm install

# Create .env file
copy .env.example .env

# Edit .env
# PUBLIC_API_URL=http://localhost:8000

# Run development server
npm run dev
```

Frontend will be available at `http://localhost:5173`

### 5. Create Admin User

Use the API or database to create an admin user:

```sql
-- Connect to database
psql imis

-- Update a user to admin
UPDATE users SET role = 'admin' WHERE email = 'your-email@example.com';
```

## Docker Setup (Alternative)

```bash
# Start all services
docker-compose up --build

# Backend: http://localhost:8000
# Frontend: http://localhost:5173
# Database: localhost:5432
```

## Testing the System

1. Register a new user at `/login`
2. Report a lost item at `/lost`
3. Report a found item at `/found`
4. Check matches on item detail pages
5. Send messages between users
6. Access admin dashboard at `/admin` (admin users only)

## Troubleshooting

### Database Connection Error
- Verify PostgreSQL is running
- Check DATABASE_URL in .env
- Ensure PostGIS extension is installed

### Frontend API Error
- Verify backend is running on port 8000
- Check PUBLIC_API_URL in frontend .env
- Check browser console for CORS errors

### Import Errors (Python)
- Ensure virtual environment is activated
- Reinstall dependencies: `pip install -r requirements.txt`

### Module Not Found (Node)
- Delete node_modules and package-lock.json
- Run `npm install` again

## Next Steps

- Configure environment variables for production
- Set up SSL certificates
- Configure backup strategy
- Set up monitoring and logging
- Review security settings
- Test all features thoroughly
