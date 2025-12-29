@echo off
echo ========================================
echo IMIS COMPLETE RESTART AND FIX
echo ========================================
echo.

echo [1/6] Killing all existing processes...
taskkill /F /IM python.exe /T 2>nul
taskkill /F /IM node.exe /T 2>nul
taskkill /F /IM uvicorn.exe /T 2>nul
timeout /t 3 /nobreak >nul

echo [2/6] Fixing backend CORS configuration...
cd /d "%~dp0backend"

echo [3/6] Creating fixed main.py...
(
echo from fastapi import FastAPI
echo from fastapi.middleware.cors import CORSMiddleware
echo from .core.database import engine, Base
echo from .api import ^(
echo     auth, items, messages, admin, anonymous,
echo     enhanced_items, enhanced_messages, enhanced_admin, payments
echo ^)
echo.
echo app = FastAPI^(
echo     title="IMIS API - Complete System",
echo     description="Ishakiro Information Management System - Complete Lost & Found Platform for Rwanda",
echo     version="3.0.0",
echo     docs_url="/docs",
echo     redoc_url="/redoc"
echo ^)
echo.
echo # CORS configuration - Allow all origins
echo app.add_middleware^(
echo     CORSMiddleware,
echo     allow_origins=["*"],
echo     allow_credentials=False,
echo     allow_methods=["*"],
echo     allow_headers=["*"],
echo ^)
echo.
echo @app.on_event^("startup"^)
echo async def startup^(^):
echo     from .models import enhanced_models
echo     try:
echo         Base.metadata.create_all^(bind=engine^)
echo     except Exception as e:
echo         if "already exists" in str^(e^):
echo             print^(f"Database objects already exist: {e}"^)
echo         else:
echo             raise e
echo.
echo # Include all routers
echo app.include_router^(anonymous.router, prefix="/api"^)
echo app.include_router^(auth.router, prefix="/api"^)
echo app.include_router^(enhanced_items.router, prefix="/api"^)
echo app.include_router^(enhanced_messages.router, prefix="/api"^)
echo app.include_router^(payments.router, prefix="/api"^)
echo app.include_router^(enhanced_admin.router, prefix="/api"^)
echo app.include_router^(items.router, prefix="/legacy"^)
echo app.include_router^(messages.router, prefix="/legacy"^)
echo app.include_router^(admin.router, prefix="/legacy"^)
echo.
echo @app.get^("/"^)
echo def root^(^):
echo     return {"message": "IMIS API Running", "version": "3.0.0"}
echo.
echo @app.get^("/health"^)
echo def health^(^):
echo     return {"status": "healthy", "database": "connected"}
) > app\main.py

echo [4/6] Fixing frontend environment...
cd /d "%~dp0frontend"
echo PUBLIC_API_URL=http://192.168.61.61:8001 > .env

echo [5/6] Starting backend on all interfaces...
cd /d "%~dp0backend"
start "IMIS Backend" cmd /k "python -m uvicorn app.main:app --host 0.0.0.0 --port 8001 --reload"

echo [6/6] Starting frontend on all interfaces...
cd /d "%~dp0frontend"
start "IMIS Frontend" cmd /k "npm run dev -- --host 0.0.0.0"

echo.
echo ========================================
echo RESTART COMPLETE!
echo ========================================
echo.
echo Backend: http://192.168.61.61:8001
echo Frontend: http://192.168.61.61:5173
echo API Docs: http://192.168.61.61:8001/docs
echo.
echo Wait 30 seconds for services to start...
echo Then test: http://192.168.61.61:5173/report-lost
echo.
pause