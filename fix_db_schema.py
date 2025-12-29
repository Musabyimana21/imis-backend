#!/usr/bin/env python3
"""Fix database schema"""

import sys
import os
sys.path.append('.')

try:
    from app.core.database import engine
    from sqlalchemy import text
    
    print("Adding missing image_url column...")
    with engine.connect() as conn:
        conn.execute(text('ALTER TABLE anonymous_items ADD COLUMN IF NOT EXISTS image_url VARCHAR(500)'))
        conn.commit()
        print("✅ Added image_url column successfully")
        
except Exception as e:
    print(f"⚠️ Error: {e}")
    # Try alternative approach
    try:
        from app.core.database import Base, engine
        from app.models import enhanced_models
        Base.metadata.create_all(bind=engine)
        print("✅ Database tables recreated")
    except Exception as e2:
        print(f"❌ Failed: {e2}")