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
        'MNL',
        'RPLL',
        'Ninoy Aquino International Airport',
        'Manila',
        'Philippines',
        'Asia/Manila'
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
        'OKA',
        'ROAH',
        'Naha Airport',
        'Okinawa',
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
    ) ON CONFLICT (iata_code) DO NOTHING;