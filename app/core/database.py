from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker
from .config import settings
import os
from urllib.parse import urlsplit, urlunsplit, parse_qsl, urlencode

# Normalize and configure database URL/connection
raw_url = settings.DATABASE_URL

# 1) Normalize postgres driver and enforce sslmode=require for Render
normalized_url = raw_url
if raw_url.startswith("postgres://"):
    # SQLAlchemy 2.x prefers 'postgresql+psycopg2://'
    normalized_url = "postgresql+psycopg2://" + raw_url[len("postgres://"):]
elif raw_url.startswith("postgresql://"):
    normalized_url = "postgresql+psycopg2://" + raw_url[len("postgresql://"):]

# Append sslmode=require if missing (especially for Render external DB URLs)
try:
    parts = urlsplit(normalized_url)
    query_params = dict(parse_qsl(parts.query))
    if parts.scheme.startswith("postgresql") and "sslmode" not in query_params:
        query_params["sslmode"] = "require"
        new_query = urlencode(query_params)
        normalized_url = urlunsplit((parts.scheme, parts.netloc, parts.path, new_query, parts.fragment))
except Exception:
    # If parsing fails, fall back to raw URL
    normalized_url = normalized_url

# 2) Configure connect_args by backend type
if "sqlite" in normalized_url:
    connect_args = {"check_same_thread": False}
elif normalized_url.startswith("postgresql"):
    # Robust Postgres settings for cloud providers
    connect_args = {
        "sslmode": "require",
        "connect_timeout": 60,
        # TCP keepalive to survive brief network hiccups
        "keepalives": 1,
        "keepalives_idle": 30,
        "keepalives_interval": 10,
        "keepalives_count": 5,
    }
else:
    connect_args = {}

engine = create_engine(
    normalized_url,
    connect_args=connect_args,
    pool_pre_ping=True,
    pool_recycle=300,
    pool_timeout=60,
    max_overflow=10
)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
Base = declarative_base()

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()
