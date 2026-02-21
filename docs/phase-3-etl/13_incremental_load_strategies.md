# Phase 3: Data Quality & Performance - Day 13

## 1. Full Load vs. Incremental Load

- **Full Load**: Dropping and reloading everything. Only viable for small Dim tables.
- **Incremental Load**: Ingesting only new or changed records since the last ETL run.

## 2. High-Watermark Pattern (HWM)

In Foundry/Spark, we track a "Watermark" (usually the max `updated_at` or `created_at`).

- **The SQL Role**: Providing a query that filters by `last_update > :last_ingestion_time`.

## 3. Designing for Delta Detection

To support incremental loads, fact tables must have reliable timestamp columns:

- `created_at`: For new records (Append only).
- `updated_at`: For changes (Merge/Upsert).
