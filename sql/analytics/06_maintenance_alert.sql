/*
 * Project: Postgres Aviation Analytics
 * Phase: 5 - Data Analytics
 * Day: 24 - Maintenance Prediction & Utilization
 * Description: Calculating cumulative flight hours to trigger maintenance alerts.
 */
SET search_path TO core_ops,
    public;
WITH fleet_stats AS (
    SELECT a.tail_number,
        a.aircraft_type,
        SUM(
            GREATEST(
                EXTRACT(
                    EPOCH
                    FROM(
                            f.actual_arrival AT TIME ZONE 'UTC' - f.actual_departure AT TIME ZONE 'UTC'
                        )
                ) / 3600,
                0
            )
        ) AS total_flight_hours,
        COUNT(
            DISTINCT (f.actual_departure AT TIME ZONE 'Asia/Taipei')::date
        ) AS operational_days
    FROM core_ops.fact_flight_schedule f
        JOIN core_ops.dim_aircraft_fleet a ON f.aircraft_id = a.aircraft_id
    WHERE status = 'Arrived'
    GROUP BY a.tail_number,
        a.aircraft_type
)
SELECT tail_number,
    aircraft_type,
    ROUND(total_flight_hours::numeric, 1) AS cumulative_hours,
    ROUND(
        (total_flight_hours / NULLIF(operational_days, 0))::numeric,
        1
    ) AS daily_utilization,
    CASE
        WHEN total_flight_hours > 400 THEN '🔴 IMMEDIATE INSPECTION'
        WHEN total_flight_hours > 300 THEN '🟡 SCHEDULE A-CHECK'
        ELSE '🟢 NORMAL'
    END AS maintenance_status
FROM fleet_stats
ORDER BY total_flight_hours DESC;