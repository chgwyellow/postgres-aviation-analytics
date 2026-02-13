# Phase 1: PostgreSQL Fundamentals - Day 3

## 1. Data Ingestion Order

In a relational database with Foreign Keys, the order of insertion is critical:

- **Level 1 (Independent)**: Tables without Foreign Keys (e.g., `dim_airports`).
- **Level 2 (Parent)**: Tables referenced by others (e.g., `dim_aircraft_fleet`).
- **Level 3 (Dependent)**: Tables that reference parents (e.g., `dim_parts_inventory`, which requires an `aircraft_id`).

## 2. Advanced INSERT Syntax

- **Multi-row Insert**: Inserting multiple records in a single command for efficiency.
- **RETURNING Clause**: A powerful PostgreSQL feature that returns the data you just inserted (e.g., `RETURNING aircraft_id`). This is extremely helpful for obtaining auto-generated UUIDs or Serial IDs.
- **UUID Handling**: Using `gen_random_uuid()` to let the database handle unique identity.
