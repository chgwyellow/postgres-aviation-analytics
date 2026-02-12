/*
 * Project: Postgres Aviation Analytics
 * Phase: 1 - Basics
 * Day: 2 - Extended Relational Schema & Data Types
 * Description: Creating Aircraft, Airports, and Parts tables with specialized types and FK constraints.
 */
SET search_path TO core_ops,
    public;
-- Airport Dimension Table (Station Master)
-- Stores metadata about flight locations.
CREATE TABLE IF NOT EXISTS core_ops.dim_airports(
    airport_id SERIAL PRIMARY KEY,
    iata_code CHAR(3) UNIQUE NOT NULL,
    icao_code CHAR(4) UNIQUE NOT NULL,
    airport_name VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL,
    country VARCHAR(50) NOT NULL,
    timezone VARCHAR(50) NOT NULL,
    is_active BOOLEAN DEFAULT TRUE
);
-- Parts Inventory Table
-- Tracks specific high-value components linked to aircraft.
CREATE TABLE IF NOT EXISTS core_ops.parts_inventory(
    part_uuid UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    part_number VARCHAR(50) NOT NULL,
    serial_number VARCHAR(50) NOT NULL,
    part_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) CHECK (
        category IN ('Engine', 'Avionics', 'Landing Gear', 'Fuselage')
    ),
    -- ON DELETE SET NULL: If an aircraft is retired, the part record remains for history but becomes unassigned.
    assign_aircraft_id UUID REFERENCES core_ops.aircraft_fleet(aircraft_id) ON DELETE
    SET NULL,
        installation_date DATE,
        last_inspection_date TIMESTAMPTZ,
        current_status VARCHAR(20) DEFAULT 'Serviceable'
);
COMMENT ON TABLE core_ops.dim_airports IS 'Reference table for all international airports and their timezones.';
COMMENT ON TABLE core_ops.parts_inventory IS 'Inventory of critical aircraft components and their current installations.';
-- Quick validation
SELECT tc.table_name,
    kcu.column_name,
    ccu.table_name AS foreign_table_name,
    ccu.column_name AS foreign_column_name
FROM information_schema.table_constraints AS tc
    JOIN information_schema.key_column_usage as kcu ON tc.constraint_name = kcu.constraint_name
    AND tc.table_schema = kcu.table_schema
    JOIN information_schema.constraint_column_usage as ccu ON ccu.constraint_name = tc.constraint_name
WHERE tc.constraint_type = 'FOREIGN KEY'
    AND tc.table_schema = 'core_ops';