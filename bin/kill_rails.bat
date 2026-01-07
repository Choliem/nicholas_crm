@echo off
REM Batch script to kill any Ruby/Rails processes on port 3000
REM Usage: bin\kill_rails.bat

echo Checking for processes using port 3000...

for /f "tokens=5" %%a in ('netstat -ano ^| findstr :3000') do (
    echo Killing process using port 3000 (PID: %%a^)
    taskkill /F /PID %%a >nul 2>&1
)

echo.
echo Done! Port 3000 should now be available.
echo You can now run: rails s
pause
