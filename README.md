# Designing a Travel Reservation System

## Application Context: 

We intend to manage the data of a travel reservation system with clients all over the world. Upon registration, customers are automatically given a numeric identifier and they are asked to indicate their first and family names, their gender, date of birth, a phone number, an email address and their country of residence.

Any customer can book a trip that includes the reservation of one or more flights and, possibly, one or more hotels.

A flight is operated by an airline company, of which the system keeps its name (e.g., British Airways), the country where the airline is incorporated and, when available, its IATA code (e.g., BA, a two-letter code identifying the airline), its ICAO code (e.g., BAW, a three-letter code identifying the airline) and alternate name or alias (e.g., British).

A flight connects two airports, each having a name (e.g., London Heathrow Airport), and, possibly, a IATA (e.g., LHR) and ICAO code (e.g., EGLL); an airport serves a specific location (e.g., London, UK) and its precise position is given by its geographic coordinates (latitude and longitude).

A flight connecting two airports at specific departure and arrival times is identified by a flight number. Two flights operated by two different airline companies cannot have the same flight number, but the same flight number can denote two flights operated by the same airline company on different days.

For each flight booked by a customer, the system keeps the seat number, the travel class (e.g., economy or business), the price and the date of the flight. Usually, airlines include details on the type of aircraft they plan to use on their flight schedules; these details include the name of the aircraft (e.g., Boeing 787-8) and, when available, the IATA code (e.g., 788, a unique three-letter identifier for the aircraft) and the ICAO code (e.g., B788, a unique four-letter identifier for the aircraft).

The system maintains a list of hotels, with their names, addresses and an average review score, which is a real number denoting the average grade assigned to the hotel by its customers. Customers can write a review for an hotel; in which case the system stores the text of the review, the date and its author. When a customer books an hotel, the system keeps the price paid, the check-in and check-out dates and whether the breakfast is included.
