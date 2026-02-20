/*
 * Project: Postgres Aviation Analytics
 * Phase: 3 - ETL & Performance
 * Day: 12 - Spark-Friendly SQL Extraction
 * Description: Designing high-performance SQL for Foundry/Spark ingestion.
 */
SET search_path TO core_ops,
    public;
-- 1. Optimized Extraction for Maintenance Pipeline
-- Goal: Provide clean flight history to Spark without overwhelming the DB.
SELECT f.flight_uuid,
    f.flight_number,
    COALESCE(a.tail_number, 'UNKNOWN') AS aircraft_tail,
    EXTRACT(
        EPOCH
        FROM(f.scheduled_arrival - f.scheduled_departure)
    ) / 3600 AS flight_hours_decimal,
    COALESCE(f.status, 'Scheduled') AS operational_status,
    -- Explicit Casting: Helps Spark infer the correct Schema without guessing
    f.scheduled_departure::TIMESTAMP AS departure_ts_local,
    -- Using CASE to handle business logic before the Spark Job
    CASE
        WHEN f.status = 'Delayed' THEN 1
        ELSE 0
    END AS is_delayed_flag
FROM core_ops.fact_flight_schedule f
    JOIN core_ops.dim_aircraft_fleet a ON f.aircraft_id = a.aircraft_id
WHERE -- Predicate Pushdown: Database filters the date range first
    f.scheduled_departure >= '2026-03-01 00:00:00+08'
    AND f.scheduled_departure < '2026-04-01 00:00:00+08' -- Skip cancelled flights to save Spark memory
    AND f.status != 'Cancelled';
-- 2. Performance Audit: Explain Plan
-- Check if the query uses the index
EXPLAIN ANALYZE
SELECT count(*)
FROM core_ops.fact_flight_schedule
WHERE scheduled_departure > '2026-03-01';