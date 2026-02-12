# Phase 1: PostgreSQL Fundamentals - Day 2

## 1. Advanced Data Types in PostgreSQL

PostgreSQL offers specialized types that ensure data integrity and optimize storage:

- **UUID**: Universally Unique Identifier. Better than auto-incrementing integers for distributed systems.
- **NUMERIC(p, s)**: Exact numeric types for financial or high-precision flight data (e.g., fuel weight).
- **TIMESTAMP WITH TIME ZONE (TIMESTAMPTZ)**: Crucial for aviation! Always store time with timezone context to avoid confusion across different flight regions.
- **VARCHAR(n) vs TEXT**: In PostgreSQL, there is no performance difference. `TEXT` is preferred for long descriptions without artificial limits.

## 2. Table Constraints

- **PRIMARY KEY**: Uniquely identifies each record.
- **CHECK Constraints**: Ensures values meet specific criteria (e.g., `flight_hours >= 0`).
- **DEFAULT Values**: Automates data entry for timestamps or status codes.
