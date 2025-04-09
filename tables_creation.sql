-- Table: Aircrafts
CREATE TABLE Aircrafts (
    aircraft_name VARCHAR(100) PRIMARY KEY,
    aircraft_iata CHAR(3),
    aircraft_icao CHAR(4)
);

-- Table: Airlines
CREATE TABLE Airlines (
    airline_id INT PRIMARY KEY,
    airline_name VARCHAR(100),
    country VARCHAR(100),
    airline_iata CHAR(2),
    airline_icao CHAR(3),
    alias VARCHAR(100)
);

-- Table: Airports
CREATE TABLE Airports (
    airport_id INT PRIMARY KEY,
    airport_name VARCHAR(100),
    city VARCHAR(100),
    country VARCHAR(100),
    airport_iata CHAR(3),
    airport_icao CHAR(4),
    latitude DOUBLE,
    longitude DOUBLE
);

-- Table: Customers
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_first_name VARCHAR(50),
    customer_family_name VARCHAR(50),
    customer_gender CHAR(1),
    customer_birth_date DATE,
    customer_country VARCHAR(100),
    customer_phone_number BIGINT
);

-- Table: Hotels
CREATE TABLE Hotels (
    hotel_id INT PRIMARY KEY,
    hotel_name VARCHAR(100),
    hotel_address VARCHAR(200),
    city VARCHAR(100),
    country VARCHAR(100),
    hotel_score DECIMAL(3,2)
);

-- Table: FlightBookings
CREATE TABLE FlightBookings (
    trip_id INT,
    customer_id INT,
    flight_number VARCHAR(10),
    airline_id INT,
    aircraft VARCHAR(100),
    airport_src INT,
    airport_dst INT,
    departure_time TIME,
    departure_date DATE,
    flight_duration VARCHAR(20),
    travel_class VARCHAR(20),
    seat_number VARCHAR(10),
    price DECIMAL(10,2),
    PRIMARY KEY (trip_id, customer_id, flight_number, departure_date),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (airline_id) REFERENCES Airlines(airline_id),
    FOREIGN KEY (aircraft) REFERENCES Aircrafts(aircraft_name),
    FOREIGN KEY (airport_src) REFERENCES Airports(airport_id),
    FOREIGN KEY (airport_dst) REFERENCES Airports(airport_id)
);

-- Table: HotelBookings
CREATE TABLE HotelBookings (
    trip_id INT,
    customer_id INT,
    hotel_id INT,
    check_in_date DATE,
    check_out_date DATE,
    price DECIMAL(10,2),
    breakfast_included BOOLEAN,
    PRIMARY KEY (trip_id, customer_id, hotel_id, check_in_date),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (hotel_id) REFERENCES Hotels(hotel_id)
);