/*
 * Project: Postgres Aviation Analytics
 * Phase: 3 - ETL & Performance
 * Day: 14 - Database Security & RBAC
 * Description: Implementing the Principle of Least Privilege.
 */
-- 1. Create Roles (Group Level)
-- NO LOGIN ensures these are just groups of permissions, not individual users.
CREATE ROLE analyst_group;
CREATE ROLE data_engineer_group;
-- 2. Grant Schema Access
-- First, users must be able to "Usage" (enter) the schema.
GRANT USAGE ON SCHEMA core_ops TO analyst_group;
GRANT USAGE ON SCHEMA core_ops TO data_engineer_group;
-- 3. Analyst Permissions (ReadOnly on Views only)
-- We protect the raw tables and only let analysts see our sanitized views.
GRANT SELECT ON ALL TABLES IN SCHEMA core_ops TO analyst_group;
-- 4. Data Engineer Permissions (Full access to core_ops)
-- Engineers need to update tables and indexes for ETL performance.
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA core_ops TO data_engineer_group;
-- 5. Creating a Mock User and assigning a Role
CREATE USER arthur_dev WITH PASSWORD 'test';
GRANT data_engineer_group TO arthur_dev;
-- 6. Verification: Audit Permissions
SELECT grantee,
    table_schema,
    table_name,
    privilege_type
FROM information_schema.role_table_grants
WHERE table_schema = 'core_ops';