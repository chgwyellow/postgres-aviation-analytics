/*
 * Project: Postgres Aviation Analytics
 * Phase: 2 - Relational Operations
 * Day: 10 - Views & Materialized Views
 * Description: Encapsulating complex analytics into reusable views.
 */
SET search_path TO core_ops,
    public;
-- 1. Create a Standard View for Daily Operations
-- This view flattens the star schema for easy reporting.
CREATE OR REPLACE VIEW core_ops.v_flight_daily_schedule AS
SELECT f.flight_number,
    a.tail_number,
    a.aircraft_type,
    dep.iata_code as origin,
    arr.iata_code as destination,
    f.scheduled_departure,
    f.scheduled_arrival,
    ROW_NUMBER() OVER(
        PARTITION BY a.tail_number
        ORDER BY f.scheduled_departure
    ) as sequence_id
FROM core_ops.fact_flight_schedule f
    JOIN core_ops.dim_aircraft_fleet a ON f.aircraft_id = a.aircraft_id
    JOIN core_ops.dim_airports dep ON f.departure_airport_id = dep.airport_id
    JOIN core_ops.dim_airports arr ON f.arrival_airport_id = arr.airport_id;
-- 2. Create a Materialized View for Heavy Analytics
-- This stores the results of total flight hours per aircraft (Heavy calculation)
CREATE MATERIALIZED VIEW core_ops.mv_aircraft_utilization_stats AS
SELECT a.tail_number,
    count(f.flight_uuid) AS total_flights,
    sum(
        EXTRACT(
            EPOCH
            FROM(f.scheduled_arrival - f.scheduled_departure)
        ) / 3600
    )::NUMERIC(10, 2) AS cumulative_hours,
    MAX(f.scheduled_arrival) AS last_flight_at
FROM core_ops.dim_aircraft_fleet a
    LEFT JOIN core_ops.fact_flight_schedule f ON a.aircraft_id = f.aircraft_id
GROUP BY a.tail_number;
-- 3. Testing the Views
SELECT *
FROM v_flight_daily_schedule
WHERE tail_number = 'B-58501';
SELECT *
FROM mv_aircraft_utilization_stats
WHERE cumulative_hours IS NOT NULL;
-- 4. How to update the Materialized View
-- Run this when you want to sync the heavy stats.
-- REFRESH MATERIALIZED VIEW core_ops.mv_aircraft_utilization_stats;