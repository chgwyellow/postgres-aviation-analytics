# Phase 5: Data Analytics - Day 22

## 1. Defining OTP (On-Time Performance)

- **Standard**: A flight is "On-Time" if it arrives within 14 minutes and 59 seconds of its scheduled arrival time.
- **Delay Categories**:
  - 15-30 min: Short Delay
  - 31-60 min: Medium Delay
  - > 60 min: Major Delay

## 2. Realistic Simulation

- We need to introduce `actual_departure` and `actual_arrival` columns to compare against `scheduled` times.
