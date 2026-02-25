<h1 style="background-color: #2F3944; color: #ffffff; padding: 10px; border-radius: 5px;">Postgres Aviation Analytics</h1>

<div align="left">
  <img src="https://img.shields.io/badge/Database-PostgreSQL-336791?style=for-the-badge&logo=postgresql" alt="PostgreSQL">
  <img src="https://img.shields.io/badge/Language-SQL-blue?style=for-the-badge" alt="SQL">
  <img src="https://img.shields.io/badge/Domain-Aviation-navy?style=for-the-badge" alt="Aviation">
  <img src="https://img.shields.io/badge/Status-Learning-orange?style=for-the-badge" alt="Status">
</div>

<br>

> A structured PostgreSQL learning project using real-world aviation scenarios — covering data modeling, ETL pipelines, performance tuning, and advanced features.

---

<h2 style="background-color: #98694C; color: #ffffff; padding: 8px; border-radius: 5px;">Table of Contents</h2>

- [Technical Stack](#technical-stack)
- [Learning Roadmap](#learning-roadmap)
- [Project Structure](#project-structure)
- [SQL Scripts Overview](#sql-scripts-overview)
- [Documentation Overview](#documentation-overview)

---

<h2 style="background-color: #98694C; color: #ffffff; padding: 8px; border-radius: 5px;" id="technical-stack">Technical Stack</h2>

<h3 style="background-color: #84754E; color: #ffffff; padding: 5px; border-radius: 5px;">Core Components</h3>

<ul>
  <li><strong>Database</strong>: PostgreSQL</li>
  <li><strong>Query Language</strong>: SQL (DDL · DML · DCL · Window Functions · JSONB)</li>
  <li><strong>Domain</strong>: Aviation Data Analytics</li>
  <li><strong>Techniques</strong>: Table Partitioning · RBAC · ETL Optimization · Materialized Views</li>
</ul>

---

<h2 style="background-color: #98694C; color: #ffffff; padding: 8px; border-radius: 5px;" id="learning-roadmap">Learning Roadmap</h2>

| Phase | Theme | Key Topics |
|-------|-------|-----------|
| **Phase 1 — Basics** | Database Fundamentals | PostgreSQL intro, data types, DML basics, Upsert, data integrity |
| **Phase 2 — Facts** | Fact Table Design | Fact tables, complex ingestion, aggregation, window functions, Views |
| **Phase 3 — ETL** | ETL Pipelines | Index tuning, Spark-friendly SQL, incremental load, security & roles |
| **Phase 4 — Advanced** | Advanced Features | JSONB & IoT data, table partitioning, partition maintenance, global simulation |

---

<h2 style="background-color: #98694C; color: #ffffff; padding: 8px; border-radius: 5px;" id="project-structure">Project Structure</h2>

```
postgres-aviation-analytics/
├── README.md
├── .gitignore
│
├── docs/                              # Learning notes
│   ├── phase-1-basics/
│   │   ├── 01_postgresql_intro.md
│   │   ├── 02_postgres_data_types.md
│   │   ├── 03_data_manipulation_basics.md
│   │   ├── 04_update_and_upsert.md
│   │   ├── 04_upsert_mechanics.md
│   │   ├── 05_data_integrity_constraints.md
│   │   └── 05_why_anonymous_blocks.md
│   ├── phase-2-facts/
│   │   ├── 06_fact_table_design.md
│   │   ├── 07_complex_data_ingestion.md
│   │   ├── 08_advanced_aggregation.md
│   │   ├── 09_window_functions_intro.md
│   │   └── 10_views_vs_materialized_views.md
│   ├── phase-3-etl/
│   │   ├── 11_indexing_for_etl_performance.md
│   │   ├── 12_spark_friendly_sql.md
│   │   ├── 13_incremental_load_strategies.md
│   │   └── 14_security_and_roles.md
│   └── phase-4-advanced/
│       ├── 15_jsonb_and_iot_data.md
│       ├── 16_table_partitioning.md
│       ├── 17_partition_maintenance_and_logic.md
│       └── 18_global_flight_simulation.md
│
└── sql/                               # SQL scripts
    ├── init/                          # Project initialization
    │   └── 01_initialize_project.sql
    ├── ddl/                           # Schema definitions
    │   ├── 01_create_aircraft_fleet.sql
    │   ├── 02_expanded_aviation_schema.sql
    │   ├── 03_advanced_constraints.sql
    │   └── 04_create_fact_flights.sql
    ├── dml/                           # Data insert & update operations
    │   ├── 01_insert_dim_airports.sql
    │   ├── 02_insert_dim_aircraft_fleet.sql
    │   ├── 03_insert_dim_part_inventory.sql
    │   ├── 04_update_and_upsert_ops.sql
    │   ├── 05_insert_fact_flights.sql
    │   └── apx_insert_extra_flights.sql
    ├── views/                         # Views and materialized views
    │   └── 01_ops_dashboard.sql
    ├── analytics/                     # Analytical queries
    │   ├── 01_fleet_operational_report.sql
    │   └── 02_fleet_flight_sequencing.sql
    ├── performance/                   # ETL performance tuning
    │   ├── 01_etl_optimization.sql
    │   ├── 02_optimized_extraction.sql
    │   └── 03_incremental_setup.sql
    ├── security/                      # Access control
    │   └── 01_rbac_setup.sql
    └── advanced/                      # Advanced PostgreSQL features
        ├── 01_jsonb_telemetry.sql
        ├── 02_partitioned_flights.sql
        ├── 03_production_cutover.sql
        └── 04_global_simulation.sql
```

---

<h2 style="background-color: #98694C; color: #ffffff; padding: 8px; border-radius: 5px;" id="sql-scripts-overview">SQL Scripts Overview</h2>

<h3 style="background-color: #84754E; color: #ffffff; padding: 5px; border-radius: 5px;">init/ — Initialization</h3>

| File | Description |
|------|-------------|
| `01_initialize_project.sql` | Create database and configure initial environment |

<h3 style="background-color: #84754E; color: #ffffff; padding: 5px; border-radius: 5px;">ddl/ — Schema Design</h3>

| File | Description |
|------|-------------|
| `01_create_aircraft_fleet.sql` | Create aircraft fleet dimension table |
| `02_expanded_aviation_schema.sql` | Full aviation schema (airports, flights, part inventory) |
| `03_advanced_constraints.sql` | Advanced data integrity constraints |
| `04_create_fact_flights.sql` | Create flights fact table (star schema) |

<h3 style="background-color: #84754E; color: #ffffff; padding: 5px; border-radius: 5px;">dml/ — Data Operations</h3>

| File | Description |
|------|-------------|
| `01_insert_dim_airports.sql` | Load airport dimension data |
| `02_insert_dim_aircraft_fleet.sql` | Load aircraft fleet dimension data |
| `03_insert_dim_part_inventory.sql` | Load part inventory data |
| `04_update_and_upsert_ops.sql` | UPDATE and UPSERT (`ON CONFLICT`) operations |
| `05_insert_fact_flights.sql` | Load flight fact data |
| `apx_insert_extra_flights.sql` | Appendix: additional flight sample data |

<h3 style="background-color: #84754E; color: #ffffff; padding: 5px; border-radius: 5px;">views/ — Views</h3>

| File | Description |
|------|-------------|
| `01_ops_dashboard.sql` | Flight operations dashboard (View / Materialized View) |

<h3 style="background-color: #84754E; color: #ffffff; padding: 5px; border-radius: 5px;">analytics/ — Analytical Queries</h3>

| File | Description |
|------|-------------|
| `01_fleet_operational_report.sql` | Fleet operations report (window functions, aggregation) |
| `02_fleet_flight_sequencing.sql` | Flight sequence analysis (LAG / LEAD) |

<h3 style="background-color: #84754E; color: #ffffff; padding: 5px; border-radius: 5px;">performance/ — Performance Tuning</h3>

| File | Description |
|------|-------------|
| `01_etl_optimization.sql` | ETL index strategy and query optimization |
| `02_optimized_extraction.sql` | Optimized data extraction queries |
| `03_incremental_setup.sql` | Incremental load setup (watermark pattern) |

<h3 style="background-color: #84754E; color: #ffffff; padding: 5px; border-radius: 5px;">security/ — Access Control</h3>

| File | Description |
|------|-------------|
| `01_rbac_setup.sql` | Role-based access control (RBAC) and least-privilege design |

<h3 style="background-color: #84754E; color: #ffffff; padding: 5px; border-radius: 5px;">advanced/ — Advanced Features</h3>

| File | Description |
|------|-------------|
| `01_jsonb_telemetry.sql` | JSONB storage and queries (IoT telemetry simulation) |
| `02_partitioned_flights.sql` | Declarative table partitioning (monthly range partition) |
| `03_production_cutover.sql` | Production cutover workflow (partition maintenance) |
| `04_global_simulation.sql` | Global flight simulation (large-scale batch processing) |

---

<h2 style="background-color: #98694C; color: #ffffff; padding: 8px; border-radius: 5px;" id="documentation-overview">Documentation Overview</h2>

<details>
<summary><strong>Phase 1 — Basics</strong></summary>

| File | Topic |
|------|-------|
| `01_postgresql_intro.md` | PostgreSQL introduction and architecture |
| `02_postgres_data_types.md` | Common data types |
| `03_data_manipulation_basics.md` | DML fundamentals |
| `04_update_and_upsert.md` | UPDATE and Upsert operations |
| `04_upsert_mechanics.md` | Deep dive into Upsert mechanics |
| `05_data_integrity_constraints.md` | Data integrity constraints |
| `05_why_anonymous_blocks.md` | When and why to use anonymous blocks (DO $$) |

</details>

<details>
<summary><strong>Phase 2 — Facts</strong></summary>

| File | Topic |
|------|-------|
| `06_fact_table_design.md` | Fact table design principles (star schema) |
| `07_complex_data_ingestion.md` | Complex data ingestion strategies |
| `08_advanced_aggregation.md` | Advanced aggregation functions |
| `09_window_functions_intro.md` | Introduction to window functions |
| `10_views_vs_materialized_views.md` | Views vs. materialized views |

</details>

<details>
<summary><strong>Phase 3 — ETL</strong></summary>

| File | Topic |
|------|-------|
| `11_indexing_for_etl_performance.md` | Index strategies for ETL performance |
| `12_spark_friendly_sql.md` | Writing Spark-friendly SQL |
| `13_incremental_load_strategies.md` | Incremental load strategies |
| `14_security_and_roles.md` | Security management and role design |

</details>

<details>
<summary><strong>Phase 4 — Advanced</strong></summary>

| File | Topic |
|------|-------|
| `15_jsonb_and_iot_data.md` | JSONB and IoT data handling |
| `16_table_partitioning.md` | Table partitioning strategies |
| `17_partition_maintenance_and_logic.md` | Partition maintenance and management |
| `18_global_flight_simulation.md` | Global flight simulation scenario |

</details>
