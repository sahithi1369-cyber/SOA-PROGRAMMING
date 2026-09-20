@echo off
title MANJU HOSPITAL - Starting Services
color 0A

echo ============================================================
echo         MANJU HOSPITAL - Starting All Services
echo ============================================================
echo.

echo [1/5] Starting Eureka Server on port 8761...
start "EUREKA SERVER :8761" /MIN cmd /k "title EUREKA :8761 && java -jar "c:\Users\sahit\OneDrive\Documents\SOA PROGRAMMING\hospital-management\eureka-server\target\eureka-server-1.0.0.jar""

echo Waiting 40 seconds for Eureka to be ready...
ping -n 41 127.0.0.1 > nul

echo [2/5] Starting Auth Service on port 8081...
start "AUTH SERVICE :8081" /MIN cmd /k "title AUTH :8081 && java -jar "c:\Users\sahit\OneDrive\Documents\SOA PROGRAMMING\hospital-management\auth-service\target\auth-service-1.0.0.jar""
ping -n 21 127.0.0.1 > nul

echo [3/5] Starting Doctor Service on port 8082...
start "DOCTOR SERVICE :8082" /MIN cmd /k "title DOCTOR :8082 && java -jar "c:\Users\sahit\OneDrive\Documents\SOA PROGRAMMING\hospital-management\doctor-service\target\doctor-service-1.0.0.jar""
ping -n 21 127.0.0.1 > nul

echo [4/5] Starting Billing Service on port 8084...
start "BILLING SERVICE :8084" /MIN cmd /k "title BILLING :8084 && java -jar "c:\Users\sahit\OneDrive\Documents\SOA PROGRAMMING\hospital-management\billing-service\target\billing-service-1.0.0.jar""
ping -n 21 127.0.0.1 > nul

echo [5/5] Starting Appointment Service on port 8083...
start "APPOINTMENT SERVICE :8083" /MIN cmd /k "title APPOINTMENT :8083 && java -jar "c:\Users\sahit\OneDrive\Documents\SOA PROGRAMMING\hospital-management\appointment-service\target\appointment-service-1.0.0.jar""
ping -n 21 127.0.0.1 > nul

echo Starting API Gateway on port 8080...
start "API GATEWAY :8080" /MIN cmd /k "title GATEWAY :8080 && java -jar "c:\Users\sahit\OneDrive\Documents\SOA PROGRAMMING\hospital-management\api-gateway\target\api-gateway-1.0.0.jar""
ping -n 35 127.0.0.1 > nul

echo.
echo ============================================================
echo   ALL SERVICES STARTED!
echo   Opening Manju Hospital...
echo ============================================================
start "" "http://localhost:8080"
start "" "http://localhost:8761"
echo.
echo Keep this window open!
pause
