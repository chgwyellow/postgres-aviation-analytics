/*
 * Project: Postgres Aviation Analytics
 * Day: 24 - Data Quality Rescue
 * Description: Deleting overlapping simulated flights to restore physical reality.
 */
WITH duplicate_flights AS (
    SELECT f.flight_uuid,
        ROW_NUMBER() OVER(
            PARTITION BY f.aircraft_id,
            (f.actual_departure AT TIME ZONE 'Asia/Taipei')::date
            ORDER BY f.actual_departure
        ) AS flight_rank,
        a.aircraft_type
    FROM core_ops.fact_flight_schedule f
        JOIN core_ops.dim_aircraft_fleet a ON f.aircraft_id = a.aircraft_id
    WHERE a.aircraft_type = 'A350-941'
)
DELETE FROM core_ops.fact_flight_schedule
WHERE flight_uuid IN (
        SELECT flight_uuid FROM  duplicate_flights
        WHERE flight_rank > 1
    );