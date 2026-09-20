@echo off
title MANJU HOSPITAL - Stopping All Services...
color 0C

echo.
echo ============================================================
echo        MANJU HOSPITAL - Stopping All Services...
echo ============================================================
echo.

echo Stopping all services on ports 8080 8081 8082 8083 8084 8761...

for %%P in (8080 8081 8082 8083 8084 8761) do (
    for /f "tokens=5" %%a in ('netstat -aon ^| find ":%%P " ^| find "LISTENING"') do (
        echo Killing process on port %%P with PID %%a
        taskkill /PID %%a /F > nul 2>&1
    )
)

echo.
echo All Manju Hospital services stopped!
echo Press any key to close...
pause > nul
