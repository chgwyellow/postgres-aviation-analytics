/*
 * Project: Postgres Aviation Analytics
 * Phase: 2 - Relational Operations
 * Day: 9 - Window Functions & Sequencing
 * Description: Sequencing flights and calculating turnaround times.
 */
SET search_path TO core_ops,
    public;
-- 1. Fleet Mission Sequencing
-- Identify the order of flights for each aircraft
SELECT f.flight_number,
    a.tail_number,
    dep.iata_code AS origin,
    arr.iata_code AS destination,
    f.scheduled_departure,
    ROW_NUMBER() OVER(
        PARTITION BY a.tail_number
        ORDER BY f.scheduled_departure
    ) AS mission_id,
    LAG(f.scheduled_arrival) OVER(
        PARTITION BY a.tail_number
        ORDER BY f.scheduled_departure
    ) AS prev_flight_arrival
FROM core_ops.fact_flight_schedule f
    JOIN core_ops.dim_aircraft_fleet a ON f.aircraft_id = a.aircraft_id
    JOIN core_ops.dim_airports dep ON f.departure_airport_id = dep.airport_id
    JOIN core_ops.dim_airports arr ON f.arrival_airport_id = arr.airport_id
ORDER BY a.tail_number,
    f.scheduled_departure;
-- 2. Turnaround Time Analysis
-- Calculate how many minutes the aircraft stays at an airport before the next departure
WITH flight_sequence AS (
    SELECT a.tail_number,
        f.flight_number,
        arr.iata_code as arrival_at,
        f.scheduled_arrival,
        LEAD(f.scheduled_departure) OVER(
            PARTITION BY a.tail_number
            ORDER BY f.scheduled_departure
        ) as next_departure
    FROM core_ops.fact_flight_schedule f
        JOIN core_ops.dim_aircraft_fleet a on f.aircraft_id = a.aircraft_id
        JOIN core_ops.dim_airports arr on f.arrival_airport_id = arr.airport_id
)
SELECT *,
    (next_departure - scheduled_arrival) as ground_time
FROM flight_sequence
WHERE next_departure IS NOT NULL
ORDER BY tail_number,
    scheduled_arrival;