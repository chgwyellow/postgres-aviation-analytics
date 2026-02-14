# Phase 1: PostgreSQL Fundamentals - Day 5

## 1. The Role of Constraints

Constraints are rules enforced on data columns to ensure the accuracy and reliability of the data. In an aviation context, they prevent "impossible" data from entering our maintenance systems.

## 2. Key PostgreSQL Constraints

- **NOT NULL**: Ensures a column cannot have a NULL value (e.g., every aircraft must have a `tail_number`).
- **UNIQUE**: Ensures all values in a column are different (e.g., no two aircraft can share a `serial_number`).
- **CHECK**: Ensures the value in a column meets a specific condition. This is where business logic lives (e.g., `flight_hours` must be >= 0).
- **FOREIGN KEY**: Ensures referential integrity between tables (e.g., a part must belong to an existing aircraft).
- **DEFAULT**: Provides a fallback value if none is supplied.

## 3. Altering Existing Tables

Often, you need to add constraints after a table is created. We use `ALTER TABLE` to tighten our data rules without destroying existing data.
