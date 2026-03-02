/*
 * Project: Postgres Aviation Analytics
 * Phase: 5 - Data Analytics
 * Day: 23 - Window Functions (Ripple Effect Analysis)
 * Description: Using LAG() to see if the current delay was caused by the previous flight.
 */
SET search_path TO core_ops,
    public;
WITH flight_sequence AS (
    SELECT f.flight_number,
        a.tail_number,
        f.actual_departure,
        f.actual_arrival,
        EXTRACT(
            EPOCH
            FROM(f.actual_arrival - f.scheduled_arrival)
        ) / 60 AS current_delay_mins,
        LAG(f.actual_arrival) OVER(
            PARTITION BY f.aircraft_id
            ORDER BY f.actual_departure ASC
        ) AS prev_flight_arrival
    FROM core_ops.fact_flight_schedule f
        JOIN core_ops.dim_aircraft_fleet a ON f.aircraft_id = a.aircraft_id
    WHERE f.status = 'Arrived'
)
SELECT tail_number,
    flight_number,
    current_delay_mins,
    -- Turnaround Time
    ROUND(
        EXTRACT(
            EPOCH
            FROM(actual_departure - prev_flight_arrival)
        ) / 60,
        0
    ) AS turnaround_mins,
    -- If previous flight was delayed and the turnaround time is less than 60 mins
    -- It could be ripple delay
    CASE
        WHEN prev_flight_arrival IS NULL THEN 'First Flight of Day'
        WHEN (actual_departure - prev_flight_arrival) < INTERVAL '60 minutes'
        AND (actual_departure - prev_flight_arrival) > INTERVAL '0 minutes'
        AND current_delay_mins > 15 THEN 'Ripple Effect Delay'
        WHEN actual_departure < prev_flight_arrival THEN 'Data Error: Time Inversion'
        ELSE 'Independent Status'
    END AS delay_root_cause
FROM flight_sequence
ORDER BY tail_number,
    actual_departure;