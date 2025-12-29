from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker
from .config import settings
import os

# Configure database connection based on database type
if "sqlite" in settings.DATABASE_URL:
    # SQLite configuration
    connect_args = {"check_same_thread": False}
elif "postgresql" in settings.DATABASE_URL:
    # PostgreSQL configuration with SSL for production
    connect_args = {
        "sslmode": "require",
        "connect_timeout": 30
    }
else:
    connect_args = {}

engine = create_engine(
    settings.DATABASE_URL,
    connect_args=connect_args,
    pool_pre_ping=True,
    pool_recycle=300
)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
Base = declarative_base()

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()
