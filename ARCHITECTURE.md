# IMIS Architecture

## System Overview

IMIS is a three-tier web application with a SvelteKit frontend, FastAPI backend, and PostgreSQL database with PostGIS extension.

```
┌─────────────────┐
│   Frontend      │
│   (SvelteKit)   │
│   Port: 5173    │
└────────┬────────┘
         │ HTTP/REST
         │
┌────────▼────────┐
│   Backend       │
│   (FastAPI)     │
│   Port: 8000    │
└────────┬────────┘
         │ SQLAlchemy
         │
┌────────▼────────┐
│   Database      │
│  (PostgreSQL)   │
│   + PostGIS     │
│   Port: 5432    │
└─────────────────┘
```

## Backend Architecture

### Layers

1. **API Layer** (`app/api/`)
   - REST endpoints
   - Request validation
   - Response serialization
   - Authentication middleware

2. **Service Layer** (`app/services/`)
   - Business logic
   - AI matching algorithms
   - Data processing

3. **Data Layer** (`app/models/`)
   - SQLAlchemy ORM models
   - Database schemas
   - Pydantic validation schemas

4. **Core Layer** (`app/core/`)
   - Configuration
   - Security utilities
   - Database connection

### Key Components

**Authentication:**
- JWT tokens with expiration
- Bcrypt password hashing
- Role-based access control

**Matching Engine:**
- TF-IDF vectorization for text similarity
- Cosine similarity scoring
- PostGIS distance calculations
- Combined scoring algorithm

**Database Models:**
- Users (authentication, profiles)
- Items (lost/found items with geolocation)
- Matches (AI-generated matches)
- Messages (secure communication)
- Commissions (transaction records)

## Frontend Architecture

### Structure

```
src/
├── routes/           # SvelteKit pages
│   ├── +layout.svelte
│   ├── +page.svelte
│   ├── login/
│   ├── lost/
│   ├── found/
│   ├── messages/
│   ├── admin/
│   └── items/[id]/
├── lib/
│   ├── api.js        # API client
│   ├── stores/       # Svelte stores
│   │   ├── auth.js
│   │   └── locale.js
│   ├── i18n/         # Translations
│   └── components/   # Reusable components
└── app.css           # Global styles
```

### State Management

**Svelte Stores:**
- `auth`: User authentication state
- `locale`: Language preference
- Persistent via localStorage

### Routing

- File-based routing via SvelteKit
- Dynamic routes for item details
- Protected routes with auth checks

## Database Schema

### Users Table
- id (PK)
- email (unique)
- hashed_password
- full_name
- phone
- role (user/admin)
- created_at

### Items Table
- id (PK)
- user_id (FK)
- title
- description
- category
- status (lost/found/matched/recovered)
- location_name
- location (PostGIS Geography)
- latitude, longitude
- image_url
- date_lost_found
- created_at
- is_active

### Matches Table
- id (PK)
- item_id (FK)
- matched_item_id (FK)
- similarity_score
- distance_km
- created_at

### Messages Table
- id (PK)
- sender_id (FK)
- receiver_id (FK)
- item_id (FK)
- content
- is_read
- created_at

### Commissions Table
- id (PK)
- item_id (FK)
- user_id (FK)
- amount
- rate
- status
- created_at

## API Design

**RESTful Principles:**
- Resource-based URLs
- HTTP methods (GET, POST, PUT, DELETE)
- JSON request/response
- Standard status codes

**Authentication:**
- Bearer token in Authorization header
- Token validation on protected routes

**Error Handling:**
- Consistent error response format
- Appropriate HTTP status codes
- Descriptive error messages

## Deployment Architecture

### Production Setup

```
┌──────────────────┐
│  Cloudflare CDN  │
│   (Frontend)     │
└────────┬─────────┘
         │
┌────────▼─────────┐
│  Render          │
│  (Backend API)   │
└────────┬─────────┘
         │
┌────────▼─────────┐
│  Render          │
│  (PostgreSQL)    │
└──────────────────┘
```

**Frontend (Cloudflare Pages):**
- Static site hosting
- Global CDN
- Automatic HTTPS
- Git-based deployment

**Backend (Render):**
- Managed Python runtime
- Auto-scaling
- Health checks
- Environment variables

**Database (Render PostgreSQL):**
- Managed PostgreSQL
- PostGIS extension
- Automated backups
- Connection pooling

## Security Considerations

1. **Authentication:**
   - JWT with short expiration
   - Secure password hashing
   - Token refresh mechanism

2. **Authorization:**
   - Role-based access control
   - Resource ownership validation
   - Admin-only endpoints

3. **Data Protection:**
   - SQL injection prevention (ORM)
   - XSS prevention (framework defaults)
   - CORS configuration
   - HTTPS enforcement

4. **Privacy:**
   - No external contact sharing
   - In-app messaging only
   - User data encryption at rest

## Performance Optimization

1. **Frontend:**
   - Code splitting
   - Lazy loading
   - Minimal bundle size
   - CDN delivery

2. **Backend:**
   - Async request handling
   - Database query optimization
   - Connection pooling
   - Caching strategies

3. **Database:**
   - Indexed columns
   - PostGIS spatial indexes
   - Query optimization
   - Regular maintenance

## Scalability

**Horizontal Scaling:**
- Stateless backend design
- Load balancer ready
- Database connection pooling

**Vertical Scaling:**
- Efficient algorithms
- Optimized queries
- Resource monitoring

**Future Enhancements:**
- Redis caching layer
- Message queue for async tasks
- Microservices architecture
- CDN for user uploads
