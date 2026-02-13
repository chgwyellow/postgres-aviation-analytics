/*
 * Project: Postgres Aviation Analytics
 * Phase: 1 - Basics
 * Day: 4 - Data Updates and Upsert Logic
 * Description: Practicing targeted updates and the powerful ON CONFLICT clause.
 */
SET search_path TO core_ops,
    public;
-- 1. Targeted Update: Incrementing Flight Hours
UPDATE core_ops.dim_aircraft_fleet
SET total_flight_hours = total_flight_hours + 12.5,
    total_flight_cycles = total_flight_cycles + 1,
    last_maintenance_date = CURRENT_TIMESTAMP
WHERE tail_number = 'B-58501'
RETURNING tail_number,
    total_flight_hours,
    total_flight_cycles;
-- 2. The UPSERT Challenge: Synchronizing Part Status
-- We receive a maintenance update. If the part exists, update its status.
-- If it's a new part, insert it (though here we focus on the update aspect).
WITH maintenance_update AS (
    SELECT *
    FROM (
            VALUES (
                    'SN-B-58201-E1',
                    'Under Repair',
                    '2026-02-13'::date
                ),
                (
                    'SN-B-58201-B1',
                    'Serviceable',
                    '2026-02-13'::date
                )
        ) AS t(s_num, new_status, check_date)
)
INSERT INTO core_ops.dim_parts_inventory (
        serial_number,
        current_status,
        last_inspection_date,
        part_number,
        part_name
    )
SELECT mu.s_num,
    mu.new_status,
    mu.check_date,
    'TEMP-PN',
    -- Required for new inserts, but our goal is the conflict update
    'TEMP-NAME'
FROM maintenance_update mu ON CONFLICT (serial_number) DO
UPDATE
SET -- EXCLUDED is equal to the data written failed
    current_status = EXCLUDED.current_status,
    last_inspection_date = EXCLUDED.last_inspection_date;
-- 3. Verification Query
SELECT a.tail_number,
    p.serial_number,
    p.current_status,
    p.last_inspection_date
FROM core_ops.dim_aircraft_fleet a
    JOIN core_ops.dim_parts_inventory p ON a.aircraft_id = p.assign_aircraft_id
WHERE a.tail_number = 'B-58201';