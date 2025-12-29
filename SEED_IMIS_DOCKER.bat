@echo off
title Seed IMIS Docker Database
color 0B

echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║                  SEED IMIS DOCKER DATABASE                  ║
echo ║              Add Test Data to IMIS Containers               ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.

echo [1/3] Checking if IMIS containers are running...
docker ps --filter "name=imis-api" --format "{{.Names}}" | findstr "imis-api" >nul
if %errorlevel% neq 0 (
    echo ❌ IMIS containers not running! Start them first with START_IMIS_DOCKER.bat
    pause
    exit /b 1
)
echo ✅ IMIS containers are running

echo.
echo [2/3] Seeding database with test data...
docker exec imis-api python -c "
import sys
sys.path.append('.')
try:
    from app.core.database import engine, SessionLocal
    from app.models.enhanced_models import User, Item, Message, Payment
    from app.core.security import get_password_hash
    from sqlalchemy.orm import Session
    from datetime import datetime
    import uuid

    db = SessionLocal()
    
    # Create admin user
    admin = User(
        id=str(uuid.uuid4()),
        email='admin@imis.rw',
        hashed_password=get_password_hash('admin123'),
        full_name='IMIS Administrator',
        phone_number='+250780460621',
        is_active=True,
        role='admin',
        created_at=datetime.utcnow()
    )
    
    # Create test users
    loser = User(
        id=str(uuid.uuid4()),
        email='loser@imis.rw',
        hashed_password=get_password_hash('lost123'),
        full_name='Jean Mugabo',
        phone_number='+250781234567',
        is_active=True,
        role='user',
        created_at=datetime.utcnow()
    )
    
    finder = User(
        id=str(uuid.uuid4()),
        email='finder@imis.rw',
        hashed_password=get_password_hash('found123'),
        full_name='Marie Uwase',
        phone_number='+250782345678',
        is_active=True,
        role='user',
        created_at=datetime.utcnow()
    )
    
    # Add users
    db.merge(admin)
    db.merge(loser)
    db.merge(finder)
    db.commit()
    
    # Create test items
    lost_item = Item(
        id=str(uuid.uuid4()),
        title='Lost Black iPhone 13',
        description='Lost my black iPhone 13 near Kimisagara Market. Has a blue case.',
        category='Electronics',
        item_type='lost',
        location='Kimisagara Market, Kigali',
        latitude=-1.9441,
        longitude=30.0619,
        contact_info='jean.mugabo@email.com',
        user_id=loser.id,
        status='active',
        created_at=datetime.utcnow()
    )
    
    found_item = Item(
        id=str(uuid.uuid4()),
        title='Found Black iPhone',
        description='Found a black iPhone near Kimisagara. Has some scratches but works fine.',
        category='Electronics',
        item_type='found',
        location='Near Kimisagara Market',
        latitude=-1.9445,
        longitude=30.0615,
        contact_info='marie.uwase@email.com',
        user_id=finder.id,
        status='active',
        created_at=datetime.utcnow()
    )
    
    # Add items
    db.add(lost_item)
    db.add(found_item)
    db.commit()
    
    print('✅ Database seeded successfully!')
    print('👨💼 Admin: admin@imis.rw / admin123')
    print('😢 Loser: loser@imis.rw / lost123')
    print('😊 Finder: finder@imis.rw / found123')
    
    db.close()
    
except Exception as e:
    print(f'❌ Seeding failed: {e}')
    import traceback
    traceback.print_exc()
"

echo.
echo [3/3] Verifying seed data...
timeout /t 2 /nobreak >nul
curl -s http://localhost:8000/api/items | findstr "iPhone" >nul
if %errorlevel% equ 0 (
    echo ✅ Test data verified successfully!
) else (
    echo ⚠️ Could not verify test data, but seeding completed
)

echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║                    SEEDING COMPLETE                         ║
echo ╠══════════════════════════════════════════════════════════════╣
echo ║  🌐 Test IMIS: http://localhost:5173                        ║
echo ║  👨💼 Admin:    admin@imis.rw / admin123                      ║
echo ║  😢 Loser:    loser@imis.rw / lost123                       ║
echo ║  😊 Finder:   finder@imis.rw / found123                     ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.
pause