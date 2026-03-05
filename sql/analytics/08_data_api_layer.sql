/*
 * Project: Postgres Aviation Analytics
 * Phase: 5 - Data Analytics
 * Day: 26 - Data Service Layer (API Ready Views)
 */
SET search_path TO core_ops,
    public;
CREATE OR REPLACE VIEW core_ops.v_api_fleet_health_monitor AS WITH fleet_calc AS (
        SELECT a.tail_number,
            a.aircraft_type,
            SUM(
                GREATEST(
                    EXTRACT(
                        EPOCH
                        FROM (
                                f.actual_arrival AT TIME ZONE 'UTC' - f.actual_departure AT TIME ZONE 'UTC'
                            )
                    ) / 3600,
                    0
                )
            ) AS cumulative_hours,
            COUNT(
                DISTINCT (f.actual_departure AT TIME ZONE 'Asia/Taipei')::date
            ) AS operational_days
        FROM core_ops.fact_flight_schedule f
            JOIN core_ops.dim_aircraft_fleet a ON f.aircraft_id = a.aircraft_id
        WHERE f.status = 'Arrived'
        GROUP BY a.tail_number,
            a.aircraft_type
    )
SELECT tail_number,
    aircraft_type,
    ROUND(cumulative_hours::numeric, 1) as total_hours,
    ROUND(
        (cumulative_hours / NULLIF(operational_days, 0))::numeric,
        1
    ) as avg_daily_hours,
    CASE
        WHEN cumulative_hours >= 300 THEN '🔴 Urgent'
        WHEN cumulative_hours >= 200 THEN '🟡 Attention'
        ELSE '🟢 Healthy'
    END as health_status
FROM fleet_calc;
CREATE OR REPLACE VIEW core_ops.v_api_airport_performance AS
SELECT dep.iata_code AS airport,
    COUNT(*) AS departure_count,
    ROUND(
        (
            COUNT(*) FILTER (
                WHERE(f.actual_arrival - f.scheduled_arrival) < INTERVAL '15 minutes'
            )::numeric / COUNT(*) * 100
        )
    )
FROM core_ops.fact_flight_schedule f
    JOIN core_ops.dim_airports dep ON f.departure_airport_id = dep.airport_id
WHERE f.status = 'Arrived'
GROUP BY dep.iata_code;