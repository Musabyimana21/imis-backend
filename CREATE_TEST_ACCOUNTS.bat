@echo off
echo Creating test accounts...
echo.

docker-compose exec -T backend python -c "
from app.core.database import SessionLocal
from app.models.models import User, UserRole
from app.core.security import get_password_hash

db = SessionLocal()

# Admin
admin = User(email='admin@imis.rw', hashed_password=get_password_hash('admin123'), full_name='Admin User', phone='+250788000000', role=UserRole.ADMIN)
db.add(admin)

# Loser
loser = User(email='loser@imis.rw', hashed_password=get_password_hash('lost123'), full_name='Jean Mugabo', phone='+250788111111', role=UserRole.USER)
db.add(loser)

# Finder
finder = User(email='finder@imis.rw', hashed_password=get_password_hash('found123'), full_name='Marie Uwase', phone='+250788222222', role=UserRole.USER)
db.add(finder)

# Regular users
for i in range(1, 6):
    user = User(email=f'user{i}@imis.rw', hashed_password=get_password_hash('password123'), full_name=f'User {i}', phone=f'+25078800{i:04d}', role=UserRole.USER)
    db.add(user)

db.commit()
print('✅ Test accounts created!')
"

echo.
echo ╔══════════════════════════════════════════════════════════╗
echo ║              TEST ACCOUNTS READY!                        ║
echo ╚══════════════════════════════════════════════════════════╝
echo.
echo 🔐 Admin:
echo    Email: admin@imis.rw
echo    Pass:  admin123
echo.
echo 😢 Item Loser:
echo    Email: loser@imis.rw
echo    Pass:  lost123
echo    Name:  Jean Mugabo
echo.
echo 🎉 Item Finder:
echo    Email: finder@imis.rw
echo    Pass:  found123
echo    Name:  Marie Uwase
echo.
echo 👤 Regular Users:
echo    Email: user1@imis.rw to user5@imis.rw
echo    Pass:  password123
echo.
echo 🌐 Login at: http://localhost:5173/login
echo.
pause
