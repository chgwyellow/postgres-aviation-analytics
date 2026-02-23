/*
 * Project: Postgres Aviation Analytics
 * Phase: 4 - Advanced Patterns
 * Day: 16 - Table Partitioning (Range-based)
 * Description: Designing a high-scale flight table for multi-year growth.
 */
SET search_path TO core_ops,
    public;
-- 1. Create the Partitioned Parent Table
-- Note: We add 'PARTITION BY RANGE' at the end.
CREATE TABLE IF NOT EXISTS core_ops.fact_flight_schedule_p (
    flight_uuid UUID NOT NULL DEFAULT gen_random_uuid(),
    flight_number VARCHAR(10) NOT NULL,
    aircraft_id UUID NOT NULL,
    departure_airport_id INTEGER NOT NULL,
    arrival_airport_id INTEGER NOT NULL,
    scheduled_departure TIMESTAMPTZ NOT NULL,
    scheduled_arrival TIMESTAMPTZ NOT NULL,
    status VARCHAR(20) DEFAULT 'Scheduled',
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    -- The partition key MUST be part of the Primary Key if one exists
    PRIMARY KEY (flight_uuid, scheduled_departure)
) PARTITION BY RANGE(scheduled_departure);
CREATE INDEX IF NOT EXISTS idx_flight_p_updated_at ON core_ops.fact_flight_schedule_p (updated_at DESC);
-- 2. Create Individual Partitions (Child Tables)
-- Partition for March 2026
CREATE TABLE core_ops.fact_flight_schedule_2026_m03 PARTITION OF core_ops.fact_flight_schedule_p FOR
VALUES
FROM ('2026-03-01 00:00:00+08') TO ('2026-04-01 00:00:00+08');
-- Partition for April 2026
CREATE TABLE core_ops.fact_flight_schedule_2026_m04 PARTITION OF core_ops.fact_flight_schedule_p FOR
VALUES
FROM ('2026-04-01 00:00:00+08') TO ('2026-05-01 00:00:00+08');
-- 3. Migration: Copy data from our old table
INSERT INTO core_ops.fact_flight_schedule_p
SELECT flight_uuid,
    flight_number,
    aircraft_id,
    departure_airport_id,
    arrival_airport_id,
    scheduled_departure,
    scheduled_arrival,
    status
FROM core_ops.fact_flight_schedule;
-- 4. The Magic: Explain Plan Verification
-- Notice how the planner "prunes" (skips) partitions that don't match.
EXPLAIN ANALYZE
SELECT *
FROM core_ops.fact_flight_schedule_p
WHERE scheduled_departure >= '2026-03-01'
    AND scheduled_departure < '2026-03-07';