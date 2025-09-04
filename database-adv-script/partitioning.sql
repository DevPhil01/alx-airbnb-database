-- ======================================================
-- PARTITIONING BOOKINGS TABLE BY DATE RANGE
-- ======================================================

-- 1. Rename existing table (if it already contains data)
ALTER TABLE bookings RENAME TO bookings_old;

-- 2. Create the parent partitioned table
CREATE TABLE bookings (
    booking_id UUID PRIMARY KEY,
    property_id UUID NOT NULL,
    user_id UUID NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL NOT NULL,
    status VARCHAR(20) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) PARTITION BY RANGE (start_date);

-- 3. Create partitions (e.g., per quarter for 2024 as an example)
CREATE TABLE bookings_q1_2024 PARTITION OF bookings
    FOR VALUES FROM ('2024-01-01') TO ('2024-04-01');

CREATE TABLE bookings_q2_2024 PARTITION OF bookings
    FOR VALUES FROM ('2024-04-01') TO ('2024-07-01');

CREATE TABLE bookings_q3_2024 PARTITION OF bookings
    FOR VALUES FROM ('2024-07-01') TO ('2024-10-01');

CREATE TABLE bookings_q4_2024 PARTITION OF bookings
    FOR VALUES FROM ('2024-10-01') TO ('2025-01-01');

-- 4. (Optional) Insert existing data from the old table into the new partitioned structure
INSERT INTO bookings
SELECT * FROM bookings_old;

-- 5. Drop the old table if no longer needed
DROP TABLE bookings_old;

-- 6. Test query performance before partitioning
EXPLAIN ANALYZE
SELECT *
FROM bookings
WHERE start_date BETWEEN '2024-05-01' AND '2024-06-30';

-- 7. Test query performance after partitioning (should be faster)
EXPLAIN ANALYZE
SELECT *
FROM bookings
WHERE start_date BETWEEN '2024-05-01' AND '2024-06-30';
