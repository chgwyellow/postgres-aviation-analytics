# Phase 4: Advanced Patterns - Day 20

## 1. What is an Exclusion Constraint?

It ensures that if any two rows are compared on specified columns using specified operators, at least one of these operator comparisons will return false.

- In our case: "No two rows can have the same `aircraft_id` AND overlapping time ranges."

## 2. The Power of `tsrange`

PostgreSQL provides Range Types (like `tstzrange`). We use the `&&` (overlaps) operator to detect scheduling conflicts.

## 3. Requirement: `btree_gist`

Standard GiST indexes handle ranges, but to compare them alongside plain columns (like UUID/Integer), we need the `btree_gist` extension.
