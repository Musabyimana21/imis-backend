@echo off
echo ========================================
echo Testing Payment Service for Timeouts
echo ========================================

cd /d "%~dp0"

echo.
echo 1. Testing MTN Payment Service...
python -c "
import sys
sys.path.append('backend')
from backend.app.services.mtn_payment_optimized import MTNPaymentService
import time

print('Creating MTN service...')
service = MTNPaymentService()

print('Testing payment initiation...')
start_time = time.time()
result = service.initiate_payment('250788123456', 1000, 'TEST123')
end_time = time.time()

print(f'Payment result: {result}')
print(f'Time taken: {end_time - start_time:.2f} seconds')

if end_time - start_time > 5:
    print('WARNING: Payment took too long!')
else:
    print('SUCCESS: Payment completed quickly')
"

echo.
echo 2. Testing Payment Status Check...
python -c "
import sys
sys.path.append('backend')
from backend.app.services.mtn_payment_optimized import MTNPaymentService
import time

service = MTNPaymentService()

print('Testing status check...')
start_time = time.time()
result = service.check_payment_status('TEST123')
end_time = time.time()

print(f'Status result: {result}')
print(f'Time taken: {end_time - start_time:.2f} seconds')

if end_time - start_time > 3:
    print('WARNING: Status check took too long!')
else:
    print('SUCCESS: Status check completed quickly')
"

echo.
echo ========================================
echo Payment Timeout Test Complete
echo ========================================
pause