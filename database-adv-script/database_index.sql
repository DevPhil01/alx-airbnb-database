-- ==========================================
-- Airbnb Clone: Create Indexes & Performance Analysis
-- ==========================================

-- ==========================================
-- Baseline Query Performance (Before Indexes)
-- ==========================================
EXPLAIN ANALYZE
SELECT b.booking_id, b.booking_date, b.status, u.first_name, u.last_name
FROM bookings b
INNER JOIN users u ON b.user_id = u.user_id
WHERE b.status = 'confirmed'
ORDER BY b.booking_date DESC;

-- ==========================================
-- Create Indexes on High-Usage Columns
-- ==========================================

-- Index on bookings table for filtering and ordering
CREATE INDEX idx_bookings_status ON bookings(status);
CREATE INDEX idx_bookings_date ON bookings(booking_date);
CREATE INDEX idx_bookings_user_property ON bookings(user_id, property_id);

-- Index on users table for JOIN and unique identification
CREATE INDEX idx_users_created_at ON users(created_at);
CREATE UNIQUE INDEX idx_users_email ON users(email);

-- You may also add indexes for properties if frequently queried
-- CREATE INDEX idx_properties_location ON properties(location);

-- ==========================================
-- Analyze Query Performance After Indexing
-- ==========================================
EXPLAIN ANALYZE
SELECT b.booking_id, b.booking_date, b.status, u.first_name, u.last_name
FROM bookings b
INNER JOIN users u ON b.user_id = u.user_id
WHERE b.status = 'confirmed'
ORDER BY b.booking_date DESC;

-- Expected Improvements:
-- - Change from Seq Scan to Index Scan
-- - Lower query cost
-- - Faster execution time
