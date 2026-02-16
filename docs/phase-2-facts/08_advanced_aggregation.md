# Phase 2: Relational Operations - Day 8

## 1. Summarizing Fact Data

Fact tables store individual events. To understand the "big picture," we must use Aggregation Functions:

- **COUNT()**: Measuring flight frequency.
- **SUM()**: Calculating total operational hours.
- **AVG()**: Finding average flight duration (essential for fuel planning).

## 2. Multi-Level Grouping

Using `GROUP BY` with multiple dimension keys allows us to drill down into specific patterns:

- Flights per Aircraft Type.
- Traffic volume per Airport.

## 3. Filtering Aggregated Results

- **WHERE**: Filters raw rows *before* they are grouped (e.g., only counting 'Arrived' flights).
- **HAVING**: Filters groups *after* aggregation (e.g., identifying airports with more than 50 flights per day).
