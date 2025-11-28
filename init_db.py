#!/usr/bin/env python3
"""
Robust database initialization script
"""
import sys
import os
sys.path.append(os.path.dirname(os.path.abspath(__file__)))

def init_database():
    """Initialize database tables with error handling"""
    print("Initializing database...")
    
    try:
        # Import with error handling
        from app.core.database import engine, Base
        print("Database engine loaded")
        
        # Import models
        from app.models import enhanced_models
        print("Models loaded")
        
        # Test connection first
        print("Testing database connection...")
        from sqlalchemy import text
        with engine.connect() as conn:
            result = conn.execute(text("SELECT 1"))
            print("Database connection successful!")
        
        # Create all tables
        print("Creating database tables...")
        Base.metadata.create_all(bind=engine)
        print("Database tables created successfully!")
        
        return True
        
    except ImportError as e:
        print(f"Import error: {e}")
        print("Try: pip install sqlalchemy psycopg2-binary")
        return False
    except Exception as e:
        error_msg = str(e).lower()
        if "password authentication failed" in error_msg:
            print(f"Database password error: {e}")
            print("Run: RESET_PG18_PASSWORD.bat")
        elif "connection refused" in error_msg:
            print(f"Database connection refused: {e}")
            print("Check if PostgreSQL is running")
        elif "database" in error_msg and "does not exist" in error_msg:
            print(f"Database does not exist: {e}")
            print("Create database 'imis' first")
        else:
            print(f"Database error: {e}")
        return False

if __name__ == "__main__":
    success = init_database()
    if success:
        print("\nDatabase is ready!")
        sys.exit(0)
    else:
        print("\nDatabase initialization failed!")
        sys.exit(1)