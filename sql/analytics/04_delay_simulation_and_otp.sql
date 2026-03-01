-- Step 1: Add actual time and create delay
-- 1. Add actual dep and arr time column
ALTER TABLE core_ops.fact_flight_schedule
ADD COLUMN IF NOT EXISTS actual_departure TIMESTAMPTZ,
    ADD COLUMN IF NOT EXISTS actual_arrival TIMESTAMPTZ;
-- 2. Simulation Delay for A321neo
UPDATE core_ops.fact_flight_schedule
SET actual_departure = scheduled_departure + (random() * interval '40 minutes'),
    actual_arrival = scheduled_arrival + (random() * interval '45 minutes'),
    status = 'Arrived'
WHERE aircraft_id IN (
        SELECT aircraft_id
        FROM core_ops.dim_aircraft_fleet
        WHERE aircraft_type = 'A321neo'
    )
    AND random() < 0.15;
-- 3. Others flights are on-time
UPDATE core_ops.fact_flight_schedule
SET actual_departure = scheduled_departure,
    actual_arrival = scheduled_arrival,
    status = 'Arrived'
WHERE actual_arrival IS NULL;
-- Step 2: Calculate OTP
WITH otp_raw AS (
    SELECT a.aircraft_type,
        f.flight_number,
        EXTRACT(
            EPOCH
            FROM(f.actual_arrival - f.scheduled_arrival)
        ) / 60 AS delay_minutes
    FROM core_ops.fact_flight_schedule f
        JOIN core_ops.dim_aircraft_fleet a ON f.aircraft_id = a.aircraft_id
    WHERE f.status = 'Arrived'
)
SELECT aircraft_type,
    count(*) AS total_flights,
    -- delay < 15 mins
    (
        count(*) FILTER (
            WHERE delay_minutes < 15
        )::numeric / count(*) * 100
    )::numeric(5, 2) || '%' AS otp_percentage,
    -- Avg delay
    AVG(delay_minutes) FILTER (
        WHERE delay_minutes > 0
    )::numeric(10, 1) AS avg_delay_mins
FROM otp_raw
GROUP BY aircraft_type
ORDER BY otp_percentage DESC;