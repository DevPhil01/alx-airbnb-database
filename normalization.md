# Normalization Steps to 3NF

## Step 1: First Normal Form (1NF)

A table is in 1NF if:

* Each cell contains a single value (atomicity).

* Each record is unique.

**Check:**

* All your tables use atomic fields (e.g., first_name, pricepernight, status).

* Primary keys are defined (UUIDs).

* No repeating groups.

**Action:**
No changes required. Schema already satisfies 1NF.

## Step 2: Second Normal Form (2NF)

A table is in 2NF if:

* It is in 1NF.

* All non-key attributes are fully dependent on the whole primary key (no partial dependency).

**Check:**

* All tables have a single-column primary key (UUID).

* No non-key attribute depends on only part of a composite key (since no composite keys exist).

**Action:** 
No changes required. Schema already satisfies 2NF.

## Step 3: Third Normal Form (3NF)

A table is in 3NF if:

* It is in 2NF.

There are no transitive dependencies (non-key attributes must not depend on other non-key attributes).

**Check & Adjustments:**

* User Table: No transitive dependencies (e.g., email, name, phone, and role all directly depend on user_id).

* Property Table: Attributes like pricepernight, location, name depend directly on property_id. No transitive dependency.

* Booking Table: total_price might be a derived field ((end_date - start_date) * pricepernight), but storing it is acceptable for performance reasons. If strict 3NF is enforced, remove total_price and compute it dynamically.

* Payment Table: All fields depend on payment_id. No issues.

* Review Table: Attributes depend directly on review_id. No issues.

* Message Table: Attributes depend on message_id. No issues.

**Action:**

Optional: Remove total_price from Booking table for strict 3NF compliance.

Otherwise, schema already adheres closely to 3NF.

## Final Notes

The schema already follows good normalization practices.

Storing total_price is a controlled denormalization for efficiency, not a violation unless strict 3NF is required.

Relationships are well-defined via foreign keys.

