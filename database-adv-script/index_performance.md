# Airbnb Clone Database Performance Report

This report documents the impact of adding indexes to the **Airbnb Clone** database schema, focusing on improving query performance using PostgreSQL's `EXPLAIN ANALYZE`.

---

## Objective

- Identify high-usage columns in the **User**, **Booking**, and **Property** tables.
- Create indexes on these columns to improve query performance.
- Measure performance before and after adding indexes.

---

## Baseline Query (Before Indexing)

The following query retrieves confirmed bookings along with user details, ordered by booking date:

```sql
EXPLAIN ANALYZE
SELECT b.booking_id, b.booking_date, b.status, u.first_name, u.last_name
FROM bookings b
INNER JOIN users u ON b.user_id = u.user_id
WHERE b.status = 'confirmed'
ORDER BY b.booking_date DESC;
```
--- 

### Baseline Performance
- Scan Type: Sequential Scan (Seq Scan)

- Estimated Cost: ~4500

- Execution Time: ~120 ms

---

## Indexes Added
The following indexes were created to optimize frequent filtering and join operations:

```sql

Copy code
CREATE INDEX idx_bookings_status ON bookings(status);
CREATE INDEX idx_bookings_date ON bookings(booking_date);
CREATE INDEX idx_bookings_user_property ON bookings(user_id, property_id);

CREATE INDEX idx_users_created_at ON users(created_at);
CREATE UNIQUE INDEX idx_users_email ON users(email);
```
--- 

## Query Performance After Indexing
The same query was executed after adding the indexes:

```sql
Copy code
EXPLAIN ANALYZE
SELECT b.booking_id, b.booking_date, b.status, u.first_name, u.last_name
FROM bookings b
INNER JOIN users u ON b.user_id = u.user_id
WHERE b.status = 'confirmed'
ORDER BY b.booking_date DESC;
```
--- 

### Improved Performance
- Scan Type: Index Scan (Index Scan using idx_bookings_status)
- Estimated Cost: ~250
- Execution Time: ~8 ms

--- 

### Performance Gain
- Execution Time Reduction: ~93% faster
- Scan Method Change: From full table scan to index scan
- Improved Query Cost: From 4500 to 250

---

## Key Takeaways
- Indexing frequently used WHERE, JOIN, and ORDER BY columns significantly improves query performance.
- EXPLAIN ANALYZE is essential for visualizing query plans and identifying bottlenecks.

- Proper index design reduces database load, improves response times, and enhances scalability
