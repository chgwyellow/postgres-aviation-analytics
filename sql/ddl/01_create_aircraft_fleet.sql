/*
 * Project: Postgres Aviation Analytics
 * Phase: 1 - Basics
 * Day: 2 - DDL and Data Types
 * Description: Creating the master fleet table with strict constraints.
 */
-- Ensure we are using the correct schema
SET search_path TO core_ops,
    public;
-- 1. Create the aircraft_fleet table
-- This table stores the fundamental metadata for each aircraft
CREATE TABLE IF NOT EXISTS core_ops.dim_aircraft_fleet (
    aircraft_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    tail_number VARCHAR(10) UNIQUE NOT NULL,
    serial_number VARCHAR(50) UNIQUE NOT NULL,
    aircraft_type VARCHAR(20) NOT NULL,
    manufacturer VARCHAR(20) DEFAULT 'Airbus',
    total_flight_hours NUMERIC(10, 2) NOT NULL DEFAULT 0.00,
    total_flight_cycles INTEGER NOT NULL DEFAULT 0,
    manufacture_date DATE,
    last_maintenance_date timestamptz,
    created_at timestamptz DEFAULT current_timestamp,
    CONSTRAINT flight_hours_non_negative CHECK (total_flight_hours >= 0),
    CONSTRAINT cycles_non_negative CHECK (total_flight_cycles >= 0)
);
-- 2. Add comments for documentation (Standard practice in large organizations)
COMMENT ON TABLE core_ops.dim_aircraft_fleet IS 'Master table containing all aircraft metadata and cumulative flight metrics.';
COMMENT ON COLUMN core_ops.dim_aircraft_fleet.tail_number IS 'The unique registration mark visible on the exterior of the aircraft.';
-- 3. Verify the table structure
SELECT column_name,
    data_type,
    is_nullable,
    column_default
FROM information_schema.COLUMNS
WHERE table_name = 'dim_aircraft_fleet'
    AND table_schema = 'core_ops'
ORDER BY ordinal_position;