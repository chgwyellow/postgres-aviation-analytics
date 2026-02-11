/*
 * Project: Postgres Aviation Analytics
 * Phase: 1 - Basics
 * Day: 1 - Database & Schema Initialization
 * Description: Setting up the initial environment and testing connectivity.
 */

-- 1. Create a dedicated schema for aviation operations
-- Using a Schema ensures organizational clarity and security isolation.
CREATE SCHEMA IF NOT EXISTS core_ops;

-- 2. Configure the search path
-- This tells PostgreSQL to look into 'core_ops' first when a table name is referenced.
SET search_path TO core_ops,
    public;

-- 3. Verify current environment status
-- Returns the active database, schema, and current user.
SELECT
	current_database() AS active_db,
	current_schema() AS active_schema,
	current_user AS db_user;

-- 4. Create a connectivity test table
-- Practice basic DDL and ensure permissions are correctly set in the new schema.
CREATE TABLE IF NOT EXISTS core_ops.connect_test (
	test_id SERIAL PRIMARY KEY,
	test_timestamp TIMESTAMP WITH TIME ZONE DEFAULT current_timestamp,
	status text DEFAULT 'Initialization Successful'
);

-- 5. Validate table creation in metadata
-- Querying the information_schema to confirm the table exists in 'core_ops'.
SELECT table_name, table_type
FROM information_schema.TABLES
WHERE table_schema = 'core_ops';