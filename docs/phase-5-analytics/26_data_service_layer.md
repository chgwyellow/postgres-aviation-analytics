# Phase 5: Data Analytics - Day 26

## 1. Concept: Data Service Layer (DSL)

- We are moving logic from raw tables to **API-ready Views**.
- This decouples the physical storage (Partitioned Tables) from the analytical consumption.
- Goal: "Single Source of Truth" for maintenance and operational metrics.

## 2. Key Metrics Standardized

- **Maintenance Health**: Using the 200/300-hour threshold for aircraft alerts.
- **Operational OTP**: Standardizing the 15-minute delay window.
- **Daily Utilization**: Correcting for timezone-aware calendar day counts.

## 3. Integration Readiness

- These views are optimized for **Airflow**, **dbt**, and **Python (Pandas/SQLAlchemy)**.
- No Stored Procedures are used to ensure maximum compatibility with modern orchestration tools.
