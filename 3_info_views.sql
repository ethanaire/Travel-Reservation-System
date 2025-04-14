-- ==============================
-- Customer Insights Views
-- ==============================

-- View: Total spending by top individual customers
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

-- View: Customer Demographics -> Insight into the profile of customers (gender, age group, country).
CREATE VIEW v_customer_demographics AS
SELECT
  customer_id,
  customer_country,
  customer_gender,
  DATE_PART('year', AGE(current_date, customer_birth_date)) AS age
FROM customers;

-- View: Customers by country
CREATE VIEW v_customer_by_country AS
SELECT
    customer_country,
    COUNT(*) AS total_customers
FROM customers
GROUP BY customer_country;

-- View: Customer age distribution
CREATE VIEW v_customer_age_distribution AS
SELECT
    EXTRACT(YEAR FROM AGE(current_date, customer_birth_date)) AS age,
    COUNT(*) AS count
FROM customers
GROUP BY age
ORDER BY age;

-- View: Top customers by spending
CREATE VIEW v_top_customers_by_spending AS
SELECT
    c.customer_id,
    select CONCAT(c.customer_first_name, ' ',c.customer_family_name) AS customer_name,
    COALESCE(SUM(fb.price), 0) + COALESCE(SUM(hb.price), 0) AS total_spending
FROM customers c
LEFT JOIN flightbookings fb ON c.customer_id = fb.customer_id
LEFT JOIN hotel_bookings hb ON c.customer_id = hb.customer_id
GROUP BY c.customer_id, customer_name
ORDER BY total_spending DESC;

-- View: Returning vs new customers
CREATE VIEW v_returning_vs_new_customers AS
SELECT
    c.customer_id,
    select CONCAT(c.customer_first_name, ' ',c.customer_family_name) AS customer_name,
    COUNT(DISTINCT fb.booking_id) + COUNT(DISTINCT hb.booking_id) AS total_bookings,
    CASE
        WHEN COUNT(DISTINCT fb.booking_id) + COUNT(DISTINCT hb.booking_id) > 1 THEN 'Returning'
        ELSE 'New'
    END AS customer_type
FROM customers c
LEFT JOIN flight_bookings fb ON c.customer_id = fb.customer_id
LEFT JOIN hotel_bookings hb ON c.customer_id = hb.customer_id
GROUP BY c.customer_id, c.name;

-- ==============================
-- Travel Overview Views
-- ==============================

-- View: Aggregated flight bookings by airline, route, and class
CREATE VIEW v_flight_summary AS
SELECT
  fb.trip_id,
  a.airline_name AS airline,
  fb.travel_class,
  COUNT(*) AS total_flight_bookings,
  SUM(fb.price) AS total_revenue
FROM flightbookings fb
JOIN airlines a ON fb.airline_id = a.airline_id
GROUP BY fb.trip_id, a.airline_name, fb.travel_class;

-- View: Frequent and high-revenue flight routes.
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

-- View: Hotel check-in/check-out trends and revenue.
CREATE VIEW v_hotel_trends AS
SELECT
  hb.hotel_id,
  h.hotel_name,
  DATE_TRUNC('month', hb.check_in_date) AS month,
  COUNT(*) AS total_bookings,
  SUM(hb.price) AS total_revenue,
  AVG(hb.price) AS avg_price
FROM hotelbookings hb
JOIN hotels h ON hb.hotel_id = h.hotel_id
GROUP BY hb.hotel_id, h.hotel_name, month;

-- View: Route demand
CREATE VIEW v_route_demand AS
SELECT
    fb.airport_src,
    src.airport_name AS departure_airport,
    fb.airport_dst,
    dst.airport_name AS arrival_airport,
    COUNT(*) AS total_bookings
FROM flightbookings fb
JOIN airports src ON fb.airport_src = src.airport_id
JOIN airports dst ON fb.airport_dst = dst.airport_id
GROUP BY fb.airport_src, src.name, fb.airport_dst, dst.name;

-- View: Booking mix
CREATE VIEW v_booking_mix AS
SELECT
    c.customer_id,
    COUNT(DISTINCT fb.trip_id) AS flightbookings,
    COUNT(DISTINCT hb.trip_id) AS hotelbookings
FROM customers c
LEFT JOIN flightbookings fb ON c.customer_id = fb.customer_id
LEFT JOIN hotelbookings hb ON c.customer_id = hb.customer_id
GROUP BY c.customer_id;

-- ==============================
-- Operational Overview Views
-- ==============================

-- View: Airline usage frequency
CREATE VIEW v_airline_usage_frequency AS
SELECT
    a.airline_id,
    al.name AS airline_name,
    COUNT(*) AS flight_count
FROM flightbookings fb
JOIN airlines al ON fb.airline_id = al.airline_id
GROUP BY a.airline_id, al.name;

-- View: Aircraft types per airline
CREATE VIEW v_aircraft_types_per_airline AS
SELECT
    al.airline_id,
    al.airline_name,
    ac.aircraft_name,
    COUNT(*) AS count_per_model
FROM flightbookings fb
JOIN airlines al ON fb.airline_id = al.airline_id
JOIN aircrafts ac ON fb.aircraft = ac.aircraft_iata
GROUP BY al.airline_id, al.name, ac.aircraft_name;

-- View: Top airports by the number of departures and arrivals.
CREATE VIEW v_airport_traffic AS
SELECT
  ap.airport_id,
  ap.airport_name,
  COUNT(fb1.trip_id) AS departures,
  COUNT(fb2.trip_id) AS arrivals,
  COUNT(fb1.trip_id) + COUNT(fb2.trip_id) AS total_traffic
FROM airports ap
LEFT JOIN flightbookings fb1 ON ap.airport_id = fb1.airport_src
LEFT JOIN flightbookings fb2 ON ap.airport_id = fb2.airport_dst
GROUP BY ap.airport_id, ap.airport_name
HAVING COUNT(fb1.trip_id) + COUNT(fb2.trip_id) > 0;

-- View: Airline and airport combinations
CREATE VIEW vw_airline_airport_matrix AS
SELECT DISTINCT
    fb.airline_id,
    al.airline_name,
    fb.airport_src,
    ap.airport_name
FROM flightbookings fb
JOIN airlines al ON fb.airline_id = al.airline_id
JOIN airports ap ON fb.airport_src = ap.airport_id;

