/*
 * Project: Postgres Aviation Analytics
 * Phase: 3 - ETL & Performance
 * Day: 13 - Incremental Ingestion Setup
 * Description: Adding tracking columns and specialized indexes for Delta loads.
 */
SET search_path TO core_ops,
    public;
-- 1. Add 'updated_at' to track changes
-- Even in a modern stack, having a DB-level timestamp helps Spark identify changes.
ALTER TABLE core_ops.fact_flight_schedule
ADD COLUMN IF NOT EXISTS updated_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP;
-- 2. Create a specific Index for the Incremental Loader
-- This index is designed for Spark to find ONLY the newest records.
CREATE INDEX IF NOT EXISTS idx_flight_incremental_sync ON core_ops.fact_flight_schedule (updated_at DESC);
-- 3. Optimized View for Spark Incremental Extraction
-- This view filters by the 'updated_at' column which Spark will use as a Watermark.
CREATE OR REPLACE VIEW core_ops.v_etl_incremental_flights AS
SELECT flight_uuid,
    flight_number,
    aircraft_id,
    departure_airport_id,
    arrival_airport_id,
    scheduled_departure,
    scheduled_arrival,
    status,
    updated_at
FROM core_ops.fact_flight_schedule;
-- 4. Verify table stats to fix the Index issue from today's screenshot
ANALYZE core_ops.fact_flight_schedule;