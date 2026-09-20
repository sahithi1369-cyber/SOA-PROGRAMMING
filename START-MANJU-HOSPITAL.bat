@echo off
title MANJU HOSPITAL - Starting All Services...
color 0A

echo.
echo ============================================================
echo        MANJU HOSPITAL - Appointment Management System
echo        "Your Health, Our Sacred Responsibility"
echo ============================================================
echo.
echo [1/6] Starting Eureka Server...
start "EUREKA SERVER :8761" cmd /k "cd /d "%~dp0eureka-server" && mvn spring-boot:run"
ping -n 35 127.0.0.1 > nul

echo [2/6] Starting Auth Service...
start "AUTH SERVICE :8081" cmd /k "cd /d "%~dp0auth-service" && mvn spring-boot:run"
ping -n 20 127.0.0.1 > nul

echo [3/6] Starting Doctor Service...
start "DOCTOR SERVICE :8082" cmd /k "cd /d "%~dp0doctor-service" && mvn spring-boot:run"
ping -n 20 127.0.0.1 > nul

echo [4/6] Starting Billing Service...
start "BILLING SERVICE :8084" cmd /k "cd /d "%~dp0billing-service" && mvn spring-boot:run"
ping -n 20 127.0.0.1 > nul

echo [5/6] Starting Appointment Service...
start "APPOINTMENT SERVICE :8083" cmd /k "cd /d "%~dp0appointment-service" && mvn spring-boot:run"
ping -n 20 127.0.0.1 > nul

echo [6/6] Starting API Gateway...
start "API GATEWAY :8080" cmd /k "cd /d "%~dp0api-gateway" && mvn spring-boot:run"
ping -n 30 127.0.0.1 > nul

echo.
echo ============================================================
echo   ALL SERVICES STARTED!
echo   Opening Manju Hospital webpage...
echo ============================================================
echo.
start "" "http://localhost:8080"
start "" "http://localhost:8761"

echo.
echo   Manju Hospital Page  --^>  http://localhost:8080
echo   Eureka Dashboard     --^>  http://localhost:8761
echo.
echo   Press any key to close this window...
pause > nul
