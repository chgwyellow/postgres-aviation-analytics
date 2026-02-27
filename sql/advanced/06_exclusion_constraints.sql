/*
 * Project: Postgres Aviation Analytics
 * Phase: 4 - Advanced Patterns
 * Day: 20 - Exclusion Constraints (Preventing Overlaps)
 * Description: Using GiST indexes to ensure an aircraft isn't in two places at once.
 */
SET search_path TO core_ops,
    public;
-- 1. Activate necessary extension function
-- btree_gist allows us to mix the normal column with range column
CREATE EXTENSION IF NOT EXISTS btree_gist;
-- 2. Create a temp schedule table for demonstration
CREATE TABLE IF NOT EXISTS core_ops.aircraft_schedule_check (
    schedule_id SERIAL PRIMARY KEY,
    aircraft_id UUID REFERENCES core_ops.dim_aircraft_fleet(aircraft_id),
    flight_range TSTZRANGE,
    -- time range includes start and end time
    -- Core constraint which doesn't allow a aircraft has duplicate time range
    EXCLUDE USING gist (
        aircraft_id WITH =,
        -- same aircraft
        flight_range WITH && -- time overlap
    )
);
-- 3. Add test data
INSERT INTO core_ops.aircraft_schedule_check (aircraft_id, flight_range)
VALUES (
        (
            SELECT aircraft_id
            FROM core_ops.dim_aircraft_fleet
            WHERE tail_number = 'B-58501'
        ),
        tstzrange(
            '2026-03-01 08:00:00+08',
            '2026-03-01 12:00:00+08'
        )
    );
-- 4. Insert a conflict data to test
INSERT INTO core_ops.aircraft_schedule_check (aircraft_id, flight_range)
VALUES(
        (
            SELECT aircraft_id
            FROM core_ops.dim_aircraft_fleet
            WHERE tail_number = 'B-58501'
        ),
        tstzrange(
            '2026-03-01 10:00:00+08',
            '2026-03-01 14:00:00+08'
        )
    );