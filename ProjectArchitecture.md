# Planning du projet FleetTrack

## 1. Structure du backend

### Architecture par domaine (Feature-Based)

```text
fleettrack-backend/
│
├── src/main/java/com/commune/fleettrack/
│   │
│   ├── FleetTrackApplication.java
│   │
│   ├── config/
│   │   ├── SecurityConfig.java
│   │   ├── JwtConfig.java
│   │   ├── CorsConfig.java
│   │   └── SwaggerConfig.java
│   │
│   ├── common/
│   │   ├── exception/
│   │   │   ├── GlobalExceptionHandler.java
│   │   │   ├── ResourceNotFoundException.java
│   │   │   └── BusinessRuleException.java
│   │   ├── dto/
│   │   │   └── ApiResponse.java
│   │   └── enums/
│   │       ├── ExpenseStatus.java
│   │       ├── VoucherStatus.java
│   │       └── Role.java
│   │
│   ├── user/
│   ├── vehicle/
│   ├── expense/
│   ├── fuelvoucher/
│   ├── justification/
│   ├── verification/
│   ├── audit/
│   ├── dashboard/
│   └── report/
│
├── src/main/resources/
│   ├── application.yml
│   ├── application-dev.yml
│   └── db/migration/
│
├── src/test/java/
├── docker-compose.yml
├── pom.xml
└── README.md

```

## 2. Base de données
### 2.1 Vue d'ensemble des relations 


```text

users
   │
   ├──< vehicle_assignments >──── vehicles
   │                                  │
   │                                  ├──< expenses
   │                                  ├──< fuel_vouchers
   │                                  └──< mileage_records
   │
   ├──< expenses (created_by)
   ├──< expenses (verified_by)
   ├──< fuel_vouchers (responsible_id)
   ├──< justifications (uploaded_by)
   └──< audit_logs (user_id)

expenses
   │
   ├──< expense_status_history
   └──< justifications

fuel_vouchers
   │
   ├──< fuel_voucher_usages
   └──< justifications