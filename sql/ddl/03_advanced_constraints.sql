/*
 * Project: Postgres Aviation Analytics
 * Phase: 1 - Basics
 * Day: 5 - Advanced Constraints & Data Integrity
 * Description: Tightening business rules to prevent data corruption.
 */
SET search_path TO core_ops,
    public;
-- 1. Add specialized CHECK constraint to dim_aircraft_fleet
ALTER TABLE core_ops.dim_aircraft_fleet
ADD CONSTRAINT valid_aircraft_model CHECK (
        aircraft_type IN ('A321neo', 'A330-941', 'A350-941', 'A350-1041')
    );
-- 2. Add CHECK constraint to dim_part_inventory
-- Ensure status follows a specific lifecycle
ALTER TABLE core_ops.dim_parts_inventory
ADD CONSTRAINT valid_parts_status CHECK(
        current_status IN (
            'Serviceable',
            'Unserviceable',
            'Under Repair',
            'Scrapped'
        )
    );
-- 3. Practical Exercise: Try to break the rules (Testing)
DO $$ BEGIN
INSERT INTO core_ops.dim_aircraft_fleet(tail_number, serial_number, aircraft_type)
VALUES ('B-99999', 'MSN999', 'B777');
EXCEPTION
WHEN check_violation THEN RAISE NOTICE 'Success: Data integrity kept B777 out of our Airbus-only fleet.';
END $$;
-- 4. View all constraints in our current schema for auditing
SELECT
	conname,
	pg_get_constraintdef(oid)
FROM pg_constraint
WHERE conrelid = 'core_ops.dim_aircraft_fleet'::regclass;