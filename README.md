<h1 style="background-color: #2F3944; color: #ffffff; padding: 10px; border-radius: 5px;">Postgres Aviation Analytics</h1>

<div align="left">
  <img src="https://img.shields.io/badge/Database-PostgreSQL-336791?style=for-the-badge&logo=postgresql" alt="PostgreSQL">
  <img src="https://img.shields.io/badge/Language-SQL-blue?style=for-the-badge" alt="SQL">
  <img src="https://img.shields.io/badge/Domain-Aviation-navy?style=for-the-badge" alt="Aviation">
  <img src="https://img.shields.io/badge/Status-Completed-brightgreen?style=for-the-badge" alt="Status">
</div>

<br>

> A structured PostgreSQL learning project using real-world aviation scenarios — covering data modeling, ETL pipelines, performance tuning, advanced analytics, and data warehousing.

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
  <li><strong>Techniques</strong>: Table Partitioning · RBAC · ETL Optimization · Materialized Views · SCD Type 2 · FDW · Concurrency Control</li>
</ul>

---

<h2 style="background-color: #98694C; color: #ffffff; padding: 8px; border-radius: 5px;" id="learning-roadmap">Learning Roadmap</h2>

| Phase | Theme | Key Topics |
|-------|-------|-----------|
| **Phase 1 — Basics** | Database Fundamentals | PostgreSQL intro, data types, DML basics, Upsert, data integrity |
| **Phase 2 — Facts** | Fact Table Design | Fact tables, complex ingestion, aggregation, window functions, Views |
| **Phase 3 — ETL** | ETL Pipelines | Index tuning, Spark-friendly SQL, incremental load, security & roles |
| **Phase 4 — Advanced** | Advanced Features | JSONB & IoT data, table partitioning, partition maintenance, global simulation, partition indexing, exclusion constraints |
| **Phase 5 — Analytics** | Operational Analytics | OTP analysis, delay simulation, ripple effect, maintenance alerts, work order generation, data service layer |
| **Phase 6 — Data Warehousing** | Data Warehousing | SCD Type 2 history tracking, FDW remote integration, concurrency control |

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
│   ├── phase-4-advanced/
│   │   ├── 15_jsonb_and_iot_data.md
│   │   ├── 16_table_partitioning.md
│   │   ├── 17_partition_maintenance_and_logic.md
│   │   ├── 18_global_flight_simulation.md
│   │   ├── 19_partition_indexing.md
│   │   └── 20_exclusion_constraints.md
│   ├── phase-5-analytics/
│   │   ├── 21_basic_operational_metrics.md
│   │   ├── 22_otp_and_delay_classification.md
│   │   ├── 23_window_functions_and_ripple_effect.md
│   │   ├── 24_maintenance_utilization.md
│   │   ├── 25_automated_maintenance_generation.md
│   │   └── 26_data_service_layer.md
│   └── phase-6-data_warehousing/
│       ├── 27_scd_type2_history.md
│       ├── 28_fdw_remote_integration.md
│       └── 29_concurrency_control.md
│
└── sql/                               # SQL scripts
    ├── init/                          # Project initialization
    │   ├── 01_initialize_project.sql
    │   └── 02_clean_duplicate_flights.sql
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
    │   ├── 02_fleet_flight_sequencing.sql
    │   ├── 03_otp_analysis.sql
    │   ├── 04_delay_simulation_and_otp.sql
    │   ├── 05_ripple_effect_analysis.sql
    │   ├── 06_maintenance_alert.sql
    │   ├── 07_work_order_generator.sql
    │   └── 08_data_api_layer.sql
    ├── performance/                   # ETL performance tuning
    │   ├── 01_etl_optimization.sql
    │   ├── 02_optimized_extraction.sql
    │   └── 03_incremental_setup.sql
    ├── security/                      # Access control
    │   └── 01_rbac_setup.sql
    ├── advanced/                      # Advanced PostgreSQL features
    │   ├── 01_jsonb_telemetry.sql
    │   ├── 02_partitioned_flights.sql
    │   ├── 03_production_cutover.sql
    │   ├── 04_global_simulation.sql
    │   ├── 05_partition_tuning.sql
    │   └── 06_exclusion_constraints.sql
    └── data_warehousing/              # Data warehousing patterns
        ├── 01_scd_type2_fleet.sql
        ├── 02_postgresql_fdw_setup.sql
        └── 03_advanced_concurrency.sql
```

---

<h2 style="background-color: #98694C; color: #ffffff; padding: 8px; border-radius: 5px;" id="sql-scripts-overview">SQL Scripts Overview</h2>

<h3 style="background-color: #84754E; color: #ffffff; padding: 5px; border-radius: 5px;">init/ — Initialization</h3>

| File | Description |
|------|-------------|
| `01_initialize_project.sql` | Create database and configure initial environment |
| `02_clean_duplicate_flights.sql` | Remove duplicate flight records for data quality |

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
| `03_otp_analysis.sql` | On-time performance (OTP) analysis |
| `04_delay_simulation_and_otp.sql` | Delay simulation and OTP classification |
| `05_ripple_effect_analysis.sql` | Delay ripple effect analysis across flight chains |
| `06_maintenance_alert.sql` | Automated maintenance alert generation |
| `07_work_order_generator.sql` | Work order generation from maintenance alerts |
| `08_data_api_layer.sql` | Data service layer (API-friendly views and functions) |

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
| `05_partition_tuning.sql` | Partition index tuning and query optimization |
| `06_exclusion_constraints.sql` | Exclusion constraints for conflict prevention |

<h3 style="background-color: #84754E; color: #ffffff; padding: 5px; border-radius: 5px;">data_warehousing/ — Data Warehousing</h3>

| File | Description |
|------|-------------|
| `01_scd_type2_fleet.sql` | SCD Type 2 history tracking for aircraft fleet |
| `02_postgresql_fdw_setup.sql` | Foreign Data Wrapper (FDW) remote integration setup |
| `03_advanced_concurrency.sql` | Concurrency control (locking strategies, MVCC) |

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
| `19_partition_indexing.md` | Partition index design and optimization |
| `20_exclusion_constraints.md` | Exclusion constraints for data integrity |

</details>

<details>
<summary><strong>Phase 5 — Analytics</strong></summary>

| File | Topic |
|------|-------|
| `21_basic_operational_metrics.md` | Basic operational metrics and KPIs |
| `22_otp_and_delay_classification.md` | On-time performance and delay classification |
| `23_window_functions_and_ripple_effect.md` | Window functions for ripple effect analysis |
| `24_maintenance_utilization.md` | Maintenance utilization tracking |
| `25_automated_maintenance_generation.md` | Automated maintenance work order generation |
| `26_data_service_layer.md` | Building a data service layer for API consumption |

</details>

<details>
<summary><strong>Phase 6 — Data Warehousing</strong></summary>

| File | Topic |
|------|-------|
| `27_scd_type2_history.md` | SCD Type 2 history tracking patterns |
| `28_fdw_remote_integration.md` | Foreign Data Wrapper remote integration |
| `29_concurrency_control.md` | Concurrency control and locking strategies |

</details>
