
-- Insert sample users
INSERT INTO "User" (user_id, first_name, last_name, email, password_hash, phone_number, role)
VALUES
(gen_random_uuid(), 'John', 'Mwangi', 'john.mwangi@example.com', 'hashed_password1', '+254712345678', 'guest'),
(gen_random_uuid(), 'Mary', 'Wambui', 'mary.wambui@example.com', 'hashed_password2', '+254722334455', 'host'),
(gen_random_uuid(), 'Peter', 'Otieno', 'peter.otieno@example.com', 'hashed_password3', '+254733556677', 'guest'),
(gen_random_uuid(), 'Grace', 'Achieng', 'grace.achieng@example.com', 'hashed_password4', '+254744667788', 'host'),
(gen_random_uuid(), 'David', 'Kamau', 'david.kamau@example.com', 'hashed_password5', '+254755778899', 'guest'),
(gen_random_uuid(), 'Lucy', 'Njeri', 'lucy.njeri@example.com', 'hashed_password6', '+254766889900', 'admin'),
(gen_random_uuid(), 'Samuel', 'Mutua', 'samuel.mutua@example.com', 'hashed_password7', '+254777990011', 'guest'),
(gen_random_uuid(), 'Esther', 'Karanja', 'esther.karanja@example.com', 'hashed_password8', '+254788001122', 'host'),
(gen_random_uuid(), 'Brian', 'Ochieng', 'brian.ochieng@example.com', 'hashed_password9', '+254799112233', 'guest'),
(gen_random_uuid(), 'Faith', 'Waithera', 'faith.waithera@example.com', 'hashed_password10', '+254710223344', 'host');

-- Insert sample properties
INSERT INTO Property (property_id, host_id, name, description, location, pricepernight)
VALUES
(gen_random_uuid(), (SELECT user_id FROM "User" WHERE email='mary.wambui@example.com'), 'Cozy Nairobi Apartment', 'Modern apartment in Westlands, Nairobi.', 'Westlands, Nairobi', 5000),
(gen_random_uuid(), (SELECT user_id FROM "User" WHERE email='grace.achieng@example.com'), 'Beachfront Cottage', 'Relaxing cottage near Diani Beach.', 'Diani, Kwale', 7500),
(gen_random_uuid(), (SELECT user_id FROM "User" WHERE email='esther.karanja@example.com'), 'Mountain View Cabin', 'Rustic cabin with a view of Mt. Kenya.', 'Nanyuki, Laikipia', 6000),
(gen_random_uuid(), (SELECT user_id FROM "User" WHERE email='mary.wambui@example.com'), 'Urban Studio', 'Compact studio near CBD.', 'Nairobi CBD', 4000),
(gen_random_uuid(), (SELECT user_id FROM "User" WHERE email='grace.achieng@example.com'), 'Lakeside Villa', 'Luxury villa near Lake Naivasha.', 'Naivasha, Nakuru', 12000);

-- Insert sample bookings
INSERT INTO Booking (booking_id, property_id, user_id, start_date, end_date, total_price, status)
VALUES
(gen_random_uuid(), (SELECT property_id FROM Property WHERE name='Cozy Nairobi Apartment'), (SELECT user_id FROM "User" WHERE email='john.mwangi@example.com'), '2025-09-01', '2025-09-05', 20000, 'confirmed'),
(gen_random_uuid(), (SELECT property_id FROM Property WHERE name='Beachfront Cottage'), (SELECT user_id FROM "User" WHERE email='peter.otieno@example.com'), '2025-09-10', '2025-09-15', 37500, 'pending'),
(gen_random_uuid(), (SELECT property_id FROM Property WHERE name='Mountain View Cabin'), (SELECT user_id FROM "User" WHERE email='samuel.mutua@example.com'), '2025-09-20', '2025-09-25', 30000, 'confirmed'),
(gen_random_uuid(), (SELECT property_id FROM Property WHERE name='Urban Studio'), (SELECT user_id FROM "User" WHERE email='david.kamau@example.com'), '2025-10-01', '2025-10-03', 8000, 'confirmed'),
(gen_random_uuid(), (SELECT property_id FROM Property WHERE name='Lakeside Villa'), (SELECT user_id FROM "User" WHERE email='brian.ochieng@example.com'), '2025-10-05', '2025-10-08', 36000, 'canceled');

-- Insert sample payments
INSERT INTO Payment (payment_id, booking_id, amount, payment_method)
VALUES
(gen_random_uuid(), (SELECT booking_id FROM Booking WHERE total_price=20000), 20000, 'credit_card'),
(gen_random_uuid(), (SELECT booking_id FROM Booking WHERE total_price=30000), 30000, 'paypal'),
(gen_random_uuid(), (SELECT booking_id FROM Booking WHERE total_price=8000), 8000, 'stripe');

-- Insert sample reviews
INSERT INTO Review (review_id, property_id, user_id, rating, comment)
VALUES
(gen_random_uuid(), (SELECT property_id FROM Property WHERE name='Cozy Nairobi Apartment'), (SELECT user_id FROM "User" WHERE email='john.mwangi@example.com'), 5, 'Amazing stay! Very clean and comfortable.'),
(gen_random_uuid(), (SELECT property_id FROM Property WHERE name='Mountain View Cabin'), (SELECT user_id FROM "User" WHERE email='samuel.mutua@example.com'), 4, 'Beautiful view but the weather was cold.');

-- Insert sample messages
INSERT INTO Message (message_id, sender_id, recipient_id, message_body)
VALUES
(gen_random_uuid(), (SELECT user_id FROM "User" WHERE email='john.mwangi@example.com'), (SELECT user_id FROM "User" WHERE email='mary.wambui@example.com'), 'Hello, is the Nairobi apartment available next weekend?'),
(gen_random_uuid(), (SELECT user_id FROM "User" WHERE email='mary.wambui@example.com'), (SELECT user_id FROM "User" WHERE email='john.mwangi@example.com'), 'Yes, it is available. You can proceed to book.');
