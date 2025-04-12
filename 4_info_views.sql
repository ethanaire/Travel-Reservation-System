-- Select schema
USE travel_reservation;

-- Customer Demographics View
-- Insight into the profile of customers (gender, age group, country).
CREATE VIEW v_customer_demographics AS
SELECT
  customer_id,
  country,
  gender,
  DATE_PART('year', AGE(current_date, date_of_birth)) AS age
FROM Customers;

-- Revenue View
-- Total spending by top individual customers
CREATE VIEW customer_spending AS
SELECT
    c.customer_id,
    c.customer_first_name,
    c.customer_family_name,
    SUM(COALESCE(fb.price, 0) + COALESCE(hb.price, 0)) AS total_spent
FROM Customers c
LEFT JOIN FlightBookings fb ON c.customer_id = fb.customer_id
LEFT JOIN HotelBookings hb ON c.customer_id = hb.customer_id
GROUP BY c.customer_id, c.customer_first_name, c.customer_family_name;

-- Flight Summary View 
-- Aggregated flight bookings by airline, route, and class
CREATE VIEW v_flight_summary AS
SELECT
  fb.flight_id,
  a.name AS airline,
  fb.travel_class,
  COUNT(*) AS total_bookings,
  SUM(fb.price) AS total_revenue
FROM flight_bookings fb
JOIN flights f ON fb.flight_id = f.flight_id
JOIN airlines a ON f.airline_id = a.airline_id
GROUP BY fb.flight_id, a.name, fb.travel_class;
