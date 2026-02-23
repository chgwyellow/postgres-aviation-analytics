# Phase 4: Advanced Patterns - Day 15

## 1. Why JSONB for IoT?

- **Schema Flexibility**: Aircraft sensors evolve. `JSONB` allows us to add new metrics (e.g., fuel flow, humidity) without a DDL change.
- **Foundry Compatibility**: Spark reads JSONB as a String or Struct, making it easy to parse in PySpark.

## 2. JSONB vs. JSON

- **JSON**: A plain text copy. Fast to write, slow to search.
- **JSONB**: Binary format. Slightly slower to write (indexing happens), but lightning-fast to query.

## 3. Key Operators to Remember

- `->` : Returns a JSON object/array.
- `->>` : Returns the field as plain TEXT.
- `::jsonb` : Type casting a string into a JSONB object.
