# Phase 4: Advanced Patterns - Day 19

## 1. Local vs. Global Indexing

- In PostgreSQL, indexes on a partitioned table are "Local". Each child table has its own physical index.
- Adding an index to the Parent table automatically creates it for all Child tables.

## 2. Partial Indexes

- Why index everything? We can create indexes only for specific rows (e.g., `WHERE status != 'Arrived'`) to save disk space and speed up writes.
