# Phase 4: Advanced Patterns - Day 16

## 1. What is Table Partitioning?

Partitioning refers to splitting one logically large table into smaller physical pieces.

- **The User's View**: It looks like a single table.
- **The DB's View**: It's a collection of smaller tables (child tables).

## 2. Why Partition?

- **Query Pruning**: If Spark asks for "March 2026" data, PostgreSQL only scans the March partition, ignoring millions of rows from other months.
- **Maintenance**: Deleting old data (e.g., logs from 5 years ago) becomes as simple as dropping a partition, which is instant compared to a massive `DELETE`.

## 3. Declarative Partitioning in Postgres

- **Range Partitioning**: Best for time-series data (e.g., partitioning by `scheduled_departure`).
- **List Partitioning**: Best for categorical data (e.g., partitioning by `aircraft_type`).
