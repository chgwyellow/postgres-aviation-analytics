/*
 * Project: Postgres Aviation Analytics
 * Phase: 5 - Data Analytics
 * Day: 25 - Automated Maintenance Work Orders
 * Description: Generating actual tasks based on health metrics.
 */
SET search_path TO core_ops,
    public;
CREATE TABLE IF NOT EXISTS core_ops.fact_maintenance_tasks (
    task_id SERIAL PRIMARY KEY,
    aircraft_id UUID REFERENCES core_ops.dim_aircraft_fleet(aircraft_id),
    task_type VARCHAR(20) DEFAULT 'A-Check',
    trigger_hours NUMERIC(10, 1),
    status VARCHAR(20) DEFAULT 'Pending',
    created_at TIMESTAMPTZ DEFAULT NOW(),
    UNIQUE(aircraft_id, task_type, status) -- Prevent duplicate orders
);
-- Auto assign orders
INSERT INTO core_ops.fact_maintenance_tasks(aircraft_id, trigger_hours)
SELECT f.aircraft_id,
    SUM(
        GREATEST(
            EXTRACT(
                EPOCH
                FROM(f.actual_arrival - f.actual_departure)
            ) / 3600,
            0
        )
    ) AS current_hours
FROM core_ops.fact_flight_schedule f
WHERE f.status = 'Arrived'
GROUP BY f.aircraft_id
HAVING SUM(
        GREATEST(
            EXTRACT(
                EPOCH
                FROM(f.actual_arrival - f.actual_departure)
            ) / 3600,
            0
        )
    ) >= 200 ON CONFLICT (aircraft_id, task_type, status) DO NOTHING;
-- Check the orders
SELECT a.tail_number,
	a.aircraft_type,
    t.task_type,
    t.trigger_hours,
    t.status,
    t.created_at
FROM core_ops.fact_maintenance_tasks t
    JOIN core_ops.dim_aircraft_fleet a on t.aircraft_id = a.aircraft_id
WHERE t.status = 'Pending';