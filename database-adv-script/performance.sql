-- ==========================================
-- PERFORMANCE OPTIMIZATION SCRIPT FOR AIRBNB CLONE BACKEND
-- ==========================================
-- This script contains:
-- 1. Initial complex query
-- 2. Performance analysis using EXPLAIN ANALYZE
-- 3. Index creation for optimization
-- 4. Optimized query version

-- ==========================================
-- INITIAL COMPLEX QUERY
-- ==========================================
EXPLAIN ANALYZE
SELECT 
    b.booking_id,
    b.booking_date,
    b.status,
    u.user_id,
    u.first_name,
    u.last_name,
    p.property_id,
    p.property_name,
    p.location,
    pay.payment_id,
    pay.amount,
    pay.payment_status
FROM bookings b
INNER JOIN users u ON b.user_id = u.user_id
INNER JOIN properties p ON b.property_id = p.property_id
LEFT JOIN payments pay ON b.booking_id = pay.booking_id
ORDER BY b.booking_date DESC;

-- ==========================================
-- PERFORMANCE ANALYSIS
-- ==========================================
-- Run the above EXPLAIN ANALYZE query to identify:
-- - Sequential scans on large tables
-- - Missing indexes on JOIN or ORDER BY columns
-- - High cost estimates (cost=...) and execution time

-- ==========================================
-- INDEX CREATION FOR OPTIMIZATION
-- ==========================================
-- Create indexes to speed up JOIN and ORDER BY operations
CREATE INDEX IF NOT EXISTS idx_bookings_user_id ON bookings(user_id);
CREATE INDEX IF NOT EXISTS idx_bookings_property_id ON bookings(property_id);
CREATE INDEX IF NOT EXISTS idx_bookings_date ON bookings(booking_date);

CREATE INDEX IF NOT EXISTS idx_users_id ON users(user_id);
CREATE INDEX IF NOT EXISTS idx_properties_id ON properties(property_id);
CREATE INDEX IF NOT EXISTS idx_payments_booking_id ON payments(booking_id);

-- ==========================================
-- OPTIMIZED COMPLEX QUERY
-- ==========================================
EXPLAIN ANALYZE
SELECT 
    b.booking_id,
    b.booking_date,
    b.status,
    u.first_name || ' ' || u.last_name AS user_name,
    p.property_name,
    p.location,
    COALESCE(pay.amount, 0) AS payment_amount,
    COALESCE(pay.payment_status, 'Not Paid') AS payment_status
FROM bookings b
JOIN users u ON b.user_id = u.user_id
JOIN properties p ON b.property_id = p.property_id
LEFT JOIN payments pay ON b.booking_id = pay.booking_id
ORDER BY b.booking_date DESC;


