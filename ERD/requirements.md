
# DATABASE DESIGN OVERVIEW
  The database schema is is designed to support the key functionalities of the Airbnb Clone project. Below are the core entities, their essential fields, and how they relate to each other:

## 1. User
    Stores account information for all users, including guests, hosts, and admins.

  **Important Fields:** 

  * **user_id (UUID, Primary Key, Indexed) –** Unique identifier for each user.
      
  * **first_name, last_name (VARCHAR, NOT NULL) –** User's full name.
      
  * **email (UNIQUE, NOT NULL) –** Used for login and identification.
      
  * **password_hash (NOT NULL) –** Securely hashed password.
      
  * **role (ENUM: guest, host, admin) –** Defines the user’s role in the system.
      
  * **created_at (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP) –** Account creation date.

  **Relationships:**

  * A user (host) can own multiple properties.
    
  * A user (guest) can make multiple bookings.
    
  * A user can send and receive messages, write reviews, and make payments for bookings.
  

## 2. Property

Represents the listings created by hosts.

**Important Fields:** 

* **property_id (UUID, Primary Key, Indexed) –** Unique identifier for the property.

* **host_id (Foreign Key → User.user_id)–** The host who owns the property.

* **name (VARCHAR, NOT NULL) –** Property title.

* **description (TEXT, NOT NULL) –** Property details.

* **location (VARCHAR, NOT NULL) –** Property address or area.

* **price_per_night (DECIMAL, NOT NULL) –** Nightly rate.

* **created_at and updated_at (TIMESTAMP) –** Track creation and updates.

**Relationships:**

* A property belongs to one host (user).

* A property can have multiple bookings and reviews.

## 3. Booking

Manages reservations between guests and properties.

**Important Fields:**

* **booking_id (UUID, Primary Key, Indexed) –**  Unique identifier for each booking.

* **property_id (Foreign Key → Property.property_id) –**  Booked property.

* **user_id (Foreign Key → User.user_id) –**  Guest who booked the property.

* **start_date, end_date (DATE, NOT NULL) –**  Booking period.

* **total_price (DECIMAL, NOT NULL) –**  Total booking cost.

* **status (ENUM: pending, confirmed, canceled) –** Booking status.

* **created_at (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP) –**  Booking creation time.

**Relationships:** 

* A booking belongs to a user (guest) and a property.

* A booking can have one or more payments.


## 4. Payment

Handles financial transactions for bookings.

**Important Fields:**

* **payment_id (UUID, Primary Key, Indexed) –** Unique payment identifier.

* **booking_id (Foreign Key → Booking.booking_id) –**  Associated booking.

* **amount (DECIMAL, NOT NULL) –**  Payment amount.

* **payment_method (ENUM: credit_card, paypal, stripe) –**  Payment method.

* **payment_date (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP) –** Payment timestamp.

**Relationships:**

* A payment belongs to one booking.

## 5. Review

Captures guest feedback on properties.

**Important Fields:**

* **review_id (UUID, Primary Key, Indexed) –** Unique identifier for the review.

* **property_id (Foreign Key → Property.property_id) –** Reviewed property.

* **user_id (Foreign Key → User.user_id) –**  Guest who wrote the review.

* **rating (INTEGER, CHECK 1–5) –** Rating score.

* **comment (TEXT, NOT NULL) –** Review message.

* **created_at (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP) –** Review creation date.

**Relationships:**

* A review belongs to a property and is written by a guest (user).

## 6. Message

Enables communication between guests and hosts.

**Important Fields:**

* **message_id (UUID, Primary Key, Indexed) –** Unique identifier for the message.

* **sender_id (Foreign Key → User.user_id) –**  User sending the message.

* **recipient_id (Foreign Key → User.user_id) –**  User receiving the message.

* **message_body (TEXT, NOT NULL)** – Message content.

* **sent_at (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP) –** Timestamp of message.

**Relationships:**

* A message is sent from one user to another user.

## Key Constraints & Indexing

* Unique: User emails must be unique.

* Foreign Keys: Enforce referential integrity between users, properties, bookings, payments, reviews, and messages.

* Indexes: Primary keys are indexed by default. Additional indexes include:

  * email in User.

  * property_id in Property and Booking.

  * booking_id in Booking and Payment.
 
## ERD Diagram
 ![Untitled diagram _ Mermaid Chart-2025-08-29-092331](https://github.com/user-attachments/assets/dc785f3e-d854-4506-beb4-1c6852ae3947)
<svg id="export-svg" width="100%" xmlns="http://www.w3.org/2000/svg" class="erDiagram" style="max-width: 1392.70703125px;" viewBox="0 0 1392.70703125 1630.75" role="graphics-document document" aria-roledescription="er"><style xmlns="http://www.w3.org/1999/xhtml">/* Google Inc.



