# Phase 3: ETL & Performance - Day 14

## 1. Role-Based Access Control (RBAC)

Instead of assigning permissions to individuals, we create "Roles" (e.g., `analyst_role`, `engineer_role`) and assign permissions to these roles.

- **Grant**: Giving permission to a role.
- **Revoke**: Taking permission away.

## 2. Principle of Least Privilege

Users should only have the minimum level of access required to perform their jobs.

- A Data Analyst might only need `SELECT` on Views.
- A Spark ETL Service Account needs `SELECT` on Tables and `INSERT` on Logs.

## 3. Schema-Level Security

You can restrict access to entire schemas (like `core_ops`), preventing unauthorized users from even seeing the table names.
