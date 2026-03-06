/*
 * Project: Postgres Aviation Analytics
 * Phase: 6 - Advanced Data Warehousing
 * Day: 27 - Slowly Changing Dimension (SCD) Type 2
 */
SET search_path TO core_ops,
    public;
-- 1. Establish the table with maintenance status
CREATE TABLE IF NOT EXISTS core_ops.dim_aircraft_status_history(
    history_id SERIAL PRIMARY KEY,
    aircraft_id UUID REFERENCES core_ops.dim_aircraft_fleet(aircraft_id),
    status_code VARCHAR(30),
    -- e.g., 'ACTIVE', 'IN_MAINTENANCE', 'GROUNDED'
    remarks TEXT,
    effective_from TIMESTAMPTZ NOT NULL,
    effective_to TIMESTAMPTZ,
    is_current BOOLEAN DEFAULT TRUE
);
-- 2. Initialize data: turn all fleets' status to 'ACTIVE'
INSERT INTO core_ops.dim_aircraft_status_history(aircraft_id, status_code, effective_from)
SELECT aircraft_id,
    'ACTIVE',
    '2026-03-01 00:00:00+08'
FROM core_ops.dim_aircraft_fleet ON CONFLICT DO NOTHING;
-- 3. Turn B-58501 to 'A-CHECK'
-- Step A: Set the effective day to now
UPDATE core_ops.dim_aircraft_status_history
SET effective_to = NOW(),
    is_current = FALSE
WHERE aircraft_id = (
        SELECT aircraft_id
        FROM core_ops.dim_aircraft_fleet
        WHERE tail_number = 'B-58501'
    )
    AND is_current = TRUE;
-- Step B: Insert new records
INSERT INTO core_ops.dim_aircraft_status_history(
        aircraft_id,
        status_code,
        remarks,
        effective_from,
        is_current
    )
SELECT aircraft_id,
    'IN_MAINTENANCE',
    'Scheduled A-Check triggered by Day 25 Alert',
    NOW(),
    TRUE
FROM core_ops.dim_aircraft_fleet
WHERE tail_number = 'B-58501';
-- 4. Check result
SELECT a.tail_number,
    h.status_code,
    h.effective_from,
    h.effective_to,
    h.is_current
FROM core_ops.dim_aircraft_status_history h
    JOIN core_ops.dim_aircraft_fleet a ON h.aircraft_id = a.aircraft_id
WHERE a.tail_number = 'B-58501'
ORDER BY h.effective_from;