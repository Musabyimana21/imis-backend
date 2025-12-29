@echo off
echo Starting IMIS Frontend on IP 192.168.61.61...
cd /d "t:\IMIS\frontend"

echo Installing dependencies...
npm install

echo Starting frontend server on 192.168.61.61:5173...
npm run dev -- --host 192.168.61.61 --port 5173

pause