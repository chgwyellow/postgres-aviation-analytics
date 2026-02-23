SET search_path TO core_ops,
    public;
INSERT INTO core_ops.dim_airports (
        iata_code,
        icao_code,
        airport_name,
        city,
        country,
        timezone
    )
VALUES (
        'TPE',
        'RCTP',
        'Taiwan Taoyuan International Airport',
        'Taipei',
        'Taiwan',
        'Asia/Taipei'
    ),
    (
        'RMQ',
        'RCMQ',
        'Taichung International Airport',
        'Taichung',
        'Taiwan',
        'Asia/Taipei'
    ),
    (
        'KHH',
        'RCKH',
        'Kaohsiung International Airport',
        'Kaohsiung',
        'Taiwan',
        'Asia/Taipei'
    ),
    (
        'MFM',
        'VMMC',
        'Macau International Airport',
        'Macau',
        'Macau',
        'Asia/Macau'
    ),
    (
        'HKG',
        'VHHH',
        'Hong Kong International Airport',
        'Hong Kong',
        'China',
        'Asia/Hong_Kong'
    ),
    (
        'NRT',
        'RJAA',
        'Narita International Airport',
        'Tokyo',
        'Japan',
        'Asia/Tokyo'
    ),
    (
        'KIX',
        'RJBB',
        'Kansai International Airport',
        'Osaka',
        'Japan',
        'Asia/Tokyo'
    ),
    (
        'NGO',
        'RJGG',
        'Chubu Centrair International Airport',
        'Nagoya',
        'Japan',
        'Asia/Tokyo'
    ),
    (
        'FUK',
        'RJFF',
        'Fukuoka Airport',
        'Fukuoka',
        'Japan',
        'Asia/Tokyo'
    ),
    (
        'CTS',
        'RJCC',
        'New Chitose Airport',
        'Sapporo',
        'Japan',
        'Asia/Tokyo'
    ),
    (
        'OKA',
        'ROAH',
        'Naha Airport',
        'Okinawa',
        'Japan',
        'Asia/Tokyo'
    ),
    (
        'KMJ',
        'RJFT',
        'Kumamoto Airport',
        'Kumamoto',
        'Japan',
        'Asia/Tokyo'
    ),
    (
        'UKB',
        'RJBE',
        'Kobe Airport',
        'Kobe',
        'Japan',
        'Asia/Tokyo'
    ),
    (
        'SDJ',
        'RJSS',
        'Sendai Airport',
        'Sendai',
        'Japan',
        'Asia/Tokyo'
    ),
    (
        'HKD',
        'RJCH',
        'Hakodate Airport',
        'Hakodate',
        'Japan',
        'Asia/Tokyo'
    ),
    (
        'PUS',
        'RKPK',
        'Gimhae International Airport',
        'Busan',
        'South Korea',
        'Asia/Seoul'
    ),
    (
        'BKK',
        'VTBS',
        'Suvarnabhumi Airport',
        'Bangkok',
        'Thailand',
        'Asia/Bangkok'
    ),
    (
        'SIN',
        'WSSS',
        'Singapore Changi Airport',
        'Singapore',
        'Singapore',
        'Asia/Singapore'
    ),
    (
        'SGN',
        'VVTS',
        'Tan Son Nhat International Airport',
        'Ho Chi Minh City',
        'Vietnam',
        'Asia/Ho_Chi_Minh'
    ),
    (
        'DAD',
        'VVDN',
        'Da Nang International Airport',
        'Da Nang',
        'Vietnam',
        'Asia/Ho_Chi_Minh'
    ),
    (
        'HAN',
        'VVNB',
        'Noi Bai International Airport',
        'Hanoi',
        'Vietnam',
        'Asia/Hanoi'
    ),
    (
        'PQC',
        'VVPQ',
        'Phu Quoc International Airport',
        'Phu Quoc',
        'Vietnam',
        'Asia/Ho_Chi_Minh'
    ),
    (
        'MNL',
        'RPLL',
        'Ninoy Aquino International Airport',
        'Manila',
        'Philippines',
        'Asia/Manila'
    ),
    (
        'CEB',
        'RPVM',
        'Mactan–Cebu International Airport',
        'Cebu',
        'Philippines',
        'Asia/Manila'
    ),
    (
        'KUL',
        'WMKK',
        'Kuala Lumpur International Airport',
        'Kuala Lumpur',
        'Malaysia',
        'Asia/Kuala_Lumpur'
    ),
    (
        'CGK',
        'WIII',
        'Soekarno–Hatta International Airport',
        'Jakarta',
        'Indonesia',
        'Asia/Jakarta'
    ),
    (
        'LAX',
        'KLAX',
        'Los Angeles International Airport',
        'Los Angeles',
        'USA',
        'America/Los_Angeles'
    ),
    (
        'SFO',
        'KSFO',
        'San Francisco International Airport',
        'San Francisco',
        'USA',
        'America/Los_Angeles'
    ),
    (
        'SEA',
        'KSEA',
        'Seattle-Tacoma International Airport',
        'Seattle',
        'USA',
        'America/Los_Angeles'
    ),
    (
        'ONT',
        'KONT',
        'Ontario International Airport',
        'Ontario',
        'USA',
        'America/Los_Angeles'
    ),
    (
        'PHX',
        'KPHX',
        'Phoenix Sky Harbor International Airport',
        'Phoenix',
        'USA',
        'America/Phoenix'
    ),
    (
        'PRG',
        'LKPR',
        'Vaclav Havel Airport Prague',
        'Prague',
        'Czech Republic',
        'Europe/Prague'
    ) ON CONFLICT (iata_code) DO
UPDATE
SET airport_name = EXCLUDED.airport_name,
    city = EXCLUDED.city,
    timezone = EXCLUDED.timezone;