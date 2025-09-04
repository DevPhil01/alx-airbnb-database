-- Indexes for Users Table
-- High-usage columns: email (login lookups), user_id (joins), created_at (sorting/filtering)

-- Unique index for email to speed up login and enforce uniqueness
CREATE UNIQUE INDEX idx_users_email ON users(email);

-- Index for created_at for sorting/filtering by registration date
CREATE INDEX idx_users_created_at ON users(created_at);


-- Indexes for Properties Table
-- High-usage columns: location (search), user_id (host), property_id (joins), price_per_night (filters/sorting)

-- Index for location to improve property searches by city or area
CREATE INDEX idx_properties_location ON properties(location);

-- Index for host (user_id) to speed up host-related queries
CREATE INDEX idx_properties_user_id ON properties(user_id);

-- Index for price filtering or sorting
CREATE INDEX idx_properties_price_per_night ON properties(price_per_night);


-- Indexes for Bookings Table
-- High-usage columns: user_id, property_id, booking_date, status (pending, confirmed, cancelled)

-- Composite index for user_id and property_id to improve joins and lookups
CREATE INDEX idx_bookings_user_property ON bookings(user_id, property_id);

-- Index for booking_date to speed up date range queries
CREATE INDEX idx_bookings_date ON bookings(booking_date);

-- Index for booking status for dashboard filtering
CREATE INDEX idx_bookings_status ON bookings(status);
