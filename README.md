# Designing a Travel Reservation System

## Application Context: 

We intend to manage the data of a **travel reservation system** with clients all over the world:  

- Upon registration, customers are automatically given _a numeric identifier_ and asked to indicate _their first and family names, their gender, date of birth, a phone number, an email address and their country of residence_.

- Any customer can book a trip that includes the _reservation of one or more flights_ and, possibly, _one or more hotels_.

- A flight is operated by an airline company, including _name (e.g., British Airways), country of origin, IATA code (e.g., BA, a two-letter code identifying the airline), ICAO code (e.g., BAW, a three-letter code identifying the airline)_ and _alternative name or alias (e.g., British)_.

- A flight connects two airports, including _name (e.g., London Heathrow Airport), IATA (e.g., LHR) and ICAO code (e.g., EGLL)_; each airport serves a _specific location (e.g., London, UK)_ and its precise position is stored in form of _geographic coordinates (latitude and longitude)_.

- A flight has its own _flight number_ accompanied by separate _departure and arrival times_.

- Two flights of a route by two different airline companies **cannot have the same flight number**, but _the flight number can remain unchanged on different days at the same time period_.

- The flight booking information includes _seat number, travel class (e.g., economy / business), price, flight date_. Usually, airlines can also provide details on the aircraft model with _model name(e.g., Boeing 787-8), IATA code (e.g., 788, a unique three-letter identifier for the aircraft), ICAO code (e.g., B788, a unique four-letter identifier for the aircraft)_.

- The system maintains a list of hotels, with their _names, addresses, average review score by its customers_. Customers can write reviews for any hotel; in which case the system stores the _review, date and its author_. When a customer books an hotel, the system keeps the _price paid, check-in / check-out dates, additional services (e.g., breakfast)_.

## Project Tasks: 

Conceptual Schema → Normalization → Logical Model → Physical Schema → Database Creation → Data Preprocessing and Importing → Analytics Queries, Information Views -> Design Dashboards

## Data Models: 

- `customers.csv` → `flight_bookings.csv` & `hotel_bookings.csv`
- `airlines.csv`, `aircrafts.csv`, `airports.csv` → enrich `flight_bookings.csv`
- `hotels.csv` → enrich `hotel_bookings.csv`

The logical model should fit the given datasets to create a suitable physical schema.

## Logical Model: 

<img title="Logical Model" alt="Alt text" src="/Assets/Physical Schema.png">

## Project Tasks: 

- Languages: python, SQL.
- Tools: VSCode, PostgreSQL, pgAdmin4, PowerBI.
  
## Note: 

The challenge's credit belongs to [Gianluca Quercini](https://gquercini.github.io/) 
