/*
 * Project: Postgres Aviation Analytics
 * Phase: 4 - Advanced Patterns
 * Day: 17 - Production Cutover & Safety Net
 * Description: Finalizing the partitioned structure for operational use.
 */
SET search_path TO core_ops,
    public;
-- 1. Define the default area to store the homeless data.
CREATE TABLE IF NOT EXISTS core_ops.fact_flight_schedule_default PARTITION OF core_ops.fact_flight_schedule_p DEFAULT;
-- 2. Execute Atomic Switch
BEGIN;
INSERT INTO core_ops.fact_flight_schedule_p (
        flight_uuid,
        flight_number,
        aircraft_id,
        departure_airport_id,
        arrival_airport_id,
        scheduled_departure,
        scheduled_arrival,
        status,
        created_at,
        updated_at
    )
SELECT flight_uuid,
    flight_number,
    aircraft_id,
    departure_airport_id,
    arrival_airport_id,
    scheduled_departure,
    scheduled_arrival,
    status,
    created_at,
    updated_at
FROM core_ops.fact_flight_schedule ON CONFLICT (flight_uuid, scheduled_departure) DO NOTHING;
-- Drop old table
DROP TABLE IF EXISTS core_ops.fact_flight_schedule CASCADE;
-- Rename new table
ALTER TABLE core_ops.fact_flight_schedule_p
    RENAME TO fact_flight_schedule;
-- Establish the constraints
ALTER TABLE core_ops.fact_flight_schedule
ADD CONSTRAINT fk_flight_aircraft FOREIGN KEY (aircraft_id) REFERENCES core_ops.dim_aircraft_fleet(aircraft_id),
    ADD CONSTRAINT fk_flight_dep_airport FOREIGN KEY (departure_airport_id) REFERENCES core_ops.dim_airports(airport_id),
    ADD CONSTRAINT fk_flight_arr_airport FOREIGN KEY (arrival_airport_id) REFERENCES core_ops.dim_airports(airport_id);
-- Rebuild views
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
CREATE OR REPLACE VIEW core_ops.v_flight_daily_schedule AS
SELECT f.flight_number,
    a.tail_number,
    a.aircraft_type,
    dep.iata_code AS origin,
    arr.iata_code AS destination,
    f.scheduled_departure,
    f.scheduled_arrival,
    row_number() OVER (
        PARTITION BY a.tail_number
        ORDER BY f.scheduled_departure
    ) AS sequence_id
FROM core_ops.fact_flight_schedule f
    JOIN core_ops.dim_aircraft_fleet a ON f.aircraft_id = a.aircraft_id
    JOIN core_ops.dim_airports dep ON f.departure_airport_id = dep.airport_id
    JOIN core_ops.dim_airports arr ON f.arrival_airport_id = arr.airport_id;
COMMIT;
-- 3. Result
SELECT relname,
    relkind
FROM pg_class c
    JOIN pg_namespace n ON n.oid = c.relnamespace
WHERE n.nspname = 'core_ops'
    AND relname = 'fact_flight_schedule';