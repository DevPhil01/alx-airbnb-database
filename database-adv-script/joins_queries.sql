-- PostgreSQL SQL JOIN Queries

-- 1. INNER JOIN: Retrieve all bookings and the respective users who made those bookings
SELECT b.booking_id,
       b.property_id,
       b.user_id,
       b.booking_date,
       u.name AS user_name,
       u.email AS user_email
FROM bookings b
INNER JOIN users u
ON b.user_id = u.user_id;

-- 2. LEFT JOIN: Retrieve all properties and their reviews, including properties that have no reviews
SELECT p.property_id,
       p.property_name,
       r.review_id,
       r.rating,
       r.comment
FROM properties p
LEFT JOIN reviews r
ON p.property_id = r.property_id
ORDER BY p.property_id;

-- 3. FULL OUTER JOIN: Retrieve all users and all bookings, even if the user has no booking or a booking is not linked to a user
SELECT u.user_id,
       u.name AS user_name,
       b.booking_id,
       b.property_id,
       b.booking_date
FROM users u
FULL OUTER JOIN bookings b
ON u.user_id = b.user_id;
