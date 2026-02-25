# Phase 4: Advanced Patterns - Day 18

## 1. Cross-Regional Simulation

- We will simulate flights across three regions: Northeast Asia, Southeast Asia, and North America.
- Different aircraft types (A321neo, A330-941, A350-941) will be assigned to appropriate routes.

## 2. Generating Mass Data

- Using `generate_series()` to create thousands of flights for March 2026.
- This will test our Partitioning logic and the Default Partition safety net.

## 3. Verifying View Integrity

- After the Day 17 cutover, we will use our re-established Views to query this new mass data.
