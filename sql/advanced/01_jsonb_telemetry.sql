/*
 * Project: Postgres Aviation Analytics
 * Phase: 4 - Advanced Patterns
 * Day: 15 - IoT Sensor Data with JSONB
 * Description: Handling semi-structured engine telemetry data.
 */
SET search_path TO core_ops,
    public;
-- 1. Create Telemetry Table
CREATE TABLE IF NOT EXISTS core_ops.fact_engine_telemetry (
    telemetry_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    aircraft_id UUID REFERENCES core_ops.dim_aircraft_fleet(aircraft_id),
    record_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    -- JSONB: Binary JSON for fast querying and indexing
    sensor_data JSONB NOT NULL
);
-- 2. Insert Mock IoT Data (Casting string to ::jsonb)
INSERT INTO core_ops.fact_engine_telemetry(aircraft_id, sensor_data)
VALUES(
        (
            SELECT aircraft_id
            FROM core_ops.dim_aircraft_fleet
            WHERE tail_number = 'B-58501'
        ),
        '{"engine_id": "ENG-A350-01", "temp": 750, "vibration": 0.02, "oil_pressure": 45}'::jsonb
    ),
    (
        (
            SELECT aircraft_id
            FROM core_ops.dim_aircraft_fleet
            WHERE tail_number = 'B-58501'
        ),
        '{"engine_id": "ENG-A350-01", "temp": 920, "vibration": 0.08, "oil_pressure": 42, "alert": "HIGH_TEMP"}'::jsonb
    );
-- 3. Advanced Querying: Extracting values for Spark Analysis
-- We cast the text output (->>) to integer for mathematical comparison
SELECT record_at,
    sensor_data->>'engine_id' AS engine,
    (sensor_data->>'temp')::integer AS current_stamp,
    sensor_data->>'alert' AS alert_msg
FROM core_ops.fact_engine_telemetry
WHERE (sensor_data->>'temp')::integer > 800;