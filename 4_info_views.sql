-- Select schema
USE travel_reservation;

-- 1. Customer Demographics View
-- Insight into the profile of customers (gender, age group, country).
CREATE VIEW v_customer_demographics AS
SELECT
  customer_id,
  country,
  gender,
  DATE_PART('year', AGE(current_date, date_of_birth)) AS age
FROM customers;

-- 2. Revenue View
-- Total spending by top individual customers
CREATE VIEW v_customer_spending AS
SELECT
    c.customer_id,
    c.customer_first_name,
    c.customer_family_name,
    SUM(COALESCE(fb.price, 0) + COALESCE(hb.price, 0)) AS total_spent
FROM customers c
LEFT JOIN flightbookings fb ON c.customer_id = fb.customer_id
LEFT JOIN hotelbookings hb ON c.customer_id = hb.customer_id
GROUP BY c.customer_id, c.customer_first_name, c.customer_family_name;

-- 3. Flight Summary View 
-- Aggregated flight bookings by airline, route, and class
CREATE VIEW v_flight_summary AS
SELECT
  fb.trip_id,
  a.airline_name AS airline,
  fb.travel_class,
  COUNT(*) AS total_flight_bookings,
  SUM(fb.price) AS total_revenue
FROM flightbookings fb
JOIN airlines a ON fb.airline_id = a.airline_id
GROUP BY fb.flight_id, a.airline_name, fb.travel_class;

-- 4. Top Routes View 
-- Frequent and high-revenue flight routes.
CREATE VIEW v_top_routes AS
SELECT
  fb.airport_src,
  fb.airport_dst,
  ap1.name AS departure_airport,
  ap2.name AS arrival_airport,
  COUNT(fb.booking_id) AS booking_count,
  SUM(fb.price) AS revenue
FROM flight_bookings fb
JOIN airports ap1 ON fb.airport_src = ap1.airport_id
JOIN airports ap2 ON fb.airport_dst = ap2.airport_id
GROUP BY fb.airport_src, fb.airport_dst, ap1.name, ap2.name;

-- 5. Hotel Booking Trends View
-- Useful to analyze hotel check-in/check-out trends and revenue.
