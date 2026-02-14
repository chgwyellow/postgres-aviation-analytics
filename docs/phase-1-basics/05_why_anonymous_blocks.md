# Phase 1: PostgreSQL Fundamentals - Day 5 Supplement

## 1. Error Handling (The Primary Reason)

Standard `INSERT` statements are "all-or-nothing." If a constraint is violated, the script stops. By using a `DO` block with an `EXCEPTION` clause:

- We can **trap** the error.
- We can provide a custom, readable message using `RAISE NOTICE`.
- The script can continue executing subsequent tests without crashing.

## 2. Automated Validation (Unit Testing)

In a production pipeline, we often write "Guardrails."

- We intentionally try to insert "bad data" to ensure our database constraints are actually working.
- The `DO` block allows us to automate this "Expected Failure" test.

## 3. Procedural Logic

Standard SQL is declarative (telling the DB *what* to do). `DO $$...$$` allows for **Procedural Logic** (telling the DB *how* to handle situations):

- You can use `IF/THEN`, `LOOP`, and `EXCEPTION` handling which are unavailable in a plain `INSERT` statement.
