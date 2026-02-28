/*
 * Project: Postgres Aviation Analytics
 * Phase: 5 - Data Analytics
 * Day: 21 - Operational Metrics (OTP)
 * Description: Calculating on-time performance for the newly simulated data.
 */
SET search_path TO core_ops,
    public;
WITH flight_duration AS (
    SELECT f.flight_number,
        a.aircraft_type,
        dep.city AS dep_city,
        arr.city AS arr_city,
        f.status,
        ABS(
            EXTRACT(
                EPOCH
                FROM(
                        f.scheduled_arrival AT TIME ZONE 'UTC' - f.scheduled_departure AT TIME ZONE 'UTC'
                    )
            )
        ) / 3600 AS scheduled_duration,
        CASE
            WHEN (f.scheduled_arrival - f.scheduled_departure) > INTERVAL '6 hours' THEN 'Long-Haul'
            ELSE 'Short-Haul'
        END AS route_category
    FROM core_ops.fact_flight_schedule f
        JOIN core_ops.dim_aircraft_fleet a ON a.aircraft_id = f.aircraft_id
        JOIN core_ops.dim_airports dep ON dep.airport_id = f.departure_airport_id
        JOIN core_ops.dim_airports arr ON arr.airport_id = f.arrival_airport_id
)
SELECT route_category,
    aircraft_type,
    count(*) AS total_flights,
    count(*) FILTER (
        WHERE status = 'Scheduled'
    ) AS scheduled_count,
    AVG(scheduled_duration)::numeric(10, 2) AS avg_flight_hours
FROM flight_duration
GROUP BY ROLLUP(route_category, aircraft_type)
ORDER BY route_category,
    avg_flight_hours DESC;