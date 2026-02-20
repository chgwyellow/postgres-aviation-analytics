# Phase 3: Data Quality & Performance - Day 12

## 1. Beyond `SELECT *`

In Spark JDBC ingestion, `SELECT *` is a performance killer. It forces the database to fetch metadata and scan all columns, even those Spark doesn't need (like raw JSON or heavy text).

- **Rule**: Always specify columns explicitly to reduce memory footprint.

## 2. Handling NULLs at the Source

Spark's handling of `NULL` can sometimes lead to unexpected results in complex aggregations.

- **Best Practice**: Use `COALESCE()` or `NULLIF()` at the SQL level to provide default values or normalize empty strings before Spark sees them.

## 3. The Power of "Predicate Pushdown"

By writing efficient `WHERE` clauses in your source SQL, PostgreSQL handles the heavy filtering so Spark only processes the relevant subset.
