# Phase 6: Advanced Data Warehousing - Day 27

## 1. Concept: Slowly Changing Dimension (SCD) Type 2

- **Purpose**: To track historical changes in aircraft attributes (e.g., maintenance status, seat configuration).
- **Why not Type 1 (Update)**: Overwriting data loses the ability to perform point-in-time analysis.
- **Why Type 2**: We add new rows with validity periods (`effective_from` to `effective_to`) to preserve history.

## 2. Table Schema Requirements

- `effective_from`: When the status became active.
- `effective_to`: When the status was superseded (NULL means currently active).
- `is_current`: A boolean flag for high-performance filtering of the latest status.

## 3. Business Use Case

- Tracking the duration an aircraft spends in "A-Check" vs. "Active Service" to calculate true fleet availability.
