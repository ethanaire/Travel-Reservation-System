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

-- 4. Aircraft Utilization
-- Find which aircraft types are most commonly used.
SELECT 
    aircraft,
    COUNT(*) AS usage_count
FROM FlightBookings
GROUP BY aircraft
ORDER BY usage_count DESC;

-- 5. Hotel Ratings by City
-- Determine where high-rated hotels are concentrated.
SELECT 
    city,
    AVG(hotel_score) AS avg_score
FROM Hotels
GROUP BY city
HAVING COUNT(*) > 5
ORDER BY avg_score DESC
LIMIT 10;

-- 6. Impact of Breakfast Inclusion on Hotel Booking Price
-- Evaluate how breakfast impacts hotel pricing.
SELECT 
    breakfast_included,
    AVG(price) AS avg_price
FROM HotelBookings
GROUP BY breakfast_included;

-- 7. Frequent Travelers
-- Identify repeat travelers who book multiple trips.
SELECT 
    customer_id,
    COUNT(DISTINCT trip_id) AS trip_count
FROM FlightBookings
GROUP BY customer_id
HAVING trip_count > 1
ORDER BY trip_count DESC;





