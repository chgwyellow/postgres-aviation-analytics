# Phase 2: Relational Design & Operations - Day 6

## 1. Dimension Tables vs. Fact Tables

- **Dimension (Dim)**: The "Who, What, Where" (e.g., Aircraft, Airports, Parts). These are relatively static.
- **Fact (Fact)**: The "When and How Much" (e.g., Flight logs, Maintenance events). These grow rapidly and record every single occurrence.

## 2. Fact Table Design Principles

- **Lean Columns**: Use Foreign Keys (IDs) instead of text descriptions to save space and ensure consistency.
- **Granularity**: Decide what one row represents (e.g., one flight leg).
- **Time-Centric**: Almost every fact table must have timestamps.
