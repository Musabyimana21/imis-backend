from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from .core.database import engine, Base
from .api import (
    auth, items, messages, admin, anonymous,
    enhanced_items, enhanced_messages, enhanced_admin, payments, chat
)

app = FastAPI(
    title="IMIS API - Complete System",
    description="Ishakiro Information Management System - Complete Lost & Found Platform for Rwanda",
    version="3.0.0",
    docs_url="/docs",
    redoc_url="/redoc"
)

# CORS configuration - Allow production domains
app.add_middleware(
    CORSMiddleware,
    allow_origins=[
        "http://localhost:5173",
        "http://localhost:3000",
        "https://*.pages.dev",
        "https://*.cloudflare.com",
        "https://imis-frontend.pages.dev",
        "https://imis-backend.onrender.com"
    ],
    allow_credentials=False,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.on_event("startup")
async def startup():
    from .models import enhanced_models
    try:
        Base.metadata.create_all(bind=engine)
    except Exception as e:
        if "already exists" in str(e):
            print(f"Database objects already exist: {e}")
        else:
            raise e

# Include all routers
app.include_router(anonymous.router, prefix="/api")
app.include_router(chat.router, prefix="/api")
app.include_router(auth.router, prefix="/api")
app.include_router(enhanced_items.router, prefix="/api")
app.include_router(enhanced_messages.router, prefix="/api")
app.include_router(payments.router, prefix="/api")
app.include_router(enhanced_admin.router, prefix="/api")
app.include_router(items.router, prefix="/legacy")
app.include_router(messages.router, prefix="/legacy")
app.include_router(admin.router, prefix="/legacy")

@app.get("/")
def root():
    return {"message": "IMIS API Running", "version": "3.0.0"}

@app.get("/health")
def health():
    return {"status": "healthy", "database": "connected"}
