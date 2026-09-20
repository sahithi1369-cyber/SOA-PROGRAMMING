@echo off
echo Starting Manju Hospital Webpage...
cd /d "c:\Users\sahit\OneDrive\Documents\SOA PROGRAMMING\hospital-management\api-gateway\src\main\resources\static"
start "" "http://localhost:3000"
python -m http.server 3000
