/*
 * Project: Postgres Aviation Analytics
 * Phase: 2 - Relational Operations
 * Day: 7 - Complex Relational Ingestion
 * Description: Scheduling flights by resolving IDs from Dim tables.
 */
SET search_path TO core_ops,
    public;
-- 1. Insert Flight Schedules using Subqueries
INSERT INTO core_ops.fact_flight_schedule(
    flight_number,
    aircraft_id,
    departure_airport_id,
    arrival_airport_id,
    scheduled_departure,
    scheduled_arrival,
    status
)
VALUES(
    'JX800',
    (SELECT aircraft_id FROM core_ops.dim_aircraft_fleet WHERE tail_number = 'B-58501'),
    (SELECT airport_id FROM core_ops.dim_airports WHERE iata_code = 'TPE'),
    (SELECT airport_id FROM core_ops.dim_airports WHERE iata_code = 'NRT'),
    '2026-03-01 08:30:00+08',
    '2026-03-01 12:45:00+09',
    'Scheduled'
),
(
    'JX801', 
    (SELECT aircraft_id FROM core_ops.dim_aircraft_fleet WHERE tail_number = 'B-58501'),
    (SELECT airport_id FROM core_ops.dim_airports WHERE iata_code = 'NRT'),
    (SELECT airport_id FROM core_ops.dim_airports WHERE iata_code = 'TPE'),
    '2026-03-01 14:00:00+09', 
    '2026-03-01 16:50:00+08', 
    'Scheduled'
);
-- 2. Verification Query
SELECT
    f.flight_number,
    a.tail_number,
    dep.iata_code AS origin,
    arr.iata_code AS destination,
    f.scheduled_departure,
    f.scheduled_arrival
FROM core_ops.fact_flight_schedule f
JOIN core_ops.dim_aircraft_fleet a ON f.aircraft_id = a.aircraft_id
JOIN core_ops.dim_airports dep ON f.departure_airport_id = dep.airport_id
JOIN core_ops.dim_airports arr ON f.arrival_airport_id = arr.airport_id;