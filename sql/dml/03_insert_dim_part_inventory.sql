SET search_path TO core_ops,
    public;
INSERT INTO core_ops.dim_parts_inventory (
        part_number,
        serial_number,
        part_name,
        category,
        assign_aircraft_id
    )
SELECT p.part_num,
    concat('SN-', a.tail_number, '-', p.suffix) as serial_num,
    p.name,
    p.cat,
    a.aircraft_id
FROM core_ops.dim_aircraft_fleet a
    CROSS JOIN (
        VALUES ('ENG-LEAP-1A', 'Leap-1A Engine', 'Engine', 'E1'),
            (
                'LG-BRAKE-01',
                'Main Landing Gear Brake',
                'Landing Gear',
                'B1'
            ),
            (
                'AV-TRANS-X1',
                'ATC Transponder',
                'Avionics',
                'T1'
            ),
            (
                'ECS-VALVE-V2',
                'Air Conditioning Pack Valve',
                'Fuselage',
                'V1'
            ),
            (
                'STR-COWLING-L',
                'Engine Cowling Left',
                'Fuselage',
                'C1'
            )
    ) AS p(part_num, name, cat, suffix) ON CONFLICT (serial_number) DO NOTHING;
-- Verification: List part counts per aircraft type
SELECT a.aircraft_type,
    count(p.part_uuid) as component_count
FROM core_ops.dim_aircraft_fleet a
    LEFT JOIN core_ops.dim_parts_inventory p ON a.aircraft_id = p.assign_aircraft_id
GROUP BY a.aircraft_type;