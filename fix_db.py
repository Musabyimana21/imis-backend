import sys
sys.path.append('backend')

from backend.app.core.database import engine, Base
Base.metadata.create_all(bind=engine)
print("Database updated")