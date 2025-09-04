-- SQL Aggregation and Window Functions for Airbnb Clone

-- 1) Total bookings per user
SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    COUNT(b.booking_id) AS total_bookings
FROM users u
LEFT JOIN bookings b
  ON u.user_id = b.user_id
GROUP BY u.user_id, u.first_name, u.last_name
ORDER BY total_bookings DESC;


-- 2) Rank properties by total bookings — using ROW_NUMBER, RANK, DENSE_RANK
SELECT
    t.property_id,
    t.property_name,
    t.total_bookings,
    ROW_NUMBER() OVER (ORDER BY t.total_bookings DESC)   AS row_number_rank,
    RANK()      OVER (ORDER BY t.total_bookings DESC)   AS rank_rank,
    DENSE_RANK()OVER (ORDER BY t.total_bookings DESC)   AS dense_rank
FROM (
    SELECT
        p.property_id,
        p.name AS property_name,
        COUNT(b.booking_id) AS total_bookings
    FROM properties p
    LEFT JOIN bookings b
      ON p.property_id = b.property_id
    GROUP BY p.property_id, p.name
) AS t
ORDER BY t.total_bookings DESC;


-- 3) Example: ROW_NUMBER() partitioned by location (top property per location)
SELECT
    property_id,
    property_name,
    location,
    total_bookings
FROM (
    SELECT
        p.property_id,
        p.name AS property_name,
        p.location,
        COUNT(b.booking_id) AS total_bookings,
        ROW_NUMBER() OVER (PARTITION BY p.location ORDER BY COUNT(b.booking_id) DESC) AS rn
    FROM properties p
    LEFT JOIN bookings b ON p.property_id = b.property_id
    GROUP BY p.property_id, p.name, p.location
) s
WHERE s.rn = 1
ORDER BY location;
