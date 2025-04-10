-- Select schema
USE travel_reservation;

-- Import aircrafts data
LOAD DATA LOCAL INFILE 'C:/Users/haiho/GITHUB/Travel-reservation-system/Data/aircrafts.csv'
INTO TABLE aircrafts
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(aircraft_name, aircraft_iata, aircraft_icao);

-- Import airlines data
LOAD DATA LOCAL INFILE 'C:/Users/haiho/GITHUB/Travel-reservation-system/Data/airlines.csv'
INTO TABLE airlines
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(airline_id, airline_name, country, airline_iata, airline_icao, alias);

-- Import airports data
LOAD DATA LOCAL INFILE 'C:/Users/haiho/GITHUB/Travel-reservation-system/Data/airports.csv'
INTO TABLE airports
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(airport_id, airport_name, city, country, airport_iata, airport_icao, latitude, longitude);

-- Import customers data
LOAD DATA LOCAL INFILE 'C:/Users/haiho/GITHUB/Travel-reservation-system/Data/customers.csv'
INTO TABLE customers
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(customer_id, customer_first_name, customer_family_name, customer_gender, customer_birth_date, customer_country, customer_phone_number);

-- Import hotels data
LOAD DATA LOCAL INFILE 'C:/Users/haiho/GITHUB/Travel-reservation-system/Data/hotels.csv'
INTO TABLE hotels
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(hotel_id, hotel_name, hotel_address, city, country, hotel_score);

-- Import flight bookings data
LOAD DATA LOCAL INFILE 'C:/Users/haiho/GITHUB/Travel-reservation-system/Data/flight_bookings.csv'
INTO TABLE flightbookings
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(trip_id, customer_id, flight_number, airline_id, aircraft, airport_src, airport_dst, departure_time, departure_date, flight_duration, travel_class, seat_number, price);

-- Import hotel bookings data
LOAD DATA LOCAL INFILE 'C:/Users/haiho/GITHUB/Travel-reservation-system/Data/hotel_bookings.csv'
INTO TABLE hotelbookings
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(trip_id, customer_id, hotel_id, check_in_date, check_out_date, price, breakfast_included);
