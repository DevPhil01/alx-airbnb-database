-- Step 1: Initial Query (Before Optimization)
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
WHERE b.status = 'confirmed'
AND b.booking_date >= CURRENT_DATE - INTERVAL '6 months'
ORDER BY b.booking_date DESC;

-- Step 2: Create Indexes for Performance
CREATE INDEX IF NOT EXISTS idx_bookings_status_date ON bookings(status, booking_date);
CREATE INDEX IF NOT EXISTS idx_bookings_user_id ON bookings(user_id);
CREATE INDEX IF NOT EXISTS idx_bookings_property_id ON bookings(property_id);
CREATE INDEX IF NOT EXISTS idx_users_id ON users(user_id);
CREATE INDEX IF NOT EXISTS idx_properties_id ON properties(property_id);
CREATE INDEX IF NOT EXISTS idx_payments_booking_id ON payments(booking_id);

-- Step 3: Optimized Query (After Optimization)
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
WHERE b.status = 'confirmed'
AND b.booking_date >= CURRENT_DATE - INTERVAL '6 months'
ORDER BY b.booking_date DESC;
