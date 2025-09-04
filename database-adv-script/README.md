# PostgreSQL Join Queries

## Overview
This project contains sample SQL queries demonstrating different types of joins in PostgreSQL, based on the Airbnb Clone dataset.  
The queries are useful for practicing **INNER JOIN**, **LEFT JOIN**, and **FULL OUTER JOIN** operations.

## Queries Included
1. **INNER JOIN**  
   Retrieves all bookings along with the respective users who made those bookings.

2. **LEFT JOIN**  
   Retrieves all properties and their reviews, including properties that do not have any reviews.

3. **FULL OUTER JOIN**  
   Retrieves all users and all bookings, even if a user has no booking or a booking is not linked to a user.

## How to Use
1. Ensure you have a PostgreSQL database set up with the relevant tables (`users`, `properties`, `reviews`, `bookings`).  
2. Download and open the `joins_queries.sql` file.  
3. Run the queries in your PostgreSQL environment (e.g., **psql**, **PgAdmin**, or any PostgreSQL client).  

## File Structure
- `joins_queries.sql` – Contains the SQL queries.

## Compatibility
- Tested on **PostgreSQL 13+**.
- Should work with any PostgreSQL-supported version with standard SQL join operations.

# PostgreSQL Subqueries – Airbnb Clone Backend

This repository contains advanced SQL queries designed for the **Airbnb Clone backend project**, focusing on the use of **correlated** and **non-correlated subqueries** in PostgreSQL.

---

## Overview

Subqueries are powerful SQL tools that allow you to nest one query inside another.  
This file demonstrates:
- **Non-correlated subquery**: Independent of the outer query, executed once.
- **Correlated subquery**: Dependent on the outer query, executed repeatedly for each row.

These queries interact with the following database tables:
- **users** – Stores user profiles (guests and hosts)
- **properties** – Contains property listings
- **reviews** – Stores user reviews with ratings
- **bookings** – Stores user bookings

---

## Queries Included

### 1. Non-Correlated Subquery – Properties with High Average Ratings

This query retrieves all properties with an **average review rating greater than 4.0**.

```sql
SELECT p.property_id, p.name, p.location
FROM properties p
WHERE p.property_id IN (
    SELECT r.property_id
    FROM reviews r
    GROUP BY r.property_id
    HAVING AVG(r.rating) > 4.0
);
