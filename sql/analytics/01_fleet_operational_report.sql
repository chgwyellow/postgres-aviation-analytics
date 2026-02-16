/*
 * Project: Postgres Aviation Analytics
 * Phase: 2 - Relational Operations
 * Day: 8 - Advanced Aggregation & Analytics
 * Description: Generating operational KPIs for the fleet.
 */
SET search_path TO core_ops,
    public;
-- 1. Fleet Utilization Summary
-- Calculate how many flights each aircraft type has performed and total hours.
SELECT a.aircraft_type,
    COUNT(f.flight_uuid) as total_flights,
    SUM(
        EXTRACT(
            EPOCH
            FROM (f.scheduled_arrival - f.scheduled_departure)
        ) / 3600
    )::numeric(10, 2) as total_scheduled_hours,
    round(
        avg(
            EXTRACT(
                EPOCH
                FROM (f.scheduled_arrival - f.scheduled_departure)
            ) / 3600
        )::numeric,
        2
    ) as avg_flight_duration
FROM core_ops.dim_aircraft_fleet a
    LEFT JOIN core_ops.fact_flight_schedule f ON a.aircraft_id = f.aircraft_id
GROUP BY a.aircraft_type
ORDER BY total_flights DESC;
-- 2. Airport Traffic Analysis (Busiest Hubs)
-- Identify which airports have the most departures and arrivals.
WITH airport_status AS (
    SELECT departure_airport_id as airport_id,
        'Departure' as type
    FROM core_ops.fact_flight_schedule
    UNION
    SELECT arrival_airport_id as airport_id,
        'Arrival' as type
    FROM core_ops.fact_flight_schedule
)
SELECT d.iata_code,
    d.airport_name,
    COUNT(*) as total_traffic
FROM airport_status s
    JOIN core_ops.dim_airports d ON s.airport_id = d.airport_id
GROUP BY d.iata_code,
    d.airport_name
HAVING COUNT(*) > 0
ORDER BY total_traffic DESC;
-- 3. Flight Status Monitor
-- Using FILTER (PostgreSQL specific) to count specific statuses within a single scan
SELECT a.aircraft_id,
    a.aircraft_type,
    count(*) FILTER(
        WHERE f.status = 'Arrived'
    ) as arrived_count,
    count(*) FILTER(
        WHERE f.status = 'Delayed'
    ) as delayed_count
FROM core_ops.dim_aircraft_fleet a
    JOIN core_ops.fact_flight_schedule f ON a.aircraft_id = f.aircraft_id
GROUP BY a.aircraft_id,
    a.aircraft_type;