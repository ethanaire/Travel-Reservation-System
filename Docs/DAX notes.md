# DAX notes

## Calendar table:

- create table: 
calendar = CALENDAR(MIN(flight_bookings[departure_date]), MAX(flight_bookings[departure_date]))

- month column: 
month = FORMAT(Calendar[date], "MMMM")