# Phase 6: Advanced Data Warehousing - Day 28

## 1. Concept: Foreign Data Wrapper (FDW)

- **Purpose**: To query data from a remote PostgreSQL instance or other databases without physical migration.
- **Why FDW**: It enables a "Federated Query" architecture, allowing to join maintenance data with external weather or vendor API data in real-time.
- **Why not SP/ETL**: Traditional ETL creates data lag. FDW provides a live link to the source of truth.

## 2. Key Components

- **Foreign Server**: Defines the remote host connection.
- **User Mapping**: Maps local DB users to remote DB credentials.
- **Foreign Table**: A proxy table that points to the remote data.

## 3. Business Use Case

- Joining your `fact_flight_schedule` with a remote `vendor_parts_catalog` to check if spare parts are available for an upcoming A-Check.
