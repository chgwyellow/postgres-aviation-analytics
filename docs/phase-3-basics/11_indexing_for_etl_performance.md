# Phase 3: Data Quality & Performance - Day 11

## 1. The Role of Indexing in ETL

Indexing is not just for faster queries; it's the engine behind efficient ETL.

- **B-Tree Indexes**: The default for range and equality queries.
- **Partial Indexes**: Only indexing "Active" flights to save space.
- **Multi-Column Indexes**: Speeding up lookups for specific Aircraft + Date combinations.

## 2. Why No Stored Procedures?

- **Data Lineage**: Keeping logic in Spark/Foundry ensures we can trace every calculation.
- **Scalability**: Decoupling logic from the DB allows the database to focus on Storage and the compute engine to focus on Processing.
