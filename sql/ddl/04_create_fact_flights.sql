/*
 * Project: Postgres Aviation Analytics
 * Phase: 2 - Relational Operations
 * Day: 6 - Fact Table Design
 * Description: Creating the central flight fact table.
 */
SET search_path TO core_ops,
    public;
-- 1. Create the Flight Fact Table
CREATE TABLE IF NOT EXISTS core_ops.fact_flight_schedule(
    flight_uuid UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    flight_number VARCHAR(10) NOT NULL,
    -- Foreign Keys to Dimension Tables
    aircraft_id UUID REFERENCES core_ops.dim_aircraft_fleet(aircraft_id),
    departure_airport_id INTEGER REFERENCES core_ops.dim_airports(airport_id),
    arrival_airport_id INTEGER REFERENCES core_ops.dim_airports(airport_id),
    -- Schedule Information
    scheduled_departure TIMESTAMPTZ NOT NULL,
    scheduled_arrival TIMESTAMPTZ NOT NULL,
    -- Status Tracking
    status VARCHAR(20) DEFAULT 'Scheduled' CHECK (
        status IN (
            'Scheduled',
            'On Time',
            'Delayed',
            'Departed',
            'Arrived',
            'Cancelled'
        )
    ),
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    -- Logical Constraint: Departure must be before arrival
    CONSTRAINT flight_time_check CHECK(scheduled_arrival > scheduled_departure)
);
-- 2. Add documentation
COMMENT ON Table core_ops.fact_flight_schedule IS 'Central fact table recording every planned and executed flight leg.';
-- 3. Verify the Foreign Key links
SELECT conname as constraint_name,
    pg_get_constraintdef(oid) as definition
FROM pg_constraint
WHERE conrelid = 'core_ops.fact_flight_schedule'::regclass;