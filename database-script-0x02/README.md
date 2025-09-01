# Airbnb Clone - Seed Data

This README provides an overview of the **seed data** used to populate the Airbnb Clone database for testing and development purposes.

---

## Overview

The seed data:

- Inserts sample records into all major tables: **Users, Properties, Bookings, Payments, Reviews, and Messages**.
- Contains **20 records** designed to simulate real-world usage.- Includes a mix of Kenyan and international names for diversity.

---

## Usage

1. Ensure your database schema is set up using the `schema.sql` file.
2. Load the seed data by running:
   ```bash
   psql -U your_username -d your_database -f seed_data.sql
## Notes

- The seed data is for testing purposes only.
- Payment methods and statuses are simulated.
- Dates are randomized within a realistic range.

## License
This project if for educational use only
