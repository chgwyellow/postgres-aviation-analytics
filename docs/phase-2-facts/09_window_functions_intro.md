# Phase 2: Relational Operations - Day 9

## 1. What are Window Functions?

Window functions perform a calculation across a set of table rows that are somehow related to the current row. Unlike `GROUP BY`, they do not collapse rows; they keep each individual row while adding an analytical context.

## 2. Key Syntax: `OVER (PARTITION BY ... ORDER BY ...)`

- **PARTITION BY**: Divides rows into groups (e.g., group by Aircraft).
- **ORDER BY**: Defines the sequence within that group (e.g., chronological flight order).

## 3. Essential Window Functions

- **ROW_NUMBER()**: Assigns a unique rank (1, 2, 3...) to each flight per aircraft.
- **LAG()**: Accesses data from the *previous* row (Great for calculating "Turnaround Time").
- **LEAD()**: Accesses data from the *next* row.
