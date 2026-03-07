/*
 * Project: Postgres Aviation Analytics
 * Phase: 6 - Advanced Data Warehousing
 * Day: 28 - Foreign Data Wrapper (FDW)
 */
CREATE EXTENSION IF NOT EXISTS postgres_fdw;
-- Define remote server
CREATE SERVER IF NOT EXISTS vendor_server FOREIGN DATA WRAPPER postgres_fdw OPTIONS (
    host 'localhost',
    port '5432',
    dbname 'vendor_db'
);
-- Create user mapping
CREATE USER MAPPING IF NOT EXISTS FOR CURRENT_USER SERVER vendor_server OPTIONS (user 'admin', password 'password');
-- Create remote agent (Foreign Table)
-- It's an assumed table
CREATE FOREIGN TABLE IF NOT EXISTS core_ops.remote_parts_catalog(
    part_id INT,
    part_name VARCHAR(100),
    stock_quantity INT,
    last_updated TIMESTAMPTZ
) SERVER vendor_server OPTIONS (
    schema_name 'public',
    table_name 'parts_inventory'
);
-- Query
SELECT t.tail_number,
    t.task_type,
    p.part_name,
    p.stock_quantity FORM core_ops.fact_maintenance_tasks t
    JOIN core_ops.remote_parts_catalog p ON p.part_name = 'A350_Engine_Filter'
WHERE t.status = 'Pending'
    AND p.stock_quantity < 5;