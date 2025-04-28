# Designing a Travel Reservation System

## Task Flows: 

- Conceptual Schema → Logical Model → Physical Schema → Database Creation 
- Data Preprocessing and Importing → Analytics Queries, Information Views -> Design Dashboards

## Physical Schema: 
<p align="center">
  <img title="Logical Model" alt="Alt text" src="/Assets/Physical Schema.png" width="900" height="530">

## Data Model: 

- `customers.csv` → `flight_bookings.csv` & `hotel_bookings.csv`
- `airlines.csv`, `aircrafts.csv`, `airports.csv` → enrich `flight_bookings.csv`
- `hotels.csv` → enrich `hotel_bookings.csv`

The logical model should fit the given datasets to enable Power BI's data modeling part.
<p align="center">
  <img title="Data Model" alt="Alt text" src="/Assets/Power BI Modeling.png" width="900" height="466">

## Analytical Dashboard: 

The dashboard named `Travel Reservation System` consists of 3 pages: Overview, Travel Information, Customer Insights. 

**Overview** Page: 
<p align="center">
  <img title="Data Model" alt="Alt text" src="/Assets/Dashboard_Overview.png" width="900" height="520">

## Data Preprocessing Execution:

- The given datasets are currently in `.csv` format whose possible delimiter (tab `\t` or commas `,`) and quotechar problems should be handled before being imported into each table.

- Besides, PostgreSQL only accepts `DATE` values in `YYYY-MM-DD` format while all available date-related values are in `DD-MM-YYYY`. Data type transformation is also required for valid data importing.

- To install dependencies:
```bash
pip install -r requirements.txt
```
- To execute the python file, run:

```bash
python data_preprocessing.py
```

## Technologies: 

- Languages: python, SQL.
- Tools: VSCode, PostgreSQL, pgAdmin4, PowerBI.
  
## Note: 

The challenge's credit belongs to [Gianluca Quercini](https://gquercini.github.io/) 
