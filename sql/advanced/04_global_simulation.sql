/*
 * Project: Postgres Aviation Analytics
 * Phase: 4 - Advanced Patterns
 * Day: 18 - Global Fleet Simulation
 * Description: Mass-generating logical flights to test partitioning and views.
 */
SET search_path TO core_ops,
    public;
-- 1. Truncate the old table if necessary
TRUNCATE TABLE core_ops.fact_flight_schedule CASCADE;
-- 2. Create the global flight table
INSERT INTO core_ops.fact_flight_schedule (
        flight_number,
        aircraft_id,
        departure_airport_id,
        arrival_airport_id,
        scheduled_departure,
        scheduled_arrival,
        status
    ) WITH route_template AS (
        -- Northern America flights (A350)
        SELECT a.aircraft_id,
            dep.airport_id as dep_id,
            arr.airport_id as arr_id,
            'JX00' AS prefix,
            interval '12 hours' AS duration
        FROM core_ops.dim_aircraft_fleet a,
            core_ops.dim_airports dep,
            core_ops.dim_airports arr
        WHERE a.aircraft_type = 'A350-941'
            AND dep.iata_code = 'TPE'
            AND arr.iata_code IN ('LAX', 'SFO', 'SEA')
        UNION ALL
        -- A321neo for short trip
        SELECT a.aircraft_id,
            dep.airport_id as dep_id,
            arr.airport_id as arr_id,
            'JX20' AS prefix,
            interval '2 hours' AS duration
        FROM core_ops.dim_aircraft_fleet a,
            core_ops.dim_airports dep,
            core_ops.dim_airports arr
        WHERE a.aircraft_type = 'A321neo'
            AND dep.iata_code = 'TPE'
            AND arr.iata_code IN ('MFM', 'HKG', 'BKK')
    ),
    time_series AS (
        -- from 2026/03/01-03/15
        SELECT generate_series(
                '2026-03-01 00:00:00+08'::timestamptz,
                '2026-03-15 00:00:00+08'::timestamptz,
                '1 day' -- steps
            ) AS flight_day
    )
SELECT rt.prefix || (
        row_number() OVER(
            ORDER BY ts.flight_day
        )
    ) as flight_number,
    rt.aircraft_id,
    rt.dep_id,
    rt.arr_id,
    ts.flight_day + (random() * interval '12 hours') as scheduled_departure,
    ts.flight_day + (random() * interval '12 hours') + rt.duration as scheduled_arrival,
    'Scheduled'
FROM route_template rt
    CROSS JOIN time_series ts;
-- 3. Validation
SELECT count(*)
FROM core_ops.fact_flight_schedule_2026_m03;
SELECT *
FROM core_ops.v_flight_daily_schedule
WHERE scheduled_departure::date = '2026-03-05';