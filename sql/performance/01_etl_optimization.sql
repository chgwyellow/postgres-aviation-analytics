/*
 * Project: Postgres Aviation Analytics
 * Phase: 3 - Data Quality & Performance
 * Day: 11 - ETL Performance Optimization
 * Description: Creating indexes to support high-speed ingestion.
 */
SET search_path TO core_ops,
    public;
-- 1. Create a standard B-Tree Index on Flight Number
-- Supports quick lookups for specific flight history.
CREATE INDEX IF NOT EXISTS idx_flight_number ON core_ops.fact_flight_schedule (flight_number);
-- 2. Create a Composite Index for Date-based ETL
-- Spark often asks for: WHERE scheduled_departure >= '2026-03-01'
-- This index speeds up incremental loading.
CREATE INDEX IF NOT EXISTS idx_flight_departure_date ON core_ops.fact_flight_schedule (scheduled_departure DESC);
-- 3. Create a Partial Index (Advanced)
-- For maintenance systems, we often only care about 'Arrived' flights.
-- We only index those to save storage space.
CREATE INDEX IF NOT EXISTS idx_active_maintenance_flights ON core_ops.fact_flight_schedule (aircraft_id)
WHERE status = 'Arrived';
-- 4. Analyze Table (Vital for the Query Planner)
-- This updates statistics so PostgreSQL knows how to use our new indexes.
ANALYZE core_ops.fact_flight_schedule;
-- 5. Verification: Check Index Usage
SELECT relname as table_name,
    indexrelname as index_name,
    pg_size_pretty(pg_relation_size(indexrelid)) as index_size
FROM pg_stat_user_indexes
WHERE schemaname = 'core_ops';