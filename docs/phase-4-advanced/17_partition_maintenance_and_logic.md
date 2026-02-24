# Phase 4: Advanced Patterns - Day 17

## 1. Schema Parity

- When migrating to a partitioned table (`_p`), ensuring it has technical columns like `created_at` and `updated_at` is crucial for downstream Spark jobs.

## 2. Handling Data Without a Home

- **Default Partition**: Acts as a safety net. If an `INSERT` date doesn't match any existing partition, it falls into the `DEFAULT` table instead of throwing an error.

## 3. Atomic Cutover

- Using a `Transaction (BEGIN/COMMIT)` to drop the old monolithic table and rename the partitioned table ensures zero downtime for the flight system.
