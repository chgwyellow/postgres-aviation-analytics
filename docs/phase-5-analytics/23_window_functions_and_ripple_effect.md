# Phase 5: Data Analytics - Day 23

## 1. What are Window Functions?

- They perform a calculation across a set of table rows that are related to the current row.
- Key Functions: `LAG()`(previous), `LEAD()`(next), `RANK()`.

## 2. Tracking Fleet Turnaround

- We will group data by `aircraft_id` and sort by `actual_departure`.
- By comparing the "previous arrival time" with the "current departure time", we can calculate the **Turnaround Time**.
