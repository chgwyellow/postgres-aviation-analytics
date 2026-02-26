/*
 * Project: Postgres Aviation Analytics
 * Phase: 4 - Advanced Patterns
 * Day: 19 - Partitioned Index Tuning
 * Description: Optimizing query performance for large-scale aviation data.
 */
SET search_path TO core_ops,
    public;
-- 1. Create partial index
CREATE INDEX idx_active_flights ON core_ops.fact_flight_schedule (status)
WHERE status != 'Arrived';
-- 2. Fine-tune long haul flight (A350)
CREATE INDEX idx_long_haul_routes ON core_ops.fact_flight_schedule (departure_airport_id, arrival_airport_id)
WHERE arrival_airport_id IN (29, 30, 31, 32, 62, 63);
-- 3. Verify the indexes
SELECT schemaname,
    tablename,
    indexname,
    indexdef
FROM pg_indexes
WHERE tablename LIKE 'fact_flight_schedule%';
-- 4. Performance comparison
EXPLAIN ANALYZE
SELECT *
FROM core_ops.fact_flight_schedule
WHERE scheduled_departure >= '2026-03-01'
    AND scheduled_departure < '2026-03-05'
    AND status = 'Scheduled';