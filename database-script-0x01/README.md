
# Airbnb Clone Database Schema

## Overview
This repository contains the database schema for an Airbnb Clone project built on **PostgreSQL**. The schema is designed to support key functionalities of the platform, including user management, property listings, bookings, payments, reviews, and messaging.

## Entities and Attributes
The schema includes the following main entities:

### 1. Users
- **user_id**: Primary key (UUID)
- **first_name**, **last_name**: Required fields
- **email**: Unique identifier for each user
- **password_hash**: Securely stored password
- **phone_number**: Optional
- **role**: ENUM (guest, host, admin)
- **created_at**: Timestamp of user creation

### 2. Properties
- **property_id**: Primary key (UUID)
- **host_id**: Foreign key → Users(user_id)
- **name**, **description**, **location**: Property details
- **price_per_night**: Decimal value
- **created_at**, **updated_at**: Timestamps for tracking

### 3. Bookings
- **booking_id**: Primary key (UUID)
- **property_id**: Foreign key → Properties(property_id)
- **user_id**: Foreign key → Users(user_id)
- **start_date**, **end_date**: Booking period
- **total_price**: Total booking cost
- **status**: ENUM (pending, confirmed, canceled)
- **created_at**: Booking creation timestamp

### 4. Payments
- **payment_id**: Primary key (UUID)
- **booking_id**: Foreign key → Bookings(booking_id)
- **amount**: Decimal
- **payment_date**: Timestamp
- **payment_method**: ENUM (credit_card, paypal, stripe)

### 5. Reviews
- **review_id**: Primary key (UUID)
- **property_id**: Foreign key → Properties(property_id)
- **user_id**: Foreign key → Users(user_id)
- **rating**: Integer (1–5)
- **comment**: Review text
- **created_at**: Timestamp

### 6. Messages
- **message_id**: Primary key (UUID)
- **sender_id**: Foreign key → Users(user_id)
- **recipient_id**: Foreign key → Users(user_id)
- **message_body**: Message content
- **sent_at**: Timestamp

## Relationships
- A **User** can be a guest, host, or admin.
- A **Host (User)** can have multiple **Properties**.
- A **Property** can have many **Bookings**.
- A **Booking** can have one **Payment**.
- A **User** can write multiple **Reviews** for different **Properties**.
- A **User** can send multiple **Messages** to other users.

## Normalization
The schema adheres to **Third Normal Form (3NF)**:
- No redundant data across tables.
- Each table has a primary key.
- Non-key attributes depend only on the primary key.

## How to Use

### 1. Clone the Repository
```bash
git clone https://github.com/yourusername/airbnb-clone-database.git
cd airbnb-clone-database
```

### 2. Set Up PostgreSQL
Ensure you have PostgreSQL installed and running:
```bash
sudo service postgresql start
```

### 3. Create the Database
```bash
psql -U your_user -c "CREATE DATABASE airbnb_clone;"
```

### 4. Run the Schema
```bash
psql -U your_user -d airbnb_clone -f schema_postgresql.sql
```

This will create all tables, constraints, and indexes.

## Indexing
- Primary keys are indexed automatically.
- Additional indexes:
  - **Users.email**
  - **Properties.property_id**
  - **Bookings.booking_id**
  - **Bookings.property_id**
  - **Payments.booking_id**

## Future Enhancements
- Add triggers for booking availability validation.
- Implement cascading deletes for properties and bookings.
- Add support for multi-currency payments.
