# Phase 2: Relational Operations - Day 7

## 1. The Challenge of Fact Table Ingestion

Fact tables like `fact_flight_schedule` rely heavily on Foreign Keys. You rarely have the UUIDs or Integer IDs on hand; usually, you only have business keys like:

- Tail Number (e.g., 'B-58501')
- IATA Codes (e.g., 'TPE', 'NRT')

## 2. Relational Lookup via Subqueries

To insert a flight, we must "look up" the IDs from our dimension tables during the `INSERT` process. This ensures data integrity and prevents hardcoding.

## 3. Handling Timezones in Aviation

When inserting flight schedules, we use `TIMESTAMPTZ`. PostgreSQL automatically handles the conversion based on the provided offset or timezone name, which is vital for flights between different regions (e.g., Taipei to Tokyo).
