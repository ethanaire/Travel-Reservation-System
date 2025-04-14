-- 1. Customer Lifetime Value (CLV)
-- Identify the most valuable customers.
SELECT 
    c.customer_id,
    c.customer_first_name,
    c.customer_family_name,
    SUM(fb.price + COALESCE(hb.price, 0)) AS total_spent
FROM customers c
LEFT JOIN flightbookings fb ON c.customer_id = fb.customer_id
LEFT JOIN hotelbookings hb ON c.customer_id = hb.customer_id AND fb.trip_id = hb.trip_id
GROUP BY c.customer_id, c.customer_first_name, c.customer_family_name
ORDER BY total_spent DESC
LIMIT 10;

-- 2. Most Popular Flight Routes
-- Determine which airport pairs are most commonly traveled.
SELECT 
    a1.city AS source_city,
    a2.city AS destination_city,
    COUNT(*) AS bookings
FROM flightbookings fb
JOIN airports a1 ON fb.airport_src = a1.airport_id
JOIN airports a2 ON fb.airport_dst = a2.airport_id
GROUP BY a1.city, a2.city
ORDER BY bookings DESC
LIMIT 10;

-- 3. Seasonal Travel Demand
-- Analyze how flight bookings fluctuate throughout the year. 
SELECT 
    EXTRACT(MONTH FROM departure_date) AS month,
    COUNT(*) AS flight_count
FROM flightbookings
GROUP BY month
ORDER BY month;

-- 4. Aircraft Utilization
-- Find which aircraft types are most commonly used.
SELECT 
    aircraft,
    COUNT(*) AS usage_count
FROM flightbookings
GROUP BY aircraft
ORDER BY usage_count DESC;

-- 5. Hotel Ratings by City
-- Determine where high-rated hotels are concentrated.
SELECT 
    city,
    AVG(hotel_score) AS avg_score
FROM hotels
GROUP BY city
HAVING COUNT(*) > 5
ORDER BY avg_score DESC;

-- 6. Impact of Breakfast Inclusion on Hotel Booking Price
-- Evaluate how breakfast impacts hotel pricing.
SELECT 
    breakfast_included,
    ROUND(AVG(price),2) AS avg_price
FROM hotelbookings
GROUP BY breakfast_included;

-- 7. Frequent Travelers
-- Identify repeat travelers who book multiple trips.
SELECT 
    customer_id,
    COUNT(DISTINCT trip_id) AS trip_count
FROM flightbookings
GROUP BY customer_id
HAVING COUNT(DISTINCT trip_id) > 1
ORDER BY trip_count DESC;





