SET search_path TO core_ops,
    public;
-- 1. 清空舊的測試資料 (可選，確保乾淨)
TRUNCATE TABLE core_ops.fact_flight_schedule CASCADE;
-- 2. 批量寫入一週的航班 (利用 VALUES as Table 與 CROSS JOIN 技巧)
INSERT INTO core_ops.fact_flight_schedule (
        flight_number,
        aircraft_id,
        departure_airport_id,
        arrival_airport_id,
        scheduled_departure,
        scheduled_arrival,
        status
    ) WITH fleet AS (
        SELECT aircraft_id,
            tail_number,
            aircraft_type
        FROM core_ops.dim_aircraft_fleet
        WHERE tail_number IN ('B-58201', 'B-58301', 'B-58501')
    ),
    airports AS (
        SELECT airport_id,
            iata_code
        FROM core_ops.dim_airports
    ),
    base_schedule AS (
        -- 定義基礎航線範本
        VALUES ('JX800', 'TPE', 'NRT', '08:30:00', '12:30:00'),
            ('JX801', 'NRT', 'TPE', '14:00:00', '16:45:00'),
            ('JX822', 'TPE', 'KIX', '09:15:00', '12:50:00'),
            ('JX823', 'KIX', 'TPE', '14:30:00', '17:20:00'),
            ('JX721', 'TPE', 'SIN', '10:10:00', '15:00:00'),
            ('JX722', 'SIN', 'TPE', '16:15:00', '21:30:00')
    )
SELECT bs.column1 || '-' || d.day as flight_no,
    -- 產生如 JX800-1, JX800-2
    f.aircraft_id,
    dep.airport_id as dep_id,
    arr.airport_id as arr_id,
    -- 動態產生 2026-03-01 到 2026-03-07 的時間
    ('2026-03-0' || d.day || ' ' || bs.column4)::timestamptz as departure,
    ('2026-03-0' || d.day || ' ' || bs.column5)::timestamptz as arrival,
    'Arrived' as status
FROM base_schedule bs
    CROSS JOIN (
        SELECT generate_series(1, 7) AS day
    ) d -- 產生 7 天
    JOIN fleet f ON (
        (
            bs.column1 LIKE 'JX80%'
            AND f.aircraft_type = 'A350-941'
        )
        OR -- A350 飛東京
        (
            bs.column1 LIKE 'JX82%'
            AND f.aircraft_type = 'A330-941'
        )
        OR -- A330 飛大阪
        (
            bs.column1 LIKE 'JX72%'
            AND f.aircraft_type = 'A321neo'
        ) -- A321 飛新加坡
    )
    JOIN airports dep ON bs.column2 = dep.iata_code
    JOIN airports arr ON bs.column3 = arr.iata_code;
-- 3. 檢查數據量
SELECT count(*) as total_flights_generated
FROM core_ops.fact_flight_schedule;