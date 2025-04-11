-- Select schema
USE travel_reservation;

-- Revenue View
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