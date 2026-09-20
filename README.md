
 ╔══════════════════════════════════════════════════════════════════╗
 ║                                                                  ║
 ║    ╔╦╗╔═╗╔╗╔ ╦╦ ╦  ╦ ╦╔═╗╔═╗╔═╗╦╔╦╗╔═╗╦                        ║
 ║    ║║║╠═╣║║║ ║║ ║  ╠═╣║ ║╚═╗╠═╝║ ║ ╠═╣║                        ║
 ║    ╩ ╩╩ ╩╝╚╝╚╝╚═╝  ╩ ╩╚═╝╚═╝╩  ╩ ╩ ╩ ╩╩═╝                      ║
 ║                                                                  ║
 ║         ✚ ─────────────────────────────────── ✚                 ║
 ║         |   C A R I N G   •   H E A L I N G   |                 ║
 ║         |        •   T R U S T I N G  •        |                ║
 ║         ✚ ─────────────────────────────────── ✚                 ║
 ║                                                                  ║
 ║              🏥  MANJU HOSPITAL  🏥                              ║
 ║         "Your Health, Our Sacred Responsibility"                 ║
 ║                                                                  ║
 ╚══════════════════════════════════════════════════════════════════╝

# 🏥 MANJU HOSPITAL — Appointment Management System

> **"Your Health, Our Sacred Responsibility"**
> Caring • Healing • Trusting

---

## 🌟 About Manju Hospital

**Manju Hospital** is a modern, patient-first healthcare institution committed to delivering
compassionate and world-class medical care. Our digital appointment system ensures every
patient gets the right doctor, at the right time, with zero hassle.

---

## 🏗️ System Architecture

```
                    ┌─────────────────────────────────┐
                    │       🏥 MANJU HOSPITAL          │
                    │   Appointment Management System  │
                    └────────────┬────────────────────┘
                                 │
                    ┌────────────▼────────────┐
                    │   🔐 Auth Service        │  :8081
                    │   JWT Token Issuer       │
                    └────────────┬────────────┘
                                 │
                    ┌────────────▼────────────┐
                    │   🌐 API Gateway         │  :8080
                    │   JWT Validator + Router │
                    └──┬──────────┬───────┬───┘
                       │          │       │
           ┌───────────▼─┐  ┌─────▼──┐  ┌▼──────────┐
           │ 👨‍⚕️ Doctor   │  │ 📅 Appt │  │ 💳 Billing│
           │  Service    │  │ Service │  │  Service  │
           │   :8082     │  │  :8083  │  │   :8084   │
           └─────────────┘  └────┬────┘  └───────────┘
                                 │  inter-service calls
                    ┌────────────▼────────────┐
                    │   📡 Eureka Server       │  :8761
                    │   Service Discovery      │
                    └─────────────────────────┘
```

---

## 🚀 Services & Ports

| Service                  | Port | Description                          |
|--------------------------|------|--------------------------------------|
| 📡 Eureka Server         | 8761 | Service Registry & Discovery         |
| 🌐 API Gateway           | 8080 | Single Entry Point + JWT Validation  |
| 🔐 Auth Service          | 8081 | Login & JWT Token Generation         |
| 👨‍⚕️ Doctor Service       | 8082 | Doctor CRUD & Availability           |
| 📅 Appointment Service   | 8083 | Booking & Schedule Management        |
| 💳 Billing Service       | 8084 | Bill Generation & Payment Tracking   |

---

## ▶️ Startup Order

```bash
# 1. Start Eureka Server (Service Registry)
cd eureka-server && mvn spring-boot:run

# 2. Start Auth Service
cd auth-service && mvn spring-boot:run

# 3. Start Doctor Service
cd doctor-service && mvn spring-boot:run

# 4. Start Billing Service
cd billing-service && mvn spring-boot:run

# 5. Start Appointment Service
cd appointment-service && mvn spring-boot:run

# 6. Start API Gateway (last)
cd api-gateway && mvn spring-boot:run
```

---

## 📋 API Usage

### 🔐 Step 1 — Get JWT Token
```http
POST http://localhost:8080/api/auth/login
Content-Type: application/json

{ "username": "admin", "password": "admin123" }
```
Response:
```json
{ "token": "eyJhbGciOiJIUzI1NiJ9..." }
```

---

### 👨‍⚕️ Step 2 — Register a Doctor
```http
POST http://localhost:8080/api/doctors
Authorization: Bearer <token>
Content-Type: application/json

{
  "name": "Dr. Ravi Kumar",
  "specialization": "Cardiology",
  "availability": true
}
```

---

### 📅 Step 3 — Book an Appointment
```http
POST http://localhost:8080/api/appointments
Authorization: Bearer <token>
Content-Type: application/json

{
  "patientId": 1,
  "doctorId": 1,
  "date": "2024-12-01T10:00:00"
}
```
> ⚡ This automatically: checks doctor availability → saves appointment → marks doctor busy → generates bill

---

### ✅ Step 4 — Complete an Appointment
```http
PATCH http://localhost:8080/api/appointments/1/status?status=COMPLETED
Authorization: Bearer <token>
```
> ⚡ This automatically frees the doctor's availability

---

### 💳 Step 5 — View Bill
```http
GET http://localhost:8080/api/bills/appointment/1
Authorization: Bearer <token>
```

---

### 💰 Step 6 — Pay Bill
```http
PATCH http://localhost:8080/api/bills/1/payment?status=PAID
Authorization: Bearer <token>
```

---

## 🔄 Inter-Service Communication Flow

```
Patient books appointment
        │
        ▼
Appointment Service
        ├──► Doctor Service    (Is doctor available?)
        ├──► Save Appointment
        ├──► Doctor Service    (Mark doctor as BUSY)
        └──► Billing Service   (Generate ₹500 bill)
```

---

## 🧪 Running Tests

```bash
# Unit Tests — Doctor Service
cd doctor-service && mvn test

# Unit Tests — Appointment Service
cd appointment-service && mvn test

# Unit Tests — Billing Service
cd billing-service && mvn test
```

---

## 🗄️ H2 In-Memory Databases (Dev Only)

| Service     | Console URL                        | JDBC URL                    |
|-------------|------------------------------------|-----------------------------|
| Doctor      | http://localhost:8082/h2-console   | jdbc:h2:mem:doctordb        |
| Appointment | http://localhost:8083/h2-console   | jdbc:h2:mem:appointmentdb   |
| Billing     | http://localhost:8084/h2-console   | jdbc:h2:mem:billingdb       |

---

## 🏥 Manju Hospital — Core Values

```
  ❤️  Compassion   — Every patient is treated with dignity and care
  🔬  Excellence   — World-class medical expertise at your service
  🤝  Trust        — Transparent, honest, and reliable healthcare
  ⚡  Speed        — Quick appointments, zero waiting hassle
  🔒  Privacy      — Your health data is always secure
```

---

*© 2024 Manju Hospital. All Rights Reserved.*
*"Your Health, Our Sacred Responsibility"*
