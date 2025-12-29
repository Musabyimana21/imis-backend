#!/usr/bin/env python3
"""Quick fix for database and CORS issues"""

import sys
import os
sys.path.append('backend')

try:
    from backend.app.core.database import engine, Base
    from backend.app.models.enhanced_models import AnonymousItem
    
    print("Updating database schema...")
    Base.metadata.create_all(bind=engine)
    print("✅ Database schema updated successfully")
    
    # Test database connection
    from sqlalchemy import text
    with engine.connect() as conn:
        result = conn.execute(text("SELECT 1"))
        print("✅ Database connection working")
        
except Exception as e:
    print(f"❌ Database error: {e}")
    print("Make sure PostgreSQL is running and database exists")

print("\n🚀 Run FIX_CORS_AND_DB.bat to restart services")