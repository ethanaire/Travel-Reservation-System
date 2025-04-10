-- Select schema
USE travel_reservation;

-- 1. Customer Lifetime Value (CLV)
-- Identify the most valuable customers.
SELECT 
    c.customer_id,
    c.customer_first_name,
    c.customer_family_name,
    SUM(fb.price + COALESCE(hb.price, 0)) AS total_spent
FROM Customers c
LEFT JOIN FlightBookings fb ON c.customer_id = fb.customer_id
LEFT JOIN HotelBookings hb ON c.customer_id = hb.customer_id AND fb.trip_id = hb.trip_id
GROUP BY c.customer_id, c.customer_first_name, c.customer_family_name
ORDER BY total_spent DESC
LIMIT 10;

-- 2. Most Popular Flight Routes
-- Determine which airport pairs are most commonly traveled.
SELECT 
    a1.city AS source_city,
    a2.city AS destination_city,
    COUNT(*) AS bookings
FROM FlightBookings fb
JOIN Airports a1 ON fb.airport_src = a1.airport_id
JOIN Airports a2 ON fb.airport_dst = a2.airport_id
GROUP BY a1.city, a2.city
ORDER BY bookings DESC
LIMIT 10;

-- 3. Seasonal Travel Demand
-- Analyze how flight bookings fluctuate throughout the year. 
SELECT 
    EXTRACT(MONTH FROM departure_date) AS month,
    COUNT(*) AS flight_count
FROM FlightBookings
GROUP BY month
ORDER BY month;
