# Phase 2: Relational Operations - Day 10

## 1. Standard View (Virtual Table)

- **What it is**: A stored query definition.
- **Pros**: Zero storage cost; always real-time.
- **Cons**: If the underlying query is heavy (e.g., millions of joins), it will be slow every time you select from it.

## 2. Materialized View (Physically Stored)

- **What it is**: It executes the query and **saves the result** to disk as a physical table.
- **Pros**: Blazing fast reads.
- **Cons**: Data becomes "stale" (old). You must manually or scheduled-ly `REFRESH` it.
- **Use Case**: Daily dashboard reports that don't need second-by-second updates.
