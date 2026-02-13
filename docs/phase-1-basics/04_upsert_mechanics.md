# Phase 1: PostgreSQL Fundamentals - Day 4 Supplement

## 1. Type Casting with `::`

PostgreSQL uses the `::` operator for explicit type conversion.

- Example: `'100'::integer` or `'2026-02-13'::date`.
- Importance: Ensures data matches the table schema strictly, preventing "Type Mismatch" errors.

## 2. The Mechanics of `EXCLUDED`

The `EXCLUDED` keyword refers to the row that was proposed for insertion but was rejected due to a unique constraint conflict:

- It acts as a temporary buffer for the new data.
- It allows you to selectively pick which columns from the "new" data should overwrite the "old" data.

## 3. Selective Overwriting

In our maintenance script, even though we provided dummy data for `part_number`, it was never written to the DB because it was omitted from the `DO UPDATE SET` clause.

- **Security**: This protects static columns (like Part Names) from being corrupted by temporary update scripts.
