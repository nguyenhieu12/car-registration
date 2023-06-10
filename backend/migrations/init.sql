CREATE
EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE
EXTENSION IF NOT EXISTS CITEXT;

create table if not exists inspection
(
    no
    serial,
    inspection_id
    integer not null,
    registration_id varchar
(
    255
) not null,
    inspection_date date not null,
    expiry_date date not null,
    station_code varchar
(
    255
) not null
    );

alter table inspection
    owner to postgres;

alter table inspection
    add primary key (no);

create table if not exists vehicle
(
    registration_id varchar
(
    255
) not null,
    inspection_id varchar
(
    255
) not null,
    registration_date date not null,
    place_of_registration varchar
(
    255
) not null,
    chassis_number varchar
(
    255
) not null,
    engine_number varchar
(
    255
) not null,
    vin_id varchar
(
    255
) not null,
    manufactured_country varchar
(
    255
) not null,
    manufactured_year integer not null,
    brand varchar
(
    255
) not null,
    model_code varchar
(
    255
) not null,
    color varchar
(
    255
) not null,
    owner_id uuid not null
    );

alter table vehicle
    owner to postgres;

alter table vehicle
    add primary key (registration_id);

alter table inspection
    add foreign key (registration_id) references vehicle;

create table if not exists owner
(
    owner_id uuid default uuid_generate_v4
(
) not null,
    owner_type varchar
(
    255
) not null,
    full_name varchar
(
    255
) not null,
    address varchar
(
    255
) not null,
    person_identity_number varchar
(
    255
),
    tax_identity_number varchar
(
    255
)
    );

alter table owner
    owner to postgres;

alter table owner
    add primary key (owner_id);

alter table vehicle
    add foreign key (owner_id) references owner;

create table users
(
    user_id       uuid                        default uuid_generate_v4() not null,
    user_name     varchar(255)                                           not null
        unique,
    role          varchar(255),
    full_name     varchar(255),
    first_name    varchar(255),
    last_name     varchar(255),
    station_code  varchar(255),
    password      varchar(255)                                           not null,
    email         varchar(255)                                           not null,
    date_of_birth timestamp with time zone,
    gender        varchar(255),
    about         varchar(255),
    avatar        varchar(255),
    phone_number  varchar(255),
    identity_no   varchar(255),
    created_at    timestamp with time zone    default now(),
    updated_at    timestamp with time zone    default CURRENT_TIMESTAMP,
    login_date    timestamp(0) with time zone default CURRENT_TIMESTAMP
);

alter table "users"
    owner to postgres;

alter table "users"
    add primary key (user_id);

alter table "users"
    add unique (user_name);

create table if not exists area
(
    province varchar
(
    255
) not null,
    area varchar
(
    255
) not null
    );

alter table area
    owner to postgres;

alter table area
    add primary key (province);

create table if not exists station
(
    station_id
    serial,
    station_code
    varchar
(
    255
),
    station_name varchar
(
    255
) not null,
    province varchar
(
    255
) not null,
    station_url varchar
(
    255
),
    station_hotline varchar
(
    255
),
    station_address varchar
(
    255
),
    station_email varchar
(
    255
),
    station_map_source varchar
(
    255
),
    station_manager varchar
(
    255
) not null
    );

alter table station
    owner to postgres;

alter table station
    add primary key (station_id);

alter table station
    add unique (station_code);

alter table inspection
    add foreign key (station_code) references station (station_code);

alter table "users"
    add foreign key (station_code) references station (station_code);

alter table station
    add foreign key (province) references area;

create table if not exists vehicledetails
(
    vin_id varchar
(
    255
) not null,
    mark varchar
(
    255
),
    manufactured_year integer,
    model_code varchar
(
    255
),
    type varchar
(
    255
),
    commercial_use varchar
(
    255
),
    modification varchar
(
    255
),
    wheel_formula varchar
(
    255
),
    wheel_tread varchar
(
    255
),
    overall_dimension varchar
(
    255
),
    largest_luggage_container_dimension varchar
(
    255
),
    wheel_base varchar
(
    255
),
    kerb_mass varchar
(
    255
),
    design__authorized_pay_load varchar
(
    255
),
    design__authorized_towed_mass varchar
(
    255
),
    design__authorized_total_mass varchar
(
    255
),
    permissible_no_of_per_carried integer,
    seat integer,
    stood_place integer,
    laying_place integer,
    type_of_fuel_used varchar
(
    255
),
    max_output varchar
(
    255
),
    rpm integer,
    engine_displacement varchar
(
    255
),
    number_of_tires integer,
    tires_size__axle varchar
(
    255
),
    equipped_with_tachograph boolean,
    equipped_with_camera boolean,
    notes text
    );

alter table vehicledetails
    owner to postgres;

alter table vehicledetails
    add primary key (vin_id);

alter table vehicle
    add foreign key (vin_id) references vehicledetails;


-- Insert to vehicleDetails
INSERT INTO public.vehicledetails (vin_id, mark, manufactured_year, model_code, type, commercial_use, modification,
                                   wheel_formula, wheel_tread, overall_dimension, largest_luggage_container_dimension,
                                   wheel_base, kerb_mass, design__authorized_pay_load, design__authorized_towed_mass,
                                   design__authorized_total_mass, permissible_no_of_per_carried, seat, stood_place,
                                   laying_place, type_of_fuel_used, max_output, rpm, engine_displacement,
                                   number_of_tires, tires_size__axle, equipped_with_tachograph, equipped_with_camera,
                                   notes)
VALUES ('1FTEW1E48LF', 'Ford', 2020, 'F-150', 'Ô tô con', 'True', null, '4x2', '1690', '4850', 'none', '2923', '2147',
        'none', 'none', '2950/2950', null, 5, 0, 0, 'Xăng', '66', 6000, null, 2, '255/55R20', false, true,
        'Biển đăng ký nền vàng');
INSERT INTO public.vehicledetails (vin_id, mark, manufactured_year, model_code, type, commercial_use, modification,
                                   wheel_formula, wheel_tread, overall_dimension, largest_luggage_container_dimension,
                                   wheel_base, kerb_mass, design__authorized_pay_load, design__authorized_towed_mass,
                                   design__authorized_total_mass, permissible_no_of_per_carried, seat, stood_place,
                                   laying_place, type_of_fuel_used, max_output, rpm, engine_displacement,
                                   number_of_tires, tires_size__axle, equipped_with_tachograph, equipped_with_camera,
                                   notes)
VALUES ('1HGCT1B83EA', 'Honda', 2014, 'Accord EX-L', 'Ô tô con', 'True', null, '4x2', '1773', '4869', null, '2776',
        '2105', 'none', 'none', '2950/2951', null, 5, 0, 0, 'Dầu', '66', 5805, null, 2, '255/55R21', false, true,
        'Biển đăng ký nền xanh');
INSERT INTO public.vehicledetails (vin_id, mark, manufactured_year, model_code, type, commercial_use, modification,
                                   wheel_formula, wheel_tread, overall_dimension, largest_luggage_container_dimension,
                                   wheel_base, kerb_mass, design__authorized_pay_load, design__authorized_towed_mass,
                                   design__authorized_total_mass, permissible_no_of_per_carried, seat, stood_place,
                                   laying_place, type_of_fuel_used, max_output, rpm, engine_displacement,
                                   number_of_tires, tires_size__axle, equipped_with_tachograph, equipped_with_camera,
                                   notes)
VALUES ('1V2KR2CA7NC', 'Volkswagen', 2022, 'Atlas 4Motion', 'Ô tô con', 'True', null, '4x2', '1498', '4716', null,
        '2982', '2324', 'none', 'none', '2950/2952', null, 5, 0, 0, 'Dầu', '74', 6062, null, 2, '255/55R22', false,
        true, 'Biển đăng ký nền vàng');
INSERT INTO public.vehicledetails (vin_id, mark, manufactured_year, model_code, type, commercial_use, modification,
                                   wheel_formula, wheel_tread, overall_dimension, largest_luggage_container_dimension,
                                   wheel_base, kerb_mass, design__authorized_pay_load, design__authorized_towed_mass,
                                   design__authorized_total_mass, permissible_no_of_per_carried, seat, stood_place,
                                   laying_place, type_of_fuel_used, max_output, rpm, engine_displacement,
                                   number_of_tires, tires_size__axle, equipped_with_tachograph, equipped_with_camera,
                                   notes)
VALUES ('4JGFF5KE1LA', 'Mercedes-Benz', 2020, 'GLS450-4M', 'Ô tô con', 'True', null, '4x2', '1502', '4725', null,
        '2969', '2175', 'none', 'none', '2950/2953', null, 5, 0, 0, 'Xăng', '63', 6167, null, 2, '255/55R23', false,
        true, 'Biển đăng ký nền xanh');
INSERT INTO public.vehicledetails (vin_id, mark, manufactured_year, model_code, type, commercial_use, modification,
                                   wheel_formula, wheel_tread, overall_dimension, largest_luggage_container_dimension,
                                   wheel_base, kerb_mass, design__authorized_pay_load, design__authorized_towed_mass,
                                   design__authorized_total_mass, permissible_no_of_per_carried, seat, stood_place,
                                   laying_place, type_of_fuel_used, max_output, rpm, engine_displacement,
                                   number_of_tires, tires_size__axle, equipped_with_tachograph, equipped_with_camera,
                                   notes)
VALUES ('4T1BF1FK4DU', 'Toyota', 2013, 'Camry', 'Ô tô con', 'True', null, '4x2', '1807', '4854', null, '2978', '2067',
        'none', 'none', '2950/2954', null, 5, 0, 0, 'Dầu', '56', 5991, null, 2, '255/55R24', false, true,
        'Biển đăng ký nền trắng');
INSERT INTO public.vehicledetails (vin_id, mark, manufactured_year, model_code, type, commercial_use, modification,
                                   wheel_formula, wheel_tread, overall_dimension, largest_luggage_container_dimension,
                                   wheel_base, kerb_mass, design__authorized_pay_load, design__authorized_towed_mass,
                                   design__authorized_total_mass, permissible_no_of_per_carried, seat, stood_place,
                                   laying_place, type_of_fuel_used, max_output, rpm, engine_displacement,
                                   number_of_tires, tires_size__axle, equipped_with_tachograph, equipped_with_camera,
                                   notes)
VALUES ('4T1BF1FKXEU', 'Toyota', 2014, 'Camry', 'Ô tô con', 'True', null, '4x2', '1682', '4895', null, '3120', '2074',
        'none', 'none', '2950/2955', null, 5, 0, 0, 'Xăng', '72', 5987, null, 2, '255/55R25', false, true,
        'Biển đăng ký nền trắng');
INSERT INTO public.vehicledetails (vin_id, mark, manufactured_year, model_code, type, commercial_use, modification,
                                   wheel_formula, wheel_tread, overall_dimension, largest_luggage_container_dimension,
                                   wheel_base, kerb_mass, design__authorized_pay_load, design__authorized_towed_mass,
                                   design__authorized_total_mass, permissible_no_of_per_carried, seat, stood_place,
                                   laying_place, type_of_fuel_used, max_output, rpm, engine_displacement,
                                   number_of_tires, tires_size__axle, equipped_with_tachograph, equipped_with_camera,
                                   notes)
VALUES ('4T1BG28K9YU', 'Toyota', 2000, 'Camry', 'Ô tô con', 'True', null, '4x2', '1816', '4862', null, '2808', '2241',
        'none', 'none', '2950/2956', null, 5, 0, 0, 'Dầu', '62', 5921, null, 2, '255/55R26', false, true,
        'Biển đăng ký nền xanh');
INSERT INTO public.vehicledetails (vin_id, mark, manufactured_year, model_code, type, commercial_use, modification,
                                   wheel_formula, wheel_tread, overall_dimension, largest_luggage_container_dimension,
                                   wheel_base, kerb_mass, design__authorized_pay_load, design__authorized_towed_mass,
                                   design__authorized_total_mass, permissible_no_of_per_carried, seat, stood_place,
                                   laying_place, type_of_fuel_used, max_output, rpm, engine_displacement,
                                   number_of_tires, tires_size__axle, equipped_with_tachograph, equipped_with_camera,
                                   notes)
VALUES ('5NMS2DAJXNH', 'Hyundai', 2022, 'Santa Fe', 'Ô tô con', 'True', null, '4x2', '1656', '5040', null, '2824',
        '2270', 'none', 'none', '2950/2957', null, 5, 0, 0, 'Xăng', '65', 5975, null, 2, '255/55R27', false, true,
        'Biển đăng ký nền vàng');
INSERT INTO public.vehicledetails (vin_id, mark, manufactured_year, model_code, type, commercial_use, modification,
                                   wheel_formula, wheel_tread, overall_dimension, largest_luggage_container_dimension,
                                   wheel_base, kerb_mass, design__authorized_pay_load, design__authorized_towed_mass,
                                   design__authorized_total_mass, permissible_no_of_per_carried, seat, stood_place,
                                   laying_place, type_of_fuel_used, max_output, rpm, engine_displacement,
                                   number_of_tires, tires_size__axle, equipped_with_tachograph, equipped_with_camera,
                                   notes)
VALUES ('5TDJKRFH3ES', 'Toyota', 2014, 'Highlander XLE ', 'Ô tô con', 'True', null, '4x2', '1848', '4863', null, '2803',
        '2070', 'none', 'none', '2950/2958', null, 5, 0, 0, 'Dầu', '63', 6012, null, 2, '255/55R28', false, true,
        'Biển đăng ký nền đỏ');
INSERT INTO public.vehicledetails (vin_id, mark, manufactured_year, model_code, type, commercial_use, modification,
                                   wheel_formula, wheel_tread, overall_dimension, largest_luggage_container_dimension,
                                   wheel_base, kerb_mass, design__authorized_pay_load, design__authorized_towed_mass,
                                   design__authorized_total_mass, permissible_no_of_per_carried, seat, stood_place,
                                   laying_place, type_of_fuel_used, max_output, rpm, engine_displacement,
                                   number_of_tires, tires_size__axle, equipped_with_tachograph, equipped_with_camera,
                                   notes)
VALUES ('5UX23EM08P9', 'BMW', 2023, 'X7', 'Ô tô con', 'True', null, '4x2', '1635', '4673', null, '3090', '2102', 'none',
        'none', '2950/2959', null, 5, 0, 0, 'Dầu', '64', 6052, null, 2, '255/55R29', false, true,
        'Biển đăng ký nền trắng');
INSERT INTO public.vehicledetails (vin_id, mark, manufactured_year, model_code, type, commercial_use, modification,
                                   wheel_formula, wheel_tread, overall_dimension, largest_luggage_container_dimension,
                                   wheel_base, kerb_mass, design__authorized_pay_load, design__authorized_towed_mass,
                                   design__authorized_total_mass, permissible_no_of_per_carried, seat, stood_place,
                                   laying_place, type_of_fuel_used, max_output, rpm, engine_displacement,
                                   number_of_tires, tires_size__axle, equipped_with_tachograph, equipped_with_camera,
                                   notes)
VALUES ('5XYP3DHC9NG', 'KIA', 2022, 'Telluride', 'Ô tô con', 'True', null, '4x2', '1804', '5038', null, '3067', '2333',
        'none', 'none', '2950/2960', null, 5, 0, 0, 'Dầu', '76', 6084, null, 2, '255/55R30', false, true,
        'Biển đăng ký nền vàng');
INSERT INTO public.vehicledetails (vin_id, mark, manufactured_year, model_code, type, commercial_use, modification,
                                   wheel_formula, wheel_tread, overall_dimension, largest_luggage_container_dimension,
                                   wheel_base, kerb_mass, design__authorized_pay_load, design__authorized_towed_mass,
                                   design__authorized_total_mass, permissible_no_of_per_carried, seat, stood_place,
                                   laying_place, type_of_fuel_used, max_output, rpm, engine_displacement,
                                   number_of_tires, tires_size__axle, equipped_with_tachograph, equipped_with_camera,
                                   notes)
VALUES ('JTEBU5JR8E5', 'Toyota', 2014, '4Runner', 'Ô tô con', 'True', null, '4x2', '1856', '4729', null, '2942', '2068',
        'none', 'none', '2950/2961', null, 5, 0, 0, 'Dầu', '72', 5922, null, 2, '255/55R31', false, true,
        'Biển đăng ký nền trắng');
INSERT INTO public.vehicledetails (vin_id, mark, manufactured_year, model_code, type, commercial_use, modification,
                                   wheel_formula, wheel_tread, overall_dimension, largest_luggage_container_dimension,
                                   wheel_base, kerb_mass, design__authorized_pay_load, design__authorized_towed_mass,
                                   design__authorized_total_mass, permissible_no_of_per_carried, seat, stood_place,
                                   laying_place, type_of_fuel_used, max_output, rpm, engine_displacement,
                                   number_of_tires, tires_size__axle, equipped_with_tachograph, equipped_with_camera,
                                   notes)
VALUES ('JTHBF30G225', 'Lexus', 2002, 'Lexus ES300', 'Ô tô con', 'True', null, '4x2', '1670', '4877', null, '3105',
        '2112', 'none', 'none', '2950/2962', null, 5, 0, 0, 'Dầu', '59', 6056, null, 2, '255/55R32', false, true,
        'Biển đăng ký nền vàng');
INSERT INTO public.vehicledetails (vin_id, mark, manufactured_year, model_code, type, commercial_use, modification,
                                   wheel_formula, wheel_tread, overall_dimension, largest_luggage_container_dimension,
                                   wheel_base, kerb_mass, design__authorized_pay_load, design__authorized_towed_mass,
                                   design__authorized_total_mass, permissible_no_of_per_carried, seat, stood_place,
                                   laying_place, type_of_fuel_used, max_output, rpm, engine_displacement,
                                   number_of_tires, tires_size__axle, equipped_with_tachograph, equipped_with_camera,
                                   notes)
VALUES ('JTJAB7CX0P4', 'Lexus', 2023, 'LX600', 'Ô tô con', 'True', null, '4x2', '1492', '4668', null, '3069', '2047',
        'none', 'none', '2950/2963', null, 5, 0, 0, 'Xăng', '61', 6018, null, 2, '255/55R33', false, true,
        'Biển đăng ký nền đỏ');
INSERT INTO public.vehicledetails (vin_id, mark, manufactured_year, model_code, type, commercial_use, modification,
                                   wheel_formula, wheel_tread, overall_dimension, largest_luggage_container_dimension,
                                   wheel_base, kerb_mass, design__authorized_pay_load, design__authorized_towed_mass,
                                   design__authorized_total_mass, permissible_no_of_per_carried, seat, stood_place,
                                   laying_place, type_of_fuel_used, max_output, rpm, engine_displacement,
                                   number_of_tires, tires_size__axle, equipped_with_tachograph, equipped_with_camera,
                                   notes)
VALUES ('JTMCY7AJXM4', 'Toyota', 2021, 'Land Cruiser', 'Ô tô con', 'True', null, '4x2', '1579', '4995', null, '2986',
        '2017', 'none', 'none', '2950/2964', null, 5, 0, 0, 'Dầu', '64', 5872, null, 2, '255/55R34', false, true,
        'Biển đăng ký nền trắng');
INSERT INTO public.vehicledetails (vin_id, mark, manufactured_year, model_code, type, commercial_use, modification,
                                   wheel_formula, wheel_tread, overall_dimension, largest_luggage_container_dimension,
                                   wheel_base, kerb_mass, design__authorized_pay_load, design__authorized_towed_mass,
                                   design__authorized_total_mass, permissible_no_of_per_carried, seat, stood_place,
                                   laying_place, type_of_fuel_used, max_output, rpm, engine_displacement,
                                   number_of_tires, tires_size__axle, equipped_with_tachograph, equipped_with_camera,
                                   notes)
VALUES ('SALGV2RE8JA', 'Land Rover', 2018, 'Range Rover AUTOBIOGRAPHY', 'Ô tô con', 'True', null, '4x2', '1627', '4835',
        null, '2894', '2147', 'none', 'none', '2950/2965', null, 5, 0, 0, 'Dầu', '62', 6174, null, 2, '255/55R35',
        false, true, 'Biển đăng ký nền trắng');
INSERT INTO public.vehicledetails (vin_id, mark, manufactured_year, model_code, type, commercial_use, modification,
                                   wheel_formula, wheel_tread, overall_dimension, largest_luggage_container_dimension,
                                   wheel_base, kerb_mass, design__authorized_pay_load, design__authorized_towed_mass,
                                   design__authorized_total_mass, permissible_no_of_per_carried, seat, stood_place,
                                   laying_place, type_of_fuel_used, max_output, rpm, engine_displacement,
                                   number_of_tires, tires_size__axle, equipped_with_tachograph, equipped_with_camera,
                                   notes)
VALUES ('SALGW2RE6LA', 'Land Rover', 2020, 'Range Rover Sport HSE', 'Ô tô con', 'True', null, '4x2', '1669', '4868',
        null, '3009', '2021', 'none', 'none', '2950/2966', null, 5, 0, 0, 'Dầu', '56', 5883, null, 2, '255/55R36',
        false, true, 'Biển đăng ký nền vàng');
INSERT INTO public.vehicledetails (vin_id, mark, manufactured_year, model_code, type, commercial_use, modification,
                                   wheel_formula, wheel_tread, overall_dimension, largest_luggage_container_dimension,
                                   wheel_base, kerb_mass, design__authorized_pay_load, design__authorized_towed_mass,
                                   design__authorized_total_mass, permissible_no_of_per_carried, seat, stood_place,
                                   laying_place, type_of_fuel_used, max_output, rpm, engine_displacement,
                                   number_of_tires, tires_size__axle, equipped_with_tachograph, equipped_with_camera,
                                   notes)
VALUES ('W1NYC7HJ0MX', 'Mercedes-Benz', 2021, 'AMG G 63', 'Ô tô con', 'True', null, '4x2', '1517', '4677', null, '2768',
        '2312', 'none', 'none', '2950/2967', null, 5, 0, 0, 'Xăng', '64', 6007, null, 2, '255/55R37', false, true,
        'Biển đăng ký nền trắng');
INSERT INTO public.vehicledetails (vin_id, mark, manufactured_year, model_code, type, commercial_use, modification,
                                   wheel_formula, wheel_tread, overall_dimension, largest_luggage_container_dimension,
                                   wheel_base, kerb_mass, design__authorized_pay_load, design__authorized_towed_mass,
                                   design__authorized_total_mass, permissible_no_of_per_carried, seat, stood_place,
                                   laying_place, type_of_fuel_used, max_output, rpm, engine_displacement,
                                   number_of_tires, tires_size__axle, equipped_with_tachograph, equipped_with_camera,
                                   notes)
VALUES ('WA1LXAF76MD', 'Audi', 2021, 'Q7 PREMIUM PLUS', 'Ô tô con', 'True', null, '4x2', '1619', '4707', null, '2807',
        '2082', 'none', 'none', '2950/2968', null, 5, 0, 0, 'Dầu', '60', 6048, null, 2, '255/55R38', false, true,
        'Biển đăng ký nền vàng');
INSERT INTO public.vehicledetails (vin_id, mark, manufactured_year, model_code, type, commercial_use, modification,
                                   wheel_formula, wheel_tread, overall_dimension, largest_luggage_container_dimension,
                                   wheel_base, kerb_mass, design__authorized_pay_load, design__authorized_towed_mass,
                                   design__authorized_total_mass, permissible_no_of_per_carried, seat, stood_place,
                                   laying_place, type_of_fuel_used, max_output, rpm, engine_displacement,
                                   number_of_tires, tires_size__axle, equipped_with_tachograph, equipped_with_camera,
                                   notes)
VALUES ('WBA7F2C56KB', 'BMW', 2019, '7-Series 750i', 'Ô tô con', 'True', null, '4x2', '1618', '4827', null, '2965',
        '2012', 'none', 'none', '2950/2969', null, 5, 0, 0, 'Dầu', '74', 5999, null, 2, '255/55R39', false, true,
        'Biển đăng ký nền trắng');
INSERT INTO public.vehicledetails (vin_id, mark, manufactured_year, model_code, type, commercial_use, modification,
                                   wheel_formula, wheel_tread, overall_dimension, largest_luggage_container_dimension,
                                   wheel_base, kerb_mass, design__authorized_pay_load, design__authorized_towed_mass,
                                   design__authorized_total_mass, permissible_no_of_per_carried, seat, stood_place,
                                   laying_place, type_of_fuel_used, max_output, rpm, engine_displacement,
                                   number_of_tires, tires_size__axle, equipped_with_tachograph, equipped_with_camera,
                                   notes)
VALUES ('YV1CZ91H341', 'Volvo', 2004, 'XC90', 'Ô tô con', 'True', null, '4x2', '1519', '4956', null, '3051', '2249',
        'none', 'none', '2950/2970', null, 5, 0, 0, 'Xăng', '64', 5856, null, 2, '255/55R40', false, true,
        'Biển đăng ký nền vàng');


-- Insert to owner
INSERT INTO public.owner (owner_id, owner_type, full_name, address, person_identity_number, tax_identity_number)
VALUES ('263cb675-6697-4aa7-aa2e-c8fa79a0156c', 'Cá nhân', 'Đăng Đào', 'Hà Nội', '83740460251', null);
INSERT INTO public.owner (owner_id, owner_type, full_name, address, person_identity_number, tax_identity_number)
VALUES ('7504cb30-cd1c-4809-8783-1d4361e9dbd3', 'Cá nhân', 'Hiếu Nguyễn', 'Hà Nội', '52948079032', null);
INSERT INTO public.owner (owner_id, owner_type, full_name, address, person_identity_number, tax_identity_number)
VALUES ('a9254c87-c571-4f0a-b3f6-ba5a15b415d6', 'Cá nhân', 'Hoàn Nguyễn', 'Hà Nội', '65946056443', null);
INSERT INTO public.owner (owner_id, owner_type, full_name, address, person_identity_number, tax_identity_number)
VALUES ('cbf6c313-ac46-430e-b107-29bc4d790216', 'Doanh nghiệp', 'Công ty TNHH APlus Web', 'Hà Nội', null,
        '17676641771');
INSERT INTO public.owner (owner_id, owner_type, full_name, address, person_identity_number, tax_identity_number)
VALUES ('f5f1cae3-f8de-4716-a3e5-af4ec43232d6', 'Doanh nghiệp', 'Công ty TNHH Destroy Web', 'Hà Nội', null,
        '89486825154');
INSERT INTO public.owner (owner_id, owner_type, full_name, address, person_identity_number, tax_identity_number)
VALUES ('bf7b74f2-c2e3-4455-92c1-a4a7dc0674a0', 'Cá nhân', 'Phạm Hữu Tâm', 'Hà Nội', '77404778471', null);
INSERT INTO public.owner (owner_id, owner_type, full_name, address, person_identity_number, tax_identity_number)
VALUES ('2fb0a318-445c-4d61-bca6-3fea849924f0', 'Cá nhân', 'Đỗ Việt Hải', 'Hà Nội', '70150524806', null);
INSERT INTO public.owner (owner_id, owner_type, full_name, address, person_identity_number, tax_identity_number)
VALUES ('a8fbab38-66ec-41f3-abae-e299df72dede', 'Cá nhân', 'Hoàng Tấn Trương', 'Hà Nội', '73520441140', null);
INSERT INTO public.owner (owner_id, owner_type, full_name, address, person_identity_number, tax_identity_number)
VALUES ('3d672e1a-7149-43aa-8097-ee493d653085', 'Cá nhân', 'Nguyễn Tuấn Hùng', 'Hà Nội', '55778367064', null);
INSERT INTO public.owner (owner_id, owner_type, full_name, address, person_identity_number, tax_identity_number)
VALUES ('4ac45e07-b72a-4301-afb9-300a6066d8e0', 'Cá nhân', 'Đặng Ðình Trung', 'Hà Nội', '69227155416', null);
INSERT INTO public.owner (owner_id, owner_type, full_name, address, person_identity_number, tax_identity_number)
VALUES ('f9cc6f5b-f009-43f4-a297-ac55f696e33e', 'Cá nhân', 'Nguyễn Thiên Hương', 'Hà Nội', '70819280510', null);
INSERT INTO public.owner (owner_id, owner_type, full_name, address, person_identity_number, tax_identity_number)
VALUES ('a8799386-700a-415c-8331-0800fc1f59c3', 'Cá nhân', 'Bùi Phương Hạnh', 'Hà Nội', '28125286602', null);
INSERT INTO public.owner (owner_id, owner_type, full_name, address, person_identity_number, tax_identity_number)
VALUES ('96cc31d9-83f4-4264-99d0-5253d36bc0c9', 'Cá nhân', 'Ngô Trà Giang', 'Hà Nội', '39228580246', null);
INSERT INTO public.owner (owner_id, owner_type, full_name, address, person_identity_number, tax_identity_number)
VALUES ('213f9eec-6bd7-4eee-8398-340db44a8fa9', 'Cá nhân', 'Lê Khánh Vân', 'Hà Nội', '29079268670', null);
INSERT INTO public.owner (owner_id, owner_type, full_name, address, person_identity_number, tax_identity_number)
VALUES ('18666fc1-3be6-49bc-ae6c-9fff98751b43', 'Cá nhân', 'Tống Minh Hà', 'Hà Nội', '55351622184', null);


-- Insert to vehicle
INSERT INTO public.vehicle (registration_id, inspection_id, registration_date, place_of_registration, chassis_number,
                            engine_number, vin_id, manufactured_country, manufactured_year, brand, model_code, color,
                            owner_id)
VALUES ('29A00111', '12358', '2001-03-09', 'Nam Từ Liêm, Hà Nội', '4T1BG28K9YU625180', 'BG28K9Y4T100', '4T1BG28K9YU',
        'Mỹ', 2000, 'Toyota', 'Camry', 'Đỏ', 'f9cc6f5b-f009-43f4-a297-ac55f696e33e');
INSERT INTO public.vehicle (registration_id, inspection_id, registration_date, place_of_registration, chassis_number,
                            engine_number, vin_id, manufactured_country, manufactured_year, brand, model_code, color,
                            owner_id)
VALUES ('29A80157', '12359', '2001-09-08', 'Cầu Giấy, Hà Nội', '4T1BG28K9YU625180', 'BG28K9Y4T100', '4T1BG28K9YU', 'Mỹ',
        2000, 'Toyota', 'Camry', 'Đen', '96cc31d9-83f4-4264-99d0-5253d36bc0c9');
INSERT INTO public.vehicle (registration_id, inspection_id, registration_date, place_of_registration, chassis_number,
                            engine_number, vin_id, manufactured_country, manufactured_year, brand, model_code, color,
                            owner_id)
VALUES ('30A18821', '12360', '2001-06-27', 'Cầu Giấy, Hà Nội', '4T1BG28K9YU625180', 'BG28K9Y4T100', '4T1BG28K9YU', 'Mỹ',
        2000, 'Toyota', 'Camry', 'Đen', 'bf7b74f2-c2e3-4455-92c1-a4a7dc0674a0');
INSERT INTO public.vehicle (registration_id, inspection_id, registration_date, place_of_registration, chassis_number,
                            engine_number, vin_id, manufactured_country, manufactured_year, brand, model_code, color,
                            owner_id)
VALUES ('30A54084', '12361', '2001-09-14', 'Nam Từ Liêm, Hà Nội', '4T1BG28K9YU625180', 'BG28K9Y4T100', '4T1BG28K9YU',
        'Mỹ', 2000, 'Toyota', 'Camry', 'Đỏ', 'f5f1cae3-f8de-4716-a3e5-af4ec43232d6');
INSERT INTO public.vehicle (registration_id, inspection_id, registration_date, place_of_registration, chassis_number,
                            engine_number, vin_id, manufactured_country, manufactured_year, brand, model_code, color,
                            owner_id)
VALUES ('30A38454', '12362', '2001-02-21', 'Hai Bà Trưng, Hà Nội', 'JTHBF30G225036752', 'EW1E48L1FT20', 'JTHBF30G225',
        'Nhật Bản', 2002, 'Lexus', 'Lexus ES300', 'Bạc', '263cb675-6697-4aa7-aa2e-c8fa79a0156c');
INSERT INTO public.vehicle (registration_id, inspection_id, registration_date, place_of_registration, chassis_number,
                            engine_number, vin_id, manufactured_country, manufactured_year, brand, model_code, color,
                            owner_id)
VALUES ('30A44435', '12363', '2001-03-06', 'Cầu Giấy, Hà Nội', 'YV1CZ91H341062482', 'EW1E48L1FT20', 'YV1CZ91H341',
        'Thụy Điển', 2004, 'Volvo', 'XC90', 'Trằng', 'a9254c87-c571-4f0a-b3f6-ba5a15b415d6');
INSERT INTO public.vehicle (registration_id, inspection_id, registration_date, place_of_registration, chassis_number,
                            engine_number, vin_id, manufactured_country, manufactured_year, brand, model_code, color,
                            owner_id)
VALUES ('29A01234', '12364', '2014-01-27', 'Cầu Giấy, Hà Nội', '4T1BF1FK4DU238353', 'BF1FK4D4T113', '4T1BF1FK4DU', 'Mỹ',
        2013, 'Toyota', 'Camry', 'Trắng', 'f9cc6f5b-f009-43f4-a297-ac55f696e33e');
INSERT INTO public.vehicle (registration_id, inspection_id, registration_date, place_of_registration, chassis_number,
                            engine_number, vin_id, manufactured_country, manufactured_year, brand, model_code, color,
                            owner_id)
VALUES ('29A15045', '12365', '2014-05-03', 'Hai Bà Trưng, Hà Nội', '4T1BF1FK4DU238353', 'BF1FK4D4T113', '4T1BF1FK4DU',
        'Mỹ', 2013, 'Toyota', 'Camry', 'Đen', '3d672e1a-7149-43aa-8097-ee493d653085');
INSERT INTO public.vehicle (registration_id, inspection_id, registration_date, place_of_registration, chassis_number,
                            engine_number, vin_id, manufactured_country, manufactured_year, brand, model_code, color,
                            owner_id)
VALUES ('30A06747', '12366', '2014-06-27', 'Hai Bà Trưng, Hà Nội', '4T1BF1FK4DU238353', 'BF1FK4D4T113', '4T1BF1FK4DU',
        'Mỹ', 2013, 'Toyota', 'Camry', 'Đen', '3d672e1a-7149-43aa-8097-ee493d653085');
INSERT INTO public.vehicle (registration_id, inspection_id, registration_date, place_of_registration, chassis_number,
                            engine_number, vin_id, manufactured_country, manufactured_year, brand, model_code, color,
                            owner_id)
VALUES ('30A61911', '12367', '2014-08-26', 'Hai Bà Trưng, Hà Nội', '4T1BF1FK4DU238353', 'BF1FK4D4T113', '4T1BF1FK4DU',
        'Mỹ', 2013, 'Toyota', 'Camry', 'Đen', 'cbf6c313-ac46-430e-b107-29bc4d790216');
INSERT INTO public.vehicle (registration_id, inspection_id, registration_date, place_of_registration, chassis_number,
                            engine_number, vin_id, manufactured_country, manufactured_year, brand, model_code, color,
                            owner_id)
VALUES ('30A82935', '12368', '2014-03-26', 'Nam Từ Liêm, Hà Nội', '5TDJKRFH3ES038522', '7F2C56KWBA19', '5TDJKRFH3ES',
        'Mỹ', 2014, 'Toyota', 'Highlander XLE ', 'Bạc', 'a9254c87-c571-4f0a-b3f6-ba5a15b415d6');
INSERT INTO public.vehicle (registration_id, inspection_id, registration_date, place_of_registration, chassis_number,
                            engine_number, vin_id, manufactured_country, manufactured_year, brand, model_code, color,
                            owner_id)
VALUES ('30A47830', '12369', '2014-10-13', 'Nam Từ Liêm, Hà Nội', '4T1BF1FKXEU318970', 'GW2RE6LSAL20', '4T1BF1FKXEU',
        'Mỹ', 2014, 'Toyota', 'Camry', 'Trắng', 'f5f1cae3-f8de-4716-a3e5-af4ec43232d6');
INSERT INTO public.vehicle (registration_id, inspection_id, registration_date, place_of_registration, chassis_number,
                            engine_number, vin_id, manufactured_country, manufactured_year, brand, model_code, color,
                            owner_id)
VALUES ('30A79645', '12370', '2014-11-17', 'Nam Từ Liêm, Hà Nội', 'JTEBU5JR8E5190319', 'FF5KE1L4JG20', 'JTEBU5JR8E5',
        'Mỹ', 2014, 'Toyota', '4Runner', 'Bạc', '3d672e1a-7149-43aa-8097-ee493d653085');
INSERT INTO public.vehicle (registration_id, inspection_id, registration_date, place_of_registration, chassis_number,
                            engine_number, vin_id, manufactured_country, manufactured_year, brand, model_code, color,
                            owner_id)
VALUES ('30A31127', '12371', '2014-08-03', 'Cầu Giấy, Hà Nội', '1HGCT1B83EA012871', 'EW1E48L1FT20', '1HGCT1B83EA', 'Mỹ',
        2014, 'Honda', 'Accord EX-L', 'Xanh da trời', 'a8799386-700a-415c-8331-0800fc1f59c3');
INSERT INTO public.vehicle (registration_id, inspection_id, registration_date, place_of_registration, chassis_number,
                            engine_number, vin_id, manufactured_country, manufactured_year, brand, model_code, color,
                            owner_id)
VALUES ('30A35425', '12372', '2014-05-09', 'Hai Bà Trưng, Hà Nội', '4T1BF1FKXEU318970', 'GW2RE6LSAL20', '4T1BF1FKXEU',
        'Mỹ', 2014, 'Toyota', 'Camry', 'Đen', '96cc31d9-83f4-4264-99d0-5253d36bc0c9');
INSERT INTO public.vehicle (registration_id, inspection_id, registration_date, place_of_registration, chassis_number,
                            engine_number, vin_id, manufactured_country, manufactured_year, brand, model_code, color,
                            owner_id)
VALUES ('30A56792', '12373', '2014-07-24', 'Hai Bà Trưng, Hà Nội', 'JTEBU5JR8E5190319', 'FF5KE1L4JG20', 'JTEBU5JR8E5',
        'Mỹ', 2014, 'Toyota', '4Runner', 'Đỏ', 'a8799386-700a-415c-8331-0800fc1f59c3');
INSERT INTO public.vehicle (registration_id, inspection_id, registration_date, place_of_registration, chassis_number,
                            engine_number, vin_id, manufactured_country, manufactured_year, brand, model_code, color,
                            owner_id)
VALUES ('29A68688', '12374', '2021-09-07', 'Hai Bà Trưng, Hà Nội', 'SALGV2RE8JA507260', 'GV2RE8JSAL18', 'SALGV2RE8JA',
        'Anh', 2018, 'Land Rover', 'Range Rover AUTOBIOGRAPHY', 'xanh da trời', '2fb0a318-445c-4d61-bca6-3fea849924f0');
INSERT INTO public.vehicle (registration_id, inspection_id, registration_date, place_of_registration, chassis_number,
                            engine_number, vin_id, manufactured_country, manufactured_year, brand, model_code, color,
                            owner_id)
VALUES ('30A41968', '12375', '2021-09-07', 'Nam Từ Liêm, Hà Nội', 'SALGV2RE8JA507260', 'GV2RE8JSAL18', 'SALGV2RE8JA',
        'Anh', 2018, 'Land Rover', 'Range Rover AUTOBIOGRAPHY', 'đen', '263cb675-6697-4aa7-aa2e-c8fa79a0156c');
INSERT INTO public.vehicle (registration_id, inspection_id, registration_date, place_of_registration, chassis_number,
                            engine_number, vin_id, manufactured_country, manufactured_year, brand, model_code, color,
                            owner_id)
VALUES ('29A01975', '12376', '2019-12-05', 'Nam Từ Liêm, Hà Nội', 'WBA7F2C56KB239637', '7F2C56KWBA19', 'WBA7F2C56KB',
        'Đức', 2019, 'BMW', '7-Series 750i', 'trắng', 'f9cc6f5b-f009-43f4-a297-ac55f696e33e');
INSERT INTO public.vehicle (registration_id, inspection_id, registration_date, place_of_registration, chassis_number,
                            engine_number, vin_id, manufactured_country, manufactured_year, brand, model_code, color,
                            owner_id)
VALUES ('29A99999', '12377', '2021-02-02', 'Nam Từ Liêm, Hà Nội', 'SALGW2RE6LA569658', 'GW2RE6LSAL20', 'SALGW2RE6LA',
        'Anh', 2020, 'Land Rover', 'Range Rover Sport HSE', 'xanh da trời', '213f9eec-6bd7-4eee-8398-340db44a8fa9');
INSERT INTO public.vehicle (registration_id, inspection_id, registration_date, place_of_registration, chassis_number,
                            engine_number, vin_id, manufactured_country, manufactured_year, brand, model_code, color,
                            owner_id)
VALUES ('30A111111', '12378', '2022-12-12', 'Cầu Giấy, Hà Nội', '4JGFF5KE1LA149462', 'FF5KE1L4JG20', '4JGFF5KE1LA',
        'Mỹ', 2020, 'Mercedes-Benz', 'GLS450-4M', 'xám', 'a9254c87-c571-4f0a-b3f6-ba5a15b415d6');
INSERT INTO public.vehicle (registration_id, inspection_id, registration_date, place_of_registration, chassis_number,
                            engine_number, vin_id, manufactured_country, manufactured_year, brand, model_code, color,
                            owner_id)
VALUES ('29A19798', '12379', '2019-12-05', 'Hai Bà Trưng, Hà Nội', '1FTEW1E48LFA46974', 'EW1E48L1FT20', '1FTEW1E48LF',
        'Mỹ', 2020, 'Ford', 'F-150', 'Đen', '2fb0a318-445c-4d61-bca6-3fea849924f0');
INSERT INTO public.vehicle (registration_id, inspection_id, registration_date, place_of_registration, chassis_number,
                            engine_number, vin_id, manufactured_country, manufactured_year, brand, model_code, color,
                            owner_id)
VALUES ('29A67247', '12380', '2019-12-05', 'Hai Bà Trưng, Hà Nội', '1FTEW1E48LFA46974', 'EW1E48L1FT20', '1FTEW1E48LF',
        'Mỹ', 2020, 'Ford', 'F-150', 'Trắng', '3d672e1a-7149-43aa-8097-ee493d653085');
INSERT INTO public.vehicle (registration_id, inspection_id, registration_date, place_of_registration, chassis_number,
                            engine_number, vin_id, manufactured_country, manufactured_year, brand, model_code, color,
                            owner_id)
VALUES ('30A65866', '12381', '2022-10-31', 'Hai Bà Trưng, Hà Nội', '1FTEW1E48LFA46974', 'EW1E48L1FT20', '1FTEW1E48LF',
        'Mỹ', 2020, 'Ford', 'F-150', 'Trắng', '2fb0a318-445c-4d61-bca6-3fea849924f0');
INSERT INTO public.vehicle (registration_id, inspection_id, registration_date, place_of_registration, chassis_number,
                            engine_number, vin_id, manufactured_country, manufactured_year, brand, model_code, color,
                            owner_id)
VALUES ('30A21901', '12382', '2021-10-06', 'Nam Từ Liêm, Hà Nội', 'SALGW2RE6LA569658', 'GW2RE6LSAL20', 'SALGW2RE6LA',
        'Anh', 2020, 'Land Rover', 'Range Rover Sport HSE', 'Đỏ', '96cc31d9-83f4-4264-99d0-5253d36bc0c9');
INSERT INTO public.vehicle (registration_id, inspection_id, registration_date, place_of_registration, chassis_number,
                            engine_number, vin_id, manufactured_country, manufactured_year, brand, model_code, color,
                            owner_id)
VALUES ('30A02943', '12383', '2022-12-12', 'Cầu Giấy, Hà Nội', '4JGFF5KE1LA149462', 'FF5KE1L4JG20', '4JGFF5KE1LA', 'Mỹ',
        2020, 'Mercedes-Benz', 'GLS450-4M', 'Trắng', 'f9cc6f5b-f009-43f4-a297-ac55f696e33e');
INSERT INTO public.vehicle (registration_id, inspection_id, registration_date, place_of_registration, chassis_number,
                            engine_number, vin_id, manufactured_country, manufactured_year, brand, model_code, color,
                            owner_id)
VALUES ('30A87829', '12384', '2021-10-06', 'Cầu Giấy, Hà Nội', '1FTEW1E48LFA46974', 'EW1E48L1FT20', '1FTEW1E48LF', 'Mỹ',
        2020, 'Ford', 'F-150', 'bạc', 'a8799386-700a-415c-8331-0800fc1f59c3');
INSERT INTO public.vehicle (registration_id, inspection_id, registration_date, place_of_registration, chassis_number,
                            engine_number, vin_id, manufactured_country, manufactured_year, brand, model_code, color,
                            owner_id)
VALUES ('29A03038', '12385', '2023-01-02', 'Hai Bà Trưng, Hà Nội', 'SALGW2RE6LA569658', 'GW2RE6LSAL20', 'SALGW2RE6LA',
        'Anh', 2020, 'Land Rover', 'Range Rover Sport HSE', 'Trắng', '18666fc1-3be6-49bc-ae6c-9fff98751b43');
INSERT INTO public.vehicle (registration_id, inspection_id, registration_date, place_of_registration, chassis_number,
                            engine_number, vin_id, manufactured_country, manufactured_year, brand, model_code, color,
                            owner_id)
VALUES ('30A12345', '12386', '2021-05-05', 'Hai Bà Trưng, Hà Nội', 'W1NYC7HJ0MX368068', 'YC7HJ0MW1N21', 'W1NYC7HJ0MX',
        'Áo', 2021, 'Mercedes-Benz', 'AMG G 63', 'trắng', 'a8799386-700a-415c-8331-0800fc1f59c3');
INSERT INTO public.vehicle (registration_id, inspection_id, registration_date, place_of_registration, chassis_number,
                            engine_number, vin_id, manufactured_country, manufactured_year, brand, model_code, color,
                            owner_id)
VALUES ('30A00056', '12387', '2021-10-06', 'Nam Từ Liêm, Hà Nội', 'WA1LXAF76MD029675', 'LXAF76MWA121', 'WA1LXAF76MD',
        'SLOVAKIA', 2021, 'Audi', 'Q7 PREMIUM PLUS', 'xám', '3d672e1a-7149-43aa-8097-ee493d653085');
INSERT INTO public.vehicle (registration_id, inspection_id, registration_date, place_of_registration, chassis_number,
                            engine_number, vin_id, manufactured_country, manufactured_year, brand, model_code, color,
                            owner_id)
VALUES ('30A41975', '12388', '2021-03-08', 'Nam Từ Liêm, Hà Nội', 'JTMCY7AJXM4104323', 'CY7AJXMJTM21', 'JTMCY7AJXM4',
        'Nhật Bản', 2021, 'Toyota', 'Land Cruiser', 'Trắng', '3d672e1a-7149-43aa-8097-ee493d653085');
INSERT INTO public.vehicle (registration_id, inspection_id, registration_date, place_of_registration, chassis_number,
                            engine_number, vin_id, manufactured_country, manufactured_year, brand, model_code, color,
                            owner_id)
VALUES ('29A62164', '12389', '2021-10-06', 'Nam Từ Liêm, Hà Nội', 'JTMCY7AJXM4104323', 'CY7AJXMJTM21', 'JTMCY7AJXM4',
        'Nhật Bản', 2021, 'Toyota', 'Land Cruiser', 'trắng', '263cb675-6697-4aa7-aa2e-c8fa79a0156c');
INSERT INTO public.vehicle (registration_id, inspection_id, registration_date, place_of_registration, chassis_number,
                            engine_number, vin_id, manufactured_country, manufactured_year, brand, model_code, color,
                            owner_id)
VALUES ('30A36382', '12390', '2023-01-02', 'Nam Từ Liêm, Hà Nội', 'W1NYC7HJ0MX368068', 'YC7HJ0MW1N21', 'W1NYC7HJ0MX',
        'Áo', 2021, 'Mercedes-Benz', 'AMG G 63', 'Trắng', 'a8fbab38-66ec-41f3-abae-e299df72dede');
INSERT INTO public.vehicle (registration_id, inspection_id, registration_date, place_of_registration, chassis_number,
                            engine_number, vin_id, manufactured_country, manufactured_year, brand, model_code, color,
                            owner_id)
VALUES ('30A24155', '12391', '2021-03-08', 'Hoàn Kiếm, Hà Nội', 'W1NYC7HJ0MX368068', 'YC7HJ0MW1N21', 'W1NYC7HJ0MX',
        'Áo', 2021, 'Mercedes-Benz', 'AMG G 63', 'Đen', 'a8799386-700a-415c-8331-0800fc1f59c3');
INSERT INTO public.vehicle (registration_id, inspection_id, registration_date, place_of_registration, chassis_number,
                            engine_number, vin_id, manufactured_country, manufactured_year, brand, model_code, color,
                            owner_id)
VALUES ('29A67890', '12392', '2022-10-31', 'Hoàn Kiếm, Hà Nội', '1V2KR2CA7NC550556', 'KR2CA7N1V222', '1V2KR2CA7NC',
        'Mỹ', 2022, 'Volkswagen', 'Atlas 4Motion', 'bạc', '4ac45e07-b72a-4301-afb9-300a6066d8e0');
INSERT INTO public.vehicle (registration_id, inspection_id, registration_date, place_of_registration, chassis_number,
                            engine_number, vin_id, manufactured_country, manufactured_year, brand, model_code, color,
                            owner_id)
VALUES ('29A55555', '12393', '2023-01-02', 'Nam Từ Liêm, Hà Nội', '5NMS2DAJXNH431924', 'S2DAJXN5NM22', '5NMS2DAJXNH',
        'Mỹ', 2022, 'Hyundai', 'Santa Fe', 'Đỏ', '18666fc1-3be6-49bc-ae6c-9fff98751b43');
INSERT INTO public.vehicle (registration_id, inspection_id, registration_date, place_of_registration, chassis_number,
                            engine_number, vin_id, manufactured_country, manufactured_year, brand, model_code, color,
                            owner_id)
VALUES ('30A22234', '12394', '2021-10-06', 'Cầu Giấy, Hà Nội', '5XYP3DHC9NG218967', 'P3DHC9N5XY22', '5XYP3DHC9NG', 'Mỹ',
        2022, 'KIA', 'Telluride', 'Đen', '4ac45e07-b72a-4301-afb9-300a6066d8e0');
INSERT INTO public.vehicle (registration_id, inspection_id, registration_date, place_of_registration, chassis_number,
                            engine_number, vin_id, manufactured_country, manufactured_year, brand, model_code, color,
                            owner_id)
VALUES ('29A50424', '12395', '2023-01-02', 'Hai Bà Trưng, Hà Nội', '5NMS2DAJXNH431924', 'S2DAJXN5NM22', '5NMS2DAJXNH',
        'Mỹ', 2022, 'Hyundai', 'Santa Fe', 'đen', '3d672e1a-7149-43aa-8097-ee493d653085');
INSERT INTO public.vehicle (registration_id, inspection_id, registration_date, place_of_registration, chassis_number,
                            engine_number, vin_id, manufactured_country, manufactured_year, brand, model_code, color,
                            owner_id)
VALUES ('29A38356', '12396', '2021-10-06', 'Hoàn Kiếm, Hà Nội', '5XYP3DHC9NG218967', 'P3DHC9N5XY22', '5XYP3DHC9NG',
        'Mỹ', 2022, 'KIA', 'Telluride', 'bạc', 'a8799386-700a-415c-8331-0800fc1f59c3');
INSERT INTO public.vehicle (registration_id, inspection_id, registration_date, place_of_registration, chassis_number,
                            engine_number, vin_id, manufactured_country, manufactured_year, brand, model_code, color,
                            owner_id)
VALUES ('29A40008', '12397', '2021-09-07', 'Nam Từ Liêm, Hà Nội', '1V2KR2CA7NC550556', 'KR2CA7N1V222', '1V2KR2CA7NC',
        'Mỹ', 2022, 'Volkswagen', 'Atlas 4Motion', 'xám', 'f5f1cae3-f8de-4716-a3e5-af4ec43232d6');
INSERT INTO public.vehicle (registration_id, inspection_id, registration_date, place_of_registration, chassis_number,
                            engine_number, vin_id, manufactured_country, manufactured_year, brand, model_code, color,
                            owner_id)
VALUES ('29A56834', '12398', '2019-12-05', 'Hai Bà Trưng, Hà Nội', '5NMS2DAJXNH431924', 'S2DAJXN5NM22', '5NMS2DAJXNH',
        'Mỹ', 2022, 'Hyundai', 'Santa Fe', 'đen', '7504cb30-cd1c-4809-8783-1d4361e9dbd3');
INSERT INTO public.vehicle (registration_id, inspection_id, registration_date, place_of_registration, chassis_number,
                            engine_number, vin_id, manufactured_country, manufactured_year, brand, model_code, color,
                            owner_id)
VALUES ('29A91690', '12399', '2023-04-04', 'Hoàn Kiếm, Hà Nội', '5XYP3DHC9NG218967', 'P3DHC9N5XY22', '5XYP3DHC9NG',
        'Mỹ', 2022, 'KIA', 'Telluride', 'bạc', '213f9eec-6bd7-4eee-8398-340db44a8fa9');
INSERT INTO public.vehicle (registration_id, inspection_id, registration_date, place_of_registration, chassis_number,
                            engine_number, vin_id, manufactured_country, manufactured_year, brand, model_code, color,
                            owner_id)
VALUES ('30A00666', '12400', '2023-04-04', 'Hai Bà Trưng, Hà Nội', 'JTJAB7CX0P4016943', 'AB7CX0PJTJ23', 'JTJAB7CX0P4',
        'Nhật Bản', 2023, 'Lexus', 'LX600', 'đen', '7504cb30-cd1c-4809-8783-1d4361e9dbd3');
INSERT INTO public.vehicle (registration_id, inspection_id, registration_date, place_of_registration, chassis_number,
                            engine_number, vin_id, manufactured_country, manufactured_year, brand, model_code, color,
                            owner_id)
VALUES ('30A62626', '12401', '2023-04-04', 'Hoàn Kiếm, Hà Nội', '5UX23EM08P9N85342', '23EM08P5UX23', '5UX23EM08P9',
        'Mỹ', 2023, 'BMW', 'X7', 'Trắng', 'a9254c87-c571-4f0a-b3f6-ba5a15b415d6');
INSERT INTO public.vehicle (registration_id, inspection_id, registration_date, place_of_registration, chassis_number,
                            engine_number, vin_id, manufactured_country, manufactured_year, brand, model_code, color,
                            owner_id)
VALUES ('29A36364', '12402', '2023-04-04', 'Cầu Giấy, Hà Nội', '5UX23EM08P9N85342', '23EM08P5UX23', '5UX23EM08P9', 'Mỹ',
        2023, 'BMW', 'X7', 'Đỏ', 'f9cc6f5b-f009-43f4-a297-ac55f696e33e');
INSERT INTO public.vehicle (registration_id, inspection_id, registration_date, place_of_registration, chassis_number,
                            engine_number, vin_id, manufactured_country, manufactured_year, brand, model_code, color,
                            owner_id)
VALUES ('29A74070', '12403', '2022-12-12', 'Hoàn Kiếm, Hà Nội', 'JTJAB7CX0P4016943', 'AB7CX0PJTJ23', 'JTJAB7CX0P4',
        'Nhật Bản', 2023, 'Lexus', 'LX600', 'Trắng', 'a9254c87-c571-4f0a-b3f6-ba5a15b415d6');
INSERT INTO public.vehicle (registration_id, inspection_id, registration_date, place_of_registration, chassis_number,
                            engine_number, vin_id, manufactured_country, manufactured_year, brand, model_code, color,
                            owner_id)
VALUES ('30A77211', '12404', '2021-03-08', 'Nam Từ Liêm, Hà Nội', '5UX23EM08P9N85342', '23EM08P5UX23', '5UX23EM08P9',
        'Mỹ', 2023, 'BMW', 'X7', 'Đỏ', 'f9cc6f5b-f009-43f4-a297-ac55f696e33e');
INSERT INTO public.vehicle (registration_id, inspection_id, registration_date, place_of_registration, chassis_number,
                            engine_number, vin_id, manufactured_country, manufactured_year, brand, model_code, color,
                            owner_id)
VALUES ('30A16161', '12405', '2019-12-05', 'Hoàn Kiếm, Hà Nội', '5UX23EM08P9N85342', '23EM08P5UX23', '5UX23EM08P9',
        'Mỹ', 2023, 'BMW', 'X7', 'Trắng', '213f9eec-6bd7-4eee-8398-340db44a8fa9');


-- Insert to area
INSERT INTO public.area (province, area)
VALUES ('An Giang', 'Miền Nam');
INSERT INTO public.area (province, area)
VALUES ('Bà Rịa Vũng Tàu', 'Miền Nam');
INSERT INTO public.area (province, area)
VALUES ('Bạc Liêu', 'Miền Nam');
INSERT INTO public.area (province, area)
VALUES ('Bắc Kạn', 'Miền Bắc');
INSERT INTO public.area (province, area)
VALUES ('Bắc Giang', 'Miền Bắc');
INSERT INTO public.area (province, area)
VALUES ('Bắc Ninh', 'Miền Bắc');
INSERT INTO public.area (province, area)
VALUES ('Bến Tre', 'Miền Nam');
INSERT INTO public.area (province, area)
VALUES ('Bình Dương', 'Miền Nam');
INSERT INTO public.area (province, area)
VALUES ('Bình Định', 'Miền Trung');
INSERT INTO public.area (province, area)
VALUES ('Bình Phước', 'Miền Nam');
INSERT INTO public.area (province, area)
VALUES ('Bình Thuận', 'Miền Trung');
INSERT INTO public.area (province, area)
VALUES ('Cà Mau', 'Miền Nam');
INSERT INTO public.area (province, area)
VALUES ('Cao Bằng', 'Miền Bắc');
INSERT INTO public.area (province, area)
VALUES ('Cần Thơ', 'Miền Nam');
INSERT INTO public.area (province, area)
VALUES ('Đà Nẵng', 'Miền Trung');
INSERT INTO public.area (province, area)
VALUES ('Đắk Lắk', 'Miền Trung');
INSERT INTO public.area (province, area)
VALUES ('Đắk Nông', 'Miền Trung');
INSERT INTO public.area (province, area)
VALUES ('Điện Biên', 'Miền Bắc');
INSERT INTO public.area (province, area)
VALUES ('Đồng Nai', 'Miền Nam');
INSERT INTO public.area (province, area)
VALUES ('Đồng Tháp', 'Miền Nam');
INSERT INTO public.area (province, area)
VALUES ('Gia Lai', 'Miền Trung');
INSERT INTO public.area (province, area)
VALUES ('Hà Giang', 'Miền Bắc');
INSERT INTO public.area (province, area)
VALUES ('Hà Nam', 'Miền Bắc');
INSERT INTO public.area (province, area)
VALUES ('Hà Nội', 'Miền Bắc');
INSERT INTO public.area (province, area)
VALUES ('Hà Tây', 'Miền Bắc');
INSERT INTO public.area (province, area)
VALUES ('Hà Tĩnh', 'Miền Trung');
INSERT INTO public.area (province, area)
VALUES ('Hải Dương', 'Miền Bắc');
INSERT INTO public.area (province, area)
VALUES ('Hải Phòng', 'Miền Bắc');
INSERT INTO public.area (province, area)
VALUES ('Hoà Bình', 'Miền Bắc');
INSERT INTO public.area (province, area)
VALUES ('Hồ Chí Minh', 'Miền Nam');
INSERT INTO public.area (province, area)
VALUES ('Hậu Giang', 'Miền Nam');
INSERT INTO public.area (province, area)
VALUES ('Hưng Yên', 'Miền Bắc');
INSERT INTO public.area (province, area)
VALUES ('Khánh Hoà', 'Miền Trung');
INSERT INTO public.area (province, area)
VALUES ('Kiên Giang', 'Miền Nam');
INSERT INTO public.area (province, area)
VALUES ('Kon Tum', 'Miền Trung');
INSERT INTO public.area (province, area)
VALUES ('Lai Châu', 'Miền Bắc');
INSERT INTO public.area (province, area)
VALUES ('Lào Cai', 'Miền Bắc');
INSERT INTO public.area (province, area)
VALUES ('Lạng Sơn', 'Miền Bắc');
INSERT INTO public.area (province, area)
VALUES ('Lâm Đồng', 'Miền Trung');
INSERT INTO public.area (province, area)
VALUES ('Long An', 'Miền Nam');
INSERT INTO public.area (province, area)
VALUES ('Nam Định', 'Miền Bắc');
INSERT INTO public.area (province, area)
VALUES ('Nghệ An', 'Miền Trung');
INSERT INTO public.area (province, area)
VALUES ('Ninh Bình', 'Miền Bắc');
INSERT INTO public.area (province, area)
VALUES ('Ninh Thuận', 'Miền Trung');
INSERT INTO public.area (province, area)
VALUES ('Phú Thọ', 'Miền Bắc');
INSERT INTO public.area (province, area)
VALUES ('Phú Yên', 'Miền Trung');
INSERT INTO public.area (province, area)
VALUES ('Quảng Bình', 'Miền Trung');
INSERT INTO public.area (province, area)
VALUES ('Quảng Nam', 'Miền Trung');
INSERT INTO public.area (province, area)
VALUES ('Quảng Ngãi', 'Miền Trung');
INSERT INTO public.area (province, area)
VALUES ('Quảng Ninh', 'Miền Bắc');
INSERT INTO public.area (province, area)
VALUES ('Quảng Trị', 'Miền Trung');
INSERT INTO public.area (province, area)
VALUES ('Sóc Trăng', 'Miền Nam');
INSERT INTO public.area (province, area)
VALUES ('Sơn La', 'Miền Bắc');
INSERT INTO public.area (province, area)
VALUES ('Tây Ninh', 'Miền Nam');
INSERT INTO public.area (province, area)
VALUES ('Thái Bình', 'Miền Bắc');
INSERT INTO public.area (province, area)
VALUES ('Thái Nguyên', 'Miền Bắc');
INSERT INTO public.area (province, area)
VALUES ('Thanh Hoá', 'Miền Trung');
INSERT INTO public.area (province, area)
VALUES ('Thừa Thiên - Huế', 'Miền Trung');
INSERT INTO public.area (province, area)
VALUES ('Tiền Giang', 'Miền Nam');
INSERT INTO public.area (province, area)
VALUES ('Trà Vinh', 'Miền Nam');
INSERT INTO public.area (province, area)
VALUES ('Tuyên Quang', 'Miền Bắc');
INSERT INTO public.area (province, area)
VALUES ('Vĩnh Long', 'Miền Nam');
INSERT INTO public.area (province, area)
VALUES ('Vĩnh Phúc', 'Miền Bắc');
INSERT INTO public.area (province, area)
VALUES ('Yên Bái', 'Miền Bắc');


-- Insert to station
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (245, '9807D', 'TTDK XCG 9807D - Bắc Giang', 'Bắc Giang', 'dangkiem9807D.kiemdinhoto.vn', '0204.3666939',
        'Thôn Đình, xã Khám Lạng, huyện Lục Nam, tỉnh Bắc Giang', '9807D@kiemdinhoto.vn',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m21!1m12!1m3!1d7224.159323580617!2d106.36832691995038!3d21.274568792654133!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!4m6!3e6!4m0!4m3!3m2!1d21.2763381!2d106.37237549999999!5e0!3m2!1svi!2s!4v1672815983278!5m',
        'Lê Trọng Hưng');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (251, 'VR', 'Cục Đăng kiểm Việt Nam', 'Hà Nội', 'http://www.vr.org.vn/', '0123456789',
        'Số 18 đường Phạm Hùng, phường Mỹ Đình 2, quận Nam Từ Liêm', 'ddang.daodang@gmail.com', null,
        'Nguyễn Chiến Thắng');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (252, 'GOD', 'Cục Đăng kiểm Việt Nam', 'Hà Nội', 'http://www.vr.org.vn/', '0999999999',
        'Số 18 đường Phạm Hùng, phường Mỹ Đình 2, quận Nam Từ Liêm', 'ddang.daodang@gmail.com', null, 'Đào Đăng');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (1, '1101S', 'TTDK XCG 1101S - Cao Bằng', 'Cao Bằng', 'dangkiem1101S.kiemdinhoto.vn', '0206-3758742',
        'Km4 - P. Sông Hiến - TP. Cao Bằng', 'dangkiem1101s@yahoo.com.vn',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m23!1m12!1m3!1d58900.43738439949!2d106.1991872176613!3d22.68071747378125!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!4m8!3e6!4m0!4m5!1s0x36ca668adeb26ec3%3A0x9031fda58508d3a0!2zVHJ1bmcgVMOibSDEkcSDbmcga2nhu4',
        'Đinh Ngọc Hiến');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (2, '1102D', 'TTDK XCG 1102D - Cao Bằng 22', 'Cao Bằng', 'dangkiem1102D.kiemdinhoto.vn', '0206.3888929',
        'Tổ 8, phường Ngọc Xuân, TP. Cao Bằng', 'cttnhhdangkiemcb@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m23!1m12!1m3!1d58901.019629133705!2d106.21872171765594!3d22.679362173960005!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!4m8!3e6!4m0!4m5!1s0x36ca642af3728931%3A0x1bd90ddd53e00ae4!2zVHJ1bmcgdMOibSDEkcSDbmcga2n',
        'Lê Văn Trung');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (3, '1201D', 'TTDK XCG 1201D -  Lạng Sơn', 'Lạng Sơn', 'dangkiem1201D.kiemdinhoto.vn', '0205-3715737',
        '50 Lê Đại Hành - Phường Vĩnh Trại - Lạng Sơn', 'dangkiem.1201s1@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d59250.44176779871!2d106.69927535820312!3d21.8516484!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x36b54e7d6ef495e9%3A0xb1ef1b260a036b00!2zVHJ1bmcgdMOibSDEkMSDbmcga2nhu4NtIHhlIGPGoSBn',
        'Triệu Hoàng Sơn - Phó giám đốc phụ trách');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (4, '1202D', 'TTDK XCG 1202D - Lạng Sơn', 'Lạng Sơn', 'dangkiem1202D.kiemdinhoto.vn', '0205873888',
        'tổ 5, khối 1+2, thị trấn Cao Lộc, huyện Cao Lộc, tỉnh Lạng Sơn', 'dangkiemls1202d@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d59250.44483421308!2d106.69910366620334!3d21.851641005673173!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x36b54f53e395735f%3A0x40cd040c881f47ed!2zVHJ1bmcgVMOibSDEkMSDbmcgS2nhu4NtIDEy',
        'Nguyễn Văn Khiêm');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (5, '1401D', 'TTDK XCG  1401D - Quảng Ninh', 'Quảng Ninh', 'dangkiem1401D.kiemdinhoto.vn', '0203-3834080',
        'Phường Hà Phong - Thành phố Hạ Long - Quảng Ninh', 'trungtamdangkiem1401d@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d948013.4554129186!2d106.17221954249644!3d21.85068576316737!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x314a5628b31d9145%3A0x42829e3e4be7c615!2zVHJ1bmcgVMOibSDEkMSDbmcgS2nhu4NtIFhlI',
        'Đào Duy Long');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (6, '1402D', 'TTDK XCG 1402D - Quảng Ninh', 'Quảng Ninh', 'dangkiem1402D.kiemdinhoto.vn', '0203.3851141',
        'Phường Thanh Sơn - T.p Uông Bí - Quảng Ninh', 'dangkiemqn@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3723.9304100492727!2d106.74157615098662!3d21.035470292855315!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x314a8814d4717643%3A0xefba5d11ed16a4c0!2zVHJ1bmcgVMOibSDEkMSDbmcgS2nhu4NtIFh',
        'Nguyễn Văn Khiêm');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (7, '1403D', 'TTDK XCG 1403D - Quảng Ninh', 'Quảng Ninh', 'dangkiem1403D.kiemdinhoto.vn', '0203-3876889',
        'Km 9, xã Hải Đông – T.p Móng Cái - Quảng Ninh', 'dangkiemqn@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d475847.8964680924!2d107.03716808581632!3d21.28881077562808!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x314b522615f30e1b%3A0x3afba913d72658e1!2zVHJ1bmcgVMOibSDEkMSDbmcgS2nhu4NtIFhlI',
        'Phạm Văn Hoan');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (8, '1404D', 'TTDK XCG 1404D - Quảng Ninh', 'Quảng Ninh', 'dangkiem1404D.kiemdinhoto.vn', '0203.3868.806',
        'Tổ 5, khu 11, Phường Mông Dương, Tp. Cẩm Phả, tỉnh Quảng Ninh', 'trungtamdangkiem1404d@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d475845.25504607917!2d107.03579301221947!3d21.28962698184644!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x314b03bdd9027121%3A0x6e16c458475325fc!2zVHJ1bmcgdMOibSDEkcSDbmcga2nhu4NtIHhl',
        'Đỗ Duy Linh');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (9, '1405D', 'TTDK XCG 1405D - Quảng Ninh', 'Quảng Ninh', 'dangkiem1405D.kiemdinhoto.vn', '0325.113.168',
        'Ô đất số 9,10,34 và 35, lô ĐNN_D thuộc Cụm Công nghiệp Hà Khánh, Tp. Hạ Long, tỉnh Quảng Ninh',
        '1405D@kiemdinhoto.vn',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d475842.6135970068!2d107.03441793863273!3d21.290443166588645!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x314af9fd4da8a173%3A0x56acefd9c4c4556e!2zVHJ1bmcgdMOibSDEkcSDbmcga2nhu4NtIHhl',
        'Nguyễn Nghị');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (10, '1406D', 'TTDK XCG 1406D - Quảng Ninh', 'Quảng Ninh', 'dangkiem1406D.kiemdinhoto.vn', '0898.255666',
        'Khu CN Cái Lân, phường Giếng Đáy, Tp. Hạ Long, tỉnh Quảng Ninh', '1406D@kiemdinhoto.vn',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d475839.9721208814!2d107.0330428650561!3d21.291259329855354!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x314a59a88707db31%3A0xf3d5056818078763!2zVHJ1bmcgdMOibSDEkMSDbmcga2nhu4NtIFhDR',
        'Hoàng Anh Hùng');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (11, '1407D', 'TTDK XCG 1407D - Quảng Ninh', 'Quảng Ninh', 'dangkiem1407D.kiemdinhoto.vn', '0898.255.666',
        'Tổ 1, khu 4, P. Quang Hanh, Tp. Cẩm Phả, tỉnh Quảng Ninh', '1407D@kiemdinhoto.vn',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m23!1m12!1m3!1d7449.457151250146!2d107.21996318548284!3d21.0035145702458!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!4m8!3e0!4m0!4m5!1s0x314aff1d96a761eb%3A0xf77b57135be6d2c!2zQ8O0bmcgVHkgQ-G7lSBQaOG6p24gVGj',
        'Vũ Minh Đạt');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (12, '1501V', 'Trung tâm đăng kiểm xe cơ giới số 1501V', 'Hải Phòng', 'dangkiem1501V.kiemdinhoto.vn',
        '02253.824769', 'Km 90 QL 5 mới, Khu Cam Lộ 2, Q.Hồng Bàng, TP.Hải Phòng', 't1501v@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m23!1m12!1m3!1d59648.46662457479!2d106.59550252467668!3d20.870874720121428!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!4m8!3e6!4m0!4m5!1s0x314a7a4697e860eb%3A0xf8de565455981ebd!2zVHJ1bmcgVMOibSDEkcSDbmcga2nh',
        'Trần Thái Phong');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (13, '1502S', 'TTDK XCG 1502S - Hải Phòng', 'Hải Phòng', 'dangkiem1502S.kiemdinhoto.vn', '0225-3828396',
        'Khu Hạ Đoạn 2, P. Đông Hải 2, Q. Hải An, Hải Phòng', 'trungtamdangkiemxecogioi1502s@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d14913.358661683373!2d106.70775607943226!3d20.858355227848037!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x314a654eb7fc3795%3A0xbe5a0d93c9e3b5c6!2zVHJ1bmcgVMOibSDEkMSDbmcgS2nhu4NtIFh',
        'Đào Trọng Hà');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (14, '1503D', 'TTDK XCG 1503D - Hải Phòng', 'Hải Phòng', 'dangkiem1503D.ttdk.com.vn', '2.253.916.627',
        'Kênh Giang, Thuỷ Nguyên, Hải Phòng', '1503D@kiemdinhoto.vn', null, 'Đỗ Đức Kiên');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (15, '1504D', 'TTDK XCG 1504D - Hải Phòng', 'Hải Phòng', 'dangkiem1504D.kiemdinhoto.vn', '038.8888.108',
        'Cụm CN Cầu Nghìn, xã Hưng Nhân, huyện Vĩnh Bảo, TP Hải Phòng', 'dangkiem1504d@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d238471.18077957994!2d106.49627919650644!3d20.948008895202666!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3135f56bca27a0fb%3A0xf26f0bfb95fb8746!2zVHJ1bmcgdMOibSDEkcSDbmcga2nhu4NtIHh',
        'Nguyễn Văn Quý');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (16, '1505D', 'TTDK XCG 1505D - Hải Phòng', 'Hải Phòng', 'dangkiem1505D.kiemdinhoto.vn', '0225.8832.917',
        'Số 01 đường Lê Thánh Tông, phường Máy Tơ, quận Ngô Quyền, Tp. Hải Phòng', 'dangkiem1505d@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3728.115925509978!2d106.695706050985!3d20.867377198574495!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x314a7b4af3959e95%3A0x24f5293d4e70450c!2zVHJ1bmcgdMOibSDEkMSDbmcga2nhu4NtIHhlIG',
        'Nguyễn Nghị');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (17, '1506D', 'TTDK XCG 1506D - Hải Phòng', 'Hải Phòng', 'dangkiem1506D.kiemdinhoto.vn', '0225 8832 430',
        'Lô CN 3.2H-KCN Đình Vũ, Phường Đông Hải 2, Quận Hải An, Thành Phố Hải Phòng, Việt Nam', 'tt1506d@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d14915.522959420563!2d106.74974313955079!3d20.836521800000018!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x314a6596bc96c07d%3A0xa440e8131d854c6d!2zVHJ1bmcgdMOibSDEkcSDbmcga2nhu4NtIFh',
        'Chua Co');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (18, '1507D', 'TTDK XCG 1507D - Hải Phòng', 'Hải Phòng', 'dangkiem1507D.kiemdinhoto.vn', '09130001574',
        'Tổ dân phố Đồng Tâm, phường Đồng Hòa, quận Kiến An, Tp. Hải Phòng', '1507D@kiemdinhoto.vn',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d14916.945906141065!2d106.64380293955082!3d20.822155199999997!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x314a7112d48c1101%3A0x4d98bf504dfb93a7!2zVHJ1bmcgdMOibSDEkcSDbmcga2nhu4NtIHh',
        'Nguyễn Văn Thăng');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (19, '1509D', 'TTDK XCG 1509D - Hải Phòng', 'Hải Phòng', 'dangkiem1509D.ttdk.com.vn', '0969856933',
        '215 Hải Triều, p. Quán Toan, q. Hồng Bàng, tp. Hải Phòng', '1509D@kiemdinhoto.vn', null,
        'Phạm Quang Vinh PGĐ');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (20, '1701D', 'TTDK XCG 1701D - Thái Bình', 'Thái Bình', 'dangkiem1701D.kiemdinhoto.vn', '0227-3834013',
        'Phường Trần Hưng Đạo, TP Thái Bình', 'ttdk1701s@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d1869.2783367895004!2d106.3302298!3d20.442317!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3135e4dafcf97adb%3A0x1f07ba595fca69a!2zVHJ1bmcgVMOibSDEkMSDbmcgS2nhu4NtIFhlIEPGoSBHaeG7m2kgVGjDoWkgQsOsbmg!5',
        'Đàm Văn Tú');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (21, '1702D', 'TTDK XCG 1702D - Thái Bình', 'Thái Bình', 'dangkiem1702D.kiemdinhoto.vn', '0227.3550668',
        'Thôn Nam quán, xã Đông Các, huyên Đông Hưng, TP Thái Bình', 'trungtamdangkiem1702d@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m23!1m12!1m3!1d59780.266143943816!2d106.32488762382566!3d20.53626864444018!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!4m8!3e6!4m0!4m5!1s0x3135f0318bc515d1%3A0x4fe077636eb06a4a!2zVHJ1bmcgVMOibSDEkcSDbmcga2nh',
        'Lê Ngọc Minh');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (22, '1801S', 'TTDK XCG 1801S - Nam Định', 'Nam Định', 'dangkiem1801S.kiemdinhoto.vn', '0228-3817886',
        'Km 101, QL10, xã Mỹ Tân, Mỹ Lộc, TP Nam Định', 'dangkiem1801s@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m23!1m12!1m3!1d59843.690563044096!2d106.09791472341793!3d20.373377352825045!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!4m8!3e0!4m0!4m5!1s0x3135dfb5dd7906f7%3A0xfe149d82c436a47!2zMTAxIFFMMTAsIExpw6puIELhuqNv',
        'Nguyễn Đình Phong');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (23, '1802D', 'TTDK XCG 1802D - Nam Định', 'Nam Định', 'dangkiem1802D.kiemdinhoto.vn', '0228-3910367',
        'Km 150+800 (Phải tuyến) QL 21 (Đường Lê Đức Thọ), xã Nghĩa An, huyện Nam Trực, tỉnh Nam Định',
        'trungtam1802d@yahoo.com.vn',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d477987.42606720596!2d105.7651594516541!3d20.617572705159645!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3135e0ed4f29eeff%3A0xc912bf977f121018!2zVHJ1bmcgdMOibSDEkcSDbmcga2nhu4NtIHhl',
        'Lê Chí Hùng');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (24, '1802S', 'TTDK XCG 1802S - Nam Định', 'Nam Định', 'dangkiem1802S.kiemdinhoto.vn', '0228-3844847',
        'Số 3 Quang Trung, TP. Nam Định', 'dangkiem1801s@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m23!1m12!1m3!1d3738.8859869533435!2d106.16933775098083!3d20.428772513296803!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!4m8!3e0!4m0!4m5!1s0x3135e74e469eee6b%3A0x222ee8601e04a3d1!2zMyBRdWFuZyBUcnVuZywgQsOgIFR',
        'Nguyễn Đình Phong');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (25, '1803D', 'TTDK XCG 1803D - Nam Định', 'Nam Định', 'dangkiem1803D.kiemdinhoto.vn', '0228.3799987',
        'xã Hải Thanh, huyện Hải Hậu, tỉnh Nam Định', 'trungtamdangkiemxecogioi1803D@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m23!1m12!1m3!1d59917.17346526956!2d106.27007132294708!3d20.183079678765548!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!4m8!3e0!4m0!4m5!1s0x31360f1a1b9caf17%3A0xe0d7e3e6f52d71b3!2zSOG6o2kgVGhhbmgsIEjhuqNpIEjh',
        'Trần Việt Hoài');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (26, '1804D', 'TTDK XCG 1804D - Nam Định', 'Nam Định', 'dangkiem1804D.kiemdinhoto.vn', '022822229666',
        'Km3, Đại Lộ Thiên Trường, xã Mỹ Hưng, huyện Mỹ Lộc, Tp. Nam Định', 'tramdangkiem1804d@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m21!1m12!1m3!1d59815.426126132064!2d106.08746722359945!3d20.446121604488635!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!4m6!3e6!4m0!4m3!3m2!1d20.445833099999998!2d106.12277979999999!5e0!3m2!1svi!2s!4v1672814',
        'Phùng Mạnh Huấn');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (27, '1805D', 'TTDK XCG 1805D - Nam Định', 'Nam Định', 'dangkiem1805D.kiemdinhoto.vn', '0228.368299',
        'thửa đất số 350, tờ bản đồ số 5, Đại lộ Thiên Trường, Lộc Hòa, Tp. Nam Định', '1805D@kiemdinhoto.vn',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d477870.4082164272!2d105.82616482748249!3d20.654823466442185!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3135ddcbb7a8ca6f%3A0x2044423cd04b7e54!2zVHJ1bmcgdMOibSDEkcSDbmcga2nhu4NtIE5h',
        'Trần Công Thùy');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (28, '1901V', 'TTDK XCG 1901V - Phú Thọ', 'Phú Thọ', 'dangkiem1901V.kiemdinhoto.vn', '0210-3854342',
        '2821, đại lộ Hùng Vương, p. Vân Cơ, TP. Việt Trì, Phú Thọ', 'T1901V@vr.org.vn',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3716.356814342767!2d105.36949045098962!3d21.336416582509337!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3134928348851db5%3A0x380ec022900054fe!2zVHJ1bmcgVMOibSDEkMSDbmcgS2nhu4NtIFhl',
        'Vũ Mạnh Dũng');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (29, '1902D', 'TTDK XCG 1902D - Phú Thọ', 'Phú Thọ', 'dangkiem1902D.kiemdinhoto.vn', '0210.625.0008',
        'QL2, Khu 3, xã Phú Hộ, thị xã Phú Thọ, tỉnh Phú Thọ', 'dangkiempt1902d@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d29709.438305107047!2d105.23804467910158!3d21.441827700000026!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x313496d11f633a91%3A0xe8c0f488dfe5e3b1!2zVHJ1bmcgVMOibSDEkMSDbmcgS2nhu4NtIFh',
        'Trần Minh Lương');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (30, '1904D', 'TTDK XCG 1904D - Phú Thọ', 'Phú Thọ', 'dangkiem1904D.kiemdinhoto.vn', '0210.223.3999',
        'Khu 4, xã Kinh Kệ, huyện Lâm Thao, tỉnh Phú Thọ', '1904D@kiemdinhoto.vn',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d118965.3315436832!2d105.12510881640623!3d21.284660499999994!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31348fbbcf8e223f%3A0xeec1b5ec162c46fa!2zVHJ1bmcgVMOibSDEkMSDbmcgS2nhu4NtIDE5',
        'NGUYỄN VĂN HIẾU');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (31, '1905D', 'TTDK XCG 1905D - Phú Thọ', 'Phú Thọ', 'dangkiem1905D.kiemdinhoto.vn', '02103585999',
        'Khu Bãi Tần, thị trấn Thanh Sơn, huyện Thanh Sơn, tỉnh Phú Thọ', 'dk19.05d@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d29754.122386724026!2d105.16194847910155!3d21.22132590000001!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3134879ae8ed97f5%3A0x8ae89f0045c9b094!2zVHJ1bmcgdMOibSDEkMSDbmcga2nhu4NtIFhD',
        'Nguyễn Thị Mỹ Ngân');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (32, '1906D', 'TTDK XCG 1906D - Phú Thọ', 'Phú Thọ', 'dangkiem1906D.kiemdinhoto.vn', '0913.282.288',
        'Khu Hóc Tranh, xóm Mai, xã Trưng Vương, Tp. Việt Trì, tỉnh Phú Thọ', '1906D@kiemdinhoto.vn',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3716.4072138014108!2d105.4166557509896!3d21.334427282578222!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3134f331f820e6b9%3A0x9ea1af4d0d4c0f15!2zVHJ1bmcgdMOibSDEkcSDbmcga2nhu4NtIHhl',
        'Đàm Hải Nam');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (33, '1908D', 'TTDK XCG 1908D - Phú Thọ', 'Phú Thọ', 'dangkiem1908D.kiemdinhoto.vn', '02103.862.825',
        'Khu 7, xã Phượng Lâu, Tp. Việt Trì, tỉnh Phú Thọ', '1908D@kiemdinhoto.vn',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d119016.34063561453!2d105.10920354846209!3d21.221510516656192!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x313493606a08ba95%3A0x9dd8eacb7c9fd14!2zVHJ1bmcgVMOibSDEkMSDbmcgS2nhu4NtIHhl',
        'Nguyễn Xuân Ước');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (34, '2001S', 'TTDK XCG 2001S - Thái Nguyên', 'Thái Nguyên', 'dangkiem2001S.kiemdinhoto.vn', '0208-3851850',
        'Tổ 1A, Phường Tân lập - TP Thái Nguyên', 'dktn20@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3710.3233045601614!2d105.83009695099194!3d21.57329967426983!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3135212b01bc8ff5%3A0x8fe6917beef72a92!2zVHJ1bmcgVMOibSDEkMSDbmcgS2nhu4NtIFhl',
        'Vũ Hồng Quân');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (35, '2002S', 'TTDK XCG 2002S - Thái Nguyên', 'Thái Nguyên', 'dangkiem2002S.kiemdinhoto.vn', '0208-3622588',
        'Xóm Ao Vàng, Xã Cao Ngạn, TP Thái Nguyên', 'dktn20@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d14834.890272726456!2d105.79913043955078!3d21.635731800000002!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x313527b81a698add%3A0xe6ee94ed5136b536!2zVHJ1bmcgVMOibSDEkMSDbmcgS2nDqsyJbSA',
        'Lê Nam Hưng');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (36, '2003D', 'TTDK XCG 2003D - Thái Nguyên', 'Thái Nguyên', 'dangkiem2003D.kiemdinhoto.vn', '0208-386099',
        'Cụm công nghiệp Nguyên Gon, phường Cải Đan, TP. Sông Công, tỉnh Thái Nguyên',
        'dangkiemthainguyen2003d@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d14853.208236302047!2d105.84737493955078!3d21.456661500000006!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31351f4ff4911f61%3A0x11cbf49f74cd1b7c!2zVHJ1bmcgdMOibSDEkMSDbmcga2nhu4NtIHh',
        'Đỗ Đắc Huy');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (37, '2004D', 'TTDK XCG 2004D - Thái Nguyên', 'Thái Nguyên', 'dangkiem2004D.kiemdinhoto.vn', '0208.3934.996',
        'Xóm 9, xã Cổ Lũng, huyện Phú Lương, tỉnh Thái Nguyên', '2004D@kiemdinhoto.vn',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d118669.79966254569!2d105.62575491640621!3d21.647075799999996!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3134d92800da6161%3A0x1578ea287c1cb591!2zVHJ1bmcgVMOibSDEkMSDbmcgS2nhu4NtIDI',
        'Vũ Đình Hào');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (38, '2005D', 'TTDK XCG 2005D - Thái Nguyên', 'Thái Nguyên', 'dangkiem2005D.kiemdinhoto.vn', '086.200.4288',
        'Ngõ 845, đường Dương Tự Minh, tổ 6, phường Quang Vinh,T.p Thái Nguyên, tỉnh Thái Nguyên',
        '2005D@kiemdinhoto.vn',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d118669.79966254569!2d105.62575491640621!3d21.647075799999996!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x313527a83da1f529%3A0xca431851f72c62ec!2zVHJ1bmcgdMOibSDEkcSDbmcga2nhu4NtIHh',
        'Thái Đức Tâm');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (39, '2006D', 'TTDK XCG 2006D - Thái Nguyên', 'Thái Nguyên', 'dangkiem2006D.kiemdinhoto.vn', '0332.596.009',
        'Ngõ 398, đường Thống Nhất, phường Đồng Quang, Tp. Thái Nguyên, tỉnh Thái Nguyên', '2006D@kiemdinhoto.vn',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3710.240950006583!2d105.82562095099208!3d21.57651587415738!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x313527acb9a3e3b3%3A0x597bc528b56ef9c4!2zVHJ1bmcgdMOibSDEkcSDbmcga2nhu4NtIHhlI',
        'NGUYỄN HỮU THÙY');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (40, '2007D', 'TTDK XCG 2007D - Thái Nguyên', 'Thái Nguyên', 'dangkiem2007D.kiemdinhoto.vn', '02083.754999',
        'Tổ 2, phường Cam Giá, Tp. Thái Nguyên, tỉnh Thái Nguyên', '2007D@kiemdinhoto.vn',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d14840.961270100834!2d105.81902805066767!3d21.576540572743944!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3135215ae611ccb7%3A0x8b1a7feae9a8ec4!2zVHJ1bmcgdMOibSDEkcSDbmcga2nhu4NtIHhl',
        'Trần Ngọc Hiếu');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (41, '2008D', 'TTDK XCG 2008D - Thái Nguyên', 'Thái Nguyên', 'dangkiem2008D.kiemdinhoto.vn', '0966250668',
        'Tổ dân phố Đình, phường Nam Tiến, thành phố Thái Nguyên, tỉnh Thái Nguyên', '2008D@kiemdinhoto.vn',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d14858.538400334033!2d105.86225633955078!3d21.404287600000007!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31351f17bb14e18b%3A0xeee7d0062e8c9e85!2zVHJ1bmcgVMOibSDEkMSDbmcgS2nhu4NtIDI',
        'Ngô Hải Hùng');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (42, '2009D', 'TTDK XCG 2009D - Thái Nguyên', 'Thái Nguyên', 'dangkiem2009D.kiemdinhoto.vn', '0834.366.368',
        'Xã Sơn Cẩm, Tp. Thái Nguyên, tỉnh Thái Nguyên', '2009D@kiemdinhoto.vn',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d237736.15746580056!2d105.7305622153536!3d21.40456854183497!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3135279032790bf3%3A0xaae3022379c542d9!2zVHJ1bmcgdMOibSDEkcSDbmcga2nhu4NtIHhlI',
        'Lê Kế Phong');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (43, '2101S', 'TTDK XCG 2101S - Yên Bái', 'Yên Bái', 'dangkiem2101S.kiemdinhoto.vn', '0216.3867502',
        'Km2 - Phường Nguyễn Thái Học - TP Yên Bái', 'dangkiemyenbai2101s@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m23!1m12!1m3!1d59309.16406719611!2d104.85016462688965!3d21.709606747991124!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!4m8!3e6!4m0!4m5!1s0x31335afbcf483ffd%3A0xb6946392d7e485c4!2zVHJ1bmcgVMOibSDEkcSDbmcga2nh',
        'Chu Anh Phương');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (44, '2102D', 'TTDK XCG 2102D - Yên Bái', 'Yên Bái', 'dangkiem2102D.kiemdinhoto.vn', '0379430724',
        'Bản Nà Làng, xã NGhĩa Lợi, thị xã Nghĩa Lộ, tỉnh Yên Bái', 'dangkiemmientay@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d237406.9895531964!2d104.23682883281248!3d21.6060475!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31333dcd4510cbaf%3A0xceb58cb9ba3b1209!2zVHJ1bmcgdMOibSDEkcSDbmcga2nhu4NtIDIxMDJE!5e0',
        'Nguyễn Thanh Tú');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (45, '2201S', 'TTDK XCG 2201S - Tuyên Quang', 'Tuyên Quang', 'dangkiem2201S.kiemdinhoto.vn', '0207-3873.829',
        'Tổ 17, phường An Tường, xã An Tường - TP. Tuyên Quang', 'tuyenquangt2201s@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m21!1m12!1m3!1d59274.89484393203!2d105.18281212711481!3d21.792606590613676!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!4m6!3e6!4m0!4m3!3m2!1d21.780231699999998!2d105.20606869999999!5e0!3m2!1svi!2s!4v16728157',
        'Mai Đại Độ');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (46, '2202D', 'TTDK XCG 2202D - Tuyên Quang', 'Tuyên Quang', 'dangkiem2202D.kiemdinhoto.vn', '0207.222.0227',
        'Thôn Lượng, xã Tứ Quận, huyện Yên Sơn, tỉnh Tuyên Quang', '2202D@kiemdinhoto.vn',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d237099.02426066887!2d105.07731830235177!3d21.7929421004211!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x36cb536b0cba8f95%3A0xd5762c3c9e14fca9!2zVHJ1bmcgdMOibSDEkMSDbmcga2nhu4NtIHhlI',
        'Vũ Đình Hào');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (47, '2203D', 'TTDK XCG 2203D - Tuyên Quang', 'Tuyên Quang', 'dangkiem2203D.kiemdinhoto.vn', '0207.222.0227',
        'Tổ 16, phường Tân Hà, Tp. Tuyên Quang, tỉnh Tuyên Quang', '2203D@kiemdinhoto.vn',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m21!1m12!1m3!1d59258.30958896706!2d105.15804932722388!3d21.832668162870572!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!4m6!3e6!4m0!4m3!3m2!1d21.8261345!2d105.1874266!5e0!3m2!1svi!2s!4v1672815824239!5m2!1svi!',
        'Nguyễn Văn Tâm');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (48, '2301S', 'TTDK XCG 2301S - Hà Giang', 'Hà Giang', 'dangkiem2301S.kiemdinhoto.vn', '0219-3867014',
        'Tổ 18 - Phường Nguyễn Trãi - TP. Hà Giang', 'dangkiemhg@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d948388.7804429936!2d104.65455705263588!3d21.794047598147827!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x36cc790721183eb3%3A0x4624b951b864031f!2zVHJ1bmcgVMOibSDEkMSDbmcgS2nhu4NtIFhl',
        'Đàm Quốc Tuấn');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (49, '2401D', 'TTDK XCG 2401D', 'Lào Cai', 'dangkiem2401D.kiemdinhoto.vn', '0214.3842757',
        'Phường Bắc Cường - Tp Lào Cai - Tỉnh Lào Cai', 'laocaidk@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d58989.509980207295!2d103.90389355820312!3d22.472481800000008!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x36cd146997d04e71%3A0x1bccd368e0b0c3f3!2zVHJ1bmcgVMOibSDEkMSDbmcgS2nhu4NtIFh',
        'Phạm Mạnh Tường');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (50, '2403D', 'TTDK XCG 2403D', 'Lào Cai', 'dangkiem2403D.kiemdinhoto.vn', '0214.3838999',
        'Quốc lộ 4E, thôn Tiến Lợi, xã Xuân Giao, huyện Bảo Thắng, tỉnh Lào Cai', '2403D@kiemdinhoto.vn',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3689.950875953472!2d104.0975466510002!3d22.355483646465583!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x36cd3db3e7de4485%3A0x9e1cdc99bbe7dbf1!2zQ8O0bmcgdHkgQ-G7lSBQaOG6p24gxJDEg25nI',
        'Nguyễn Tuấn Vũ');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (51, '2404D', 'TTDK XCG 2404D - Công ty cổ phần Kinh doanh kỹ thuật giao thông Kim Thành', 'Lào Cai',
        'dangkiem2404D.kiemdinhoto.vn', '0919.989.566', 'Lô 21, KCN Bắc Duyên Hải, Tp. Lào Cai, tỉnh Lào Cai',
        '2404D@kiemdinhoto.vn',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d29493.66685728723!2d103.95750379451316!3d22.477591305503683!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x36cd15e1f9db3b7b%3A0xe156455a525efe07!2zVHJ1bmcgdMOibSDEkMSDbmcga2nhu4NtIHhl',
        'Đỗ Anh Tuấn');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (52, '2501S', 'TTDK XCG 2501S - Lai Châu', 'Lai Châu', 'dangkiem2501S.kiemdinhoto.vn', '02133795628',
        'Phường Tân Phong, TP Lai Châu, Lai Châu', 't2501s@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3688.7302568751193!2d103.46150265100069!3d22.4015241448004!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x36d2a191c3a583f7%3A0x8e4afe93c00f9fb5!2zMTU3IEzDqiBEdeG6qW4sIFTDom4gUGhvbmcsI',
        'Nguyễn Trung Thọ');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (53, '2601D', 'TTDK XCG 2601D - Sơn La', 'Sơn La', 'dangkiem2601D.kiemdinhoto.vn', '0212.3874016',
        'bản Noọng La, phường chiềng Sinh - TP Sơn La', 't2601d@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d59466.379536298904!2d103.8862473969804!3d21.32489237811933!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31325f59fa7606d3%3A0x6e90410b3e588ee7!2zVHJ1bmcgVMOibSDEkMSDbmcgS2nhu4NtIFhlI',
        'Trần Tiến Dũng');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (54, '2602D', 'TTDK XCG 2602D - Sơn La (Công ty cổ phần đăng kiểm cơ giới thủy bộ Sơn La)', 'Sơn La',
        'dangkiem2602D.kiemdinhoto.vn', '0212.3853229', 'Tổ 8 Phường Quyết Thắng - TP. Sơn La - Tỉnh Sơn La',
        'dangkiemsonla@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3716.650779682224!2d103.91916935098949!3d21.324811082910777!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3132f4d6b77a662f%3A0xcb46b93fd806ad68!2zVHJ1bmcgVMOibSDEkMSDbmcgS2nhu4NtIHhl',
        'Phạm Tuấn Anh');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (55, '2603D', 'TTDK XCG 2603D - Sơn La', 'Sơn La', 'dangkiem2603D.kiemdinhoto.vn', '0868.899.679',
        'Km177, Quốc lộ 6, Bản Chiềng Đi 1, xã Vân Hồ, huyện Vân Hồ, tỉnh Sơn La', '2603D@kiemdinhoto.vn',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d59466.31768241712!2d103.88607570789831!3d21.32504503777632!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31325f59fa7606d3%3A0x6e90410b3e588ee7!2zVHJ1bmcgVMOibSDEkMSDbmcgS2nhu4NtIFhlI',
        'Trần Tiến Dũng');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (56, '2701S', 'TTDK XCG 2701S - Điện Biên', 'Điện Biên', 'dangkiem2701S.kiemdinhoto.vn', '02153824436',
        'Tổ 10- P.Thanh Trường- TP Điện Biên Phủ', 'ttdangkiem2701s@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3714.6011659818846!2d103.0024973509903!3d21.405603180111488!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x312d08a74def8667%3A0xd3c9254f9f0bb547!2zVFJVTkcgVMOCTSDEkMSCTkcgS0nhu4JNIFhF',
        'Nguyễn Đình Tân');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (57, '2801S', 'TTDK XCG 2801S - Hoà Bình', 'Hoà Bình', 'dangkiem2801S.kiemdinhoto.vn', '0218.3853192',
        'Km 71+100 - Quốc lộ 6 - P.Đồng Tiến - TP Hòa Bình', 'dkhb2801s@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3730.1717611694344!2d105.34530905098413!3d20.784338001384153!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31346bac5da26991%3A0xd92912405e9b6707!2zVHJ1bmcgVMOibSDEkMSDbmcgS2nhu4NtIFh',
        'Anh Tân');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (58, '2901S', 'TTDK XCG 2901S - Hà Nội', 'Hà Nội', 'dangkiem2901S.kiemdinhoto.vn', '024.38585824',
        'Số 454 Phạm Văn Đồng - Từ Liêm - Hà Nội', '2901S@kiemdinhoto.vn',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d238503.88121670237!2d105.43531970037432!3d20.927476231842046!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3135aad267281a9d%3A0x59439d944d3819e3!2zVHJ1bmcgVMOibSDEkMSDbmcgS2nhu4NtIFh',
        'Phạm Hồng Thắng');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (59, '2901V', 'TTDK XCG 2901V - Hà Nội', 'Hà Nội', 'dangkiem2901V.kiemdinhoto.vn', '024.36810440',
        'Km 15+200 Quốc lộ 1A, Thôn Yên Phú - Xã Liên Ninh - Thanh Trì - Hà Nội', 'trungtamdangkiem2901v@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3727.114757882565!2d105.85080335098537!3d20.907702197206472!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3135b20ca1dd5f47%3A0xab8e45363b73a1ab!2zVHJ1bmcgVMOibSDEkMSDbmcgS2nhu4NtIFhl',
        'Lê Văn Ngân');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (60, '2902S', 'TTDK XCG 2902S - Hà Nội', 'Hà Nội', 'dangkiem2902S.kiemdinhoto.vn', '024.38586821',
        'Đường Đặng Phúc Thông- Yên Viên- Gia Lâm-Hà Nội.', 't2902s@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d59558.776699203016!2d105.85621725820313!3d21.09567390000001!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31350780e5899f0f%3A0x1a38880add740dce!2zVHJ1bmcgVMOibSDEkMSDbmcgS2nhu4NtIFhD',
        'Nguyễn Khánh Tùng');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (61, '2902V', 'TTDK XCG 2902V - Hà Nội', 'Hà Nội', 'dangkiem2902V.kiemdinhoto.vn', '024.38750285',
        'Xã Phú Thị, Huyện Gia Lâm - Hà Nội', 'tt2902v@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3724.51818188777!2d105.95297365098646!3d21.011942493658307!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3135a627adbebfb5%3A0xb415f86d2b547927!2zVHJ1bmcgVMOibSDEkMSDbmcgS2nhu4NtIFhlI',
        'Phùng Thế Ghi');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (62, '2903S', 'TTDK XCG 2903S - Hà Nội', 'Hà Nội', 'dangkiem2903S.kiemdinhoto.vn', '024.37858997',
        'Số 3 Lê Quang Đạo - Mỹ Đình - Nam Từ Liên - Hà Nội', 't2903s@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d29795.604699080213!2d105.73519497910156!3d21.014649500000004!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x313453c48160713d%3A0xfc5cdb19ccbc7ea1!2zVHLhuqFtIMSQxINuZyBLaeG7g20gWGUgQ8a',
        'Đỗ Văn Sơn');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (63, '2903V', 'TTDK XCG 2903V - Hà Nội', 'Hà Nội', 'dangkiem2903V.kiemdinhoto.vn', '024.37660976',
        'Láng Thượng - Đống Đa - Hà Nội', 'tt2903v@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3724.1146375203202!2d105.80179715098657!3d21.0280985931069!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3135ab423e14c5d9%3A0x6301ecd5784ea163!2zVHJ1bmcgdMOibSDEkcSDbmcga2nhu4NtIHhlI',
        'Trần Quốc Hoan');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (64, '2904V', 'TTDK XCG 2904V - Hà Nội', 'Hà Nội', 'dangkiem2904V.kiemdinhoto.vn', '024-35251280',
        'Km 8, đường Bắc Thăng Long – Nội Bài, Xã Quang Minh, Huyện Mê Linh, Hà Nội', 'ttam2904v@yahoo.com.vn',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d29760.157572200376!2d105.74711087910156!3d21.191376500000015!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3134fe028b23ab49%3A0x92e232e8cfc1b2e3!2zVHJ1bmcgVMOibSDEkMSDbmcgS2nhu4NtIFh',
        'Cao Văn Tư');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (65, '2905V', 'TTDK XCG 29-05V - Hà Nội', 'Hà Nội', 'dangkiem2905V.kiemdinhoto.vn', '0243.5742757',
        'Số 49, Phố Đức Giang, Phường Đức Giang, Quận Long Biên, Thành phố Hà Nội', 'ttdk2905v@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3723.202880169009!2d105.89109865098698!3d21.064557691861282!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3135a93df090e4ed%3A0xb8e8d4af8be80b87!2zVHJ1bmcgVMOibSDEkMSDbmcgS2nhu4NtIFhl',
        'Đặng Tuấn Anh');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (66, '2906V', 'TTDK XCG 2906V - Hà Nội', 'Hà Nội', 'dangkiem2906V.kiemdinhoto.vn', '024.36872319',
        'Đường Phan Trọng Tuệ - Xã Tam Hiệp - Thanh trì - Hà Nội', 't2906v@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3726.156649872352!2d105.82661735098584!3d20.946223395897185!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3135ad0923db4371%3A0x6f599712da2da28d!2zVHJ1bmcgVMOibSDEkMSDbmcgS2nhu4NtIFhl',
        'Vi Hồng Huy - Phụ trách Trung tâm');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (67, '2907D', 'TTDK XCG 2907D - Hà Nội', 'Hà Nội', 'dangkiem2907D.kiemdinhoto.vn', '024.39615888',
        'Km 1, QL3, Du Nội, Mai Lâm, Đông Anh- Hà Nội', 't2907d@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d119121.57459379408!2d105.76000891640626!3d21.0906596!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3135a9de23006b79%3A0x49316cfb78137451!2zVHJ1bmcgdMOibSDEkcSDbmcga2nhu4NtIHhlIGPGoSB',
        'Nguyễn Như Thanh');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (68, '2908D', 'TTDK XCG 2908D - Hà Nội', 'Hà Nội', 'dangkiem2908D.kiemdinhoto.vn', '024.33660388',
        'Lô 6, cụm CN Lai Xá, xã Kim Chung, Hoài Đức,Hà Nội', 'dangkiem2908d@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3723.3311055539234!2d105.72381375098679!3d21.059433892036417!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3134545186936ecb%3A0xbaa76da193e6e922!2zVHJ1bmcgdMOibSDEkcSDbmcga2nhu4NtIHh',
        'Sinh');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (69, '2909D', 'TTDK XCG 2909D - Hà Nội', 'Hà Nội', 'dangkiem2909D.kiemdinhoto.vn', '024.32247528',
        '685, đường Lĩnh Nam, phường Lĩnh Nam, Hoàng Mai, Hà Nội', 'dangkiem2909d@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3725.3028778930925!2d105.89005375098607!3d20.980492794730655!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3135aebdf4565971%3A0x6bed80c1a1f4731c!2zVHJ1bmcgdMOibSDEkMSDbmcga2nhu4NtIFh',
        'Hùng');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (70, '2910D', 'TTDK XCG 2910D - Hà Nội', 'Hà Nội', 'dangkiem2910D.kiemdinhoto.vn', '024.32315999',
        'Bãi đỗ xe công cộng và dịch vụ Đền Lừ, phường Hoàng Văn Thụ, quận Hoàng Mai, Hà Nội', 't2910d@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d14901.224396375137!2d105.84640313955076!3d20.98036359999999!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3135ac3d25bfe45d%3A0xcc68727e21f846dd!2zVFQgxJDEg25nIEtp4buDbSAyOTEwRA!5e0!3',
        'Vũ Mạnh Cường');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (71, '2911D', 'TTDK XCG 2911D - Hà Nội', 'Hà Nội', 'dangkiem2911D.kiemdinhoto.vn', '024.33600678',
        'Km31, QL 6, xã Đông Sơn, Chương Mỹ, Hà Nội', 'dangkiem2911d@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d59632.83970762987!2d105.53528125820311!3d20.910208100000006!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31344f8ded8c8c99%3A0xb49f68b0fb265e48!2zVHJ1bmcgdMOibSDEkMSDbmcga2nhu4NtIHhl',
        'Bùi Minh Kiên');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (72, '2912D', 'TTDK XCG 2912D - Hà Nội', 'Hà Nội', 'dangkiem2912D.kiemdinhoto.vn', '0243.8840123',
        'Km 21+200 QL3, Mai Đình, Sóc Sơn, Hà Nội', 'trungtamdangkiem2912d@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d238028.29231609957!2d105.56719013281253!3d21.224231000000003!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x313503bc70003b23%3A0x9a457793d53e7a39!2zVHJ1bmcgdMOibSDEkcSDbmcga2nhu4NtIHh',
        'Thụy');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (73, '2913D', 'TTDK XCG 2913D - Hà Nội', 'Hà Nội', 'dangkiem2913D.kiemdinhoto.vn', '0243.5810489',
        'Thôn Sơn Du, xã Nguyên Khê, Đông Anh, Hà Nội', 't2913d@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3720.3788807304945!2d105.83691185098799!3d21.177102788003207!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3135016e1ede6c5b%3A0x5cf508d98452cca6!2zVHJ1bmcgVMOibSDEkMSDbmcgS2nhu4NtIFh',
        'Đoàn Văn Hiếu');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (74, '2914D', 'TTDK XCG 2914D - Hà Nội', 'Hà Nội', 'dangkiem2914D.kiemdinhoto.vn', '0243.2001196',
        'Cụm CN Thanh Oai, Bích Hòa, Thanh Oai, Hà Nội', 't2914d@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d119250.30436376417!2d105.61715881640626!3d20.92953189999999!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3134535238c0b84d%3A0xe107e59a4376101c!2zVHJ1bmcgVMOibSDEkMSDbmcgS2nhu4NtIFhl',
        'Nguyễn Quang Đức');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (75, '2915D', 'TTDK XCG 2915D - Hà Nội', 'Hà Nội', 'dangkiem2915D.kiemdinhoto.vn', '0834.683.886',
        'Km21, xã Hà Hồi, huyện Thường Tín, Tp. Hà Nội', '2915D@kiemdinhoto.vn',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d119214.71716830836!2d105.71003179747588!3d20.974193663823513!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3135b318a92ce383%3A0x40b2a1faf14d7397!2zVHJ1bmcgdMOibSDEkcSDbmcga2nhu4NtIHh',
        'Phạm Chí Công');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (76, '2916D', 'TTDK XCG 2916D – Hà Nội', 'Hà Nội', 'dangkiem2916D.kiemdinhoto.vn', '0243.5258855',
        '144/95 đường Vũ Xuân Thiều, phường Sài Đồng, quận Long Biên, Hà Nội', 'dangkiemlongbien2916d@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d119214.48428605185!2d105.7096883635701!3d20.97448563085033!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3135a9e7a8d03817%3A0xa5176bf0e7426650!2zVHJ1bmcgVMOibSDEkMSDbmcgS2nhu4NtIFhDR',
        'Hoàng Bảo Sơn');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (77, '2917D', 'TTDK XCG 2917D - Hà Nội', 'Hà Nội', 'dangkiem2917D.kiemdinhoto.vn', '0243.200.4730',
        'Tổ 16, đường Nguyễn Văn Linh, phường Thạch Bàn, quận Long Biên, Hà Nội', 'dangkiem2917d@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3724.1585129385285!2d105.91791505098654!3d21.026342593166902!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3135a9e37caf09a3%3A0xa5ba5806e3edfd2!2zVHJ1bmcgdMOibSDEkMSDbmcga2nhu4NtIHhl',
        'Nguyễn Tiến Thôn');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (78, '3302S', 'TTDK XCG 3302S - Hà Nội', 'Hà Nội', 'dangkiem3302S.kiemdinhoto.vn', '024.33833259',
        'Phường Quang Trung - Thị Xã Sơn tây - Hà Nội', 'ttdkxcghanoi@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3721.5625110828664!2d105.50460473488768!3d21.1300011!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3134f602650142bf%3A0x6160362b4a9551ea!2zVHJ1bmcgVMOibSDEkMSDbmcgS2nhu4NtIFhlIEPGoSB',
        'Phan Văn Chính');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (79, '3401D', 'TTDK XCG 3401D', 'Hải Dương', 'dangkiem3401D.kiemdinhoto.vn', '0220.3890187',
        'Đường Tân Dân, P. Việt Hòa,TP.Hải Dương', 't3401s@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3726.2636341878197!2d106.28150225098571!3d20.94192539604343!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31359ba0deb9dea3%3A0x2669b4e30cb2d27f!2zVHJ1bmcgVMOibSDEkMSDbmcgS2nhu4NtIFhl',
        'Nguyễn Ngọc Hiếu');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (80, '3402D', 'TTDK XCG 3402D - Hải Dương', 'Hải Dương', 'dangkiem3402D.kiemdinhoto.vn', '0378447844',
        'Km 33+300, QL 18, cụm CN II, P. Văn An, TP Chí Linh,T.Hải Dương', 't3402d@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d59556.18433882026!2d106.29378895820312!3d21.102137400000004!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31357915592aa3c7%3A0x8f2c90c5826d9896!2zVHJ1bmcgdMOibSDEkcSDbmcga2nhu4NtIHhl',
        'Nguyễn Tiến Mạnh');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (81, '3404D', 'TTDK XCG 3404D - Hải Dương', 'Hải Dương', 'dangkiem3404D.kiemdinhoto.vn', '0220.3867.868',
        'Thôn Quỳnh Khê, xã Kim Xuyên, huyên Kim Thành, Tỉnh Hải Dương', '3404D@kiemdinhoto.vn',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d59613.739865300435!2d106.35444727490176!3d20.958187161217317!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3135814eb4698937%3A0xaa5a13d8214c22e!2zVHJ1bmcgdMOibSDEkcSDbmcga2nhu4NtIHhl',
        'Trần Văn Ngọc');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (82, '3405D', 'TTDK XCG 3405D - Hải Dương', 'Hải Dương', 'dangkiem3405D.kiemdinhoto.vn', '0393622399',
        'Phân khu 2, đô thị mới phía nam thành phố Hải Dương, xã Liên Hồng, Tp. Hải Dương, tỉnh Hải Dương',
        '3405D@kiemdinhoto.vn',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d238511.20527913564!2d106.24912510016745!3d20.92287480198512!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31359b3d36132039%3A0x39afe57604a4939!2zVHJ1bmcgVMOibSDEkMSDbmcgS2nhu4NtIFhlI',
        'Phùng Quang Thịnh');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (83, '3407D', 'TTDK XCG 3407D - Hải Dương', 'Hải Dương', 'dangkiem3407D.kiemdinhoto.vn', '0220.3867.868',
        'Cụm công nghiệp Ngọc Sơn, xã Ngọc Sơn, Tp. Hải Dương', '3407D@kiemdinhoto.vn',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3727.3391053843743!2d106.34557865098522!3d20.898672397513!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31359bc22ba04363%3A0x7705ab0f4800b95a!2zVHJ1bmcgdMOibSDEkcSDbmcga2nhu4NtIHhlIG',
        'Nguyễn Xuân Hòa');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (84, '3501D', 'TTDK XCG 3501D - Ninh Bình (Công ty cổ phần đăng kiểm xe cơ giới Ninh Bình)', 'Ninh Bình',
        'dangkiem3501D.kiemdinhoto.vn', '0229.6559966',
        'Số 58 đường Trần Nhân Tông, phố An Hòa, phường Ninh Phong, TP. Ninh Bình, tỉnh Ninh Bình', 't3501s@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3743.958451172066!2d105.96455705097883!3d20.21904752023359!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31367b263893f249%3A0xb024982627965057!2zQ8OUTkcgVFkgQ-G7lCBQSOG6pk4gxJDEgk5HI',
        'Nguyễn Trung Thao');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (85, '3502D', 'TTDK XCG 3502D - Ninh Bình', 'Ninh Bình', 'dangkiem3502D.kiemdinhoto.vn', '0229.3632386',
        'Phố Bích Sơn, P. Bích Đào, TP Ninh Bình', 't3502d@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d14973.137383843668!2d105.97932123955079!3d20.247038800000013!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x313670cbe6d75fe7%3A0x3a384de704a9bc51!2zVHJ1bmcgVMOibSDEkMSDbmcgS2nhu4NtIFh',
        'Chu Mạnh Đức');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (86, '3503D', 'TTDK XCG 3503D - Ninh Bình', 'Ninh Bình', 'dangkiem3503D.kiemdinhoto.vn', '0982099314',
        'Tổ 2, phường Bắc Sơn, Tp. Tam Điệp, Tỉnh Ninh Bình', 'Ctydangkiem3503d@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d14981.368878737545!2d105.90752103955079!3d20.16147179999999!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x313665d66376ab71%3A0x93f0866e9c8872d1!2zVHJ1bmcgVMOibSDEkMSDbmcgS2nhu4NtIFhl',
        'Nguyễn Hữu Thư');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (87, '3504D', 'TTDK XCG 3504D - Ninh Bình', 'Ninh Bình', 'dangkiem3504D.kiemdinhoto.vn', '0229.6430.604',
        'Thôn Cổ Loan Hạ, giáp đường 477, xã Ninh Tiến, Tp. Ninh Bình, tỉnh Ninh Bình', 'Ctydangkiem3503d@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3743.7278227604943!2d105.95435055097896!3d20.22862821991814!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31367ba5861ce557%3A0x95264f9715480484!2zVHJ1bmcgdMOibSDEkMSDbmcga2nhu4NtIHhl',
        'Phan Đình Chiều');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (88, '3601S', 'TTDK XCG 3601S - Thanh Hoá', 'Thanh Hoá', 'dangkiem3601S.kiemdinhoto.vn', '0237.3961959',
        '267 Bà Triệu - Đông Thọ - TP Thanh Hóa', 'Dangkiemthanhhoa@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3753.2191382394444!2d105.77002965097519!3d19.830678632902725!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3136f78969d62b71%3A0x39a72066046a10bf!2zVHJ1bmcgdMOibSDEkMSDbmcga2nhu4NtIHh',
        'Nguyễn Văn Khoát');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (89, '3602S', 'TTDK XCG 3602S - Thanh Hoá', 'Thanh Hoá', 'dangkiem3602S.kiemdinhoto.vn', '0237.3776700',
        'Phường Bắc Sơn - TX Bỉm Sơn - Thanh Hoá', 'Dangkiemthanhhoa@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3746.826844910011!2d105.85255333488767!3d20.0995239!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3136636046d3af4f%3A0x59d6d6f5e8554254!2zVHJ1bmcgdMOibSDEkcSDbmcga2nhu4NtIHhlIGPGoSBn',
        'Nguyễn Văn Khoát');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (90, '3603D', 'TTDK XCG 3603D - Thanh Hoá', 'Thanh Hoá', 'dangkiem3603D.kiemdinhoto.vn',
        '0237.3917.222 / 0237.3957.222', 'Đường Võ Nguyên Giáp, P. Quảng Thành, T.p Thanh Hoá',
        'dangkiem3603d@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d120143.56323607203!2d105.64295581640624!3d19.77696620000001!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x313657d863975ef5%3A0x8d20a842cb58168b!2zVHJ1bmcgdMOibSDEkcSDbmcga2nhu4NtIHhl',
        'Nguyễn Thanh Hải');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (91, '3604D', 'TTDK XCG 3604D - Thanh Hoá', 'Thanh Hoá', 'dangkiem3604D.kiemdinhoto.vn', '0237.755.442',
        'Phố 7, Phường Quảng Thắng, T.p Thanh Hóa, tỉnh Thanh Hóa', '3604D@kiemdinhoto.vn',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3754.3794149466553!2d105.75801815097476!3d19.781504234490626!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3136f9bdc3a9ace1%3A0x9e9bf872ab1ff2a6!2zVHJ1bmcgdMOibSDEkMSDbmcga2nhu4NtIFh',
        'LÊ VĂN VIỆT');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (92, '3605D', 'TTDK XCG 3605D - Thanh Hoá', 'Thanh Hoá', 'dangkiem3605D.kiemdinhoto.vn', '086.500.2019',
        'Xã Thạch Quảng, huyện Thạch Thành, tỉnh Thanh Hóa', '3605D@kiemdinhoto.vn',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d1871.268415888769!2d105.5213432!3d20.278035!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x0%3A0x6a801025e1266d12!2zVHJ1bmcgVMOibSDEkMSDbmcgS2nhu4NtIFhlIEPGoSBHaeG7m2kgMzYgMDVE!5e0!3m2!1sen!2s!4v16728',
        'Đỗ Hoàng Long');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (93, '3606D', 'TTDK XCG 3606D - Thanh Hoá', 'Thanh Hoá', 'dangkiem3606D.kiemdinhoto.vn', '0237.3573888',
        'Khu phố Ngọc Minh, thị trấn Ngọc Lặc, huyện Ngọc Lặc. Tỉnh Thanh Hóa', '3606D@kiemdinhoto.vn',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d1873.3527313130394!2d105.3751751!3d20.1045956!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3136bf9dcac23335%3A0xb8e3c5bfdd151fba!2zVHJ1bmcgVMOibSDEkMSDbmcgS2nhu4NtIFhlIEPGoSBHaeG7m2kgMzYuMDZE!5e0!3m',
        'Dương Văn Thông');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (94, '3608D', 'TTDK XCG 3608D - Thanh Hoá', 'Thanh Hoá', 'dangkiem3608D.kiemdinhoto.vn', '0237.248.1888',
        'Xã Đông Hoàng, huyện Đông Sơn, tỉnh Thanh Hóa', '3608D@kiemdinhoto.vn',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d239865.69019924663!2d105.43381651216654!3d20.05457189215464!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3136f1a64a32cddf%3A0x3e810508af4407b9!2zVHJ1bmcgdMOibSDEkcSDbmcga2nhu4NtIHhl',
        'Trịnh Ngọc Tuấn');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (95, '3609D', 'TTDK XCG 3609D - Thanh Hoá', 'Thanh Hoá', 'dangkiem3609D.kiemdinhoto.vn', '02373.943943',
        '25/38 Phú Thọ 3, Phường Phú Sơn, Tp. Thanh Hóa, tỉnh Thanh Hóa', 't3609d@dangkiemphuson.vn',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d239919.71586327357!2d105.50975721066207!3d20.019190846118335!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3136f930157fd0cb%3A0x15f906f007326ac6!2zVFJVTkcgVMOCTSDEkMSCTkcgS0nhu4JNIFh',
        'LÊ VĂN BÌNH');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (96, '3610D', 'TTDK XCG 3610D - Thanh Hoá', 'Thanh Hoá', 'dangkiem3610D.kiemdinhoto.vn', '0944.472.868',
        'Quốc lộ 10, xã Liên Lộc, huyện Hậu Lộc, tỉnh Thanh Hóa', '3610D@kiemdinhoto.vn',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d239918.89957453968!2d105.50907011712144!3d20.01972587427706!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31365d1eba61ff47%3A0x95724b2f84320d79!2zVHJ1bmcgdMOibSDEkcSDbmcga2nhu4NtIHhl',
        'Trần Văn Hùng');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (97, '3701S', 'TTDK XCG 3701S - Nghệ An', 'Nghệ An', 'dangkiem3701S.kiemdinhoto.vn', '0238.3846751',
        '72 Phan Bội Châu - TP Vinh - Nghệ An', 'dangkiemnghean@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d3779.5055805663947!2d105.6725357!3d18.6861699!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x0%3A0x8f88f5ba6e59f627!2sNghe%20An%20Register%20Centre!5e0!3m2!1sen!2s!4v1672817831555!5m2!1sen!2s" width="',
        'Nguyễn Quý Khánh');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (98, '3702S', 'TTDK XCG 3702S - Nghệ An', 'Nghệ An', 'dangkiem3702S.kiemdinhoto.vn', '0238.3962729',
        'Xã Đông Hiếu – TX Thái Hoà - Nghệ An', 'dangkiemnghean@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3765.9908583020497!2d105.47515205097027!3d19.2827637503864!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x313714b57cc2fabb%3A0x451cf0ca4283cb91!2zVHJ1bmcgVMOibSDEkMSDbmcgS2nhu4NtIFhlI',
        'Nguyễn Quý Khánh');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (99, '3703D', 'TTDK XCG 3703D - Nghệ An', 'Nghệ An', 'dangkiem3703D.kiemdinhoto.vn', '0238.3618999',
        'Km 6, QL 46, Nghi Thạch, Nghi Lộc, Nghệ An', 't3703d@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d482975.007389989!2d105.32871589394645!3d18.96490606474999!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3139d3e69000a6df%3A0xa0a4fe0d264e6716!2zVHJ1bmcgdMOibSDEkcSDbmcga2nhu4NtIFhDRy',
        'Nguyễn Quang Doãn');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (100, '3704D', 'TTDK XCG 37-04D - Nghệ An', 'Nghệ An', 'dangkiem3704D.kiemdinhoto.vn', '0238.3719199',
        'Xã Diễn Hồng, huyện Diễn Châu, tỉnh Nghệ An', 't3704d@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3771.690436822445!2d105.58074145096815!3d19.033357858193224!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x313764d0a42d3e7d%3A0x841da90ad825abdd!2zVHJ1bmcgdMOibSDEkcSDbmcga2nhu4NtIHhl',
        'Hoàng Mạnh Huynh');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (101, '3705D', 'TTDK XCG 3705D - Nghệ An', 'Nghệ An', 'dangkiem3705D.kiemdinhoto.vn', '0238.3618866',
        'Xóm 1, xã Nghi Long, huyện Nghi Lộc, tỉnh Nghệ An', 't3704d@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d482975.007389989!2d105.32871589394645!3d18.96490606474999!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3139d6dd24dcf097%3A0xe88f3d60da1fb381!2zVHJ1bmcgdMOibSDEkcSDbmcga2nhu4NtIHhlIG',
        'Lê Ngọc Thực');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (102, '3706D', 'TTDK XCG 3706D - Nghệ An', 'Nghệ An', 'dangkiem3706D.kiemdinhoto.vn', '0238.870.888',
        'QL7B, xã Yên Sơn, huyện Đô Lương, tỉnh Nghệ An', 't3706d@dangkiemdoluong.vn',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d1887.3717860942127!2d105.3125114!3d18.8984538!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3139e3b0d785b41b%3A0x976aee41ef288c6c!2zVHLhuqFtIMSRxINuZyBraeG7g20gMzctMDZE!5e0!3m2!1sen!2s!4v167281795693',
        'Trần Thành Vinh');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (103, '3707D', 'TTDK XCG 3707D - Nghệ An', 'Nghệ An', 'dangkiem3707D.kiemdinhoto.vn', '0238.3206.886',
        'Xóm 5, xã Quỳnh Lộc, thị xã Hoàng Mai, tỉnh Nghệ An', 'dangkiem3707d@haanvr.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m21!1m12!1m3!1d60263.78769413561!2d105.70661342074953!3d19.26118847843354!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!4m6!3e6!4m0!4m3!3m2!1d19.2631062!2d105.741163!5e0!3m2!1svi!2s!4v1672818008738!5m2!1svi!2s',
        'Hồ Hữu Hưng');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (104, '3708D', 'TTDK XCG 3708D - Nghệ An', 'Nghệ An', 'dangkiem3708D.kiemdinhoto.vn', '0932.313.322',
        'Xóm 3, xã Hưng Thịnh, huyện Hưng Nguyên, tỉnh Nghệ An', '3708D@kiemdinhoto.vn',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d482975.007389989!2d105.32871589394645!3d18.96490606474998!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3139cfeaf3ada4fd%3A0x15886b0ae0aeed9f!2zVHJ1bmcgdMOibSDEkcSDbmcga2nhu4NtIHhlIG',
        'Trần Anh Phong');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (105, '3709D', 'TTDK XCG 3709D - Nghệ An', 'Nghệ An', 'dangkiem3709D.kiemdinhoto.vn', '02383.775577',
        'Khối 9, phường Quán Bàu, Tp. Vinh, tỉnh Nghệ An', '3709D@kiemdinhoto.vn',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3779.181793919668!2d105.67033445096529!3d18.70067746845839!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3139cfff0da60e5b%3A0x6fb24e9e7d1b3bd9!2zVHJ1bmcgVMOibSDEkMSDbmcgS2nhu4NtIFhlI',
        'Ngô Xuân Sơn');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (106, '3801D', 'TTDK XCG 3801D', 'Hà Tĩnh', 'dangkiem3801D.kiemdinhoto.vn', '0239.3858603',
        'Km 9 tránh Hà Tĩnh, xã Thạch Đài, Thạch Hà, Hà Tĩnh', 't3801s@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m23!1m12!1m3!1d60602.6404572793!2d105.84464931864264!3d18.31692067450311!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!4m8!3e6!4m0!4m5!1s0x313851fecfe33fff%3A0xe490371e78478336!2zQ8O0bmcgdHkgY-G7lSBwaOG6p24gxJ',
        'Võ Ngọc Sơn');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (107, '3802D', 'TTDK XCG 3802D - Hà Tĩnh', 'Hà Tĩnh', 'dangkiem3802D.kiemdinhoto.vn', '0239.3836888',
        'km486+354 QL1A, phường Đậu Liêu, TX. Hồng Lĩnh, tỉnh Hà Tĩnh', 't3802d@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d242139.35236208397!2d105.6350269020063!3d18.509579240511034!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3139cb26a9a720ef%3A0x5d2df820a52859b8!2zVHJ1bmcgVMOibSDEkMSDbmcgS2nhu4NtIEjh',
        'Nguyễn Tiến Hùng');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (108, '3803D', 'TTDK XCG 3803D - Hà Tĩnh', 'Hà Tĩnh', 'dangkiem3803D.kiemdinhoto.vn', '0239.6268.228',
        'phường Kỳ Trinh, thị xã Kỳ Anh, tỉnh Hà Tĩnh', '3803D@kiemdinhoto.vn',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d242814.19562181624!2d106.06920303281254!3d18.02651200000001!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x313887463890d42f%3A0xedf8504da31dd0a9!2zVHJ1bmcgdMOibSDEkcSDbmcga2nhu4NtIMO0',
        'Trần Đình Tịnh');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (109, '3804D', 'TTDK XCG 3804D - Hà Tĩnh', 'Hà Tĩnh', 'dangkiem3804D.kiemdinhoto.vn', '0239.355.2888',
        'Xã Trung Lễ, huyện Đức Thọ, tỉnh Hà Tĩnh', '3804D@kiemdinhoto.vn',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d242145.75249095136!2d105.3439870328125!3d18.505055100000007!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3139b7b588302f29%3A0x2c71b229e12033de!2zVHJ1bmcgdMOibSDEkMSDbmcga2nhu4NtIHhl',
        'Nguyễn Ngọc Trung');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (110, '3805D', 'TTDK XCG 3805D - Hà Tĩnh', 'Hà Tĩnh', 'dangkiem3805D.kiemdinhoto.vn', '0239.3874567',
        'Km821+810, đường Hồ Chí Minh, xã Hương Long, huyện Hương Khê, tỉnh Hà Tĩnh', 't3805d@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d242144.97720245481!2d105.34329993513997!3d18.505603194855844!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3139a9b6ccd8192b%3A0xa2065a6c261cefed!2zVHJ1bmcgdMOibSDEkcSDbmcga2nhu4NtIDM',
        'Phan Trọng Doãn');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (111, '4301S', 'TTDK XCG 4301S - Đà Nẵng', 'Đà Nẵng', 'dangkiem4301S.kiemdinhoto.vn', '0236.3765017',
        '25 Hoàng Văn Thái - P.Hòa Minh - Q.Liên Chiểu - TP. Đà Nẵng', 'dangkiemdanang@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m23!1m12!1m3!1d61347.097087102105!2d108.12981241419281!3d16.055442025743194!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!4m8!3e6!4m0!4m5!1s0x3142193d4289ae53%3A0x9ce391b4582cbeda!2zVHJ1bmcgVMOibSDEkcSDbmcga2n',
        'Bùi Văn Tấn');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (112, '4302S', 'TTDK XCG 4302S - Đà Nẵng', 'Đà Nẵng', 'dangkiem4302S.kiemdinhoto.vn', '0236.3685988',
        'Km 800 + 40 Xã Hoà Châu – Hoà Vang - Đà Nẵng', 'dangkiemdanang@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3835.545841641481!2d108.20108725094478!3d15.985076345878127!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31421a51581820bd%3A0x40a496f47a33e08b!2zVHJ1bmcgVMOibSDEkMSDbmcgS2nhu4NtIFhl',
        'Bùi Văn Tấn');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (113, '4304D', 'TTDK XCG 4304D - Đà Nẵng', 'Đà Nẵng', 'dangkiem4304D.kiemdinhoto.vn', '0236.2641.666',
        'Đường số 01, KCN Hòa Cầm, P.Hòa Thọ Tây, Q. Cẩm Lệ, Tp. Đà Nẵng', 'ttdkhoacam.4304D@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d30680.398690187263!2d108.14283757910155!3d16.010921!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31421b4d2a3f7091%3A0xbdbf0aab83a0d551!2zVHJ1bmcgdMOibSDEkcSDbmcga2nhu4NtIHhlIGPGoSBn',
        'Lê Văn Long');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (114, '4305D', 'TTDK XCG 4305D - Đà Nẵng', 'Đà Nẵng', 'dangkiem4305D.kiemdinhoto.vn', '02363709124',
        'Số 10B, Tú Mỡ, phường Hòa An, quận Cẩm Lệ, Tp. Đà Nẵng', '4305D@kiemdinhoto.vn',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d122695.56756489904!2d108.08475270402052!3d16.053213374986317!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3142191134caadc5%3A0xa18ba5b347d1fdc8!2zQ8O0bmcgVHkgVE5ISCDEkMSDbmcgS2nhu4N',
        'Trần Việt Chung');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (115, '4701D', 'TTDK XCG 4701D - Đăklăk', 'Đắk Lắk', 'dangkiem4701D.kiemdinhoto.vn', '0262.3876239',
        '31 Nguyễn Chí Thanh, P. Tân An, Tp. Buôn Ma Thuột, Đắk Lắk', 'trungtamdangkiemxcg4701d@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m23!1m12!1m3!1d62275.049859110164!2d108.03989610915399!3d12.700978425105342!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!4m8!3e6!4m0!4m5!1s0x3171f7c1230cc459%3A0x86069e9b279b9751!2zVHJ1bmcgVMOibSDEkcSDbmcga2n',
        'PGĐ Bùi Văn Trường');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (116, '4702D', 'TTDK XCG 4702D - Đăklăk', 'Đắk Lắk', 'dangkiem4702D.kiemdinhoto.vn', '0262.3949979',
        'Km 12 - QL 14 – Thôn 7- Hoà Phú - Buôn Ma Thuột - ĐăkLăk', 'dangkiem4702d@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3893.4351392422777!2d107.94581875092597!3d12.61943402587705!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31721935e564c9f1%3A0xcf9b3e39ff1a3627!2zVHJ1bmcgdMOibSDEkcSDbmcga2nhu4NtIHhl',
        'Phan Hoài Nam');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (117, '4703D', 'TTDK XCG 4703D - Đăklăk', 'Đắk Lắk', 'dangkiem4703D.kiemdinhoto.vn', '0262.3822299',
        'Thôn 9, xã Ea Đar, Eakar, Đắk lắk', 'ttdk4703d@gmail.com', null, 'Trương Văn Minh');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (118, '4704D', 'TTDK XCG 4704D - Đăklăk', 'Đắk Lắk', 'dangkiem4704D.kiemdinhoto.vn', '0262.3922222',
        '75 Nguyễn Thị Định, P. Thành Nhất, TP. Buôn Ma Thuột, Đắk lắk', 't4704d@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d62294.94112559629!2d107.91289678017003!3d12.619520717512593!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31721da8337c8b95%3A0xdbc338db83c8ab33!2sCenter%20Register%20CG%20Automobiles',
        'Nguyễn Xuân Định');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (119, '4705D', 'TTDK XCG 4705D - Đăklăk', 'Đắk Lắk', 'dangkiem4705D.kiemdinhoto.vn', '0262.3514514',
        'Thôn 15, Pơng Drang, Krông Búk, Đắk lắk', 'dangkiem4705d@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d62206.26087826657!2d108.16413345820314!3d12.978803399999997!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x316e04abaeac873d%3A0xaf175f2a649b7cc1!2zVHJ1bmcgdMOibSDEkMSDbmcgS2nhu4NtIFhl',
        'Trần Quốc Mậu');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (120, '4706D', 'TTDK XCG 4706D - Đăklăk', 'Đắk Lắk', 'dangkiem4706D.kiemdinhoto.vn', '0846.523838',
        'Thôn Hòa Thắng, xã Hòa Đông, huyện Krông Pắc, tỉnh Đắk Lắk', 'dangkiem4705d@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d62275.47394308497!2d108.09727035820313!3d12.699247099999997!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3171f10d55df69e1%3A0x42a0a5f758cc7e99!2zVHJ1bmcgVMOibSDEkMSDbmcgS2nhu4NtIFhl',
        'Lại Phú Hợp');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (121, '4801D', 'TTDK XCG 4801D', 'Đắk Nông', 'dangkiem4801D.kiemdinhoto.vn', '02613.548.055',
        'Km 3 QL 14, Tổ 4, P Nghĩa Tân, TP Gia Nghĩa, Đak Nông', 'dangkiemdaknong@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m23!1m12!1m3!1d62444.0371139958!2d107.62880120832907!3d11.991632573286987!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!4m8!3e6!4m0!4m5!1s0x3173b92d2f7248c3%3A0x298890d35acdc00!2zQ8O0bmcgdHkgY-G7lSBwaOG6p24gxJ',
        'Nguyễn Xuân Diện');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (122, '4802D', 'TTDK XCG 4802D', 'Đắk Nông', 'dangkiem4802D.ttdk.com.vn', '(0261) 3648 007',
        'Khu vực Núi Lửa, QL 14, xã Thuận An, huyện Đắk MiL, tỉnh Đắk Nông', 'dangkiem4802d@gmail.com', null,
        'Phan Hữu Nhã');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (123, '4901S', 'TTDK XCG 4901S - Lâm Đồng', 'Lâm Đồng', 'dangkiem4901S.kiemdinhoto.vn', '02633832658',
        'Số 1 Tô Hiến Thành - P.3 - TP. Đà Lạt', 'ttdkxcg@lamdong.gov.vn',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3903.6768885730535!2d108.44372585092285!3d11.927559840108842!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3171131bc5c884db%3A0x2dc7aaf3c13e5d6d!2zVFJVTkcgVMOCTSDEkMSCTkcgS0nhu4JNIFh',
        'Đinh Văn Đổi');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (124, '4902S', 'TTDK XCG 4902S - Lâm Đồng', 'Lâm Đồng', 'dangkiem4902S.kiemdinhoto.vn', '0263.3720025',
        '01 Huỳnh Thúc Kháng, P.2, TX Bảo Lộc, Lâm Đồng', 'ttdkxcg@lamdong.gov.vn',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d250185.33891893606!2d107.5189852328125!3d11.541388400000002!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3173f64ff7a8a08d%3A0x78ff2c7bf1ca226f!2zVHJ1bmcgVMOibSDEkMSDbmcgS2nhu4NtIFhl',
        'Nguyễn Nguyễn Trí Hải');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (125, '4903S', 'TTDK XCG 4903S', 'Lâm Đồng', 'dangkiem4903S.kiemdinhoto.vn', '0263.3659979',
        'Thị trấn Liên Nghĩa, Đức Trọng, Lâm Đồng', 'ttdkxcg@lamdong.gov.vn',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d250011.04583663936!2d108.07193343281251!3d11.735250500000017!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x317146b4c6d6d76f%3A0x7e835dc265237447!2zVHJ1bmcgdMOibSDEkMSDbmcga2nhu4NtIHh',
        'Nguyễn Nguyễn Trí Hải');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (126, '4904D', 'TTDK XCG 4904D - Lâm Đồng', 'Lâm Đồng', 'dangkiem4904D.kiemdinhoto.vn', '0263.3788888',
        'Đ. tránh Quốc lộ 20, Lộc Nga, Bảo Lộc, Lâm Đồng, Việt Nam', 'info@dangkiembaoloc.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d250206.79530331993!2d107.58201063281251!3d11.517300499999996!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3173f76054bec3ed%3A0xbf460407c4a116fa!2zVHJ1bmcgdMOibSDEkMSDbmcga2nhu4NtIHh',
        'Nguyễn Lương Tuân');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (127, '5004V', 'TTDK XCG 5004V - TP.HCM', 'Hồ Chí Minh', 'dangkiem5004V.kiemdinhoto.vn', '028.36369255',
        'Lô H4, Đường G, Khu công nghiệp Cát Lái - Cụm 2, Phường Thạnh Mỹ Lợi, Thành phố Thủ Đức, Thành phố Hồ Chí Minh',
        'ttdkxcg5004v@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d125383.91232392938!2d106.69110010713233!3d10.868788919034383!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3175244a399cef03%3A0x30529a5b36248168!2zVHJ1bmcgdMOibSDEkMSDbmcga2nhu4NtIHh',
        'Nguyễn Xuân Hải');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (128, '6001S', 'TTDK XCG 6001S - Đồng Nai', 'Đồng Nai', 'dangkiem6001S.kiemdinhoto.vn', '0251.3891744',
        'Số 25, Đường 2A, KCN Biên Hoà II - P.An Bình - TP Biên Hoà - Tỉnh Đồng Nai', 't6001svr@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d15669.159816911246!2d106.86939352238456!3d10.941455986081168!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3174df02c3826d75%3A0xac414237a1f7818b!2zVFJVTkcgVMOCTSDEkMSCTkcgS0nhu4JNIFh',
        'Trần Minh Lợi');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (129, '6002S', 'TTDK XCG 6002S - Đồng Nai', 'Đồng Nai', 'dangkiem6002S.kiemdinhoto.vn', '0251.3876020',
        'Quốc lộ 1A - Phường Xuân Bình - TP. Long Khánh - Tỉnh Đồng Nai', 't6001svr@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m23!1m12!1m3!1d62677.46166087333!2d107.20287560725907!3d10.937566469347736!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!4m8!3e6!4m0!4m5!1s0x3174f92bdb5a8163%3A0x7323cd9f3bce30ba!2zVHJ1bmcgVMOibSDEkcSDbmcga2nh',
        'Nguyễn Sơn Hải');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (130, '6003S', 'TTDK XCG 6003S - Đồng Nai', 'Đồng Nai', 'dangkiem6003S.kiemdinhoto.vn', '0251.3615527',
        'QL 20, Ấp Trung Hoà, Ngọc Định, Định Quán, Đồng Nai', 't6001svr@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d250709.51910439975!2d107.09738145083091!3d10.937953805422044!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31745fc105c430b9%3A0x6ee585328332a2f4!2zVHJ1bmcgVMOibSDEkMSDbmcga2nhu4NtIFh',
        'Nguyễn Hoàng Dũng');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (131, '6004D', 'TTDK XCG 6004D - Đồng Nai', 'Đồng Nai', 'dangkiem6004D.kiemdinhoto.vn', '0251.3893198',
        'Số 1A, xa lộ Hà Nội, phường Tân Biên, thành phố Biên Hòa, tỉnh Đồng Nai', 'trungtamdangkiem6004d@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3917.025718433213!2d106.8817045509192!3d10.961429758709267!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3174def652e1387d%3A0xe010d20f114cd558!2zVHJ1bmcgVMOibSDEkMSDbmcgS2nhu4NtIFhlI',
        'Lương Minh Tú');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (132, '6005D', 'TTDK XCG 6005D - Đồng Nai', 'Đồng Nai', 'dangkiem6005D.kiemdinhoto.vn', '02518.838036',
        '370/2A Võ Nguyên ​​​​​Giáp, xã Phước Tân​​, TP. Biên Hòa, tỉnh Đồng Nai', 'dangkiem60.05d@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d31342.1472288412!2d106.88756387910158!3d10.90519770000001!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3174e07d1ce81cc9%3A0xaa4f6a9d14256a22!2zVHJ1bmcgdMOibSDEkMSDbmcga2nhu4NtIHhlIG',
        'Nguyễn Văn Thuận');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (133, '6006D', 'TTDK XCG 6006D - Đồng Nai', 'Đồng Nai', 'dangkiem6006D.kiemdinhoto.vn', '0251.3510760',
        'Xã An Phước, Huyện Long Thành-Đồng Nai', 't6006dvr@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d125368.50366503578!2d106.83481887666477!3d10.905399920889618!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31751fbd8932141b%3A0xd6183c35c8224e!2zVHJ1bmcgVMOibSDEkMSDbmcgS2nhu4NtIFhlI',
        'Trương Tiến Diệu');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (134, '6101S', 'TTDK XCG 6101S - Bình Dương', 'Bình Dương', 'dangkiem6101S.kiemdinhoto.vn', '0274.3825778',
        'QL13 - P.Hiệp thành - TP. Thủ Dầu Một - Bình Dương', 'dangkiemxecogioi@binhduong.gov.vn',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3916.6638673582606!2d106.66185975091928!3d10.988724158204183!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3174d1178c994b73%3A0x4be98ac4b4e8d866!2zVHJ1bmcgVMOibSDEkMSDbmcgS2nhu4NtIFh',
        'Lâm Sơn Hà');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (135, '6102S', 'TTDK XCG 6102S - Bình Dương', 'Bình Dương', 'dangkiem6102S.kiemdinhoto.vn', '0274.770.619',
        'Đường Nguyễn Thị Minh Khai, khu phố Tân Thắng, phường Tân Bình, Tp. Dĩ An, tỉnh Bình Dương',
        'dangkiemxecogioi@binhduong.gov.vn',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d1958.6471446141104!2d106.7708673!3d10.941128!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3174d9a4e7e4669b%3A0x6ae13e5af162ea9e!2zQ2hpIE5ow6FuaCDEkMSDbmcgS2nhu4NtIFhDRyA2MS4wMlM!5e0!3m2!1svi!2s!4v16',
        'Lâm Sơn Hà');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (136, '6103D', 'TTDK XCG 6103D - Bình Dương', 'Bình Dương', 'dangkiem6103D.kiemdinhoto.vn', '0274.3884334',
        'Đường ĐX 82, Khu 2, P. Định Hòa, T.p TDM, Bình Dương', 'dangkiem6103D@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d7832.641778500603!2d106.64165386977538!3d11.014533300000005!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3174d19ebcdde239%3A0x61b2ffa50c4bc0ab!2zVHJ1bmcgVMOibSDEkMSDbmcgS2nhu4NtIFhl',
        'Lê Việt Hùng');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (137, '6103S', 'TTDK XCG 6103S - Bình Dương', 'Bình Dương', 'dangkiem6103S.ttdk.com.vn', '099999999', null,
        '6103S@kiemdinhoto.vn', null, 'Bùi Thanh Việt');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (138, '6104D', 'TTDK XCG 6104D - Bình Dương', 'Bình Dương', 'dangkiem6104D.kiemdinhoto.vn', '0274.3719888',
        '414/3B ĐL Bình Dương, Thạnh Bình, Thuận An, Bình Dương', 'dangkiem6104D@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d31336.221102614927!2d106.65878747910155!3d10.961284800000001!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3174d7337f175205%3A0x86f549e36b93d806!2zVHJ1bmcgVMOibSDEkMSDbmcgS2nhu4NtIFh',
        'Võ Đông Phong');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (139, '6105D', 'TTDK XCG 6105D - Bình Dương', 'Bình Dương', 'dangkiem6105D.kiemdinhoto.vn', '0274.3639778',
        'Thửa đất số 117, tờ bản đồ số 23, KCN Nam Tân Uyên, phường Khánh Bình, thị xã Tân Uyên, tỉnh Bình Dương',
        'ttdk6105d@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d31324.931461403146!2d106.72413377910156!3d11.0673573!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3174c53d34bacc7b%3A0x69a8ff536e590389!2zVHJ1bmcgVMOibSDEkMSDbmcgS2nhu4NtIFhlIEPGoSB',
        'Nguyễn Duy Khương');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (140, '6106D', 'TTDK XCG 6106D - Bình Dương', 'Bình Dương', 'dangkiem6106D.kiemdinhoto.vn', '0274.3795886',
        'Số 216, khu phố T1, phường Tân Bình, thị xã Dĩ An, Bình Dương', 'dangkiem6106D@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d125299.63944411486!2d106.6713887772659!3d11.067559285249907!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3174d9a2ded29deb%3A0x3e62762e939f06c1!2zVHJ1bmcgdMOibSDEkMSDbmcga2nhu4NtIHhl',
        'Danh Thanh Tiền');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (141, '6108D', 'TTDK XCG 6108D - Bình Dương', 'Bình Dương', 'dangkiem6108D.ttdk.com.vn', '099999999',
        'số 08 Đại Lộ Bình Dương, phường Tân Định, thị xã Bến Cát, tỉnh Bình Dương', '6108D@kiemdinhoto.vn', null,
        'Khong Co');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (142, '6109D', 'TTDK XCG 6109D - Bình Dương', 'Bình Dương', 'dangkiem6109D.kiemdinhoto.vn', '0274.378.7227',
        '19/2 khu phố Bình Đáng, phường Bình Hòa, Tx. Thuận An, tỉnh Bình Dương', '6109D@kiemdinhoto.vn',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3917.556421933748!2d106.7182232509191!3d10.92127695945016!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3174d737400bce13%3A0xc4998c3a1d75258d!2zVHJ1bmcgdMOibSDEkMSDbmcga2nhu4NtIFhlIE',
        'Võ Quốc Phong');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (143, '6110D', 'TTDK XCG 6110D - Bình Dương', 'Bình Dương', 'dangkiem6110D.kiemdinhoto.vn',
        'Gửi email nếu lịch bị hủy', '291, QL 13, Khu Phố 2, P. Mỹ Phước, TX. Bến Cát, Tỉnh Bình Dương',
        'dangkiem6110d@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d15657.885987644753!2d106.5809963395508!3d11.152683700000003!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3174d967038f419b%3A0xd419f53d56fbd714!2zVFJVTkcgVMOCTSDEkMSCTkcgS0nhu4JNIFhF',
        'Phan Hũu Thọ');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (144, '6111D', 'Trung tâm Đăng kiểm XCG 6111D - Bình Dương', 'Bình Dương', 'dangkiem6111D.kiemdinhoto.vn',
        '02743801616', 'Lô CC-9A, KCN Mỹ Phước 3, P. Thới Hòa, TX. Bến Cát, T. Bình Dương', 'dangkiem6111@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d125263.0098064322!2d106.51951796941479!3d11.152864886974891!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3174cfaca5771591%3A0xf826908f381b1677!2zVFQgxJHEg25nIGtp4buDbSA2MSAxMUQ!5e0!',
        'Đoàn Văn Chiến');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (145, '6112D', 'TTDK XCG 6112D- Bình Dương', 'Bình Dương', 'dangkiem6112D.kiemdinhoto.vn', '0274.3799492',
        'Thửa đất số 294, tờ bản đồ số DC 9.4, khu phố Đông, phường Vĩnh Phú, Tp. Thuận An, tỉnh Bình Dương',
        'ttdk6112d@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d125383.41969138152!2d106.5701557164062!3d10.869961300000003!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x317529aac3dbe545%3A0xa8c96c71de698013!2zVHJ1bmcgVMOibSDEkMSDbmcgS2nhu4NtIFhl',
        'Nguyễn Thanh Thảo');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (146, '6201S', 'TTDK XCG 6201S - Long An', 'Long An', 'dangkiem6201S.kiemdinhoto.vn', '0272.3821496',
        'Số 12 Quốc Lộ 1 - Phường 5 - Thị xã Tân An - Long An', 'ttdkx@longan.gov.vn',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3922.3970475103242!2d106.41391025091792!3d10.548070366213196!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x310ac9ddfab496b7%3A0xc90260c70a2b0cc0!2zVHJ1bmcgdMOibSDEkcSDbmcga2nhu4NtIHh',
        'Nguyễn Văn Phúc');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (147, '6202D', 'TTDK XCG 6202D - Long An', 'Long An', 'dangkiem6202D.kiemdinhoto.vn', '0272.3637816',
        '356 KP9, QL1A, TT Bến Lức, Long An', 'trungtamdangkiem6202d@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d125516.63768686091!2d106.3458818939626!3d10.5482366560772!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x310acc9b302eeaa9%3A0xa797b661a3aadc76!2zVHJ1bmcgVMOibSDEkMSDbmcgS2nhu4NtIFhlIE',
        'Trần Hoàng Thái');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (148, '6301S', 'TTDK XCG 6301S - Tiền Giang', 'Tiền Giang', 'dangkiem6301S.kiemdinhoto.vn', '0273.3935153',
        'Ấp Ngãi Lợi - Xã Thân Cửu nghĩa - Huyện Châu Thành - Tiền Giang', 'tg6301s@yahoo.com.vn',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3923.97795749422!2d106.33581925091751!3d10.423323668424237!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x310aba6c7506efad%3A0x6f5105177f17315f!2zVHJ1bmcgVMOibSDEkMSDbmcgS2nhu4NtIFhlI',
        'Nguyễn Văn Hiệp');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (149, '6302D', 'TTDK XCG 6302D - Tiền Giang', 'Tiền Giang', 'dangkiem6302D.kiemdinhoto.vn', '0273.3515777',
        'Xã Tam Hiệp, huyện Châu Thành, tỉnh Tiền Giang', 'minh.ntt@dkquocthang.vn',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3923.8687776187303!2d106.31242075091752!3d10.431986268271483!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x310aba44ed63fce5%3A0xca233d5a2819a871!2zVHJ1bmcgdMOibSDEkMSDbmcga2nhu4NtIHh',
        'Trần Hoàng Thuấn');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (150, '6303D', 'TTDK XCG 6303D - Tiền Giang', 'Tiền Giang', 'dangkiem6303D.kiemdinhoto.vn', '0273.3633663',
        'Ấp đông B, xã Nhị Bình, huyện Châu Thành, tỉnh Tiền Giang', '6303D@kiemdinhoto.vn',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d15696.97799810788!2d106.2163079395508!3d10.402145600000011!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x310abdcd9d9838b9%3A0xcabdfb894d5a0d5a!2zVHJ1bmcgdMOibSDEkMSDbmcga2nhu4NtIHhlI',
        'Nguyễn Hữu Nghĩa');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (151, '6401V', 'TTDK XCG 6401V - Vĩnh Long', 'Vĩnh Long', 'dangkiem6401V.kiemdinhoto.vn', '0270.3824934',
        '10/2 Đinh Tiên Hoàng - F8 - T.P Vĩnh Long', 'ccdkvinhlong@vr.org.vn',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3926.266584301811!2d105.95430595091688!3d10.240070371627034!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x310a82bad3005811%3A0x5cb748e9b93766b6!2zVHJ1bmcgVMOibSDEkMSDbmcgS2nhu4NtIFhl',
        'Nguyễn Thành Bắc');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (152, '6501S', 'TTDK XCG 6501S- Cần Thơ', 'Cần Thơ', 'dangkiem6501S.kiemdinhoto.vn', '0292.3844226',
        'Lô 19A2, Khu Công Nghiệp Trà nóc 1, P. Trà Nóc, Q Bình Thuỷ, TP. Cần Thơ', 'dangkiemcantho6501s@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3927.926746239924!2d105.7038875509165!3d10.105082173951969!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31a086697273d9d3%3A0x5367750a1fddc9f7!2zVHJ1bmcgVMOibSDEkMSDbmcgS2nhu4NtIFhlI',
        'Lê Thuận Bé');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (153, '6502D', 'TTDK XCG 6502D - Cần Thơ', 'Cần Thơ', 'dangkiem6502D.kiemdinhoto.vn', '0292.3811688',
        'số 26B, Nguyễn Văn Linh, phường Long Hòa, quận Bình Thủy, Cần Thơ', 'ttdk6502d@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3928.618270849383!2d105.72637395091625!3d10.048324774920758!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31a08885d203be4b%3A0xa0b1fcb6d6311d7a!2zVHJ1bmcgdMOibSDEkcSDbmcga2nDqsyJbSB4',
        'PGĐ. Phạm Minh Nhựt');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (154, '6502S', 'TTDK XCG 6502S', 'Cần Thơ', 'dangkiem6502S.kiemdinhoto.vn', '02923.663379',
        'KV1, P.Hưng Thạnh, Q.Cái Răng, TP.Cần Thơ', 'dangkiemcantho6502s@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3928.9093639621515!2d105.79797845091629!3d10.024337975328688!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31a06293cc9772ad%3A0x9052bd8a546651ee!2zS2h1IFbhu7FjIEksIEPDoWkgUsSDbmcsIEP',
        'Huỳnh Quang Trung');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (155, '6503D', 'TTDK XCG 6503D - Cần Thơ', 'Cần Thơ', 'dangkiem6503D.kiemdinhoto.vn', '0911847857',
        '9A, Quốc lộ 91B, Khu vực Bình Hòa A, phường Phước Thới, quận Ô Môn, Tp. Cần Thơ', '6503D@kiemdinhoto.vn',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d31424.472397723523!2d105.63477037910154!3d10.094247700000006!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31a0853195e8cb73%3A0xd88408760e91c162!2zVHJ1bmcgdMOibSDEkcSDbmcga2nhu4NtIHh',
        'Đoàn Khánh Quang Trung');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (156, '6504D', 'TTDK XCG 6504D - Cần Thơ', 'Cần Thơ', 'dangkiem6504D.kiemdinhoto.vn', '0292.360.4568',
        'Khu vực Tràng Thọ 1, phường Thốt Nốt, Q. Thốt Nốt, Tp. Cần Thơ', '6504D@kiemdinhoto.vn',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d31407.525789207975!2d105.48457707910156!3d10.266359999999995!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x310a779d9c7c109f%3A0x3702d18ddbb2a749!2zVHJ1bmcgdMOibSDEkMSDbmcga2nhu4NtIHh',
        'Nguyễn Văn Hùng');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (157, '6505D', 'TTDK XCG 6505D - Cần Thơ', 'Cần Thơ', 'dangkiem6505D.kiemdinhoto.vn', '0229.23915999',
        'Khu vực 4, phường Hưng Thạnh, quận Cái Răng, Tp. Cần Thơ', '6505D@kiemdinhoto.vn',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d31433.131050811826!2d105.73684957910156!3d10.005178399999997!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31a08925f84c1c4b%3A0xf23a4800fb51b6a0!2zVHJ1bmcgdMOibSDEkcSDbmcga2nhu4NtIHh',
        'Trần Anh Tuyên');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (158, '6506D', 'TTDK XCG 6506D - Cần Thơ', 'Cần Thơ', 'dangkiem6506D.kiemdinhoto.vn', '02923851033',
        'ấp Vĩnh Long, xã Vĩnh Trinh, huyện Vĩnh Thạnh, TP.Cần Thơ', '6506D@kiemdinhoto.vn',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d31404.392618263704!2d105.44506107910156!3d10.297869200000001!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31a089877b2b2503%3A0xf3346255138fd6aa!2zVHJ1bmcgdMOibSDEkMSDbmcga2nhu4NtIHh',
        'Nguyễn Đức Vui');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (159, '6601S', 'TTDK XCG 6601S - Đồng Tháp', 'Đồng Tháp', 'dangkiem6601S.kiemdinhoto.vn', '02773.852753',
        'Số 386, Ấp 1, Điện Biên Phủ, xã Mỹ Trà, TP Cao lãnh, tỉnh Đồng Tháp', 'dangkiem6601s@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3923.2961802858986!2d105.64595275091763!3d10.477301567470585!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x310a643699736775%3A0x7ed0a03a060f7997!2zVHJ1bmcgdMOibSDEkMSDbmcga2nhu4NtIHB',
        'Nguyễn Ngọc Long');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (160, '6602D', 'TTDK XCG 6602D - Đồng Tháp', 'Đồng Tháp', 'dangkiem6602D.kiemdinhoto.vn', '0818.676867',
        'Số 123, Quốc lộ 80, ấp An Thạnh, xã An Nhơn, huyện Châu Thành, tỉnh Đồng Tháp', '6602D@kiemdinhoto.vn',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3926.0042125479563!2d105.85418683488766!3d10.2612431!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x310a819be24ae8f1%3A0x25c4ba9bf3119cbe!2zQ8O0bmcgVHkgVE5ISCDEkMSDbmcgS2nhu4NtIFbDoCB',
        'Trần Thanh Nhã');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (161, '6701S', 'TTDK XCG 6701S - An Giang', 'An Giang', 'dangkiem6701S.kiemdinhoto.vn', '0911856701',
        '67 Quốc lộ 91, Khóm Thới Hoà, P. Mỹ Thạnh, Tp. Long Xuyên - An Giang', 'ttdktb@angiang.gov.vn',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d251069.76361645258!2d105.13868258326838!3d10.503418446484266!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x310a7409b5385985%3A0x1007312bc574f460!2zVHJ1bmcgVMOibSDEkMSDbmcgS2nhu4NtIFh',
        'Nguyễn Thiện Bằng');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (162, '6702S', 'TTDK XCG 6702S', 'An Giang', 'dangkiem6702S.kiemdinhoto.vn', '0296.3569199- 0912696702',
        'Khóm 8- Châu Phú A - TP Châu Đốc - An Giang', 'dangkiem6702s@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d15681.7769081012!2d105.1004915!3d10.7001787!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x310a26b582d96e1d%3A0x438fb47ec8ec28e7!2zVHJhzKNtIMSQxINuZyBLacOqzIltIFhjZyBDaMOidSDEkMO0zIFj!5e0!3m2!1sen!2s!',
        'Hồ Minh Ức');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (163, '6703D', 'TTDK XCG 6703D - An Giang', 'An Giang', 'dangkiem6703D.kiemdinhoto.vn', null,
        'Tuyến tránh QL 91 (N1), Khóm Hòa Bình, phường Vĩnh Mỹ, Tp. Châu Đốc, tỉnh An Giang', 'ttdk6703d@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3920.5495982363113!2d105.13190635091836!3d10.692025763630848!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x310a230470984071%3A0x18fce74df3b5d8f3!2zVHJ1bmcgVMOibSDEkMSDbmcgS2nhu4NtIFh',
        'Trương Công Khánh Dân');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (164, '6801S', 'TTDK XCG 6801S - Kiên Giang', 'Kiên Giang', 'dangkiem6801S.kiemdinhoto.vn', '0297.3865358',
        'Khu dân cư BX liên tỉnh, đường số 2, ấp So Đũa, xã Vĩnh Hòa Hiệp, Châu Thành, Kiên Giang',
        'ttdk6801s@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d502436.2967598519!2d104.85133537165626!3d10.319176101211616!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31a0b5d495df062d%3A0x6ace429a44df8fb0!2zVHJ1bmcgVMOibSDEkMSDbmcgS2nhu4NtIFhl',
        'Nguyễn Quốc Sử');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (165, '6803D', 'TTDK XCG 6803D - Kiên Giang', 'Kiên Giang', 'dangkiem6803D.kiemdinhoto.vn', '02973556868',
        'Đường Võ Văn Kiệt, tổ 15, khu phố Dãy Ốc, phường Vĩnh Hiệp, thành phố Rạch Giá, tỉnh Kiên Giang',
        '6803D@kiemdinhoto.vn',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3929.0102714520194!2d105.10542605091631!3d10.01600967547008!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31a0b3332c2d536b%3A0xfb99bb3bb5265455!2zVFJVTkcgVMOCTSDEkMSCTkcgS0nhu4JNIFhF',
        'Lâm Hoàng Minh Tuấn');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (166, '6901V', 'TTDK XCG 6901V - Cà Mau', 'Cà Mau', 'dangkiem6901V.kiemdinhoto.vn', '0290.3835576',
        'Ấp 5 - Xã An Xuyên - TP. Cà Mau - Tỉnh Cà Mau', 'ccdkcamau@vr.org.vn',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d15754.156349768367!2d105.13072582829206!3d9.19598127593253!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31a14988db4ed161%3A0x636d9360b6a3fc95!2zQ2hpIEPhu6VjIMSQxINuZyBLaeG7g20gQ8OgI',
        'Đặng Hoàng Phong');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (167, '6902D', 'TTDK XCG 6902D - Cà Mau', 'Cà Mau', 'dangkiem6902D.kiemdinhoto.vn', '02906.267.999',
        'Số 36, đường Võ Văn Kiệt, ấp Tắc Thủ, xã Hồ Thị Kỷ, huyện Thới Bình, tỉnh Cà Mau', 'dangkiem6902d@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d15753.421891467651!2d105.0955674395508!3d9.212466000000004!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31a14ba74c3ef79f%3A0xb08d9f87b484c2e6!2zVHJ1bmcgVMOibSDEkMSDbmcgS2nhu4NtIFhlI',
        'Khưu Tố Phương');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (168, '7001S', 'TTDK XCG 7001S - Tây Ninh', 'Tây Ninh', 'dangkiem7001S.kiemdinhoto.vn', '088.9600900',
        '82 đường Trần Phú - p. Ninh Sơn - Tp. Tây Ninh - Tỉnh Tây Ninh', 'dangkiemxecogioi7001s@tarco.com.vn',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d250487.74700444535!2d106.09028881018553!3d11.197175618562586!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x310b6bd5595289d7%3A0x39e16f281aa9e272!2zVHJ1bmcgdMOibSDEkMSDbmcga2nhu4NtIHh',
        'Lê Phan Thanh Vinh (PTTT)');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (201, '7902S', 'TTDK XCG 7902S - Khánh Hoà', 'Khánh Hoà', 'dangkiem7902S.kiemdinhoto.vn', '0258-3862268',
        'QL1A, Phú Sơn, Cam Phú, Cam Ranh, Khánh Hòa', 'dangkiemkhanhhoa@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d249666.2701419346!2d109.0365531257821!3d12.10972427861838!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3170ed41baecfab9%3A0xf540197c6a7870b4!2zxJDEg25nIEtp4buDbSA3OTAyUw!5e0!3m2!1se',
        'Trần Xuân Khánh');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (169, '7002S', 'TTDK XCG 7002S - Tây Ninh', 'Tây Ninh', 'dangkiem7002S.kiemdinhoto.vn', '088.9600900',
        'Đường tránh xuyên Á, P. Gia Lộc, Tx. Tràng Bảng, Tỉnh Tây Ninh', 'dangkiemxecogioi7002s@yahoo.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d250487.74700444535!2d106.09028881018553!3d11.197175618562586!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x310b2f49a1e906b9%3A0xfc0e981fdd8a34e7!2zVHJ1bmcgdMOibSDEkMSDbmcga2nhu4NtIHh',
        'Phan Nguyễn Thanh Phong');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (170, '7003D', 'TTDK XCG 7003D - Tây Ninh', 'Tây Ninh', 'dangkiem7003D.kiemdinhoto.vn', '088.9600900',
        'đường 793, xã Thạnh Đông, huyện Tân Châu, tỉnh Tây Ninh', 'dangkiemxecogioi7003d@tarco.com.vn',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3909.1221161484887!2d106.110532915337!3d11.54309684772899!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x310b60dfbfbc7e8d%3A0x9e4bfecf639df7f0!2zVHJ1bmcgdMOibSDEkMSDbmcga2nhu4NtIHhlIG',
        'Ngô Anh Tuấn');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (171, '7101D', 'TTDK XCG 7101D', 'Bến Tre', 'dangkiem7101D.kiemdinhoto.vn', '0275.2241.178 hoặc 0275.3824.124',
        'Số 7, đường Nguyễn Văn Tư , Phường 7 , Thành phố Bến Tre , Tỉnh Bến Tre', 'ttdk7101sbt@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m16!1m12!1m3!1d44426.01224999641!2d106.37188272423873!3d10.201609758881418!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!2m1!1zU-G7kSA3IOKAkyBOZ3V54buFbiBWxINuIFTGsCDigJMgUDcg4oCTIFRYIELhur9uIFRyZSDigJMgVOG7iW',
        'Huỳnh Nguyên Thạch');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (172, '7102D', 'TTDK XCG 7102D - Bến Tre', 'Bến Tre', 'dangkiem7102D.kiemdinhoto.vn', '0275.3907102',
        'QL60, ấp Tân Long 1, xã Tân Thành Bình, huyện Mỏ Cày Bắc, tỉnh Bến Tre', '7102D@kiemdinhoto.vn',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d7873278.501866921!2d102.39792538685224!3d15.51805427687094!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x310aa7eb180bd9c3%3A0xdf2d5baf859f3f39!2zVHJ1bmcgdMOibSDEkcSDbmcga2nhu4NtIDcxL',
        'Nguyễn Thanh Đông');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (173, '7201S', 'TTDK XCG 7201S - Bà Rịa Vũng Tàu', 'Bà Rịa Vũng Tàu', 'dangkiem7201S.kiemdinhoto.vn',
        '0254.3626299', '47B, Đường 30/4, P. Thắng Nhất, TP Vũng Tàu', 't7201s@yahoo.com.vn',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d7870604.341932122!2d102.39828632039773!3d15.587987181932341!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31756e2d9be119ef%3A0x13eb01fd9fe62c60!2zVHJ1bmcgdMOibSDEkMSDbmcga2nhu4NtIDcy',
        'Hoàng Văn Sỹ');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (174, '7202D', 'TTDK XCG 7202D - Bà Rịa Vũng Tàu', 'Bà Rịa Vũng Tàu', 'dangkiem7202D.kiemdinhoto.vn',
        '0254.3717126', 'QL51, KP2, Phước Trung, TX Bà Rịa - Tỉnh Bà Rịa Vũng Tàu', 'trungtamdkxcg7202d@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d7870604.341932122!2d102.39828632039773!3d15.587987181932341!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x317573ae717eaf4f%3A0x9a6a9865ca586eb1!2zVHJ1bmcgVMOibSDEkMSDbmcgS2nhu4NtIDcy',
        'Lê Hùng Nam');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (175, '7203D', 'TTDK XCG 7203D - Bà Rịa Vũng Tàu', 'Bà Rịa Vũng Tàu', 'dangkiem7203D.kiemdinhoto.vn',
        '0254.3922222', 'Đường E, tổ 16, KP Vạn Hạnh, phường Phú Mỹ, thị xã Phú Mỹ, tỉnh Bà Rịa – Vũng Tàu',
        'trungtamdkxcg7203d@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d7870604.341932122!2d102.39828632039773!3d15.587987181932341!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31751190e7568931%3A0x75cecb45455ca984!2zVHJ1bmcgdMOibSDEkcSDbmcga2nhu4NtIHhl',
        'Nguyễn Hòa Quất');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (176, '7204S', 'TTDK XCG 7204S - Bà Rịa Vũng Tàu', 'Bà Rịa Vũng Tàu', 'dangkiem7204S.kiemdinhoto.vn',
        '02543.695999', 'Đường D6, khu công nghiệp Đất Đỏ 1, huyện Đất Đỏ, tỉnh Bà Rịa - Vũng Tàu', 't7204s@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d7870604.341932122!2d102.39828632039773!3d15.587987181932341!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3175a1167a8153f7%3A0x8ea393e5d269d1c!2zVHJ1bmcgdMOibSDEkMSDbmcga2nhu4NtIFhlI',
        'PGĐ  Trần Văn Lang');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (177, '7205D', 'TTDK XCG 7205D - Bà Rịa Vũng Tàu', 'Bà Rịa Vũng Tàu', 'dangkiem7205D.kiemdinhoto.vn',
        '02543.938118', 'KCN Mỹ Xuân A, phường Mỹ Xuân, thị xã Phú Mỹ, tỉnh Bà Rịa - Vũng Tàu',
        'ttdangkiem.7205d@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d7870604.341932122!2d102.39828632039773!3d15.587987181932341!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3175113184359efb%3A0x79ff6c33d2d796ce!2zVHJ1bmcgVMOibSDEkMSDbmcgS2nhu4NtIFhl',
        'Phan Thanh Toản');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (178, '7301S', 'TTDK XCG 7301S - Quảng Bình', 'Quảng Bình', 'dangkiem7301S.kiemdinhoto.vn', '0988877304',
        'Đường Hữu Cảnh - T.P Đồng Hới - Quảng Bình', 'ttdangkiem7301s@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m16!1m12!1m3!1d3805.884590812255!2d106.61598771537113!3d17.465237055151075!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!2m1!1zOiDEkcaw4budbmcgTmd1eeG7hW4gSOG7r3UgQ-G6o25oLCBwaMaw4budbmcgSOG6o2kgVGjhu4tuaCwgdG',
        'Nguyễn Thanh Long');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (179, '7302D', 'TTDK XCG 7302D - Quảng Bình', 'Quảng Bình', 'dangkiem7302D.kiemdinhoto.vn', '0232.3575555',
        'Thanh Lương, quảng Xuân, Quảng Trạch, Quảng Bình', 't7302d@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d15196.31578076632!2d106.41610103955078!3d17.787986500000002!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3138993673650115%3A0xc03b1a37db0a9b6b!2zVHJ1bmcgVMOibSDEkMSDbmcgS2nhu4NtIFhl',
        'Đặng Thành Chung');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (180, '7303D', 'TTDK XCG 7303D - Quảng Bình', 'Quảng Bình', 'dangkiem7303D.kiemdinhoto.vn', '0232.3910911',
        'Thôn Lệ Kỳ 1, xã Vĩnh Ninh, huyện Quảng Ninh, tỉnh Quảng Bình', 'dangkiem7303d@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d15227.741146347998!2d106.57903353955078!3d17.414893000000006!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31475439a0fce8ad%3A0x503879407c4c582d!2zVHJ1bmcgVMOibSDEkMSDbmcgS2nhu4NtIFh',
        'Trần Lê Trung');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (181, '7304D', 'TTDK XCG 7304D - Quảng Bình', 'Quảng Bình', 'dangkiem7304D.kiemdinhoto.vn', null,
        'Thôn 2, xã Trung Trạch, huyện Bố Trạch, tỉnh Quảng Bình', 't7304d@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d15212.628349585882!2d106.52222043955078!3d17.595273900000002!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31475953889e0201%3A0xb6a0cbcd48e4b7ae!2zVHJ1bmcgVMOibSDEkMSDbmcgS2nhu4NtIFh',
        'Phan Duy Tùng');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (182, '7401S', 'TTDK XCG 7401S - Quảng Trị', 'Quảng Trị', 'dangkiem7401S.kiemdinhoto.vn', '0233.3561546',
        '61 Lý Thương Kiệt - Đông Hà - Quảng Trị', 'tchcdkqt@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3819.468210643807!2d107.1125027153662!3d16.803112923813746!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3140e59b17a06b43%3A0x2dbdbb42422ac1df!2zNjEgTMO9IFRoxrDhu51uZyBLaeG7h3QsIMSQw',
        'Nguyễn Xuân Hà');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (183, '7402D', 'TTDK XCG 7402D - Quảng Trị', 'Quảng Trị', 'dangkiem7402D.kiemdinhoto.vn', '0233.3630888',
        'Hà Thanh, xã Gio Châu, Gio Linh, Quảng Trị', 'ttdangkiem7402d@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3969547.0213604504!2d104.39579930564882!3d13.687486464372151!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3140e841520acd9d%3A0x73fdbdcf37472e34!2zVHJ1bmcgVMOibSDEkMSDbmcgS2nhu4NtIFh',
        'Đặng Anh Tuấn');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (184, '7402S', 'TTDK XCG 7402S', 'Quảng Trị', 'dangkiem7402S.kiemdinhoto.vn', '0233.3568688',
        'Km 4 +700 Điện biên Phủ (9D), phường Đông Lương, TP Đông Hà, Quảng Trị', 'tchcdkqt@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d15278.397530729017!2d107.09104928651266!3d16.796595607256506!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3140e5814d2ac207%3A0xf27077263d6d4607!2zVHJ1bmcgVMOibSDEkMSDbmcgS2nhu4NtIFh',
        'PGĐ. Trần Việt Hùng');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (185, '7403D', 'TTDK XCG 7403D - Quảng Trị', 'Quảng Trị', 'dangkiem7403D.kiemdinhoto.vn', '0233.379.7999',
        'Đường Điện Biên Phủ, phường Đông Lương, Tp. Đông Hà, tỉnh Quảng Trị', 'dangkiem7403d@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d61115.664393953266!2d107.01906125820312!3d16.790151900000005!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3140ef69d3ae7be7%3A0xace3de8360a69466!2zVHJ1bmcgVMOibSDEkMSDbmcgS2nhu4NtIFh',
        'PGD. Trương Đình Tân');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (186, '7501S', 'TTDK XCG 7501S - Huế', 'Thừa Thiên - Huế', 'dangkiem7501S.kiemdinhoto.vn', '0234.382.6791',
        '332 Điện Biên Phủ - TP Huế', 'dangkiemtthue@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d61215.32864273449!2d107.49813449506013!3d16.477662196048072!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3141a156f633b991%3A0x602a3bd528757aa1!2zVHJ1bmcgVMOibSDEkMSDbmcgS2nhu4NtIFhl',
        'Nguyễn Thanh Tuệ');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (187, '7601S', 'TTDK XCG 7601S - Quảng Ngãi', 'Quảng Ngãi', 'dangkiem7601S.kiemdinhoto.vn', '02553842888',
        'Xã Tịnh Phong - Huyện Sơn Tịnh - Quảng Ngãi', 'ttdkt7601s@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d61604.68248912489!2d108.72191285820315!3d15.197142500000007!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3169b32ef26602d9%3A0x33355b84704a5605!2zVHJ1bmcgdMOibSDEkMSDbmcga2nhu4NtIHhl',
        'Nguyễn Thanh Mẫn');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (188, '7602D', 'TTDK XCG 7602D - Chi nhánh Công ty CP Thuận Phát', 'Quảng Ngãi', 'dangkiem7602D.kiemdinhoto.vn',
        '0255.392.7555-0935121269', 'QL 1A, thôn Năng Tây 3, xã Nghĩa Phương, huyện Tư Nghĩa, tỉnh Quảng Ngãi',
        'ttdk.7602d@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d61644.98404235292!2d108.7723064582031!3d15.058538800000008!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3168549b5a377253%3A0x660c6a0c5ca26c6c!2zVHJ1bmcgVMOibSDEkMSDbmcgS2nhu4NtIFhlI',
        'Nguyễn Thanh Chung');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (189, '7603D', 'TTDK XCG 7603D - Quảng Ngãi', 'Quảng Ngãi', 'dangkiem7603D.kiemdinhoto.vn', '0255.362.2567',
        'Thôn 4, xã Bình Hòa, huyện Bình Sơn, tỉnh Quảng Ngãi', 't7603d@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d61569.79060285214!2d108.75570735820313!3d15.316152100000012!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31684b8bca35cc21%3A0xbfabe9b18bdecce0!2zVHJ1bmcgVMOibSDEkMSDbmcgS2nhu4NtIHhl',
        'Võ Quang Phát');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (190, '7604D', 'TTDK XCG 7604D - Quảng Ngãi', 'Quảng Ngãi', 'dangkiem7604D.kiemdinhoto.vn', '0916870112',
        'Xã Hành Thuận, huyện Nghĩa Hành, tỉnh Quảng Ngãi', '7604D@kiemdinhoto.vn',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d61636.81284825901!2d108.71054505820311!3d15.08674140000001!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3169adf3b360ab21%3A0xb62abd561c4c2b06!2zVHJ1bmcgVMOibSDEkMSDbmcgS2nhu4NtIFhlI',
        'Trần Ngọc Duy');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (191, '7701S', 'TTDK XCG 7701S - Bình Định', 'Bình Định', 'dangkiem7701S.kiemdinhoto.vn', '0256.3846761',
        '357A Tây Sơn - Quy Nhơn - Bình Định', 'ttdk7701s@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m23!1m12!1m3!1d62004.070327660236!2d109.16346484063483!3d13.763526494366012!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!4m8!3e6!4m0!4m5!1s0x316f6cc82d7c1e41%3A0x14e850b123d926e6!2zVHJ1bmcgVMOibSDEkcSDbmcga2n',
        'Phạm Đại Lâm');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (192, '7702S', 'TTDK XCG 7702S - Bình Định', 'Bình Định', 'dangkiem7702S.kiemdinhoto.vn', '0256.3858579',
        'QLộ 1A - Thôn Vạn Lương - Mỹ Châu - Phú Mỹ - Bình Định', 'ttdk7701s@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d123701.21148307646!2d108.91600511640621!3d14.33100559999999!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3168cc280d9bd601%3A0x2f314d7f52fbd119!2zVHJ1bmcgdMOibSDEkcSDbmcga2nhu4NtIHBo',
        'Phạm Đại Lâm');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (193, '7703D', 'TTDK XCG 7703D - Bình Định', 'Bình Định', 'dangkiem7703D.kiemdinhoto.vn', '081.899.3799',
        'Khu vực Liêm Trực, p. Bình Định, Tx. An Nhơn, tỉnh Bình Định', 'tramdangkiem7703d@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d30986.9944133701!2d109.08997397910154!3d13.876553400000013!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x316f15e8533f4ddd%3A0x3fa7d0f9f2707d6b!2zVHJ1bmcgdMOibSDEkMSDbmcga2nhu4NtIHhlI',
        'Phạm Hữu Phước');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (194, '7704D', 'TTDK XCG 7704D Bình Định', 'Bình Định', 'dangkiem7704D.kiemdinhoto.vn', '0256 3666999',
        'LôA1.01 (khu A), khu kinh tế Nhơn Hội, xã Nhơn Hội, Tp. Quy Nhơn, tỉnh Bình Định', '7704D@kiemdinhoto.vn',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3874.2212127358516!2d109.25654973488768!3d13.825751200000004!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x316f6b0f085eb78d%3A0xb5b7890680d65ac9!2zVHJ1bmcgVMOibSDEkMSDbmcgS2nhu4NtIFh',
        'Nguyễn Đức Thạch');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (195, '7705D', 'TTDK XCG 7705D - Bình Định', 'Bình Định', 'dangkiem7705D.kiemdinhoto.vn', '0256.222.7777',
        'Cụm công nghiệp Hoài Tân, khu phố Giao hội 1, phường Hoài Tân, Tx. Hoài Nhơn, tỉnh Bình Định',
        'ttdkxcg7705d@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3863.20268397932!2d109.02460101535107!3d14.473047884068741!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3168c58abd6832a1%3A0xc5ca0d4f8e071b5b!2zVHJ1bmcgVMOibSDEkMSDbmcgS2nhu4NtIFhlI',
        'Thái Lý Dự');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (196, '7706D', 'TTDK XCG 7706D - Bình Định', 'Bình Định', 'dangkiem7706D.kiemdinhoto.vn', '0836.022277',
        'Tổ 23, KV3, phường Nhơn Bình, thành phố Quy Nhơn, tỉnh Bình Định', '7706D@kiemdinhoto.vn',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d991939.832854194!2d108.59456061333103!3d13.793036935730434!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x316f6b0095935a8d%3A0x6fd19c5a534e0bc2!2zVHJ1bmcgVMOibSDEkMSDbmcgS2nhu4NtIDc3M',
        'Nguyễn Đình Phương');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (197, '7801S', 'TTDK XCG 7801S - Phú Yên', 'Phú Yên', 'dangkiem7801S.kiemdinhoto.vn', '0257.3847.012',
        'Km3 Nguyễn Tất Thành P.9 - Bình Kiến - Tuy Hòa - Phú Yên', 'dangkiemphuyen@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d62162.91626321221!2d109.24390168980578!3d13.150900309977157!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x316fec78a9922abb%3A0xbdbe40c769786774!2zVHJ1bmcgdMOibSDEkMSDbmcgS2nhu4NtIFBU',
        'PHAN TIÊN VIÊN');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (198, '7802D', 'TTDK XCG 7802D - Phú Yên', 'Phú Yên', 'dangkiem7802D.kiemdinhoto.vn', '0865.028.768',
        'Km48+450, Quốc lộ 25, xã Suối Bạc, huyện Sơn Hòa, tỉnh Phú Yên', '7802D@kiemdinhoto.vn',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m23!1m12!1m3!1d3886.5836068569283!2d109.03118141534365!3d13.06215561641769!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!4m8!3e6!4m0!4m5!1s0x316fc5b07f46ff15%3A0x42ec130b7c33364a!2zNDggKzQ1MCwgUUwgMjUsIFTDom4g',
        'Phạm Xuân Hưng');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (199, '7803D', 'TTDK XCG 7803D - Phú Yên', 'Phú Yên', 'dangkiem7803D.kiemdinhoto.vn', '0257.3790888',
        'Km 1319+300, Quốc lộ 1A, xã An Chấn, huyện Tuy An, tỉnh Phú Yên', 'trungtamdkxcg7803d@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d62162.91626321221!2d109.24390168980581!3d13.15090030997715!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x316f95089d90ab95%3A0x4883c212a1e16e9d!2zVHJ1bmcgVMOibSDEkMSDbmcgS2nhu4NtIDc4L',
        'Trần Văn Tài');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (200, '7901S', 'TTDK XCG 7901S - Khánh Hoà', 'Khánh Hoà', 'dangkiem7901S.kiemdinhoto.vn', '0258.3836191',
        '01 Nguyễn Phong Sắc - Vĩnh Hoà - Nha Trang - Khánh Hoà', 'dangkiemkhanhhoa@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d249666.2701419346!2d109.0365531257821!3d12.109724278618383!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x317042aa9ff62523%3A0x18fc7509272a3f6f!2sMotor%20Vehicles%20Register%20Center%',
        'Phù Minh Sơn');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (202, '8102D', 'TTDK XCG 8102D - Gia Lai', 'Gia Lai', 'dangkiem8102D.kiemdinhoto.vn', '0269.3797.888',
        'Làng Phung, xã Biển Hồ, Pleiku-Gia Lai', 't8102d@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3871.0179365104423!2d108.02597591534851!3d14.016950794868992!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x316c1e46aaaaaaab%3A0x248d0dfc360b8ea3!2zVHJ1bmcgdMOibSDEkcSDbmcga2nhu4NtIHh',
        'Nguyễn Viết Tùng');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (203, '8103D', 'TTDK XCG 8103D', 'Gia Lai', 'dangkiem8103D.kiemdinhoto.vn', '0269.3748633',
        'Nguyễn Chí Thanh, tổ 5, p. Chi Lăng, TP. Pleiku, Gia Lai', 'tt8103d@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d61946.33808844624!2d107.97645739094229!3d13.979656731012426!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x316c20161f08292f%3A0xf649906ed60dabac!2zVHJ1bmcgdMOibSDEkMSDbmcga2nhu4NtIFhl',
        'VŨ VĂN TIÊN');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (204, '8104D', 'TTDK XCG 8104D', 'Gia Lai', 'dangkiem8104D.kiemdinhoto.vn', '0269.3738666',
        'thôn 2 xã Đak Bơ, huyện Đak Bơ, GiaLai', 't8104d@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m16!1m12!1m3!1d247596.13900532175!2d107.85371973183794!3d14.154333290697652!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!2m1!1zdGjDtG4gMiB4w6MgxJBhayBQxqEsIGh1eeG7h24gxJBhayBQxqEsIEdpYUxhaQ!5e0!3m2!1sen!2s!4v',
        'Đào Xuân Cảnh');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (205, '8105D', 'TTDK XCG 8105D', 'Gia Lai', 'dangkiem8105D.kiemdinhoto.vn', '0269.655.6969',
        'Lô C50 Cụm CN Diên Phú, thôn 3, xã Diên Phú, Tp Pleiku, tỉnh Gia Lai', 'ttdk8105D@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d247597.41323592723!2d107.85372042320716!3d14.153164020777217!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x316c2178bd026773%3A0x99f2926fc8bf1930!2zVHJ1bmcgdMOibSDEkMSDbmcga2nhu4NtIHh',
        'Trần Minh Lượng');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (206, '8201S', 'TTDK XCG 8201S - Kon Tum', 'Kon Tum', 'dangkiem8201S.kiemdinhoto.vn', '0260.3864128',
        'Số 99 Huỳnh Thúc Kháng - TX Kon Tum - Tỉnh Kon Tum', 'dangkiem8201@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3865.101420085101!2d107.99063181535041!3d14.363542286691546!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x316bff05b4c87c39%3A0x5168a8b4beee4c91!2zVHJ1bmcgdMOibSDEkMSDbmcga2nhu4NtIHhl',
        'Nguyễn Xuân Đàm');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (207, '8301V', 'TTĐK XCG 8301V - Sóc Trăng', 'Sóc Trăng', 'dangkiem8301V.kiemdinhoto.vn', '0299.3820673',
        '855 Trần Hưng Đạo, Phường 10, TP. Sóc Trăng, Sóc Trăng', 'ccdksoctrang@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m16!1m12!1m3!1d15736.455413395946!2d105.9544799359404!3d9.585453598346684!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!2m1!1zMTkxQSDigJMgVHLhuqduIEjGsG5nIMSQ4bqhbyDigJMgVFggU8OzYyBUcsSDbmcu!5e0!3m2!1sen!2s!4v',
        'Thái Trường Giang');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (208, '8302D', 'TTDK XCG 8302D - Sóc Trăng', 'Sóc Trăng', 'dangkiem8302D.kiemdinhoto.vn', '0299-3501090',
        'Ấp Xây Đá B, xã Hồ Đắc Kiện, huyện Châu Thành, tỉnh Sóc Trăng', 'dangkiem8302d@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d62934.47088177713!2d105.88978428627304!3d9.646441850449106!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31a05a11ab7bb88f%3A0xdd0e93e5b574b31!2zVHJ1bmcgdMOibSDEkMSDbmcga2nhu4NtIDgzLT',
        'Trần Văn Cảnh');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (209, '8401V', 'TTDK XCG 8401V - Trà Vinh', 'Trà Vinh', 'dangkiem8401V.kiemdinhoto.vn', '0294.3840379',
        '151 Nguyễn Đáng - P.7 - TX Trà Vinh - Trà Vinh', 'dkbotravinh@yahoo.com.vn',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3930.114151574569!2d106.33641131533169!3d9.924450277052273!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31a0175b894ddf5b%3A0x2b2c0376b999daf0!2zQ8O0bmcgVHkgQ-G7lSBQaOG6p24gVuG6rW4gV',
        'Hà Văn Út');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (210, '8402D', 'TTDK XCG 8402D - Trà Vinh', 'Trà Vinh', 'dangkiem8402D.kiemdinhoto.vn', '0939.036.836',
        'ấp Sâm Bua, xã Lương Hòa, huyện Châu Thành, tỉnh Trà Vinh', '8402D@kiemdinhoto.vn',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d2004560.761005434!2d106.61613993333296!3d11.101619419217915!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31a0179a79cd10a3%3A0xc51bd70c204dc67f!2zVHJ1bmcgdMOibSDEkcSDbmcga2nhu4NtIHhl',
        'Nguyễn Quốc Thống');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (211, '8501S', 'TTDK XCG 8501S - Ninh Thuận', 'Ninh Thuận', 'dangkiem8501S.kiemdinhoto.vn', '0259.3868805',
        'KP15 -Thị Trấn Phước Dân - Ninh Phước - Ninh Thuận', 'dangkiem8501s@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3909.1008592264566!2d108.95847731533698!3d11.544622247699284!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3170d1a2bfaa9611%3A0xf48f678ee4470087!2zVHJ1bmcgVMOibSDEkMSDbmcgS2nhu4NtIFh',
        'Tạ Hậu');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (212, '8502D', 'TTDK XCG 8502D - Ninh Thuận', 'Ninh Thuận', 'dangkiem8502D.kiemdinhoto.vn', '0259.3630630',
        'Thôn Văn Lâm 3, xã Phước Nam, huyện Thuận Nam, tỉnh Ninh Thuận', 'dangkiemkhaihung@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m16!1m12!1m3!1d125147.47083019317!2d108.8271108352374!3d11.417817462495762!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!2m1!1zUUwgMUEgVGjDtG4gVsSDbiBMw6JtIDMsIFBoxrDhu5tjIE5hbSwgVGh14bqtbiBOYW0sIE5pbmggVGh14b',
        'Đỗ Phú Trung');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (213, '8601S', 'TTDK XCG 8601S - Bình Thuận', 'Bình Thuận', 'dangkiem8601S.kiemdinhoto.vn', '0252.3821961',
        'Số 6 Từ Văn Tư - Phan Thiết - Bình Thuận', 'dangkiem@sgtvt.binhthuan.gov.vn',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m23!1m12!1m3!1d62676.93840354732!2d108.06714203733686!3d10.940041378004652!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!4m8!3e6!4m0!4m5!1s0x3176831beef950c5%3A0x9b4b9e1e013017af!2zVHJ1bmcgVMOibSDEkMSDbmcgS2nh',
        'Trương Ngọc Thiện');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (214, '8602D', 'TTDK XCG 8602D - Bình Thuận', 'Bình Thuận', 'dangkiem8602D.kiemdinhoto.vn', '0252.2481080',
        'Km 32 xã Tân Lập, Hàm Thuận Nam, Bình Thuận', 'dangkiem8602d@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m23!1m12!1m3!1d62697.10544600192!2d107.81218223724841!3d10.8442514217349!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!4m8!3e6!4m0!4m5!1s0x317432855fccca0d%3A0xc24bce26cf5cefa0!2zVHJ1bmcgVMOibSDEkcSDbmcga2nhu4',
        'Nguyễn Đình Nhựt');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (215, '8801S', 'Trung tâm Đăng kiểm xe cơ giới tỉnh Vĩnh Phúc', 'Vĩnh Phúc', 'dangkiem8801S.kiemdinhoto.vn',
        '0211.3860848', 'Đường Mê Linh, phường Khai Quang, thành phố Vĩnh Yên, tỉnh Vĩnh Phúc', 't8801s@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d59474.804030281426!2d105.55148725820314!3d21.304090400000003!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3134facba59a9157%3A0xe281c06e9137843d!2zVHJ1bmcgVMOibSDEkMSDbmcgS2nhu4NtIFh',
        'Bạch Thảo Nguyên');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (216, '8802D', 'TTDK XCG 8802D - Vĩnh Phúc', 'Vĩnh Phúc', 'dangkiem8802D.kiemdinhoto.vn', '02113888566',
        'Thôn Yên Lỗ - xã Đạo Đức, huyện Bình Xuyên - Vĩnh Phúc', 'tamanhvp@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3718.9154199157297!2d105.68422253488771!3d21.235202299999994!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3134fc758f45d007%3A0x8bb8432a7b7986ee!2zVHJ1bmcgVMOibSDEkMSDbmcgS2nhu4NtIFh',
        'Đàm Hải Nam');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (217, '8803D', 'TTDK XCG 8803D -  trực thuộc công ty CP Hưng Linh Vĩnh Phúc', 'Vĩnh Phúc',
        'dangkiem8803D.kiemdinhoto.vn', '0211.3850668',
        'Nút giao QL2, đường Lê Hồng Phong, xã Đồng Cương, huyện Yên Lạc, tỉnh Vĩnh Phúc.',
        'trungtamdangkiem8803d@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3717.8054096107057!2d105.57879781540487!3d21.279168884557382!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3134f1a98285513f%3A0x20463bb9b4caa4bf!2zVHJ1bmcgdMOibSDEkcSDbmcga2nhu4NtIHh',
        'Đào Công Khanh');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (218, '8804D', 'TTDK XCG 8804D', 'Vĩnh Phúc', 'dangkiem8804D.kiemdinhoto.vn', '0982.076.666',
        'Km 40+500, Quốc lộ 2A, xã Hợp Thịnh, huyện Tam Dương, tỉnh Vĩnh Phúc', '8804D@kiemdinhoto.vn',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d3717.6636582855404!2d105.5370257!3d21.2847773!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3134f19e014a536d%3A0x6392d6d96913775c!2zVHJ1bmcgdMOibSDEkcSDbmcga2nhu4NtIDg4LTA0RA!5e0!3m2!1sen!2s!4v167281',
        'Trần Trung Sơn');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (219, '8806D', 'TTDK XCG 88-06D', 'Vĩnh Phúc', 'dangkiem8806D.kiemdinhoto.vn', '0862.323.388',
        'Xã Quất Lưu, huyện Bình Xuyên, tỉnh Vĩnh Phúc', 'ttdk8806d@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3717.549729663402!2d105.64140971540496!3d21.289283884208075!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3134fb18fd229a0b%3A0x44964e3195cfc3ef!2zTmjDoCBWxINuIGjDs2EgdGjDtG4gR2nhu69h',
        'Nguyễn Văn Ngọc');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (220, '8901S', 'TTDK XCG 8901S - Hưng Yên', 'Hưng Yên', 'dangkiem8901S.kiemdinhoto.vn', '0221.3944051',
        'Xã Dị Sử - Mỹ Hào - Hưng Yên', 'tt8901s@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d29815.523028725067!2d106.05790385867414!3d20.914718245918554!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3135a35d34025de7%3A0xa78069fa9db57aea!2zROG7iyBT4butLCBNeSBIYW8sIEh1bmcgWWV',
        'Nguyễn Chí Phước');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (221, '8902S', 'TTDK XCG 8902S - Hưng Yên', 'Hưng Yên', 'dangkiem8902S.kiemdinhoto.vn', '0221.3824523',
        'Thôn Tiền Thắng - Bảo Khê - TX Hưng Yên - Hưng Yên', 'tt8901s@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m16!1m12!1m3!1d59718.744446259494!2d106.05717250434527!3d20.693100656947927!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!2m1!1zVGjDtG4gVGnhu4FuIFRo4bqvbmcg4oCTIELhuqNvIEtow6og4oCTIFRYIEjGsG5nIFnDqm4g4oCTIEjGs',
        'Nguyễn Chí Phước');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (222, '8904D', 'TTDK XCG 8904D - Hưng Yên', 'Hưng Yên', 'dangkiem8904D.kiemdinhoto.vn', '0221.393.9868',
        'Thôn Lại Ốc, xã Long Hưng, huyện Văn Giang, tỉnh Hưng Yên', 't8904d@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d59624.08244528486!2d105.87691005820311!3d20.93221949999999!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3135aff7b7bb024d%3A0x67ad98c4aa358d9b!2zVHJ1bmcgVMOibSDEkMSDbmcgS2nhu4NtIFhDR',
        'Đỗ Hải Nam');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (223, '8905D', 'TTDK XCG 8905D - Hưng Yên', 'Hưng Yên', 'dangkiem8905D.kiemdinhoto.vn', '0221.3962222',
        'Thôn Nghĩa Trang, thị trấn Yên Mỹ, huyện Yên Mỹ, tỉnh Hưng Yên', '8905D@kiemdinhoto.vn',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d7455.884709933126!2d106.0370387!3d20.8743736!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3135bb38e34704fd%3A0xf5b6a14030a3f8fa!2zVHJ1bmcgVMOibSDEkMSDbmcgS2nhu4NtIFhDRyA4OS0wNUQ!5e0!3m2!1sen!2s!4v16',
        'Nguyễn Trung Hiếu');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (224, '8906D', 'TTDK XCG 8906D - Hưng Yên', 'Hưng Yên', 'dangkiem8906D.kiemdinhoto.vn', '0221.3900681',
        'Thửa đất số 302, tờ bản đồ số 07, xã Nghĩa Dân, huyện Kim Động, tỉnh Hưng Yên', '8906D@kiemdinhoto.vn',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3729.925961615389!2d106.06098531540007!3d20.794283001116312!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3135b9697e7c7507%3A0xa79b7cb4796ec13e!2zVHJ1bmcgVMOibSDEkMSDbmcgS2nhu4NtIFhl',
        'Bùi Ngọc Tân');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (225, '8907D', 'TTDK XCG 8907D', 'Hưng Yên', 'dangkiem8907D.ttdk.com.vn', '0836670999',
        'Thôn Cộng Vũ, xã Vũ Xá, huyện Kim Động, tỉnh Hưng Yên', 'trungtamdangkiem8907d@gmail.com', null,
        'Nguyễn Đức Hưng');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (226, '9001S', 'TTDK XCG 9001S', 'Hà Nam', 'dangkiem9001S.kiemdinhoto.vn', '0226.3852967',
        'Xã Liêm Tiết, T.P Phủ Lý - Hà Nam', 'dangkiem9001s@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3736.666458815015!2d105.9431546153973!3d20.51989501032941!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3135d03d97579b21%3A0x235b30dee33a368c!2zVHJ1bmcgVMOibSDEkcSDbmcga2nhu4NtIHhlIG',
        'Nguyễn Văn Cam');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (227, '9002D', 'TTDK XCG 9002D - Hà Nam', 'Hà Nam', 'dangkiem9002D.kiemdinhoto.vn', '0916.383.839',
        'Km 229, Tuyến tránh Quốc lộ 1A, xã Thi Sơn, huyện Kim Bảng, tỉnh Hà Nam', '9002D@kiemdinhoto.vn',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d3735.532540066334!2d105.8807671!3d20.5662988!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x0%3A0x82f5adbd12c2d484!2zxJDEgk5HIEtJ4buCTSBIw4AgTkFNIDkwMDJELSBN4bu4IMSQw4Au!5e0!3m2!1sen!2s!4v167281742903',
        'Nguyễn Văn Tuấn');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (228, '9201D', 'TTDK XCG 9201D', 'Quảng Nam', 'dangkiem9201D.kiemdinhoto.vn', '0235.3874881',
        'Ngã ba Tây Cốc, Hà Lam, Thăng Bình, Quảng Nam', 'dangkiem9201d@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m16!1m12!1m3!1d3840.497932478114!2d108.37087056535889!3d15.724776602752131!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!2m1!1zTmfDoyBiYSBUw6J5IEPhu5FjLCBIw6AgTGFtLCBUaMSDbmcgQsOsbmgsIFF14bqjbmcgTmFt!5e0!3m2!1',
        'Đặng Bảo Lâm');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (229, '9202D', 'TTDK XCG 9202D - Quảng Nam', 'Quảng Nam', 'dangkiem9202D.kiemdinhoto.vn', '0235.3868279',
        'QL. 1A, khối Phong Nhị, P. Điện An, TX. Điện Bàn, tỉnh Quảng Nam', 'ttdangkiem9202d@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m23!1m12!1m3!1d61392.43359099884!2d108.20329514402918!3d15.907651124085097!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!4m8!3e6!4m0!4m5!1s0x31420ff584649c2d%3A0xfc68554a0a664cc5!2zVHJ1bmcgVMOibSDEkMSDbmcgS2nh',
        'Lê Thanh Tùng');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (230, '9206D', 'TTDK XCG  9206D', 'Quảng Nam', 'dangkiem9206D.ttdk.com.vn', '02353862868',
        '30 Nguyễn Tất Thành, Phường Tân An, Tp.Hội An, Tỉnh Quảng Nam', 'kiemdinhhdnhoian@gmail.com', null,
        'Trần Quang Huy');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (231, '9301S', 'TTDK XCG 9301S - Bình Phước', 'Bình Phước', 'dangkiem9301S.kiemdinhoto.vn', '0271.3881723',
        '646 Phú Riềng Đỏ , P. Tân Xuân - TP Đồng Xoài - Tỉnh Bình Phước', 'trungtamdangkiemsgtvt@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m23!1m12!1m3!1d62550.50285446645!2d106.8589705379079!3d11.522675407435582!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!4m8!3e6!4m0!4m5!1s0x3174a034a2ed1b4b%3A0x1939b26ae7f18ca6!2zVHJ1bmcgVMOibSDEkMSDbmcgS2nhu',
        'Nguyễn Thanh Giang');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (232, '9302D', 'TTDK XCG 9302D - Bình Phước', 'Bình Phước', 'dangkiem9302D.kiemdinhoto.vn', '0271.3645979',
        'Tổ 1, KP 9, Minh Hưng, Chơn Thành, Bình Phước', 'trungtamdangkiem9302d@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m23!1m12!1m3!1d62556.17805569407!2d106.58179383788163!3d11.49714801945468!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!4m8!3e6!4m0!4m5!1s0x3174abf77b192dd3%3A0x80914ff752f30d23!2zVHJ1bmcgdMOibSDEkcSDbmcga2nhu',
        'Nguyễn Thanh Tùng');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (233, '9303D', 'TTDK XCG 9303D - Bình Phước', 'Bình Phước', 'dangkiem9303D.kiemdinhoto.vn', '0271.3842379',
        'Đường ĐT 741, xã Tân Lập, huyện Đồng Phú, tỉnh Bình Phước', 'dangkiem9303d@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m23!1m12!1m3!1d62550.50285446645!2d106.85897053790784!3d11.522675407435582!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!4m8!3e6!4m0!4m5!1s0x3174a034a2ed1b4b%3A0x1939b26ae7f18ca6!2zVHJ1bmcgVMOibSDEkMSDbmcgS2nh',
        'Nguyễn Văn Tuyên');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (234, '9304D', 'TTDK XCG 9304D - Bình Phước', 'Bình Phước', 'dangkiem9304D.kiemdinhoto.vn', '02716.88889',
        'Tổ 3, ấp Thuận Thành 2, xã Thuận Lợi, huyện Đồng Phú, tỉnh Bình Phước', 'tramdangkiemhtt@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m23!1m12!1m3!1d62525.162229063484!2d106.86377573802558!3d11.635984953904478!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!4m8!3e6!4m0!4m5!1s0x31735f2866eaabe9%3A0xb2317e31de6a9533!2zVHJ1bmcgVMOibSDEkMSDbmcgS2n',
        'Nguyễn Văn Thúy');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (235, '9401V', 'TTDK XCG 9401V - Bạc Liêu', 'Bạc Liêu', 'dangkiem9401V.kiemdinhoto.vn', '0291.3824011',
        'QL 1 - Phường 7 - Xã Long Thạnh, Huyện Vĩnh Lợi- Bạc Liêu', 'ccdkbaclieu@vr.org.vn',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m23!1m12!1m3!1d62998.801228931414!2d105.64318523603308!3d9.295550498936825!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!4m8!3e6!4m0!4m5!1s0x31a10ffb310fa5db%3A0x2c3c8770dedd06cb!2zVHJ1bmcgdMOibSDEkcSDbmcga2nh',
        'Trần Quốc Thái');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (236, '9501S', 'TTDK XCG 9501D - Hậu Giang', 'Hậu Giang', 'dangkiem9501S.kiemdinhoto.vn', '0293.3848959',
        'Km 2085 - QL 1- Tân Phú Thạnh - Châu Thành A - Hậu Giang', 'TTDK9501s@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m23!1m12!1m3!1d3928.25683962615!2d105.84824351533213!3d10.078028974449754!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!4m8!3e6!4m0!4m5!1s0x31a07ceb7c458aff%3A0xc55b7314f01ea7!2zMjA4NSwgUXXhu5FjIEzhu5kgMSwgVMO',
        'Ngô Minh Khang');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (237, '9502D', 'TTDK XCG 9502D - Hậu Giang', 'Hậu Giang', 'dangkiem9502D.kiemdinhoto.vn', '02923.505.999',
        'QL 61C, Ấp Nhơn Thuận 1, xã Nhơn Nghĩa A, huyện Châu Thành A, tỉnh Hậu Giang', 'ttdk9502d@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3930.018110992278!2d105.65577941533152!3d9.932449376917653!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31a08d3b7af18d21%3A0x9a53405a8d9a7ea5!2zVFJVTkcgVMOCTSDEkMSCTkcgS0nhu4JNIFhFI',
        'Lý Thanh Thiện');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (238, '9503D', 'TTDK XCG 9503D - Hậu Giang', 'Hậu Giang', 'dangkiem9503D.kiemdinhoto.vn', '02933.604999',
        'Ấp 7, xã Vị Trung, huyện Vị Thủy, tỉnh Hậu Giang', 'dangkiem9503d@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m23!1m12!1m3!1d62908.547864867185!2d105.46784353637301!3d9.784315491308083!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!4m8!3e6!4m0!4m5!1s0x31a0efe794cb6ff7%3A0xfe31cb73d5a93a86!2zUUw2MUMsIFbhu4sgVHJ1bmcsIFbh',
        'QUÁCH VĂN THUẤN');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (239, '9701D', 'TTDK XCG 9701D', 'Bắc Kạn', 'dangkiem9701D.kiemdinhoto.vn', '0209.3871300',
        'Tổ 9 - Phùng Chí Kiên - TX Bắc Kạn - Bắc Kạn', 'dangkiembkvn@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m21!1m12!1m3!1d59133.9113864156!2d105.79694585817548!3d22.13095227364369!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!4m6!3e6!4m0!4m3!3m2!1d22.1317943!2d105.8257768!5e0!3m2!1svi!2s!4v1672816615552!5m2!1svi!2s',
        'Vũ Đình Hào');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (240, '9801S', 'TTDK XCG 9801S - Bắc Giang', 'Bắc Giang', 'dangkiem9801S.kiemdinhoto.vn', '0204.3556946',
        'Đồi Chỉ Chèo - Xương Giang - Bắc Giang', 'Ttdangkiem_sgtvt@bacgiang.gov.vn',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3717.3549484503874!2d106.21867951540507!3d21.29698658394217!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31356c4cc4132e93%3A0x7de337e84bc56729!2zVHJ1bmcgVMOibSBLaeG7g20gxJDhu4tuaCBL',
        'Vũ Văn Công');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (241, '9802D', 'TTDK XCG 9802D - Bắc Giang', 'Bắc Giang', 'dangkiem9802D.kiemdinhoto.vn', '0204.3522555',
        'Km2, đường Hoàng Hoa Thám, P. Đa Mai, TP. Bắc Giang, tỉnh Bắc Giang', 'trungtamdangkiem9802dbg@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m23!1m12!1m3!1d59480.762677172235!2d106.13981435589302!3d21.289365454178828!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!4m8!3e6!4m0!4m5!1s0x31356d24b233a5bf%3A0xe10a1ef8f03adfa7!2zVHJ1bmcgVMOibSDEkcSDbmcga2n',
        'Trần Xuân Huy');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (242, '9804D', 'TTDK XCG 9804D - Bắc Giang', 'Bắc Giang', 'dangkiem9804D.kiemdinhoto.vn', '0204.3666.976',
        'Thôn chớp, xã Lương Phong, huyện Hiệp Hòa, tỉnh Bắc Giang', 'ttdk9804d@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m23!1m12!1m3!1d59457.56181768578!2d105.95559665604473!3d21.34664461511296!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!4m8!3e6!4m0!4m5!1s0x3135115e562adee1%3A0xfb0bb0afa57d66f!2zVHJ1bmcgVMOibSDEkcSDbmcga2nhu4',
        'Nguyễn Duy Nhật');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (243, '9805D', 'TTDK XCG 9805D - Bắc Giang', 'Bắc Giang', 'dangkiem9805D.kiemdinhoto.vn', '0204.375.7575',
        'Thôn Dõng, xã Hương Gián, huyện Yên Dũng, tỉnh Bắc Giang', 't9805d@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m23!1m12!1m3!1d59494.30098418265!2d106.20123915580453!3d21.255873576990844!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!4m8!3e6!4m0!4m5!1s0x31356d5b64f4cd2f%3A0xfa00b7b0de7ad4!2zVHJ1bmcgVMOibSDEkcSDbmcga2nhu4',
        'Nguyễn Quang Long');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (244, '9806D', 'TTDK XCG 9806D - Bắc Giang', 'Bắc Giang', 'dangkiem9806D.kiemdinhoto.vn', '0204.3590666',
        'Cụm công nghiệp Tân Dĩnh - Phi Mô, thị trấn Vôi, huyện Lạng Giang, tỉnh Bắc Giang', '9806D@kiemdinhoto.vn',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m23!1m12!1m3!1d59464.42863866189!2d106.21550645599979!3d21.329706826671785!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!4m8!3e6!4m0!4m5!1s0x31356d4ad1394827%3A0x2956cc7234828fa0!2zVHJ1bmcgVMOibSDEkcSDbmcga2nh',
        'Ninh Đức Tùng');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (246, '9901S', 'TTDK XCG 9901S - Bắc Ninh', 'Bắc Ninh', 'dangkiem9901S.kiemdinhoto.vn', '0222.3820857',
        'Khu 7 - P.Thị Cầu - TP. Bắc Ninh - Tỉnh Bắc Ninh', 'T9901S@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m23!1m12!1m3!1d59519.340459216066!2d106.04558535564107!3d21.193796419213623!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!4m8!3e0!4m0!4m5!1s0x31350c500e353da1%3A0x4747546c475ef93a!2zVHJ1bmcgVMOibSDEkMSDbmcgS2n',
        'Phạm Thanh Phương');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (247, '9902S', 'TTDK XCG 9902S - Bắc Ninh', 'Bắc Ninh', 'dangkiem9902S.kiemdinhoto.vn', '0222.3759286',
        'Thôn Dương Sơn – Xã Tam Sơn – TX Từ Sơn - Tỉnh Bắc Ninh', 'T9901S@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m23!1m12!1m3!1d59535.82886342988!2d105.92197555553356!3d21.152823947039558!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!4m8!3e6!4m0!4m5!1s0x3135063adf67bfd5%3A0x44fde03a0c2f332a!2zVHJ1bmcgVMOibSDEkcSDbmcga2nh',
        'Phạm Thanh Phương');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (248, '9903D', 'TTDK XCG 9903D - Bắc Ninh', 'Bắc Ninh', 'dangkiem9903D.kiemdinhoto.vn', '0222.3635638',
        'Km 10, QL 18, TT Phố Mới, Quế Võ, Bắc Ninh', 'trungtamdangkiem.haian@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3720.9917127236!2d106.1551461154036!3d21.15272808890943!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31350b52b16b855f%3A0xea5224673a84933a!2zVHJ1bmcgVMOibSDEkMSDbmcgS2nhu4NtIFhlIEPG',
        'Trần Xuân Huy');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (249, '9904D', 'TTDK XCG 9904D - Bắc Ninh', 'Bắc Ninh', 'dangkiem9904D.kiemdinhoto.vn', '0993.999904',
        'Khu công nghiệp Lâm Bình, xã Lâm Thao, huyện Lương Tài, tỉnh Bắc Ninh.', 'dangkiem9904d@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m23!1m12!1m3!1d59602.26661310302!2d106.14135055510084!3d20.98695775934216!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!4m8!3e6!4m0!4m5!1s0x31359f151ec1ddcf%3A0xee20db892989b9f6!2zJ1RydW5nIFTDom0gxJHEg25nIGtp4',
        'Trần Minh Đức');
INSERT INTO public.station (station_id, station_code, station_name, province, station_url, station_hotline,
                            station_address, station_email, station_map_source, station_manager)
VALUES (250, '9905D', 'TTDK XCG 9905D- Bắc Ninh', 'Bắc Ninh', 'dangkiem9905D.kiemdinhoto.vn', '02226.510777',
        'thôn Ngọc Trì, xã Ngọc Nội, huyện Thuận Thành, tỉnh Bắc Ninh.', 'tuvandangkiemjsc@gmail.com',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d238166.84696046636!2d105.89958452412408!3d21.13818709155653!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3135a13369c89c9d%3A0x29b2238553789dbb!2zVHJ1bmcgVMOibSDEkMSDbmcgS2nhu4NtIDk5',
        'Trần Kiên');


-- Insert to user

INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('c92b2f4e-6de0-4c1b-8163-081d121a297e', 'dangkiem1906Dadmin', 'admin', 'Đàm Hải Nam', 'Nam', 'Đàm Hải', '1906D',
        '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem1906Dadmin@vr.org.vn',
        '1979-01-17 00:00:00.000000 +00:00', 'Nam', null, null, null, null, null, null, null);
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('d65de2e2-97f7-49ee-bd3b-98f1d68dcf8e', 'dangkiem3603Dadmin', 'admin', 'Nguyễn Thanh Hải', 'Hải',
        'Nguyễn Thanh', '3603D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem3603Dadmin@vr.org.vn', '1972-07-22 00:00:00.000000 +00:00', 'Nam', null, null, null, null, null, null,
        null);
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('c152a103-8ea5-4c15-aca2-9c80cc5cdb87', 'dangkiem3604Dadmin', 'admin', 'LÊ VĂN VIỆT', 'VIỆT', 'LÊ VĂN',
        '3604D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem3604Dadmin@vr.org.vn',
        '1982-12-29 00:00:00.000000 +00:00', 'Nam', null, null, null, null, null, null, null);
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('91b03e42-0fa9-4227-95cf-18370c1609d0', 'dangkiem6702Sadmin', 'admin', 'Hồ Minh Ức', 'Ức', 'Hồ Minh', '6702S',
        '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem6702Sadmin@vr.org.vn',
        '1986-03-01 00:00:00.000000 +00:00', 'Nam', null, null, null, null, null, null, null);
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('14d0767d-4888-42f3-a48e-e88c11377b72', 'dangkiem8804Dadmin', 'admin', 'Trần Trung Sơn', 'Sơn', 'Trần Trung',
        '8804D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem8804Dadmin@vr.org.vn',
        '1980-12-06 00:00:00.000000 +00:00', 'Nam', null, null, null, null, null, null, null);
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('6acc7aba-9c16-4862-a1fb-255c06b40d2d', 'dangkiem1509Dkdv', 'staff', 'Nhân viên TTDK 1509D', '1509D',
        'Nhân viên TTDK', '1509D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem1509Dkdv@vr.org.vn', '1973-09-16 00:00:00.000000 +00:00', 'Nam', null, null, null, null, null, null,
        null);
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('b1710515-ee3f-4c8b-8d74-70e027d123be', 'dangkiem3501Dkdv', 'staff', 'Nhân viên TTDK 3501D', '3501D',
        'Nhân viên TTDK', '3501D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem3501Dkdv@vr.org.vn', '1970-11-20 00:00:00.000000 +00:00', 'Nam', null, null, null, null, null, null,
        null);
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('08a09007-f9a5-4449-8671-e9fa6bf51c9d', 'dangkiem3609Dkdv', 'staff', 'Nhân viên TTDK 3609D', '3609D',
        'Nhân viên TTDK', '3609D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem3609Dkdv@vr.org.vn', '1990-11-12 00:00:00.000000 +00:00', 'Nam', null, null, null, null, null, null,
        null);
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('7428fc0a-79eb-4ca7-9b28-04a644992287', 'dangkiem6502Skdv', 'staff', 'Nhân viên TTDK 6502S', '6502S',
        'Nhân viên TTDK', '6502S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem6502Skdv@vr.org.vn', '1985-05-17 00:00:00.000000 +00:00', 'Nam', null, null, null, null, null, null,
        null);
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('dd3398b8-9e8f-4531-afad-b0e35e773e70', 'dangkiem7501Skdv', 'staff', 'Nhân viên TTDK 7501S', '7501S',
        'Nhân viên TTDK', '7501S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem7501Skdv@vr.org.vn', '1975-04-26 00:00:00.000000 +00:00', 'Nam', null, null, null, null, null, null,
        null);
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('fca46eae-5f5e-4c49-baa5-8ea75e661f5a', 'dangkiem2909Dadmin', 'admin', 'Nguyễn Văn Hùng', 'Hùng', 'Nguyễn Văn',
        '2909D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem2909Dadmin@vr.org.vn',
        '1971-07-11 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '1837894235', '1837894235',
        '2023-08-28 00:00:00.000000 +00:00', null, '2023-08-28 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('e0191b3e-8280-4c64-8ad9-69e67eadeeb0', 'dangkiem9807Dkdv', 'staff', 'Nhân viên TTDK 9807D', '9807D',
        'Nhân viên TTDK', '9807D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem9807Dkdv@vr.org.vn', '1985-01-11 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '1923128604',
        '1923128604', '2023-08-21 00:00:00.000000 +00:00', null, '2023-08-21 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('68aa73d9-6515-4c95-b374-3f16cd333cf9', 'dangkiem7202Dadmin', 'admin', 'Lê Hùng Nam', 'Nam', 'Lê Hùng', '7202D',
        '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem7202Dadmin@vr.org.vn',
        '1984-04-09 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '5526558782', '5526558782',
        '2023-11-21 00:00:00.000000 +00:00', null, '2023-11-21 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('c382052d-6fa9-42e7-88b2-03ad00fb52cc', 'dangkiem8907Dkdv', 'staff', 'Nhân viên TTDK 8907D', '8907D',
        'Nhân viên TTDK', '8907D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem8907Dkdv@vr.org.vn', '1989-09-26 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '7875659832',
        '7875659832', '2023-02-11 00:00:00.000000 +00:00', null, '2023-02-11 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('b0827d26-db8e-4129-8a47-34fbc397386b', 'dangkiem2903Vadmin', 'admin', 'Trần Quốc Hoan', 'Hoan', 'Trần Quốc',
        '2903V', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem2903Vadmin@vr.org.vn',
        '1973-08-11 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '8457892301', '8457892301',
        '2023-02-26 00:00:00.000000 +00:00', null, '2023-02-26 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('825dc739-4f92-4c60-b425-de5e5e334846', 'dangkiem6502Sadmin', 'admin', 'Huỳnh Quang Trung', 'Trung',
        'Huỳnh Quang', '6502S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem6502Sadmin@vr.org.vn', '1974-08-26 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '3301345876',
        '3301345876', '2023-08-18 00:00:00.000000 +00:00', null, '2023-08-18 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('3ae99928-b2be-441f-8201-b509088a424b', 'dangkiem3601Sadmin', 'admin', 'Nguyễn Văn Khoát', 'Khoát',
        'Nguyễn Văn', '3601S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem3601Sadmin@vr.org.vn', '1985-10-02 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '8422383392',
        '8422383392', '2024-02-14 00:00:00.000000 +00:00', null, '2024-02-14 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('8ae2ce92-bad9-48a1-9ed6-68025da2e896', 'dangkiem7604Dkdv', 'staff', 'Nhân viên TTDK 7604D', '7604D',
        'Nhân viên TTDK', '7604D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem7604Dkdv@vr.org.vn', '1990-09-24 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '3733729626',
        '3733729626', '2023-07-12 00:00:00.000000 +00:00', null, '2023-07-12 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('679e2ea2-9538-46b2-b481-e5911bc93a0d', 'dangkiem1202Dkdv', 'staff', 'Nhân viên TTDK 1202D', '1202D',
        'Nhân viên TTDK', '1202D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem1202Dkdv@vr.org.vn', '1977-02-01 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '3695237315',
        '3695237315', '2024-03-04 00:00:00.000000 +00:00', null, '2024-03-04 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('d6334964-025b-4956-9f88-40d6b84be049', 'dangkiem9903Dadmin', 'admin', 'Trần Xuân Huy', 'Huy', 'Trần Xuân',
        '9903D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem9903Dadmin@vr.org.vn',
        '1988-10-26 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '6696663407', '6696663407',
        '2023-02-06 00:00:00.000000 +00:00', null, '2023-02-06 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('f043789c-01b1-4037-a637-3d2b1625373e', 'dangkiem2002Sadmin', 'admin', 'Lê Nam Hưng', 'Hưng', 'Lê Nam', '2002S',
        '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem2002Sadmin@vr.org.vn',
        '1971-10-31 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '3965238498', '3965238498',
        '2024-02-13 00:00:00.000000 +00:00', null, '2024-02-13 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('fcb43388-e134-46d6-a2fc-3ebb04dbc210', 'dangkiem9002Dkdv', 'staff', 'Nhân viên TTDK 9002D', '9002D',
        'Nhân viên TTDK', '9002D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem9002Dkdv@vr.org.vn', '1983-02-07 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '8084577923',
        '8084577923', '2023-04-09 00:00:00.000000 +00:00', null, '2023-04-09 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('c49290d2-20af-48ef-87b8-af61599deaa4', 'dangkiem7205Dadmin', 'admin', 'Phan Thanh Toản', 'Toản', 'Phan Thanh',
        '7205D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem7205Dadmin@vr.org.vn',
        '1984-08-04 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '7399084255', '7399084255',
        '2023-05-17 00:00:00.000000 +00:00', null, '2023-05-17 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('ec99f9db-231e-42bf-8514-5b70727abdd7', 'dangkiem2008Dadmin', 'admin', 'Ngô Hải Hùng', 'Hùng', 'Ngô Hải',
        '2008D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem2008Dadmin@vr.org.vn',
        '1978-10-22 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '6658642722', '6658642722',
        '2024-02-17 00:00:00.000000 +00:00', null, '2024-02-17 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('85a1d51d-1a49-4fe2-b1b1-3142a00f5a59', 'dangkiem6301Skdv', 'staff', 'Nhân viên TTDK 6301S', '6301S',
        'Nhân viên TTDK', '6301S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem6301Skdv@vr.org.vn', '1974-12-13 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '5227567595',
        '5227567595', '2023-06-06 00:00:00.000000 +00:00', null, '2023-06-06 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('b7121990-2772-4bc4-8a28-e317766258a9', 'dangkiem6108Dadmin', 'admin', 'Nguyễn Văn Name6108D', 'Name6108D',
        'Nguyễn Văn', '6108D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem6108Dadmin@vr.org.vn', '1981-07-30 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '8552957918',
        '8552957918', '2023-03-31 00:00:00.000000 +00:00', null, '2023-03-31 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('92235a83-5779-4ad9-9d9a-acabe83f3354', 'dangkiem1802Dadmin', 'admin', 'Lê Chí Hùng', 'Hùng', 'Lê Chí', '1802D',
        '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem1802Dadmin@vr.org.vn',
        '1973-07-01 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '5054602981', '5054602981',
        '2023-11-07 00:00:00.000000 +00:00', null, '2023-11-07 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('a321f826-4cfc-4b61-a557-158ac2c4141d', 'dangkiem7204Skdv', 'staff', 'Nhân viên TTDK 7204S', '7204S',
        'Nhân viên TTDK', '7204S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem7204Skdv@vr.org.vn', '1976-03-03 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '5235950529',
        '5235950529', '2023-08-23 00:00:00.000000 +00:00', null, '2023-08-23 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('b19b39b5-ffd7-457a-944e-058a8e06ae15', 'staff1', 'vrstaff', 'Nhân viên VR1', 'VR1', 'Nhân viên', 'VR',
        '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'staff1@vr.org.vn',
        '1977-12-31 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '2568260239', '2568260239',
        '2023-09-24 00:00:00.000000 +00:00', null, '2023-09-24 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('9a9809cb-8f86-4799-9526-023ca36804ca', 'dangkiem9802Dadmin', 'admin', 'Trần Xuân Huy', 'Huy', 'Trần Xuân',
        '9802D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem9802Dadmin@vr.org.vn',
        '1988-11-22 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '4030360031', '4030360031',
        '2024-02-20 00:00:00.000000 +00:00', null, '2024-02-20 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('38ec1156-1043-43cc-b204-282a3526b6e6', 'dangkiem1908Dadmin', 'admin', 'Nguyễn Xuân Ước', 'Ước', 'Nguyễn Xuân',
        '1908D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem1908Dadmin@vr.org.vn',
        '1973-12-01 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '6385855520', '6385855520',
        '2023-03-23 00:00:00.000000 +00:00', null, '2023-03-23 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('d64b7ef0-7465-4c21-85a5-8897913383ad', 'dangkiem8806Dadmin', 'admin', 'Nguyễn Văn Ngọc', 'Ngọc', 'Nguyễn Văn',
        '8806D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem8806Dadmin@vr.org.vn',
        '1982-05-16 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '5072885516', '5072885516',
        '2023-08-15 00:00:00.000000 +00:00', null, '2023-08-15 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('9a07aadd-1873-48ca-9cdb-aa0073980488', 'dangkiem8601Skdv', 'staff', 'Nhân viên TTDK 8601S', '8601S',
        'Nhân viên TTDK', '8601S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem8601Skdv@vr.org.vn', '1989-08-31 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '1053578361',
        '1053578361', '2023-03-14 00:00:00.000000 +00:00', null, '2023-03-14 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('a724f3b5-824d-4d9a-bae3-ff600ecf140e', 'dangkiem7603Dadmin', 'admin', 'Võ Quang Phát', 'Phát', 'Võ Quang',
        '7603D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem7603Dadmin@vr.org.vn',
        '1978-07-14 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '9683573580', '9683573580',
        '2023-08-19 00:00:00.000000 +00:00', null, '2023-08-19 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('6f5d795a-17bf-47a9-ad35-5d5e735b1d08', 'dangkiem7001Skdv', 'staff', 'Nhân viên TTDK 7001S', '7001S',
        'Nhân viên TTDK', '7001S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem7001Skdv@vr.org.vn', '1987-01-01 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '9123714237',
        '9123714237', '2023-06-12 00:00:00.000000 +00:00', null, '2023-06-12 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('47b5c71d-7903-4988-964a-6977f2923d1d', 'dangkiem9303Dkdv', 'staff', 'Nhân viên TTDK 9303D', '9303D',
        'Nhân viên TTDK', '9303D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem9303Dkdv@vr.org.vn', '1990-10-01 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '9430767213',
        '9430767213', '2024-05-13 00:00:00.000000 +00:00', null, '2024-05-13 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('34f7098e-a22b-4f76-afe7-51bc86aa7590', 'dangkiem2203Dadmin', 'admin', 'Nguyễn Văn Tâm', 'Tâm', 'Nguyễn Văn',
        '2203D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem2203Dadmin@vr.org.vn',
        '1986-07-16 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '5902638072', '5902638072',
        '2023-05-01 00:00:00.000000 +00:00', null, '2023-05-01 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('78b83269-fafe-4075-9693-7f1d50be088d', 'dangkiem7301Sadmin', 'admin', 'Nguyễn Thanh Long', 'Long',
        'Nguyễn Thanh', '7301S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem7301Sadmin@vr.org.vn', '1971-12-04 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '3799144556',
        '3799144556', '2023-03-07 00:00:00.000000 +00:00', null, '2023-03-07 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('d9a469e1-78f4-4d46-aab1-0ad59cc6f956', 'dangkiem9202Dkdv', 'staff', 'Nhân viên TTDK 9202D', '9202D',
        'Nhân viên TTDK', '9202D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem9202Dkdv@vr.org.vn', '1975-05-13 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '5488548566',
        '5488548566', '2023-03-24 00:00:00.000000 +00:00', null, '2023-03-24 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('c8967a17-b0a8-4c72-aab7-90152456a3a0', 'dangkiem6111Dkdv', 'staff', 'Nhân viên TTDK 6111D', '6111D',
        'Nhân viên TTDK', '6111D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem6111Dkdv@vr.org.vn', '1986-05-29 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '1493275930',
        '1493275930', '2023-10-22 00:00:00.000000 +00:00', null, '2023-10-22 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('f28050f8-92c3-485d-9033-696ea28c840f', 'dangkiem7002Sadmin', 'admin', 'Phan Nguyễn Thanh Phong', 'Phong',
        'Phan Nguyễn Thanh', '7002S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem7002Sadmin@vr.org.vn', '1989-08-04 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '3787512983',
        '3787512983', '2023-10-03 00:00:00.000000 +00:00', null, '2023-10-03 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('213be7f5-db0c-436b-b24b-b3b381fda5d7', 'dangkiem7403Dadmin', 'admin', 'PGD. Trương Đình Tân', 'Tân',
        'PGD. Trương Đình', '7403D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem7403Dadmin@vr.org.vn', '1983-03-24 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '2714331297',
        '2714331297', '2023-10-16 00:00:00.000000 +00:00', null, '2023-10-16 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('2cc4ecec-7edb-4b43-ba2f-f7db9ef3819e', 'dangkiem7003Dkdv', 'staff', 'Nhân viên TTDK 7003D', '7003D',
        'Nhân viên TTDK', '7003D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem7003Dkdv@vr.org.vn', '1974-01-16 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '4013060325',
        '4013060325', '2023-10-01 00:00:00.000000 +00:00', null, '2023-10-01 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('fdc34e1b-952e-494a-82d6-dbb5bb34b4b8', 'dangkiem3706Dkdv', 'staff', 'Nhân viên TTDK 3706D', '3706D',
        'Nhân viên TTDK', '3706D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem3706Dkdv@vr.org.vn', '1972-10-02 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '1986037818',
        '1986037818', '2024-03-31 00:00:00.000000 +00:00', null, '2024-03-31 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('aca2c841-77ee-4412-968e-02baa1c719b7', 'dangkiem8401Vkdv', 'staff', 'Nhân viên TTDK 8401V', '8401V',
        'Nhân viên TTDK', '8401V', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem8401Vkdv@vr.org.vn', '1980-05-21 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '1914480644',
        '1914480644', '2024-02-18 00:00:00.000000 +00:00', null, '2024-02-18 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('5f32c500-045e-4230-b8a7-1161d46a6424', 'dangkiem8907Dadmin', 'admin', 'Nguyễn Đức Hưng', 'Hưng', 'Nguyễn Đức',
        '8907D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem8907Dadmin@vr.org.vn',
        '1976-04-12 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '8871128425', '8871128425',
        '2024-03-22 00:00:00.000000 +00:00', null, '2024-03-22 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('1aac5e6e-7933-4092-a3b5-24d6c914a68f', 'staff3', 'vrstaff', 'Nhân viên VR3', 'VR3', 'Nhân viên', 'VR',
        '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'staff3@vr.org.vn',
        '1987-07-31 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '1572917723', '1572917723',
        '2024-02-16 00:00:00.000000 +00:00', null, '2024-02-16 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('da58a70d-abb9-4c21-bb68-08818d196aaf', 'dangkiem6302Dadmin', 'admin', 'Trần Hoàng Thuấn', 'Thuấn',
        'Trần Hoàng', '6302D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem6302Dadmin@vr.org.vn', '1973-10-13 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '6808212573',
        '6808212573', '2023-06-20 00:00:00.000000 +00:00', null, '2023-06-20 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('4e12171c-bae4-4d9a-a6b4-665ffa5e09a6', 'dangkiem1902Dkdv', 'staff', 'Nhân viên TTDK 1902D', '1902D',
        'Nhân viên TTDK', '1902D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem1902Dkdv@vr.org.vn', '1982-09-17 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '7110071933',
        '7110071933', '2023-02-01 00:00:00.000000 +00:00', null, '2023-02-01 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('a616ace7-17d2-4961-aa37-90e028e8c29d', 'dangkiem9201Dadmin', 'admin', 'Đặng Bảo Lâm', 'Lâm', 'Đặng Bảo',
        '9201D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem9201Dadmin@vr.org.vn',
        '1989-03-29 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '3130200622', '3130200622',
        '2024-02-05 00:00:00.000000 +00:00', null, '2024-02-05 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('15d931af-a9bb-47b9-b8c6-d2e1a0957e6c', 'dangkiem4705Dadmin', 'admin', 'Trần Quốc Mậu', 'Mậu', 'Trần Quốc',
        '4705D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem4705Dadmin@vr.org.vn',
        '1976-05-25 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '5733945859', '5733945859',
        '2024-03-26 00:00:00.000000 +00:00', null, '2024-03-26 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('7ff5ea18-2e15-4468-938a-d7b5d2214901', 'dangkiem6502Dkdv', 'staff', 'Nhân viên TTDK 6502D', '6502D',
        'Nhân viên TTDK', '6502D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem6502Dkdv@vr.org.vn', '1985-12-16 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '6038889228',
        '6038889228', '2024-03-20 00:00:00.000000 +00:00', null, '2024-03-20 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('cec74dbf-edeb-4499-ac90-2f87910d3286', 'dangkiem1401Dadmin', 'admin', 'Đào Duy Long', 'Long', 'Đào Duy',
        '1401D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem1401Dadmin@vr.org.vn',
        '1972-11-22 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '5663273026', '5663273026',
        '2023-07-03 00:00:00.000000 +00:00', null, '2023-07-03 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('6cbbfac1-b1b7-4d45-beab-f0464ba0c08c', 'dangkiem2906Vkdv', 'staff', 'Nhân viên TTDK 2906V', '2906V',
        'Nhân viên TTDK', '2906V', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem2906Vkdv@vr.org.vn', '1988-12-31 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '4450188780',
        '4450188780', '2023-06-18 00:00:00.000000 +00:00', null, '2023-06-18 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('87be92d8-829c-415a-aa15-eab1f35d33be', 'dangkiem8906Dadmin', 'admin', 'Bùi Ngọc Tân', 'Tân', 'Bùi Ngọc',
        '8906D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem8906Dadmin@vr.org.vn',
        '1977-11-06 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '9868624145', '9868624145',
        '2023-02-15 00:00:00.000000 +00:00', null, '2023-02-15 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('c6a6bbe5-131f-4f37-b3a9-2e698d67583f', 'dangkiem6005Dadmin', 'admin', 'Nguyễn Văn Thuận', 'Thuận',
        'Nguyễn Văn', '6005D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem6005Dadmin@vr.org.vn', '1975-09-18 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '3027008164',
        '3027008164', '2023-06-26 00:00:00.000000 +00:00', null, '2023-06-26 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('69d59632-eb3d-4e40-ac89-b1f263df8db9', 'dangkiem2202Dkdv', 'staff', 'Nhân viên TTDK 2202D', '2202D',
        'Nhân viên TTDK', '2202D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem2202Dkdv@vr.org.vn', '1984-05-11 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '1181763996',
        '1181763996', '2023-07-14 00:00:00.000000 +00:00', null, '2023-07-14 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('6f932512-c738-43b2-9a58-d06da9f93563', 'dangkiem1506Dkdv', 'staff', 'Nhân viên TTDK 1506D', '1506D',
        'Nhân viên TTDK', '1506D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem1506Dkdv@vr.org.vn', '1986-12-10 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '5005905938',
        '5005905938', '2023-03-05 00:00:00.000000 +00:00', null, '2023-03-05 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('dc52df40-ff7b-4358-8ccb-a719e048c569', 'dangkiem8902Sadmin', 'admin', 'Nguyễn Chí Phước', 'Phước',
        'Nguyễn Chí', '8902S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem8902Sadmin@vr.org.vn', '1974-11-18 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '4885344838',
        '4885344838', '2023-07-23 00:00:00.000000 +00:00', null, '2023-07-23 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('669f416e-8a49-4886-8c7e-960cee0247c5', 'dangkiem4901Skdv', 'staff', 'Nhân viên TTDK 4901S', '4901S',
        'Nhân viên TTDK', '4901S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem4901Skdv@vr.org.vn', '1979-05-13 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '8197009560',
        '8197009560', '2023-12-29 00:00:00.000000 +00:00', null, '2023-12-29 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('e5ea6a52-6c85-4367-afc3-432d8ac18054', 'dangkiem9001Skdv', 'staff', 'Nhân viên TTDK 9001S', '9001S',
        'Nhân viên TTDK', '9001S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem9001Skdv@vr.org.vn', '1982-12-11 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '9805806429',
        '9805806429', '2024-05-15 00:00:00.000000 +00:00', null, '2024-05-15 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('1862df73-6f78-4a38-a991-81245e29c8fd', 'dangkiem5004Vkdv', 'staff', 'Nhân viên TTDK 5004V', '5004V',
        'Nhân viên TTDK', '5004V', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem5004Vkdv@vr.org.vn', '1990-03-24 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '9284468821',
        '9284468821', '2024-01-19 00:00:00.000000 +00:00', null, '2024-01-19 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('8f0e032b-7836-4244-af8c-741a0ffe332d', 'dangkiem2909Dkdv', 'staff', 'Nhân viên TTDK 2909D', '2909D',
        'Nhân viên TTDK', '2909D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem2909Dkdv@vr.org.vn', '1979-01-28 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '8564420793',
        '8564420793', '2024-04-13 00:00:00.000000 +00:00', null, '2024-04-13 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('51210f35-eed7-492d-a3b3-f46a09acdfe0', 'dangkiem2404Dkdv', 'staff', 'Nhân viên TTDK 2404D', '2404D',
        'Nhân viên TTDK', '2404D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem2404Dkdv@vr.org.vn', '1983-07-05 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '7481995390',
        '7481995390', '2024-04-19 00:00:00.000000 +00:00', null, '2024-04-19 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('142cef24-5f5a-41b4-abb4-17b8536a250e', 'dangkiem8105Dkdv', 'staff', 'Nhân viên TTDK 8105D', '8105D',
        'Nhân viên TTDK', '8105D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem8105Dkdv@vr.org.vn', '1972-12-13 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '7328395582',
        '7328395582', '2023-12-02 00:00:00.000000 +00:00', null, '2023-12-02 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('71815ed3-bf9d-41e0-b4bd-21f4e841e76b', 'dangkiem3404Dkdv', 'staff', 'Nhân viên TTDK 3404D', '3404D',
        'Nhân viên TTDK', '3404D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem3404Dkdv@vr.org.vn', '1988-01-13 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '3137297566',
        '3137297566', '2023-06-16 00:00:00.000000 +00:00', null, '2023-06-16 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('311322af-42a3-401f-8faa-8a746c0bdcff', 'dangkiem4301Skdv', 'staff', 'Nhân viên TTDK 4301S', '4301S',
        'Nhân viên TTDK', '4301S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem4301Skdv@vr.org.vn', '1971-02-26 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '7784818154',
        '7784818154', '2023-09-12 00:00:00.000000 +00:00', null, '2023-09-12 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('9df39235-8fc7-45e3-8b42-3e630c099983', 'dangkiem3602Skdv', 'staff', 'Nhân viên TTDK 3602S', '3602S',
        'Nhân viên TTDK', '3602S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem3602Skdv@vr.org.vn', '1985-08-01 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '3202366283',
        '3202366283', '2024-01-01 00:00:00.000000 +00:00', null, '2024-01-01 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('b0c11891-ddf5-46b1-b983-08031adf461c', 'dangkiem4705Dkdv', 'staff', 'Nhân viên TTDK 4705D', '4705D',
        'Nhân viên TTDK', '4705D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem4705Dkdv@vr.org.vn', '1977-01-09 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '1558574223',
        '1558574223', '2023-02-10 00:00:00.000000 +00:00', null, '2023-02-10 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('1aa2c8bb-26e5-4856-8f3b-5b1000a06a22', 'dangkiem6112Dadmin', 'admin', 'Nguyễn Thanh Thảo', 'Thảo',
        'Nguyễn Thanh', '6112D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem6112Dadmin@vr.org.vn', '1977-03-06 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '8233196429',
        '8233196429', '2023-10-24 00:00:00.000000 +00:00', null, '2023-10-24 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('e6f1b0a7-481e-4791-944b-8f3f64d63a98', 'dangkiem9805Dadmin', 'admin', 'Nguyễn Quang Long', 'Long',
        'Nguyễn Quang', '9805D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem9805Dadmin@vr.org.vn', '1988-05-14 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '1055552935',
        '1055552935', '2023-11-18 00:00:00.000000 +00:00', null, '2023-11-18 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('c55aeafd-e4b7-4b9c-a48a-352c63815a4b', 'dangkiem6702Skdv', 'staff', 'Nhân viên TTDK 6702S', '6702S',
        'Nhân viên TTDK', '6702S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem6702Skdv@vr.org.vn', '1980-05-05 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '6260139598',
        '6260139598', '2023-07-20 00:00:00.000000 +00:00', null, '2023-07-20 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('bdc2aa39-f582-4b05-8fda-4122debeeaf5', 'dangkiem6109Dadmin', 'admin', 'Võ Quốc Phong', 'Phong', 'Võ Quốc',
        '6109D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem6109Dadmin@vr.org.vn',
        '1982-05-08 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '5937137140', '5937137140',
        '2023-08-13 00:00:00.000000 +00:00', null, '2023-08-13 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('c85a748b-6d17-4e01-b8ac-933e76fac9c6', 'dangkiem6006Dadmin', 'admin', 'Trương Tiến Diệu', 'Diệu',
        'Trương Tiến', '6006D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem6006Dadmin@vr.org.vn', '1971-08-28 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '2305007593',
        '2305007593', '2024-02-08 00:00:00.000000 +00:00', null, '2024-02-08 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('72d916cd-8d28-4697-9b99-293aadca2198', 'dangkiem1901Vadmin', 'admin', 'Vũ Mạnh Dũng', 'Dũng', 'Vũ Mạnh',
        '1901V', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem1901Vadmin@vr.org.vn',
        '1987-10-15 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '7630121794', '7630121794',
        '2024-01-22 00:00:00.000000 +00:00', null, '2024-01-22 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('8de62009-a794-4d6a-8627-eec13504dfac', 'dangkiem9206Dadmin', 'admin', 'Trần Quang Huy', 'Huy', 'Trần Quang',
        '9206D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem9206Dadmin@vr.org.vn',
        '1975-12-04 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '9319664625', '9319664625',
        '2024-01-24 00:00:00.000000 +00:00', null, '2024-01-24 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('a1989c62-bfdb-48d0-9e5a-3176ae056e5f', 'dangkiem3804Dadmin', 'admin', 'Nguyễn Ngọc Trung', 'Trung',
        'Nguyễn Ngọc', '3804D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem3804Dadmin@vr.org.vn', '1977-06-15 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '5758325845',
        '5758325845', '2023-12-21 00:00:00.000000 +00:00', null, '2023-12-21 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('25b385cb-e423-46d9-b737-a149e3f19e5e', 'dangkiem2203Dkdv', 'staff', 'Nhân viên TTDK 2203D', '2203D',
        'Nhân viên TTDK', '2203D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem2203Dkdv@vr.org.vn', '1988-12-22 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '8123163332',
        '8123163332', '2023-05-28 00:00:00.000000 +00:00', null, '2023-05-28 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('b462ff8b-5e61-4352-af94-4475ed15551d', 'dangkiem3702Sadmin', 'admin', 'Nguyễn Quý Khánh', 'Khánh',
        'Nguyễn Quý', '3702S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem3702Sadmin@vr.org.vn', '1974-08-06 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '5339433505',
        '5339433505', '2024-01-10 00:00:00.000000 +00:00', null, '2024-01-10 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('fcf69999-a0e5-46cd-81fd-e66c1ecb5b6e', 'dangkiem8804Dkdv', 'staff', 'Nhân viên TTDK 8804D', '8804D',
        'Nhân viên TTDK', '8804D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem8804Dkdv@vr.org.vn', '1983-11-09 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '5236933589',
        '5236933589', '2024-03-17 00:00:00.000000 +00:00', null, '2024-03-17 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('0a4c087a-6d47-4e2d-85cb-b8e41947b5d8', 'dangkiem2601Dkdv', 'staff', 'Nhân viên TTDK 2601D', '2601D',
        'Nhân viên TTDK', '2601D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem2601Dkdv@vr.org.vn', '1976-09-27 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '7937229445',
        '7937229445', '2023-08-06 00:00:00.000000 +00:00', null, '2023-08-06 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('648e3a83-ab88-4065-9422-04ca296ea57c', 'dangkiem8501Sadmin', 'admin', 'Tạ Hậu', 'Hậu', 'Tạ', '8501S',
        '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem8501Sadmin@vr.org.vn',
        '1980-05-21 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '3547058703', '3547058703',
        '2023-08-02 00:00:00.000000 +00:00', null, '2023-08-02 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('c2d952e5-eb09-4127-b5eb-3a63141a0520', 'dangkiem3503Dkdv', 'staff', 'Nhân viên TTDK 3503D', '3503D',
        'Nhân viên TTDK', '3503D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem3503Dkdv@vr.org.vn', '1986-01-30 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '1727122652',
        '1727122652', '2023-03-06 00:00:00.000000 +00:00', null, '2023-03-06 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('99479efa-ce2b-4779-bd73-71162f74544b', 'dangkiem1701Dadmin', 'admin', 'Đàm Văn Tú', 'Tú', 'Đàm Văn', '1701D',
        '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem1701Dadmin@vr.org.vn',
        '1982-10-13 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '1008957546', '1008957546',
        '2023-12-07 00:00:00.000000 +00:00', null, '2023-12-07 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('391ff95e-81b0-410a-b7f9-9c0cddc34db2', 'dangkiem1904Dadmin', 'admin', 'NGUYỄN VĂN HIẾU', 'HIẾU', 'NGUYỄN VĂN',
        '1904D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem1904Dadmin@vr.org.vn',
        '1989-04-12 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '4297800113', '4297800113',
        '2023-11-28 00:00:00.000000 +00:00', null, '2023-11-28 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('9558c848-7195-46b1-ab2f-58905adb1f3f', 'dangkiem4904Dkdv', 'staff', 'Nhân viên TTDK 4904D', '4904D',
        'Nhân viên TTDK', '4904D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem4904Dkdv@vr.org.vn', '1990-02-03 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '3976881431',
        '3976881431', '2023-04-18 00:00:00.000000 +00:00', null, '2023-04-18 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('469b9450-4cb9-46ec-a099-799db8ec0166', 'dangkiem1902Dadmin', 'admin', 'Trần Minh Lương', 'Lương', 'Trần Minh',
        '1902D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem1902Dadmin@vr.org.vn',
        '1975-08-30 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '2226936693', '2226936693',
        '2023-02-07 00:00:00.000000 +00:00', null, '2023-02-07 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('e13abf04-609b-4506-ab6f-1281c304d161', 'dangkiem2007Dadmin', 'admin', 'Trần Ngọc Hiếu', 'Hiếu', 'Trần Ngọc',
        '2007D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem2007Dadmin@vr.org.vn',
        '1976-07-29 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '5882709670', '5882709670',
        '2023-01-09 00:00:00.000000 +00:00', null, '2023-01-09 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('a0f70a22-78f0-428c-83af-e4a8b3357d5a', 'dangkiem6006Dkdv', 'staff', 'Nhân viên TTDK 6006D', '6006D',
        'Nhân viên TTDK', '6006D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem6006Dkdv@vr.org.vn', '1970-12-09 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '6759285814',
        '6759285814', '2024-04-03 00:00:00.000000 +00:00', null, '2024-04-03 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('324dd21c-9c52-4743-b363-bfc771fdb445', 'dangkiem6401Vkdv', 'staff', 'Nhân viên TTDK 6401V', '6401V',
        'Nhân viên TTDK', '6401V', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem6401Vkdv@vr.org.vn', '1972-01-19 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '8764820622',
        '8764820622', '2023-09-08 00:00:00.000000 +00:00', null, '2023-09-08 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('f133e702-84cc-4255-833a-11cfe833a663', 'dangkiem5004Vadmin', 'admin', 'Nguyễn Xuân Hải', 'Hải', 'Nguyễn Xuân',
        '5004V', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem5004Vadmin@vr.org.vn',
        '1978-03-14 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '2565389955', '2565389955',
        '2024-03-14 00:00:00.000000 +00:00', null, '2024-03-14 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('cf717427-1ea0-43b5-bf9a-2123bc63e25c', 'dangkiem7204Sadmin', 'admin', 'PGĐ  Trần Văn Lang', 'Lang',
        'PGĐ Trần Văn', '7204S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem7204Sadmin@vr.org.vn', '1981-07-20 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '2074243794',
        '2074243794', '2023-06-15 00:00:00.000000 +00:00', null, '2023-06-15 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('b30f2d1c-c882-40b6-bc91-2769997b98b3', 'dangkiem1802Skdv', 'staff', 'Nhân viên TTDK 1802S', '1802S',
        'Nhân viên TTDK', '1802S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem1802Skdv@vr.org.vn', '1975-06-05 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '6587418712',
        '6587418712', '2023-08-08 00:00:00.000000 +00:00', null, '2023-08-08 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('4e21fe39-791f-4077-8de5-12a153bfc5fe', 'dangkiem6201Sadmin', 'admin', 'Nguyễn Văn Phúc', 'Phúc', 'Nguyễn Văn',
        '6201S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem6201Sadmin@vr.org.vn',
        '1975-02-14 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '7967545223', '7967545223',
        '2023-03-20 00:00:00.000000 +00:00', null, '2023-03-20 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('0fc75904-48df-46b2-924f-596ad2bc4c44', 'dangkiem2403Dkdv', 'staff', 'Nhân viên TTDK 2403D', '2403D',
        'Nhân viên TTDK', '2403D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem2403Dkdv@vr.org.vn', '1981-03-28 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '3352856507',
        '3352856507', '2024-03-24 00:00:00.000000 +00:00', null, '2024-03-24 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('6b0d4b62-9cba-4055-8fa0-9dc1ca1381a8', 'dangkiem3704Dkdv', 'staff', 'Nhân viên TTDK 3704D', '3704D',
        'Nhân viên TTDK', '3704D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem3704Dkdv@vr.org.vn', '1982-11-21 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '4220767874',
        '4220767874', '2023-05-03 00:00:00.000000 +00:00', null, '2023-05-03 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('dd5e0bbf-21bf-4ba2-a3b7-d13be25d3cf1', 'dangkiem2005Dkdv', 'staff', 'Nhân viên TTDK 2005D', '2005D',
        'Nhân viên TTDK', '2005D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem2005Dkdv@vr.org.vn', '1990-09-14 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '2893357533',
        '2893357533', '2024-04-16 00:00:00.000000 +00:00', null, '2024-04-16 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('755ecd8d-9843-4ca9-b38f-8a01644c5e66', 'dangkiem3407Dadmin', 'admin', 'Nguyễn Xuân Hòa', 'Hòa', 'Nguyễn Xuân',
        '3407D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem3407Dadmin@vr.org.vn',
        '1974-01-24 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '5924521401', '5924521401',
        '2024-03-16 00:00:00.000000 +00:00', null, '2024-03-16 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('67b209ee-2007-4958-bd04-3578b539dcf7', 'dangkiem6902Dkdv', 'staff', 'Nhân viên TTDK 6902D', '6902D',
        'Nhân viên TTDK', '6902D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem6902Dkdv@vr.org.vn', '1985-11-21 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '7433280597',
        '7433280597', '2024-04-24 00:00:00.000000 +00:00', null, '2024-04-24 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('f3a23ca0-1071-4435-8b8f-97ef4cbb05e7', 'dangdt', 'god', 'Đào Đăng', 'Đăng', 'Đào', 'GOD',
        '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangdt@vr.org.vn',
        '1979-07-31 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '3761903556', '3761903556',
        '2024-03-06 00:00:00.000000 +00:00', null, '2024-03-06 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('4510006f-2d96-4f93-92e3-aa4126ae4fa5', 'dangkiem1201Dadmin', 'admin', 'Triệu Hoàng Sơn', 'Sơn', 'Triệu Hoàng',
        '1201D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem1201Dadmin@vr.org.vn',
        '1977-02-21 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '9077442683', '9077442683',
        '2024-01-04 00:00:00.000000 +00:00', null, '2024-01-04 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('345db23a-034d-4ee3-98d7-fcd9edd2618f', 'dangkiem9201Dkdv', 'staff', 'Nhân viên TTDK 9201D', '9201D',
        'Nhân viên TTDK', '9201D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem9201Dkdv@vr.org.vn', '1979-08-04 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '2736402941',
        '2736402941', '2023-07-22 00:00:00.000000 +00:00', null, '2023-07-22 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('ca7e9e20-c5b9-41ff-a33e-c55a45e4c07d', 'dangkiem9503Dkdv', 'staff', 'Nhân viên TTDK 9503D', '9503D',
        'Nhân viên TTDK', '9503D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem9503Dkdv@vr.org.vn', '1977-07-22 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '3229397620',
        '3229397620', '2024-01-18 00:00:00.000000 +00:00', null, '2024-01-18 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('3443d365-5a93-418b-8536-0faa97922ec3', 'dangkiem4903Sadmin', 'admin', 'Nguyễn Nguyễn Trí Hải', 'Hải',
        'Nguyễn Nguyễn Trí', '4903S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem4903Sadmin@vr.org.vn', '1975-12-28 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '5150541997',
        '5150541997', '2023-05-13 00:00:00.000000 +00:00', null, '2023-05-13 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('abb10e2d-219a-489b-9a45-9f4c28c22921', 'dangkiem6602Dkdv', 'staff', 'Nhân viên TTDK 6602D', '6602D',
        'Nhân viên TTDK', '6602D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem6602Dkdv@vr.org.vn', '1971-07-17 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '4915138612',
        '4915138612', '2023-03-13 00:00:00.000000 +00:00', null, '2023-03-13 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('2df4410a-a953-4bb3-8689-9e1ddcc342ee', 'dangkiem7201Sadmin', 'admin', 'Hoàng Văn Sỹ', 'Sỹ', 'Hoàng Văn',
        '7201S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem7201Sadmin@vr.org.vn',
        '1989-09-15 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '9822400558', '9822400558',
        '2023-08-11 00:00:00.000000 +00:00', null, '2023-08-11 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('a66441e6-2d66-41b2-8f00-f08204ba242a', 'dangkiem6803Dadmin', 'admin', 'Lâm Hoàng Minh Tuấn', 'Tuấn',
        'Lâm Hoàng Minh', '6803D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem6803Dadmin@vr.org.vn', '1986-11-02 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '3193737624',
        '3193737624', '2023-05-29 00:00:00.000000 +00:00', null, '2023-05-29 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('5bf1b84f-0495-4441-a16a-676ac5e83611', 'dangkiem7604Dadmin', 'admin', 'Trần Ngọc Duy', 'Duy', 'Trần Ngọc',
        '7604D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem7604Dadmin@vr.org.vn',
        '1971-05-13 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '5448379581', '5448379581',
        '2023-02-28 00:00:00.000000 +00:00', null, '2023-02-28 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('75d09bcc-bf05-4a77-8f84-1679433a890f', 'dangkiem7701Skdv', 'staff', 'Nhân viên TTDK 7701S', '7701S',
        'Nhân viên TTDK', '7701S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem7701Skdv@vr.org.vn', '1983-02-21 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '6513584411',
        '6513584411', '2023-11-11 00:00:00.000000 +00:00', null, '2023-11-11 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('0832fe1d-3b31-4e72-9ec9-b5c76d28681c', 'dangkiem4702Dadmin', 'admin', 'Phan Hoài Nam', 'Nam', 'Phan Hoài',
        '4702D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem4702Dadmin@vr.org.vn',
        '1986-06-12 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '9395666532', '9395666532',
        '2023-04-19 00:00:00.000000 +00:00', null, '2023-04-19 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('8140821e-2c17-4691-97af-bbd0edb4af19', 'dangkiem2914Dkdv', 'staff', 'Nhân viên TTDK 2914D', '2914D',
        'Nhân viên TTDK', '2914D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem2914Dkdv@vr.org.vn', '1974-06-15 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '3787547585',
        '3787547585', '2023-11-25 00:00:00.000000 +00:00', null, '2023-11-25 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('c7906464-76ef-40be-8b3f-ac9452cdd5ea', 'dangkiem7203Dadmin', 'admin', 'Nguyễn Hòa Quất', 'Quất', 'Nguyễn Hòa',
        '7203D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem7203Dadmin@vr.org.vn',
        '1984-10-01 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '4622205613', '4622205613',
        '2024-02-27 00:00:00.000000 +00:00', null, '2024-02-27 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('af490775-66fe-4788-b6f0-aeebcd459340', 'dangkiem6501Skdv', 'staff', 'Nhân viên TTDK 6501S', '6501S',
        'Nhân viên TTDK', '6501S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem6501Skdv@vr.org.vn', '1977-02-26 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '6833790387',
        '6833790387', '2023-09-07 00:00:00.000000 +00:00', null, '2023-09-07 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('a51658f4-667a-4e47-8c6a-f18f5fe1561b', 'dangkiem4802Dadmin', 'admin', 'Phan Hữu Nhã', 'Nhã', 'Phan Hữu',
        '4802D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem4802Dadmin@vr.org.vn',
        '1988-01-16 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '4652108479', '4652108479',
        '2023-12-18 00:00:00.000000 +00:00', null, '2023-12-18 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('d9e55520-910a-408e-8f85-be37eaf2ced3', 'dangkiem6112Dkdv', 'staff', 'Nhân viên TTDK 6112D', '6112D',
        'Nhân viên TTDK', '6112D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem6112Dkdv@vr.org.vn', '1977-08-05 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '9091523577',
        '9091523577', '2023-02-04 00:00:00.000000 +00:00', null, '2023-02-04 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('5fddf33c-dde9-4e93-b09a-18fa470c8acb', 'dangkiem2002Skdv', 'staff', 'Nhân viên TTDK 2002S', '2002S',
        'Nhân viên TTDK', '2002S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem2002Skdv@vr.org.vn', '1982-02-04 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '6906492739',
        '6906492739', '2023-07-09 00:00:00.000000 +00:00', null, '2023-07-09 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('757b43f5-9711-4f47-8511-0ca9ae6ac208', 'dangkiem6103Dkdv', 'staff', 'Nhân viên TTDK 6103D', '6103D',
        'Nhân viên TTDK', '6103D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem6103Dkdv@vr.org.vn', '1974-11-20 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '4514738542',
        '4514738542', '2023-09-30 00:00:00.000000 +00:00', null, '2023-09-30 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('a48ca799-d289-42cc-a499-83f811725599', 'dangkiem8104Dkdv', 'staff', 'Nhân viên TTDK 8104D', '8104D',
        'Nhân viên TTDK', '8104D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem8104Dkdv@vr.org.vn', '1980-06-01 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '4183429488',
        '4183429488', '2023-04-10 00:00:00.000000 +00:00', null, '2023-04-10 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('913114de-0663-42e3-92eb-8f887464dc0f', 'dangkiem1406Dadmin', 'admin', 'Hoàng Anh Hùng', 'Hùng', 'Hoàng Anh',
        '1406D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem1406Dadmin@vr.org.vn',
        '1978-01-08 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '9701269078', '9701269078',
        '2023-08-04 00:00:00.000000 +00:00', null, '2023-08-04 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('7518a65f-d0bf-4b84-be19-69d817eab828', 'dangkiem1504Dadmin', 'admin', 'Nguyễn Văn Quý', 'Quý', 'Nguyễn Văn',
        '1504D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem1504Dadmin@vr.org.vn',
        '1989-01-17 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '1539174398', '1539174398',
        '2024-05-02 00:00:00.000000 +00:00', null, '2024-05-02 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('4f355390-3c42-4d2f-9612-cf458bb13246', 'dangkiem7205Dkdv', 'staff', 'Nhân viên TTDK 7205D', '7205D',
        'Nhân viên TTDK', '7205D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem7205Dkdv@vr.org.vn', '1972-12-21 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '6873491057',
        '6873491057', '2023-10-04 00:00:00.000000 +00:00', null, '2023-10-04 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('4545f443-5ce8-45f7-a413-329fd515cacb', 'dangkiem7803Dadmin', 'admin', 'Trần Văn Tài', 'Tài', 'Trần Văn',
        '7803D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem7803Dadmin@vr.org.vn',
        '1982-01-27 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '3991141654', '3991141654',
        '2023-02-22 00:00:00.000000 +00:00', null, '2023-02-22 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('454a0eb2-25e6-4cae-b823-89236e3c9db3', 'dangkiem9901Sadmin', 'admin', 'Phạm Thanh Phương', 'Phương',
        'Phạm Thanh', '9901S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem9901Sadmin@vr.org.vn', '1974-02-01 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '3798538756',
        '3798538756', '2024-05-17 00:00:00.000000 +00:00', null, '2024-05-17 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('4fdec3a5-b196-4281-9955-df15fe50e8c2', 'dangkiem7203Dkdv', 'staff', 'Nhân viên TTDK 7203D', '7203D',
        'Nhân viên TTDK', '7203D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem7203Dkdv@vr.org.vn', '1987-01-01 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '8155184218',
        '8155184218', '2024-04-22 00:00:00.000000 +00:00', null, '2024-04-22 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('6ff5949a-96be-448c-a137-75eaea5c3295', 'dangkiem9904Dadmin', 'admin', 'Trần Minh Đức', 'Đức', 'Trần Minh',
        '9904D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem9904Dadmin@vr.org.vn',
        '1986-07-20 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '6693192077', '6693192077',
        '2023-04-01 00:00:00.000000 +00:00', null, '2023-04-01 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('ff85d31d-3c4b-436c-b5fb-97900760857a', 'dangkiem6902Dadmin', 'admin', 'Khưu Tố Phương', 'Phương', 'Khưu Tố',
        '6902D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem6902Dadmin@vr.org.vn',
        '1970-12-01 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '1032352385', '1032352385',
        '2023-04-26 00:00:00.000000 +00:00', null, '2023-04-26 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('126227e9-834c-484f-8f3d-62a7f6caa5c3', 'dangkiem3401Dkdv', 'staff', 'Nhân viên TTDK 3401D', '3401D',
        'Nhân viên TTDK', '3401D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem3401Dkdv@vr.org.vn', '1981-03-10 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '8032218486',
        '8032218486', '2023-03-01 00:00:00.000000 +00:00', null, '2023-03-01 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('22e1ce71-fa89-4475-8dca-f1e4a2ed0960', 'dangkiem6901Vadmin', 'admin', 'Đặng Hoàng Phong', 'Phong',
        'Đặng Hoàng', '6901V', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem6901Vadmin@vr.org.vn', '1985-07-14 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '1186700991',
        '1186700991', '2024-01-17 00:00:00.000000 +00:00', null, '2024-01-17 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('98f3c956-2243-4bdb-817d-b5be76b41c27', 'dangkiem6109Dkdv', 'staff', 'Nhân viên TTDK 6109D', '6109D',
        'Nhân viên TTDK', '6109D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem6109Dkdv@vr.org.vn', '1978-10-11 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '6746660360',
        '6746660360', '2023-06-01 00:00:00.000000 +00:00', null, '2023-06-01 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('0565c8f6-a96a-43f0-a92f-56fa295ab721', 'dangkiem7002Skdv', 'staff', 'Nhân viên TTDK 7002S', '7002S',
        'Nhân viên TTDK', '7002S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem7002Skdv@vr.org.vn', '1988-06-23 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '2294514715',
        '2294514715', '2023-09-09 00:00:00.000000 +00:00', null, '2023-09-09 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('47ba7d9b-b821-4a1a-b94b-dcb29523b888', 'dangkiem6004Dadmin', 'admin', 'Lương Minh Tú', 'Tú', 'Lương Minh',
        '6004D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem6004Dadmin@vr.org.vn',
        '1989-08-30 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '8437594319', '8437594319',
        '2023-09-10 00:00:00.000000 +00:00', null, '2023-09-10 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('3d198c2b-77ac-4a7a-add4-7f367a143456', 'dangkiem7901Sadmin', 'admin', 'Phù Minh Sơn', 'Sơn', 'Phù Minh',
        '7901S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem7901Sadmin@vr.org.vn',
        '1982-02-19 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '9023768002', '9023768002',
        '2024-05-04 00:00:00.000000 +00:00', null, '2024-05-04 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('5afa7e58-423d-4bcc-bc71-0792e3530ef1', 'dangkiem3803Dkdv', 'staff', 'Nhân viên TTDK 3803D', '3803D',
        'Nhân viên TTDK', '3803D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem3803Dkdv@vr.org.vn', '1987-06-13 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '9912532146',
        '9912532146', '2023-08-22 00:00:00.000000 +00:00', null, '2023-08-22 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('702e3d55-360a-4205-ac31-090c4aae4b66', 'dangkiem3405Dkdv', 'staff', 'Nhân viên TTDK 3405D', '3405D',
        'Nhân viên TTDK', '3405D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem3405Dkdv@vr.org.vn', '1987-04-20 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '1679773305',
        '1679773305', '2024-04-15 00:00:00.000000 +00:00', null, '2024-04-15 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('1e6bf78c-7f39-49bf-b5d7-672bff51af29', 'dangkiem6002Skdv', 'staff', 'Nhân viên TTDK 6002S', '6002S',
        'Nhân viên TTDK', '6002S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem6002Skdv@vr.org.vn', '1983-03-15 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '9738727180',
        '9738727180', '2023-02-17 00:00:00.000000 +00:00', null, '2023-02-17 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('54a3f5c6-d363-49af-a97a-8930dbdcf224', 'dangkiem6601Skdv', 'staff', 'Nhân viên TTDK 6601S', '6601S',
        'Nhân viên TTDK', '6601S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem6601Skdv@vr.org.vn', '1988-07-08 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '6596199881',
        '6596199881', '2023-11-29 00:00:00.000000 +00:00', null, '2023-11-29 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('0a41562c-be15-40e1-87b0-c5b8d74a936e', 'dangkiem7601Skdv', 'staff', 'Nhân viên TTDK 7601S', '7601S',
        'Nhân viên TTDK', '7601S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem7601Skdv@vr.org.vn', '1975-08-05 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '1059349749',
        '1059349749', '2023-06-17 00:00:00.000000 +00:00', null, '2023-06-17 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('952ecc89-a7a6-496b-a1aa-d42099552a88', 'dangkiem4302Skdv', 'staff', 'Nhân viên TTDK 4302S', '4302S',
        'Nhân viên TTDK', '4302S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem4302Skdv@vr.org.vn', '1985-03-22 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '8512283802',
        '8512283802', '2024-04-28 00:00:00.000000 +00:00', null, '2024-04-28 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('01441dc6-0807-4918-8b31-2cd8b23af5fe', 'dangkiem3703Dkdv', 'staff', 'Nhân viên TTDK 3703D', '3703D',
        'Nhân viên TTDK', '3703D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem3703Dkdv@vr.org.vn', '1983-04-28 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '5519168213',
        '5519168213', '2023-04-27 00:00:00.000000 +00:00', null, '2023-04-27 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('a1f36b5b-b89d-4ea2-b989-9b49fd9873a7', 'dangkiem7101Dkdv', 'staff', 'Nhân viên TTDK 7101D', '7101D',
        'Nhân viên TTDK', '7101D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem7101Dkdv@vr.org.vn', '1979-12-24 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '5653125944',
        '5653125944', '2023-03-19 00:00:00.000000 +00:00', null, '2023-03-19 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('dab8e896-7cdb-483b-a1ad-756a0a765a35', 'dangkiem7304Dadmin', 'admin', 'Phan Duy Tùng', 'Tùng', 'Phan Duy',
        '7304D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem7304Dadmin@vr.org.vn',
        '1985-08-08 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '2365523471', '2365523471',
        '2023-12-31 00:00:00.000000 +00:00', null, '2023-12-31 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('8de64a8d-2010-4764-904d-cdbd8cbb5cc7', 'dangkiem8904Dkdv', 'staff', 'Nhân viên TTDK 8904D', '8904D',
        'Nhân viên TTDK', '8904D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem8904Dkdv@vr.org.vn', '1989-04-03 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '2416172950',
        '2416172950', '2024-03-27 00:00:00.000000 +00:00', null, '2024-03-27 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('52e2622c-a58a-437d-9fe3-53127079605e', 'dangkiem7102Dkdv', 'staff', 'Nhân viên TTDK 7102D', '7102D',
        'Nhân viên TTDK', '7102D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem7102Dkdv@vr.org.vn', '1976-08-10 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '5289279081',
        '5289279081', '2023-07-24 00:00:00.000000 +00:00', null, '2023-07-24 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('86020a2e-4644-42d9-8b27-d3b832f7461a', 'dangkiem4302Sadmin', 'admin', 'Bùi Văn Tấn', 'Tấn', 'Bùi Văn', '4302S',
        '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem4302Sadmin@vr.org.vn',
        '1988-01-12 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '8104714118', '8104714118',
        '2024-04-05 00:00:00.000000 +00:00', null, '2024-04-05 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('1a833096-8f31-476f-bb79-2ecd7dc433df', 'dangkiem6104Dkdv', 'staff', 'Nhân viên TTDK 6104D', '6104D',
        'Nhân viên TTDK', '6104D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem6104Dkdv@vr.org.vn', '1983-12-15 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '1426469538',
        '1426469538', '2024-02-29 00:00:00.000000 +00:00', null, '2024-02-29 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('f0862354-f4f6-426f-9e0e-790e5af27775', 'dangkiem2201Sadmin', 'admin', 'Mai Đại Độ', 'Độ', 'Mai Đại', '2201S',
        '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem2201Sadmin@vr.org.vn',
        '1990-01-26 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '7292736702', '7292736702',
        '2023-08-27 00:00:00.000000 +00:00', null, '2023-08-27 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('fbc9f9a2-318e-4b08-a791-5acbe00afd38', 'dangkiem7706Dadmin', 'admin', 'Nguyễn Đình Phương', 'Phương',
        'Nguyễn Đình', '7706D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem7706Dadmin@vr.org.vn', '1977-09-20 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '1341455362',
        '1341455362', '2023-07-05 00:00:00.000000 +00:00', null, '2023-07-05 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('02eeb670-0f47-4299-b63b-a7b342988a22', 'hoannk', 'god', 'Nguyễn Khải Hoàn', 'Hoàn', 'Nguyễn Khải', 'GOD',
        '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'hoannk@vr.org.vn',
        '1978-10-19 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '9806976183', '9806976183',
        '2024-04-20 00:00:00.000000 +00:00', null, '2024-04-20 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('fa4f6aa8-4fc8-4cec-9c1a-04d007951701', 'dangkiem1502Skdv', 'staff', 'Nhân viên TTDK 1502S', '1502S',
        'Nhân viên TTDK', '1502S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem1502Skdv@vr.org.vn', '1988-04-20 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '6854696492',
        '6854696492', '2023-01-31 00:00:00.000000 +00:00', null, '2023-01-31 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('475976d7-8da4-41c1-bc89-4d15fbac853a', 'dangkiem3801Dkdv', 'staff', 'Nhân viên TTDK 3801D', '3801D',
        'Nhân viên TTDK', '3801D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem3801Dkdv@vr.org.vn', '1978-11-17 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '8824632888',
        '8824632888', '2024-04-30 00:00:00.000000 +00:00', null, '2024-04-30 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('4bc74099-44ac-4c9e-a4b5-86c67d6177a4', 'dangkiem6801Skdv', 'staff', 'Nhân viên TTDK 6801S', '6801S',
        'Nhân viên TTDK', '6801S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem6801Skdv@vr.org.vn', '1990-06-03 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '6432786787',
        '6432786787', '2024-03-21 00:00:00.000000 +00:00', null, '2024-03-21 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('1321280a-e3a4-47e2-8592-59b2e30af339', 'dangkiem8901Skdv', 'staff', 'Nhân viên TTDK 8901S', '8901S',
        'Nhân viên TTDK', '8901S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem8901Skdv@vr.org.vn', '1976-08-15 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '7971893608',
        '7971893608', '2023-02-02 00:00:00.000000 +00:00', null, '2023-02-02 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('d435db79-cbc5-4027-823c-4952bc991923', 'dangkiem9902Sadmin', 'admin', 'Phạm Thanh Phương', 'Phương',
        'Phạm Thanh', '9902S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem9902Sadmin@vr.org.vn', '1972-08-14 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '1402909080',
        '1402909080', '2024-01-12 00:00:00.000000 +00:00', null, '2024-01-12 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('cee9fa65-c3c6-4029-b3f0-f689e4fe6319', 'dangkiem4903Skdv', 'staff', 'Nhân viên TTDK 4903S', '4903S',
        'Nhân viên TTDK', '4903S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem4903Skdv@vr.org.vn', '1976-05-27 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '4468539733',
        '4468539733', '2023-05-27 00:00:00.000000 +00:00', null, '2023-05-27 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('dac43ba6-0cf5-4f3c-9d78-fe40e8d13a18', 'dangkiem7602Dkdv', 'staff', 'Nhân viên TTDK 7602D', '7602D',
        'Nhân viên TTDK', '7602D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem7602Dkdv@vr.org.vn', '1974-07-29 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '1043137569',
        '1043137569', '2023-02-23 00:00:00.000000 +00:00', null, '2023-02-23 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('4443e612-0fb7-4018-97fa-1d72d64307a1', 'dangkiem9701Dkdv', 'staff', 'Nhân viên TTDK 9701D', '9701D',
        'Nhân viên TTDK', '9701D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem9701Dkdv@vr.org.vn', '1979-03-30 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '2817078385',
        '2817078385', '2023-11-03 00:00:00.000000 +00:00', null, '2023-11-03 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('d533723e-f88f-495a-9105-5acde2b9a2d7', 'dangkiem7201Skdv', 'staff', 'Nhân viên TTDK 7201S', '7201S',
        'Nhân viên TTDK', '7201S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem7201Skdv@vr.org.vn', '1974-10-03 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '5351527122',
        '5351527122', '2023-09-28 00:00:00.000000 +00:00', null, '2023-09-28 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('5c389086-7c1f-481a-8261-19ca9ca05153', 'dangkiem2101Sadmin', 'admin', 'Chu Anh Phương', 'Phương', 'Chu Anh',
        '2101S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem2101Sadmin@vr.org.vn',
        '1983-01-13 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '4973987387', '4973987387',
        '2024-03-01 00:00:00.000000 +00:00', null, '2024-03-01 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('895f50e2-6ee8-476d-9e3d-01e846a41604', 'dangkiem9804Dadmin', 'admin', 'Nguyễn Duy Nhật', 'Nhật', 'Nguyễn Duy',
        '9804D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem9804Dadmin@vr.org.vn',
        '1985-08-02 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '3103194979', '3103194979',
        '2023-05-11 00:00:00.000000 +00:00', null, '2023-05-11 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('07a90eab-3f35-491d-813e-0a884f5c2deb', 'dangkiem3610Dkdv', 'staff', 'Nhân viên TTDK 3610D', '3610D',
        'Nhân viên TTDK', '3610D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem3610Dkdv@vr.org.vn', '1972-03-06 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '6380493921',
        '6380493921', '2024-02-10 00:00:00.000000 +00:00', null, '2024-02-10 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('fc3f3b2b-5685-48b9-9c96-21d2659dac5e', 'dangkiem8402Dkdv', 'staff', 'Nhân viên TTDK 8402D', '8402D',
        'Nhân viên TTDK', '8402D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem8402Dkdv@vr.org.vn', '1987-11-16 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '8445932132',
        '8445932132', '2024-02-09 00:00:00.000000 +00:00', null, '2024-02-09 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('691ad368-5cbf-4b70-bbe9-6f470605b9aa', 'dangkiem8201Skdv', 'staff', 'Nhân viên TTDK 8201S', '8201S',
        'Nhân viên TTDK', '8201S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem8201Skdv@vr.org.vn', '1982-10-30 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '9965994595',
        '9965994595', '2023-06-27 00:00:00.000000 +00:00', null, '2023-06-27 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('79d6d945-a4c6-4152-95c6-1bfa7d1198b5', 'dangkiem2902Vkdv', 'staff', 'Nhân viên TTDK 2902V', '2902V',
        'Nhân viên TTDK', '2902V', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem2902Vkdv@vr.org.vn', '1984-04-02 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '2596088608',
        '2596088608', '2023-03-04 00:00:00.000000 +00:00', null, '2023-03-04 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('a0b9e2a3-1ada-49c0-8ea3-1be13c793e63', 'dangkiem8801Skdv', 'staff', 'Nhân viên TTDK 8801S', '8801S',
        'Nhân viên TTDK', '8801S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem8801Skdv@vr.org.vn', '1973-05-23 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '6437167543',
        '6437167543', '2023-06-09 00:00:00.000000 +00:00', null, '2023-06-09 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('d9a96462-91f3-4469-a7d1-dcd23216fc46', 'dangkiem7202Dkdv', 'staff', 'Nhân viên TTDK 7202D', '7202D',
        'Nhân viên TTDK', '7202D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem7202Dkdv@vr.org.vn', '1976-07-30 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '2431661051',
        '2431661051', '2023-08-16 00:00:00.000000 +00:00', null, '2023-08-16 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('566032be-d913-4baa-9986-7c5e8b29b077', 'dangkiem3702Skdv', 'staff', 'Nhân viên TTDK 3702S', '3702S',
        'Nhân viên TTDK', '3702S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem3702Skdv@vr.org.vn', '1974-03-14 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '7571863621',
        '7571863621', '2023-03-12 00:00:00.000000 +00:00', null, '2023-03-12 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('21b8e26a-3ec8-4e52-a1b9-779de792a0cb', 'cuctruong', 'vrhead', 'Cục trưởng VR', 'VR', 'Cục trưởng', 'VR',
        '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'cuctruong@vr.org.vn',
        '1980-04-16 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '7994812110', '7994812110',
        '2023-08-20 00:00:00.000000 +00:00', null, '2023-08-20 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('d77b85ef-2888-4bc8-b2ba-d82e259b331d', 'dangkiem1505Dadmin', 'admin', 'Nguyễn Nghị', 'Nghị', 'Nguyễn', '1505D',
        '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem1505Dadmin@vr.org.vn',
        '1974-05-09 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '8897315266', '8897315266',
        '2023-11-04 00:00:00.000000 +00:00', null, '2023-11-04 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('6ebeed6f-ca59-4ae6-99de-545f0f5ea22e', 'dangkiem7802Dkdv', 'staff', 'Nhân viên TTDK 7802D', '7802D',
        'Nhân viên TTDK', '7802D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem7802Dkdv@vr.org.vn', '1974-01-14 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '8953902692',
        '8953902692', '2023-11-12 00:00:00.000000 +00:00', null, '2023-11-12 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('b9a95e25-46b4-4228-be35-8aec8770036c', 'dangkiem2601Dadmin', 'admin', 'Trần Tiến Dũng', 'Dũng', 'Trần Tiến',
        '2601D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem2601Dadmin@vr.org.vn',
        '1989-10-31 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '9472625543', '9472625543',
        '2023-05-09 00:00:00.000000 +00:00', null, '2023-05-09 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('8ec1c367-bbb9-4253-85df-dd632471470a', 'dangkiem7703Dadmin', 'admin', 'Phạm Hữu Phước', 'Phước', 'Phạm Hữu',
        '7703D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem7703Dadmin@vr.org.vn',
        '1974-12-24 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '3306194539', '3306194539',
        '2023-03-02 00:00:00.000000 +00:00', null, '2023-03-02 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('0a37f9ac-813e-4aad-9069-d68a0b84340a', 'dangkiem9901Skdv', 'staff', 'Nhân viên TTDK 9901S', '9901S',
        'Nhân viên TTDK', '9901S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem9901Skdv@vr.org.vn', '1973-05-02 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '3000520839',
        '3000520839', '2023-11-26 00:00:00.000000 +00:00', null, '2023-11-26 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('5a67ae32-3f07-4f67-accb-8377988f19e3', 'dangkiem1404Dadmin', 'admin', 'Đỗ Duy Linh', 'Linh', 'Đỗ Duy', '1404D',
        '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem1404Dadmin@vr.org.vn',
        '1975-07-01 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '5750805520', '5750805520',
        '2023-06-22 00:00:00.000000 +00:00', null, '2023-06-22 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('d9779063-6ac0-4516-a56d-bfc18e7d4f40', 'dangkiem3302Skdv', 'staff', 'Nhân viên TTDK 3302S', '3302S',
        'Nhân viên TTDK', '3302S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem3302Skdv@vr.org.vn', '1978-01-29 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '9633799650',
        '9633799650', '2024-01-08 00:00:00.000000 +00:00', null, '2024-01-08 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('f1075e76-ea14-4d89-8552-6e5630a6b499', 'dangkiem6201Skdv', 'staff', 'Nhân viên TTDK 6201S', '6201S',
        'Nhân viên TTDK', '6201S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem6201Skdv@vr.org.vn', '1989-04-19 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '4176194245',
        '4176194245', '2023-11-05 00:00:00.000000 +00:00', null, '2023-11-05 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('1aaed87c-919b-4637-a591-5dad9a1ff537', 'dangkiem3609Dadmin', 'admin', 'LÊ VĂN BÌNH', 'BÌNH', 'LÊ VĂN', '3609D',
        '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem3609Dadmin@vr.org.vn',
        '1974-03-21 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '2663466464', '2663466464',
        '2024-05-11 00:00:00.000000 +00:00', null, '2024-05-11 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('0b63bf7c-7d4d-4803-b615-d230ba13489b', 'dangkiem4706Dadmin', 'admin', 'Lại Phú Hợp', 'Hợp', 'Lại Phú', '4706D',
        '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem4706Dadmin@vr.org.vn',
        '1984-07-14 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '7876231283', '7876231283',
        '2023-10-13 00:00:00.000000 +00:00', null, '2023-10-13 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('80412c67-52ec-4588-84ab-b0eb23754dfc', 'dangkiem6601Sadmin', 'admin', 'Nguyễn Ngọc Long', 'Long',
        'Nguyễn Ngọc', '6601S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem6601Sadmin@vr.org.vn', '1975-05-28 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '4862887963',
        '4862887963', '2024-05-10 00:00:00.000000 +00:00', null, '2024-05-10 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('69145495-586c-43e3-9857-65ee44210fff', 'dangkiem1805Dkdv', 'staff', 'Nhân viên TTDK 1805D', '1805D',
        'Nhân viên TTDK', '1805D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem1805Dkdv@vr.org.vn', '1984-01-29 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '8014000463',
        '8014000463', '2024-03-28 00:00:00.000000 +00:00', null, '2024-03-28 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('48f93155-803a-47b9-8eae-37b12d575316', 'dangkiem2916Dadmin', 'admin', 'Hoàng Bảo Sơn', 'Sơn', 'Hoàng Bảo',
        '2916D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem2916Dadmin@vr.org.vn',
        '1971-12-22 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '8931530268', '8931530268',
        '2024-03-07 00:00:00.000000 +00:00', null, '2024-03-07 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('a369b687-64ba-41e8-929c-bc1dc0f94213', 'staff6', 'vrstaff', 'Nhân viên VR6', 'VR6', 'Nhân viên', 'VR',
        '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'staff6@vr.org.vn',
        '1976-08-18 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '2223024418', '2223024418',
        '2023-07-13 00:00:00.000000 +00:00', null, '2023-07-13 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('f3bc3169-6910-4800-b98f-6ead7c433c3d', 'dangkiem3606Dadmin', 'admin', 'Dương Văn Thông', 'Thông', 'Dương Văn',
        '3606D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem3606Dadmin@vr.org.vn',
        '1984-04-11 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '7564684454', '7564684454',
        '2023-06-02 00:00:00.000000 +00:00', null, '2023-06-02 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('a98a232d-25b4-48e4-a296-fbd35e39b0a6', 'dangkiem6901Vkdv', 'staff', 'Nhân viên TTDK 6901V', '6901V',
        'Nhân viên TTDK', '6901V', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem6901Vkdv@vr.org.vn', '1970-12-10 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '1910904279',
        '1910904279', '2023-01-13 00:00:00.000000 +00:00', null, '2023-01-13 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('b1ef77c7-6c29-44d8-8440-603117ee07a5', 'dangkiem8302Dkdv', 'staff', 'Nhân viên TTDK 8302D', '8302D',
        'Nhân viên TTDK', '8302D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem8302Dkdv@vr.org.vn', '1981-02-24 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '2851555951',
        '2851555951', '2024-05-14 00:00:00.000000 +00:00', null, '2024-05-14 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('16a14605-f044-4605-9bcd-db4ddb73ba15', 'dangkiem6106Dadmin', 'admin', 'Danh Thanh Tiền', 'Tiền', 'Danh Thanh',
        '6106D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem6106Dadmin@vr.org.vn',
        '1982-10-08 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '6157105951', '6157105951',
        '2023-01-16 00:00:00.000000 +00:00', null, '2023-01-16 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('07790dd9-5718-4da4-acbd-0af9c86c5d89', 'dangkiem6104Dadmin', 'admin', 'Võ Đông Phong', 'Phong', 'Võ Đông',
        '6104D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem6104Dadmin@vr.org.vn',
        '1985-07-27 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '7634620273', '7634620273',
        '2023-12-26 00:00:00.000000 +00:00', null, '2023-12-26 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('c98bb6fb-876d-4c06-b4a4-502126c334a9', 'dangkiem6801Sadmin', 'admin', 'Nguyễn Quốc Sử', 'Sử', 'Nguyễn Quốc',
        '6801S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem6801Sadmin@vr.org.vn',
        '1978-06-13 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '2668041598', '2668041598',
        '2023-01-27 00:00:00.000000 +00:00', null, '2023-01-27 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('4f25ddd6-f243-4d49-9d19-dea6b07e2f0f', 'dangkiem8301Vadmin', 'admin', 'Thái Trường Giang', 'Giang',
        'Thái Trường', '8301V', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem8301Vadmin@vr.org.vn', '1980-12-04 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '5643508755',
        '5643508755', '2024-05-16 00:00:00.000000 +00:00', null, '2024-05-16 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('8d1fc1ad-5e56-4253-9c20-56ad4a5882ec', 'dangkiem8502Dadmin', 'admin', 'Đỗ Phú Trung', 'Trung', 'Đỗ Phú',
        '8502D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem8502Dadmin@vr.org.vn',
        '1982-04-05 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '5842742092', '5842742092',
        '2023-03-16 00:00:00.000000 +00:00', null, '2023-03-16 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('422f51f6-79f4-41d7-aa77-20fdb892d371', 'dangkiem3802Dkdv', 'staff', 'Nhân viên TTDK 3802D', '3802D',
        'Nhân viên TTDK', '3802D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem3802Dkdv@vr.org.vn', '1971-07-17 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '7374615067',
        '7374615067', '2024-01-03 00:00:00.000000 +00:00', null, '2024-01-03 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('b7055eb8-910f-4b9b-a981-d2316ddd6305', 'dangkiem4902Skdv', 'staff', 'Nhân viên TTDK 4902S', '4902S',
        'Nhân viên TTDK', '4902S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem4902Skdv@vr.org.vn', '1973-04-25 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '9327664169',
        '9327664169', '2023-12-01 00:00:00.000000 +00:00', null, '2023-12-01 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('92137af9-8705-410b-a8a4-04b76638ca0e', 'dangkiem8801Sadmin', 'admin', 'Bạch Thảo Nguyên', 'Nguyên',
        'Bạch Thảo', '8801S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem8801Sadmin@vr.org.vn', '1990-10-29 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '1013340195',
        '1013340195', '2024-05-03 00:00:00.000000 +00:00', null, '2024-05-03 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('2e015bb7-96a7-4da1-bb25-5ba199cc9708', 'dangkiem8901Sadmin', 'admin', 'Nguyễn Chí Phước', 'Phước',
        'Nguyễn Chí', '8901S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem8901Sadmin@vr.org.vn', '1983-08-01 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '4761722344',
        '4761722344', '2023-11-08 00:00:00.000000 +00:00', null, '2023-11-08 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('15915fe4-9dbe-4919-acf8-c51e628a18b3', 'dangkiem1506Dadmin', 'admin', 'Nguyễn Văn Name1506D', 'Name1506D',
        'Nguyễn Văn', '1506D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem1506Dadmin@vr.org.vn', '1989-05-13 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '1119434959',
        '1119434959', '2023-11-16 00:00:00.000000 +00:00', null, '2023-11-16 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('002ec6f1-95e4-4036-81d7-f79cc3a40207', 'dangkiem1805Dadmin', 'admin', 'Trần Công Thùy', 'Thùy', 'Trần Công',
        '1805D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem1805Dadmin@vr.org.vn',
        '1974-10-15 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '7286333387', '7286333387',
        '2023-02-03 00:00:00.000000 +00:00', null, '2023-02-03 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('539d3caf-f0fc-4932-9f22-8bd459b88986', 'dangkiem3502Dkdv', 'staff', 'Nhân viên TTDK 3502D', '3502D',
        'Nhân viên TTDK', '3502D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem3502Dkdv@vr.org.vn', '1977-12-08 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '8432376809',
        '8432376809', '2023-07-10 00:00:00.000000 +00:00', null, '2023-07-10 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('c518f11d-7f26-4dde-8f78-a7b8b689eac5', 'dangkiem8302Dadmin', 'admin', 'Trần Văn Cảnh', 'Cảnh', 'Trần Văn',
        '8302D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem8302Dadmin@vr.org.vn',
        '1983-05-17 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '4205704177', '4205704177',
        '2023-05-02 00:00:00.000000 +00:00', null, '2023-05-02 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('c9e54577-0f0e-4d32-98bf-4a464ad74e9d', 'dangkiem7902Skdv', 'staff', 'Nhân viên TTDK 7902S', '7902S',
        'Nhân viên TTDK', '7902S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem7902Skdv@vr.org.vn', '1974-08-20 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '5792865381',
        '5792865381', '2024-03-08 00:00:00.000000 +00:00', null, '2024-03-08 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('b9de00f8-60ed-4cb3-9bf3-f4cbacabd6d3', 'dangkiem1101Sadmin', 'admin', 'Đinh Ngọc Hiến', 'Hiến', 'Đinh Ngọc',
        '1101S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem1101Sadmin@vr.org.vn',
        '1977-03-15 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '8956920800', '8956920800',
        '2023-02-21 00:00:00.000000 +00:00', null, '2023-02-21 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('9fadef5e-34bc-447b-a301-8fcc3a575ee4', 'dangkiem6803Dkdv', 'staff', 'Nhân viên TTDK 6803D', '6803D',
        'Nhân viên TTDK', '6803D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem6803Dkdv@vr.org.vn', '1975-02-16 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '2758076944',
        '2758076944', '2023-09-18 00:00:00.000000 +00:00', null, '2023-09-18 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('02080705-53a9-4b54-ab25-2e401e06d0db', 'dangkiem6505Dadmin', 'admin', 'Trần Anh Tuyên', 'Tuyên', 'Trần Anh',
        '6505D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem6505Dadmin@vr.org.vn',
        '1987-11-24 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '3484513489', '3484513489',
        '2023-09-15 00:00:00.000000 +00:00', null, '2023-09-15 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('af5ddd84-2967-4531-a70d-13bbcbab8497', 'dangkiem3402Dadmin', 'admin', 'Nguyễn Tiến Mạnh', 'Mạnh',
        'Nguyễn Tiến', '3402D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem3402Dadmin@vr.org.vn', '1972-02-08 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '3059693356',
        '3059693356', '2023-02-05 00:00:00.000000 +00:00', null, '2023-02-05 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('2f749041-7792-4796-8f40-861ee93ab5bb', 'dangkiem1503Dadmin', 'admin', 'Đỗ Đức Kiên', 'Kiên', 'Đỗ Đức', '1503D',
        '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem1503Dadmin@vr.org.vn',
        '1987-12-19 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '1926423956', '1926423956',
        '2023-01-15 00:00:00.000000 +00:00', null, '2023-01-15 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('95a35ba8-d78e-4533-a1aa-e92babd37e4b', 'dangkiem2902Vadmin', 'admin', 'Phùng Thế Ghi', 'Ghi', 'Phùng Thế',
        '2902V', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem2902Vadmin@vr.org.vn',
        '1976-02-13 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '1616887739', '1616887739',
        '2023-09-21 00:00:00.000000 +00:00', null, '2023-09-21 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('1aabfa72-7e42-4d33-8bb1-266fb0ee8db5', 'dangkiem2003Dadmin', 'admin', 'Đỗ Đắc Huy', 'Huy', 'Đỗ Đắc', '2003D',
        '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem2003Dadmin@vr.org.vn',
        '1985-02-03 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '7460334626', '7460334626',
        '2023-10-07 00:00:00.000000 +00:00', null, '2023-10-07 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('ebd1621f-825e-4970-8f71-1eb61fca466f', 'dangkiem4703Dkdv', 'staff', 'Nhân viên TTDK 4703D', '4703D',
        'Nhân viên TTDK', '4703D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem4703Dkdv@vr.org.vn', '1990-10-21 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '6606347553',
        '6606347553', '2024-04-07 00:00:00.000000 +00:00', null, '2024-04-07 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('4e2e20fe-7426-4f29-96fc-f67366e4a29d', 'dangkiem2915Dadmin', 'admin', 'Phạm Chí Công', 'Công', 'Phạm Chí',
        '2915D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem2915Dadmin@vr.org.vn',
        '1979-01-05 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '3154465615', '3154465615',
        '2023-06-07 00:00:00.000000 +00:00', null, '2023-06-07 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('585a960a-b32b-416c-9994-cc447e3219dd', 'dangkiem7304Dkdv', 'staff', 'Nhân viên TTDK 7304D', '7304D',
        'Nhân viên TTDK', '7304D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem7304Dkdv@vr.org.vn', '1974-01-22 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '7461072310',
        '7461072310', '2023-05-04 00:00:00.000000 +00:00', null, '2023-05-04 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('d3039ed3-ad05-4a1a-bd0f-8277ca795347', 'dangkiem8905Dkdv', 'staff', 'Nhân viên TTDK 8905D', '8905D',
        'Nhân viên TTDK', '8905D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem8905Dkdv@vr.org.vn', '1976-08-31 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '8308489715',
        '8308489715', '2023-09-14 00:00:00.000000 +00:00', null, '2023-09-14 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('9adfc7fc-f5de-42e7-98c5-6e3543b45cbc', 'dangkiem7102Dadmin', 'admin', 'Nguyễn Thanh Đông', 'Đông',
        'Nguyễn Thanh', '7102D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem7102Dadmin@vr.org.vn', '1973-01-05 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '2958264987',
        '2958264987', '2023-03-27 00:00:00.000000 +00:00', null, '2023-03-27 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('f33a9688-78c5-4c7c-9d43-7249d65e557b', 'dangkiem2908Dkdv', 'staff', 'Nhân viên TTDK 2908D', '2908D',
        'Nhân viên TTDK', '2908D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem2908Dkdv@vr.org.vn', '1980-08-26 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '7988694976',
        '7988694976', '2023-01-26 00:00:00.000000 +00:00', null, '2023-01-26 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('5ad41502-82ae-4824-968d-d3a00b0ab090', 'dangkiem1502Sadmin', 'admin', 'Đào Trọng Hà', 'Hà', 'Đào Trọng',
        '1502S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem1502Sadmin@vr.org.vn',
        '1971-03-22 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '6271306403', '6271306403',
        '2023-03-25 00:00:00.000000 +00:00', null, '2023-03-25 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('bbda2824-0e11-42eb-8843-22c2b5285730', 'dangkiem1404Dkdv', 'staff', 'Nhân viên TTDK 1404D', '1404D',
        'Nhân viên TTDK', '1404D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem1404Dkdv@vr.org.vn', '1983-12-25 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '1112632676',
        '1112632676', '2023-06-04 00:00:00.000000 +00:00', null, '2023-06-04 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('dec25c71-09a5-4651-bae3-c465209d146a', 'dangkiem2901Vadmin', 'admin', 'Lê Văn Ngân', 'Ngân', 'Lê Văn', '2901V',
        '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem2901Vadmin@vr.org.vn',
        '1983-05-27 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '1013771326', '1013771326',
        '2023-01-10 00:00:00.000000 +00:00', null, '2023-01-10 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('beb74a10-b1ac-48f4-af0d-e9dd7bd684e7', 'dangkiem9502Dadmin', 'admin', 'Lý Thanh Thiện', 'Thiện', 'Lý Thanh',
        '9502D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem9502Dadmin@vr.org.vn',
        '1979-06-20 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '4547004544', '4547004544',
        '2024-02-28 00:00:00.000000 +00:00', null, '2024-02-28 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('41855881-5956-4b32-84af-254fe8a33434', 'dangkiem4704Dkdv', 'staff', 'Nhân viên TTDK 4704D', '4704D',
        'Nhân viên TTDK', '4704D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem4704Dkdv@vr.org.vn', '1977-02-18 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '2052427214',
        '2052427214', '2023-03-18 00:00:00.000000 +00:00', null, '2023-03-18 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('c4ace2b3-e87e-4de2-a2c2-7e56f4a9151e', 'dangkiem3802Dadmin', 'admin', 'Nguyễn Tiến Hùng', 'Hùng',
        'Nguyễn Tiến', '3802D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem3802Dadmin@vr.org.vn', '1984-06-09 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '5725213599',
        '5725213599', '2023-06-13 00:00:00.000000 +00:00', null, '2023-06-13 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('d55bac27-e5d9-4e1c-95cd-5c1815a643ab', 'dangkiem2404Dadmin', 'admin', 'Đỗ Anh Tuấn', 'Tuấn', 'Đỗ Anh', '2404D',
        '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem2404Dadmin@vr.org.vn',
        '1988-09-26 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '5519485042', '5519485042',
        '2023-02-14 00:00:00.000000 +00:00', null, '2023-02-14 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('fb50dc82-e075-477d-aa70-19c3a5ce5284', 'dangkiem1202Dadmin', 'admin', 'Nguyễn Văn Khiêm', 'Khiêm',
        'Nguyễn Văn', '1202D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem1202Dadmin@vr.org.vn', '1971-01-04 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '7585438270',
        '7585438270', '2023-07-16 00:00:00.000000 +00:00', null, '2023-07-16 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('0b5da032-84e4-46b5-a9e8-bfa726c1561b', 'dangkiem2903Skdv', 'staff', 'Nhân viên TTDK 2903S', '2903S',
        'Nhân viên TTDK', '2903S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem2903Skdv@vr.org.vn', '1984-01-21 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '3894275810',
        '3894275810', '2023-11-09 00:00:00.000000 +00:00', null, '2023-11-09 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('631a17b5-f99c-4e74-8047-a0b1756c0628', 'dangkiem3402Dkdv', 'staff', 'Nhân viên TTDK 3402D', '3402D',
        'Nhân viên TTDK', '3402D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem3402Dkdv@vr.org.vn', '1986-12-17 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '6353636989',
        '6353636989', '2023-04-05 00:00:00.000000 +00:00', null, '2023-04-05 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('dad2162d-b1d0-4f5a-bc91-7de0e7118637', 'dangkiem9804Dkdv', 'staff', 'Nhân viên TTDK 9804D', '9804D',
        'Nhân viên TTDK', '9804D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem9804Dkdv@vr.org.vn', '1990-05-12 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '1967889122',
        '1967889122', '2023-08-03 00:00:00.000000 +00:00', null, '2023-08-03 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('7a2aa124-2364-4abe-b814-0fc41f3e5122', 'dangkiem2801Skdv', 'staff', 'Nhân viên TTDK 2801S', '2801S',
        'Nhân viên TTDK', '2801S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem2801Skdv@vr.org.vn', '1972-03-10 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '7286686696',
        '7286686696', '2023-05-08 00:00:00.000000 +00:00', null, '2023-05-08 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('938c4772-4926-4dc0-af6e-6a6db9a0f937', 'dangkiem1507Dkdv', 'staff', 'Nhân viên TTDK 1507D', '1507D',
        'Nhân viên TTDK', '1507D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem1507Dkdv@vr.org.vn', '1985-09-09 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '7038890525',
        '7038890525', '2023-10-26 00:00:00.000000 +00:00', null, '2023-10-26 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('e1af9676-31c5-47d2-961d-290086bb989e', 'dangkiem9701Dadmin', 'admin', 'Vũ Đình Hào', 'Hào', 'Vũ Đình', '9701D',
        '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem9701Dadmin@vr.org.vn',
        '1973-12-07 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '4023978721', '4023978721',
        '2024-01-15 00:00:00.000000 +00:00', null, '2024-01-15 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('598de484-be24-4cae-b4e3-01970b52a8a8', 'dangkiem8102Dkdv', 'staff', 'Nhân viên TTDK 8102D', '8102D',
        'Nhân viên TTDK', '8102D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem8102Dkdv@vr.org.vn', '1988-09-01 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '1671238669',
        '1671238669', '2024-05-07 00:00:00.000000 +00:00', null, '2024-05-07 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('04ba9ca4-29f6-4a32-9f5e-c781ac6f9c5d', 'dangkiem3608Dadmin', 'admin', 'Trịnh Ngọc Tuấn', 'Tuấn', 'Trịnh Ngọc',
        '3608D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem3608Dadmin@vr.org.vn',
        '1982-09-10 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '7213627155', '7213627155',
        '2024-04-17 00:00:00.000000 +00:00', null, '2024-04-17 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('ac9b2cc9-c010-4dcf-b983-dec9e7dbc723', 'dangkiem1905Dkdv', 'staff', 'Nhân viên TTDK 1905D', '1905D',
        'Nhân viên TTDK', '1905D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem1905Dkdv@vr.org.vn', '1986-09-18 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '6413954984',
        '6413954984', '2024-02-15 00:00:00.000000 +00:00', null, '2024-02-15 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('f6a70df8-4c13-4f5e-ac4e-76de6df42ee6', 'dangkiem3708Dkdv', 'staff', 'Nhân viên TTDK 3708D', '3708D',
        'Nhân viên TTDK', '3708D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem3708Dkdv@vr.org.vn', '1981-10-20 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '8342044215',
        '8342044215', '2023-05-10 00:00:00.000000 +00:00', null, '2023-05-10 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('3d2188a0-b3b8-4c24-827b-8bb057fe1432', 'dangkiem2403Dadmin', 'admin', 'Nguyễn Tuấn Vũ', 'Vũ', 'Nguyễn Tuấn',
        '2403D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem2403Dadmin@vr.org.vn',
        '1978-10-06 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '1345208165', '1345208165',
        '2023-07-30 00:00:00.000000 +00:00', null, '2023-07-30 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('63a7b840-2c01-4f7a-b977-1362b29a1e07', 'dangkiem9401Vadmin', 'admin', 'Trần Quốc Thái', 'Thái', 'Trần Quốc',
        '9401V', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem9401Vadmin@vr.org.vn',
        '1976-01-26 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '6003167452', '6003167452',
        '2024-03-13 00:00:00.000000 +00:00', null, '2024-03-13 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('63c9cd64-2370-4e34-8a93-f63f50c34e84', 'dangkiem3701Skdv', 'staff', 'Nhân viên TTDK 3701S', '3701S',
        'Nhân viên TTDK', '3701S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem3701Skdv@vr.org.vn', '1988-01-13 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '2514303142',
        '2514303142', '2023-07-17 00:00:00.000000 +00:00', null, '2023-07-17 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('7e6aec5b-0331-4248-b7f5-53bb30e0fa21', 'dangkiem6004Dkdv', 'staff', 'Nhân viên TTDK 6004D', '6004D',
        'Nhân viên TTDK', '6004D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem6004Dkdv@vr.org.vn', '1971-03-16 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '8665712187',
        '8665712187', '2023-12-16 00:00:00.000000 +00:00', null, '2023-12-16 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('cefac360-a767-4a7b-8b37-3157eafc04be', 'dangkiem6703Dadmin', 'admin', 'Trương Công Khánh Dân', 'Dân',
        'Trương Công Khánh', '6703D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem6703Dadmin@vr.org.vn', '1973-06-14 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '9786606449',
        '9786606449', '2023-04-20 00:00:00.000000 +00:00', null, '2023-04-20 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('160a9e66-e418-4cdd-abd1-fe2941bf1e38', 'dangkiem3404Dadmin', 'admin', 'Trần Văn Ngọc', 'Ngọc', 'Trần Văn',
        '3404D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem3404Dadmin@vr.org.vn',
        '1988-06-14 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '9525027196', '9525027196',
        '2024-02-21 00:00:00.000000 +00:00', null, '2024-02-21 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('0cfbf59c-a54b-42b4-8da5-c147b13ff3d6', 'dangkiem7702Skdv', 'staff', 'Nhân viên TTDK 7702S', '7702S',
        'Nhân viên TTDK', '7702S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem7702Skdv@vr.org.vn', '1982-10-01 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '7864845994',
        '7864845994', '2023-04-29 00:00:00.000000 +00:00', null, '2023-04-29 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('efe22ae8-9b7b-4d01-8314-dbe0a444a8c4', 'dangkiem2101Skdv', 'staff', 'Nhân viên TTDK 2101S', '2101S',
        'Nhân viên TTDK', '2101S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem2101Skdv@vr.org.vn', '1972-03-17 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '2568142052',
        '2568142052', '2023-06-10 00:00:00.000000 +00:00', null, '2023-06-10 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('8da3d368-90ea-4130-8ec8-384bfb61406b', 'dangkiem2701Sadmin', 'admin', 'Nguyễn Đình Tân', 'Tân', 'Nguyễn Đình',
        '2701S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem2701Sadmin@vr.org.vn',
        '1983-03-17 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '1111122357', '1111122357',
        '2023-01-28 00:00:00.000000 +00:00', null, '2023-01-28 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('f6eb9a3b-2c86-47b4-b1e9-6cca1cec2336', 'dangkiem9807Dadmin', 'admin', 'Lê Trọng Hưng', 'Hưng', 'Lê Trọng',
        '9807D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem9807Dadmin@vr.org.vn',
        '1983-07-01 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '4046858087', '4046858087',
        '2023-03-30 00:00:00.000000 +00:00', null, '2023-03-30 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('a245871e-8612-40d9-9af8-5d610e7b85e9', 'dangkiem7402Sadmin', 'admin', 'PGĐ. Trần Việt Hùng', 'Hùng',
        'PGĐ. Trần Việt', '7402S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem7402Sadmin@vr.org.vn', '1983-07-21 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '2976888282',
        '2976888282', '2023-05-31 00:00:00.000000 +00:00', null, '2023-05-31 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('3730a161-f3f4-4db1-b34c-900cb5b14d91', 'dangkiem2301Skdv', 'staff', 'Nhân viên TTDK 2301S', '2301S',
        'Nhân viên TTDK', '2301S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem2301Skdv@vr.org.vn', '1982-12-20 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '3398923851',
        '3398923851', '2023-06-23 00:00:00.000000 +00:00', null, '2023-06-23 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('dc0cba49-3c69-40e6-82f6-87218fbc7ede', 'dangkiem1402Dadmin', 'admin', 'Nguyễn Văn Khiêm', 'Khiêm',
        'Nguyễn Văn', '1402D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem1402Dadmin@vr.org.vn', '1973-12-21 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '3799155003',
        '3799155003', '2024-05-18 00:00:00.000000 +00:00', null, '2024-05-18 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('5e56d91e-8a33-4519-bf05-e2480da7b3d2', 'dangkiem2917Dadmin', 'admin', 'Nguyễn Tiến Thôn', 'Thôn',
        'Nguyễn Tiến', '2917D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem2917Dadmin@vr.org.vn', '1972-01-17 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '1072807799',
        '1072807799', '2023-11-06 00:00:00.000000 +00:00', null, '2023-11-06 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('1808c069-abc8-4d5f-9d7c-c87e0f5e4b9c', 'dangkiem6501Sadmin', 'admin', 'Lê Thuận Bé', 'Bé', 'Lê Thuận', '6501S',
        '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem6501Sadmin@vr.org.vn',
        '1985-06-25 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '6004770525', '6004770525',
        '2023-01-12 00:00:00.000000 +00:00', null, '2023-01-12 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('d1ebe592-1fcc-4202-a2a4-a61c7b5b3aad', 'dangkiem2907Dkdv', 'staff', 'Nhân viên TTDK 2907D', '2907D',
        'Nhân viên TTDK', '2907D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem2907Dkdv@vr.org.vn', '1989-07-23 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '8301414022',
        '8301414022', '2023-10-30 00:00:00.000000 +00:00', null, '2023-10-30 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('4a9310a8-6779-4966-99e8-a91cd34c433a', 'dangkiem2912Dadmin', 'admin', 'Nguyễn Văn Thụy', 'Thụy', 'Nguyễn Văn',
        '2912D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem2912Dadmin@vr.org.vn',
        '1979-06-29 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '7810199255', '7810199255',
        '2023-04-12 00:00:00.000000 +00:00', null, '2023-04-12 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('2118e9f5-38eb-4e79-8afb-3ac0492826cf', 'dangkiem7003Dadmin', 'admin', 'Ngô Anh Tuấn', 'Tuấn', 'Ngô Anh',
        '7003D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem7003Dadmin@vr.org.vn',
        '1985-08-31 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '7491438587', '7491438587',
        '2023-01-23 00:00:00.000000 +00:00', null, '2023-01-23 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('cdea003c-3606-4595-8e3d-1e8c9c2d290d', 'dangkiem9304Dadmin', 'admin', 'Nguyễn Văn Thúy', 'Thúy', 'Nguyễn Văn',
        '9304D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem9304Dadmin@vr.org.vn',
        '1985-08-01 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '8117433972', '8117433972',
        '2023-11-14 00:00:00.000000 +00:00', null, '2023-11-14 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('0383bf77-12a8-460e-9f6d-ba27cdfd4a04', 'dangkiem3504Dadmin', 'admin', 'Phan Đình Chiều', 'Chiều', 'Phan Đình',
        '3504D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem3504Dadmin@vr.org.vn',
        '1985-12-17 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '6212657892', '6212657892',
        '2024-01-16 00:00:00.000000 +00:00', null, '2024-01-16 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('aa7b5ccd-e1a7-4210-8efd-6fedf2f2737e', 'dangkiem7303Dadmin', 'admin', 'Trần Lê Trung', 'Trung', 'Trần Lê',
        '7303D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem7303Dadmin@vr.org.vn',
        '1976-08-10 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '8711501041', '8711501041',
        '2023-11-20 00:00:00.000000 +00:00', null, '2023-11-20 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('22d724d4-d2df-4357-a718-49c0be347208', 'dangkiem2914Dadmin', 'admin', 'Nguyễn Quang Đức', 'Đức',
        'Nguyễn Quang', '2914D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem2914Dadmin@vr.org.vn', '1984-03-26 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '7880426922',
        '7880426922', '2023-09-03 00:00:00.000000 +00:00', null, '2023-09-03 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('205db77b-536e-4f45-88ff-8b58944700df', 'dangkiem9501Skdv', 'staff', 'Nhân viên TTDK 9501S', '9501S',
        'Nhân viên TTDK', '9501S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem9501Skdv@vr.org.vn', '1973-06-08 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '9577861387',
        '9577861387', '2023-05-25 00:00:00.000000 +00:00', null, '2023-05-25 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('2298b86a-8b80-4801-80c3-eca3c82afa7b', 'dangkiem2004Dkdv', 'staff', 'Nhân viên TTDK 2004D', '2004D',
        'Nhân viên TTDK', '2004D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem2004Dkdv@vr.org.vn', '1980-04-23 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '3742063291',
        '3742063291', '2024-02-19 00:00:00.000000 +00:00', null, '2024-02-19 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('4ddcdd68-31dc-4fe9-9d93-8aa514b57eea', 'dangkiem7301Skdv', 'staff', 'Nhân viên TTDK 7301S', '7301S',
        'Nhân viên TTDK', '7301S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem7301Skdv@vr.org.vn', '1971-12-22 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '9295739291',
        '9295739291', '2023-10-23 00:00:00.000000 +00:00', null, '2023-10-23 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('c034d58d-9757-42fc-97ef-987a343e6185', 'dangkiem7703Dkdv', 'staff', 'Nhân viên TTDK 7703D', '7703D',
        'Nhân viên TTDK', '7703D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem7703Dkdv@vr.org.vn', '1983-12-25 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '6155823417',
        '6155823417', '2024-02-06 00:00:00.000000 +00:00', null, '2024-02-06 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('a58503dc-0140-4d4e-9aa7-1cd4044fee95', 'dangkiem7704Dkdv', 'staff', 'Nhân viên TTDK 7704D', '7704D',
        'Nhân viên TTDK', '7704D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem7704Dkdv@vr.org.vn', '1988-04-01 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '7256246430',
        '7256246430', '2023-04-07 00:00:00.000000 +00:00', null, '2023-04-07 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('cf51688e-7033-49b2-a602-2aaf45d68e40', 'dangkiem8803Dadmin', 'admin', 'Đào Công Khanh', 'Khanh', 'Đào Công',
        '8803D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem8803Dadmin@vr.org.vn',
        '1988-01-01 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '6456065356', '6456065356',
        '2023-02-20 00:00:00.000000 +00:00', null, '2023-02-20 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('f9cd3b3d-48e0-48f5-8e65-c85ef165cc20', 'dangkiem8103Dadmin', 'admin', 'VŨ VĂN TIÊN', 'TIÊN', 'VŨ VĂN', '8103D',
        '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem8103Dadmin@vr.org.vn',
        '1979-01-14 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '6971493455', '6971493455',
        '2023-09-02 00:00:00.000000 +00:00', null, '2023-09-02 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('2031d2e4-e6f1-451b-825e-d3e06dd666e7', 'dangkiem7702Sadmin', 'admin', 'Phạm Đại Lâm', 'Lâm', 'Phạm Đại',
        '7702S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem7702Sadmin@vr.org.vn',
        '1982-09-10 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '2688747154', '2688747154',
        '2023-07-18 00:00:00.000000 +00:00', null, '2023-07-18 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('a7d1f748-4eaa-4a25-a57c-e75cbc64413c', 'dangkiem6102Sadmin', 'admin', 'Lâm Sơn Hà', 'Hà', 'Lâm Sơn', '6102S',
        '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem6102Sadmin@vr.org.vn',
        '1974-05-02 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '1483251053', '1483251053',
        '2023-10-06 00:00:00.000000 +00:00', null, '2023-10-06 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('ca93448e-7c98-4e5f-928a-8f382b5fb439', 'dangkiem9806Dkdv', 'staff', 'Nhân viên TTDK 9806D', '9806D',
        'Nhân viên TTDK', '9806D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem9806Dkdv@vr.org.vn', '1990-09-24 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '7372547588',
        '7372547588', '2023-01-25 00:00:00.000000 +00:00', null, '2023-01-25 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('0bcbabf0-8906-46ce-bb21-aab00ad790ab', 'dangkiem1101Skdv', 'staff', 'Nhân viên TTDK 1101S', '1101S',
        'Nhân viên TTDK', '1101S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem1101Skdv@vr.org.vn', '1975-02-18 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '5058802269',
        '5058802269', '2023-03-21 00:00:00.000000 +00:00', null, '2023-03-21 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('ae6d5968-ad5a-4471-a549-11c684338a8f', 'dangkiem6001Sadmin', 'admin', 'Trần Minh Lợi', 'Lợi', 'Trần Minh',
        '6001S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem6001Sadmin@vr.org.vn',
        '1980-02-17 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '9883313172', '9883313172',
        '2024-03-29 00:00:00.000000 +00:00', null, '2024-03-29 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('f1f7f5be-620e-4e44-9e82-65c1af8f1ad0', 'dangkiem7302Dkdv', 'staff', 'Nhân viên TTDK 7302D', '7302D',
        'Nhân viên TTDK', '7302D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem7302Dkdv@vr.org.vn', '1980-09-30 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '9523224596',
        '9523224596', '2024-03-18 00:00:00.000000 +00:00', null, '2024-03-18 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('c1404620-c697-4f73-93f7-c95dbf0587cc', 'dangkiem1801Skdv', 'staff', 'Nhân viên TTDK 1801S', '1801S',
        'Nhân viên TTDK', '1801S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem1801Skdv@vr.org.vn', '1980-08-12 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '1062443301',
        '1062443301', '2024-03-09 00:00:00.000000 +00:00', null, '2024-03-09 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('9ba386f7-94a4-431e-9678-19d21fd41232', 'dangkiem7602Dadmin', 'admin', 'Nguyễn Thanh Chung', 'Chung',
        'Nguyễn Thanh', '7602D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem7602Dadmin@vr.org.vn', '1975-06-29 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '2105413350',
        '2105413350', '2023-07-25 00:00:00.000000 +00:00', null, '2023-07-25 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('b303e52f-1d15-4a0b-9b0f-b8432e0db157', 'dangkiem1802Sadmin', 'admin', 'Nguyễn Đình Phong', 'Phong',
        'Nguyễn Đình', '1802S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem1802Sadmin@vr.org.vn', '1980-06-21 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '3451419631',
        '3451419631', '2023-03-08 00:00:00.000000 +00:00', null, '2023-03-08 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('7da69bdd-2a44-498d-98c1-aa65fc7f663f', 'dangkiem1905Dadmin', 'admin', 'Nguyễn Thị Mỹ Ngân', 'Ngân',
        'Nguyễn Thị Mỹ', '1905D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem1905Dadmin@vr.org.vn', '1979-09-28 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '8807204747',
        '8807204747', '2023-08-30 00:00:00.000000 +00:00', null, '2023-08-30 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('786a7c86-dbad-49f1-a5ed-ebccbd5b7492', 'dangkiem4801Dkdv', 'staff', 'Nhân viên TTDK 4801D', '4801D',
        'Nhân viên TTDK', '4801D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem4801Dkdv@vr.org.vn', '1974-09-24 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '2828072458',
        '2828072458', '2023-11-22 00:00:00.000000 +00:00', null, '2023-11-22 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('aa1f438a-9fb2-4a7c-b894-66c95f23a365', 'dangkiem1901Vkdv', 'staff', 'Nhân viên TTDK 1901V', '1901V',
        'Nhân viên TTDK', '1901V', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem1901Vkdv@vr.org.vn', '1979-10-18 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '3435765540',
        '3435765540', '2023-11-19 00:00:00.000000 +00:00', null, '2023-11-19 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('8781a76b-580f-4909-a9f3-b403a4b72c67', 'dangkiem2906Vadmin', 'admin', 'Vi Hồng Huy', 'Huy', 'Vi Hồng', '2906V',
        '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem2906Vadmin@vr.org.vn',
        '1974-07-08 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '4567856782', '4567856782',
        '2023-08-01 00:00:00.000000 +00:00', null, '2023-08-01 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('3f678b5b-026c-4fdf-b0bd-0d7da2c18a9d', 'dangkiem1702Dadmin', 'admin', 'Lê Ngọc Minh', 'Minh', 'Lê Ngọc',
        '1702D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem1702Dadmin@vr.org.vn',
        '1985-04-02 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '5141160174', '5141160174',
        '2024-04-01 00:00:00.000000 +00:00', null, '2024-04-01 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('5b679058-805b-40dc-a522-0a6a087794f9', 'dangkiem9904Dkdv', 'staff', 'Nhân viên TTDK 9904D', '9904D',
        'Nhân viên TTDK', '9904D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem9904Dkdv@vr.org.vn', '1989-07-29 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '7590979593',
        '7590979593', '2023-12-22 00:00:00.000000 +00:00', null, '2023-12-22 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('f1574a00-7f64-4086-bf53-c05643351509', 'dangkiem9302Dkdv', 'staff', 'Nhân viên TTDK 9302D', '9302D',
        'Nhân viên TTDK', '9302D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem9302Dkdv@vr.org.vn', '1983-10-07 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '8315007780',
        '8315007780', '2023-04-06 00:00:00.000000 +00:00', null, '2023-04-06 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('7b0b5260-eafe-433a-9daa-a43fb001b07f', 'dangkiem7705Dkdv', 'staff', 'Nhân viên TTDK 7705D', '7705D',
        'Nhân viên TTDK', '7705D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem7705Dkdv@vr.org.vn', '1984-08-18 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '6547511769',
        '6547511769', '2023-11-01 00:00:00.000000 +00:00', null, '2023-11-01 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('17c6077f-cbab-4088-b781-c5f9d077c1ff', 'dangkiem9302Dadmin', 'admin', 'Nguyễn Thanh Tùng', 'Tùng',
        'Nguyễn Thanh', '9302D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem9302Dadmin@vr.org.vn', '1977-02-06 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '7272841153',
        '7272841153', '2024-04-29 00:00:00.000000 +00:00', null, '2024-04-29 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('ef66a288-a376-40d4-81a2-8d94fbeafdfc', 'dangkiem2001Sadmin', 'admin', 'Vũ Hồng Quân', 'Quân', 'Vũ Hồng',
        '2001S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem2001Sadmin@vr.org.vn',
        '1979-02-02 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '2888364497', '2888364497',
        '2024-05-06 00:00:00.000000 +00:00', null, '2024-05-06 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('1bfe2584-e480-48e3-bae2-61a45b7302b9', 'dangkiem3804Dkdv', 'staff', 'Nhân viên TTDK 3804D', '3804D',
        'Nhân viên TTDK', '3804D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem3804Dkdv@vr.org.vn', '1976-04-13 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '4270107706',
        '4270107706', '2024-03-30 00:00:00.000000 +00:00', null, '2024-03-30 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('65177e7f-ed50-4fda-a8a1-03f4303dd06d', 'dangkiem9001Sadmin', 'admin', 'Nguyễn Văn Cam', 'Cam', 'Nguyễn Văn',
        '9001S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem9001Sadmin@vr.org.vn',
        '1974-04-19 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '4868175164', '4868175164',
        '2024-03-15 00:00:00.000000 +00:00', null, '2024-03-15 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('16f9c339-b32b-4245-9f17-e2c97a568b0d', 'dangkiem6503Dkdv', 'staff', 'Nhân viên TTDK 6503D', '6503D',
        'Nhân viên TTDK', '6503D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem6503Dkdv@vr.org.vn', '1984-01-13 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '2703859538',
        '2703859538', '2023-07-07 00:00:00.000000 +00:00', null, '2023-07-07 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('3ce481cd-c4aa-4bf3-8554-407b7cc3c711', 'dangkiem9303Dadmin', 'admin', 'Nguyễn Văn Tuyên', 'Tuyên',
        'Nguyễn Văn', '9303D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem9303Dadmin@vr.org.vn', '1988-11-16 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '3310876013',
        '3310876013', '2023-08-12 00:00:00.000000 +00:00', null, '2023-08-12 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('39239176-4391-44fb-9265-9a35c0395b7e', 'dangkiem9503Dadmin', 'admin', 'QUÁCH VĂN THUẤN', 'THUẤN', 'QUÁCH VĂN',
        '9503D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem9503Dadmin@vr.org.vn',
        '1979-09-22 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '2185328066', '2185328066',
        '2023-10-10 00:00:00.000000 +00:00', null, '2023-10-10 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('72970004-0c6c-483c-9e54-aacddf5834ca', 'dangkiem2006Dkdv', 'staff', 'Nhân viên TTDK 2006D', '2006D',
        'Nhân viên TTDK', '2006D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem2006Dkdv@vr.org.vn', '1985-09-19 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '4642304963',
        '4642304963', '2023-10-28 00:00:00.000000 +00:00', null, '2023-10-28 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('40070de1-12ad-45f5-85f4-a2aab49bb59d', 'dangkiem1701Dkdv', 'staff', 'Nhân viên TTDK 1701D', '1701D',
        'Nhân viên TTDK', '1701D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem1701Dkdv@vr.org.vn', '1983-06-28 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '6958422551',
        '6958422551', '2024-01-23 00:00:00.000000 +00:00', null, '2024-01-23 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('a0105b72-4ad6-42a2-88ed-b93b7dec13b1', 'dangkiem2602Dadmin', 'admin', 'Phạm Tuấn Anh', 'Anh', 'Phạm Tuấn',
        '2602D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem2602Dadmin@vr.org.vn',
        '1988-11-09 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '7668802824', '7668802824',
        '2023-09-23 00:00:00.000000 +00:00', null, '2023-09-23 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('73e079fd-0bd6-4823-a032-cf76a44da8da', 'dangkiem6110Dkdv', 'staff', 'Nhân viên TTDK 6110D', '6110D',
        'Nhân viên TTDK', '6110D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem6110Dkdv@vr.org.vn', '1974-06-06 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '9908834652',
        '9908834652', '2024-02-26 00:00:00.000000 +00:00', null, '2024-02-26 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('3903bdb3-718a-4ba4-a7d9-db81c32a744d', 'dangkiem9401Vkdv', 'staff', 'Nhân viên TTDK 9401V', '9401V',
        'Nhân viên TTDK', '9401V', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem9401Vkdv@vr.org.vn', '1971-04-05 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '9046499468',
        '9046499468', '2023-05-23 00:00:00.000000 +00:00', null, '2023-05-23 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('49f97628-4ae9-4ff3-b3b8-25ddeabc88b3', 'dangkiem1802Dkdv', 'staff', 'Nhân viên TTDK 1802D', '1802D',
        'Nhân viên TTDK', '1802D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem1802Dkdv@vr.org.vn', '1989-01-04 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '4988510735',
        '4988510735', '2023-03-28 00:00:00.000000 +00:00', null, '2023-03-28 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('d74d8943-b895-4782-b709-d74b14aa5f64', 'dangkiem7601Sadmin', 'admin', 'Nguyễn Thanh Mẫn', 'Mẫn',
        'Nguyễn Thanh', '7601S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem7601Sadmin@vr.org.vn', '1981-05-08 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '5588863464',
        '5588863464', '2023-03-29 00:00:00.000000 +00:00', null, '2023-03-29 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('918eed6a-c704-472e-a24e-7f486cf610e0', 'dangkiem6504Dadmin', 'admin', 'Nguyễn Văn Hùng', 'Hùng', 'Nguyễn Văn',
        '6504D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem6504Dadmin@vr.org.vn',
        '1972-03-16 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '7721542800', '7721542800',
        '2023-09-20 00:00:00.000000 +00:00', null, '2023-09-20 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('d92c9f2a-b066-47b0-a61b-f4ae90191858', 'dangkiem3706Dadmin', 'admin', 'Trần Thành Vinh', 'Vinh', 'Trần Thành',
        '3706D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem3706Dadmin@vr.org.vn',
        '1980-01-30 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '8937531029', '8937531029',
        '2023-08-29 00:00:00.000000 +00:00', null, '2023-08-29 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('7b30c74f-5499-4881-8f88-c80203d8207b', 'dangkiem1803Dadmin', 'admin', 'Trần Việt Hoài', 'Hoài', 'Trần Việt',
        '1803D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem1803Dadmin@vr.org.vn',
        '1973-12-30 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '9931524042', '9931524042',
        '2023-10-12 00:00:00.000000 +00:00', null, '2023-10-12 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('f61920fa-ba58-49b1-93e6-efdb606f801b', 'dangkiem2005Dadmin', 'admin', 'Thái Đức Tâm', 'Tâm', 'Thái Đức',
        '2005D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem2005Dadmin@vr.org.vn',
        '1979-03-28 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '6268528425', '6268528425',
        '2024-03-25 00:00:00.000000 +00:00', null, '2024-03-25 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('c087f30e-b03d-46da-af05-bcc1623a6e3a', 'dangkiem3610Dadmin', 'admin', 'Trần Văn Hùng', 'Hùng', 'Trần Văn',
        '3610D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem3610Dadmin@vr.org.vn',
        '1973-04-25 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '6072076474', '6072076474',
        '2023-05-30 00:00:00.000000 +00:00', null, '2023-05-30 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('f28bc5ce-302e-4b8a-8a94-f9b6bdb6be27', 'dangkiem8104Dadmin', 'admin', 'Đào Xuân Cảnh', 'Cảnh', 'Đào Xuân',
        '8104D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem8104Dadmin@vr.org.vn',
        '1988-10-10 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '4480989248', '4480989248',
        '2023-10-29 00:00:00.000000 +00:00', null, '2023-10-29 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('bca0ec63-607c-4283-8605-a91eb19ab385', 'dangkiem4304Dkdv', 'staff', 'Nhân viên TTDK 4304D', '4304D',
        'Nhân viên TTDK', '4304D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem4304Dkdv@vr.org.vn', '1977-06-04 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '2761327929',
        '2761327929', '2023-06-05 00:00:00.000000 +00:00', null, '2023-06-05 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('4a53a9aa-6792-4f39-bf0c-782b35c51818', 'dangkiem1405Dkdv', 'staff', 'Nhân viên TTDK 1405D', '1405D',
        'Nhân viên TTDK', '1405D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem1405Dkdv@vr.org.vn', '1972-02-24 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '8056734491',
        '8056734491', '2023-05-06 00:00:00.000000 +00:00', null, '2023-05-06 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('a1f501fd-548f-4b2e-9c3a-bd5ade2980e6', 'dangkiem3501Dadmin', 'admin', 'Nguyễn Trung Thao', 'Thao',
        'Nguyễn Trung', '3501D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem3501Dadmin@vr.org.vn', '1982-05-20 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '9138181436',
        '9138181436', '2024-02-04 00:00:00.000000 +00:00', null, '2024-02-04 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('f302e031-0485-4e3d-a464-eaf014f23418', 'dangkiem2401Dkdv', 'staff', 'Nhân viên TTDK 2401D', '2401D',
        'Nhân viên TTDK', '2401D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem2401Dkdv@vr.org.vn', '1978-04-15 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '3353299990',
        '3353299990', '2023-10-27 00:00:00.000000 +00:00', null, '2023-10-27 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('71287c50-346f-4cd8-9202-ee619a204eb0', 'dangkiem2102Dadmin', 'admin', 'Nguyễn Thanh Tú', 'Tú', 'Nguyễn Thanh',
        '2102D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem2102Dadmin@vr.org.vn',
        '1972-05-28 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '6277884346', '6277884346',
        '2023-06-25 00:00:00.000000 +00:00', null, '2023-06-25 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('05090ffa-3ef4-4d5b-a768-d86bc2461fd1', 'dangkiem3407Dkdv', 'staff', 'Nhân viên TTDK 3407D', '3407D',
        'Nhân viên TTDK', '3407D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem3407Dkdv@vr.org.vn', '1976-01-19 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '4203169860',
        '4203169860', '2024-03-11 00:00:00.000000 +00:00', null, '2024-03-11 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('00c47295-24c3-42a0-bf68-10514762b1d8', 'dangkiem6301Sadmin', 'admin', 'Nguyễn Văn Hiệp', 'Hiệp', 'Nguyễn Văn',
        '6301S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem6301Sadmin@vr.org.vn',
        '1989-05-02 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '6160350190', '6160350190',
        '2023-09-11 00:00:00.000000 +00:00', null, '2023-09-11 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('767ac9b1-bbbf-45a7-9e0c-d113e5b2d58a', 'dangkiem9801Sadmin', 'admin', 'Vũ Văn Công', 'Công', 'Vũ Văn', '9801S',
        '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem9801Sadmin@vr.org.vn',
        '1980-07-22 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '6598836439', '6598836439',
        '2023-11-02 00:00:00.000000 +00:00', null, '2023-11-02 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('454a8496-288b-486a-9273-af1c93678c3f', 'dangkiem3801Dadmin', 'admin', 'Võ Ngọc Sơn', 'Sơn', 'Võ Ngọc', '3801D',
        '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem3801Dadmin@vr.org.vn',
        '1988-01-24 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '7687791821', '7687791821',
        '2023-09-25 00:00:00.000000 +00:00', null, '2023-09-25 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('0e8835cb-1602-4269-be4f-a2d3f86f195e', 'dangkiem6502Dadmin', 'admin', 'PGĐ. Phạm Minh Nhựt', 'Nhựt',
        'PGĐ. Phạm Minh', '6502D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem6502Dadmin@vr.org.vn', '1976-04-09 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '9780422186',
        '9780422186', '2023-06-24 00:00:00.000000 +00:00', null, '2023-06-24 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('ac6568a9-6742-4f99-8332-d152f273019f', 'dangkiem6101Sadmin', 'admin', 'Lâm Sơn Hà', 'Hà', 'Lâm Sơn', '6101S',
        '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem6101Sadmin@vr.org.vn',
        '1986-05-23 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '9289823979', '9289823979',
        '2023-04-25 00:00:00.000000 +00:00', null, '2023-04-25 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('34c6780e-97c2-4a2e-ae7a-b7dd08567efc', 'dangkiem2916Dkdv', 'staff', 'Nhân viên TTDK 2916D', '2916D',
        'Nhân viên TTDK', '2916D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem2916Dkdv@vr.org.vn', '1982-09-22 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '6840150082',
        '6840150082', '2023-04-24 00:00:00.000000 +00:00', null, '2023-04-24 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('175c04be-eae6-492a-989d-2eebc2c47b8b', 'dangkiem8906Dkdv', 'staff', 'Nhân viên TTDK 8906D', '8906D',
        'Nhân viên TTDK', '8906D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem8906Dkdv@vr.org.vn', '1971-05-05 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '8814786484',
        '8814786484', '2023-04-08 00:00:00.000000 +00:00', null, '2023-04-08 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('2a528826-a83d-441e-b76a-5f2df81a73e4', 'dangkiem6105Dkdv', 'staff', 'Nhân viên TTDK 6105D', '6105D',
        'Nhân viên TTDK', '6105D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem6105Dkdv@vr.org.vn', '1975-09-12 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '9024776320',
        '9024776320', '2023-10-20 00:00:00.000000 +00:00', null, '2023-10-20 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('3e7595ae-54d2-4ead-a17e-e6c62fb4834e', 'dangkiem1908Dkdv', 'staff', 'Nhân viên TTDK 1908D', '1908D',
        'Nhân viên TTDK', '1908D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem1908Dkdv@vr.org.vn', '1987-06-14 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '9593699238',
        '9593699238', '2023-11-27 00:00:00.000000 +00:00', null, '2023-11-27 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('82d9dc17-2954-40de-8800-211353956a2a', 'dangkiem9206Dkdv', 'staff', 'Nhân viên TTDK 9206D', '9206D',
        'Nhân viên TTDK', '9206D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem9206Dkdv@vr.org.vn', '1971-01-12 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '3900302839',
        '3900302839', '2023-06-30 00:00:00.000000 +00:00', null, '2023-06-30 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('29e13659-7af4-4e59-97cf-1a267dc33c0b', 'dangkiem2004Dadmin', 'admin', 'Vũ Đình Hào', 'Hào', 'Vũ Đình', '2004D',
        '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem2004Dadmin@vr.org.vn',
        '1986-05-13 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '9721503881', '9721503881',
        '2023-10-25 00:00:00.000000 +00:00', null, '2023-10-25 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('402f1894-de56-4431-927b-cb22e602edbe', 'dangkiem2911Dadmin', 'admin', 'Bùi Minh Kiên', 'Kiên', 'Bùi Minh',
        '2911D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem2911Dadmin@vr.org.vn',
        '1988-04-11 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '4422550303', '4422550303',
        '2023-01-22 00:00:00.000000 +00:00', null, '2023-01-22 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('953d2874-a6ab-4aae-bffc-b9b057bc9f53', 'dangkiem3709Dadmin', 'admin', 'Ngô Xuân Sơn', 'Sơn', 'Ngô Xuân',
        '3709D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem3709Dadmin@vr.org.vn',
        '1984-06-01 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '3336784464', '3336784464',
        '2024-01-02 00:00:00.000000 +00:00', null, '2024-01-02 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('629de141-81af-4c4d-8f7b-76cfc077dd84', 'dangkiem8602Dadmin', 'admin', 'Nguyễn Đình Nhựt', 'Nhựt',
        'Nguyễn Đình', '8602D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem8602Dadmin@vr.org.vn', '1982-04-02 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '7598907875',
        '7598907875', '2023-04-30 00:00:00.000000 +00:00', null, '2023-04-30 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('eb1663fd-fcaf-41da-874c-bcd96503bea2', 'dangkiem2901Vkdv', 'staff', 'Nhân viên TTDK 2901V', '2901V',
        'Nhân viên TTDK', '2901V', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem2901Vkdv@vr.org.vn', '1978-06-03 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '4812649047',
        '4812649047', '2023-08-31 00:00:00.000000 +00:00', null, '2023-08-31 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('995cfeba-7029-40ca-b93f-2db8d8fd6e15', 'dangkiem3708Dadmin', 'admin', 'Trần Anh Phong', 'Phong', 'Trần Anh',
        '3708D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem3708Dadmin@vr.org.vn',
        '1975-05-01 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '1670371789', '1670371789',
        '2024-01-21 00:00:00.000000 +00:00', null, '2024-01-21 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('27baa4a9-dcb1-4b34-b5ef-912f93dfd04f', 'dangkiem2009Dkdv', 'staff', 'Nhân viên TTDK 2009D', '2009D',
        'Nhân viên TTDK', '2009D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem2009Dkdv@vr.org.vn', '1972-10-15 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '5340721328',
        '5340721328', '2024-03-19 00:00:00.000000 +00:00', null, '2024-03-19 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('82481fb9-da33-413a-8483-411cf970456a', 'dangkiem2901Sadmin', 'admin', 'Phạm Hồng Thắng', 'Thắng', 'Phạm Hồng',
        '2901S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem2901Sadmin@vr.org.vn',
        '1972-09-26 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '7258535700', '7258535700',
        '2023-07-26 00:00:00.000000 +00:00', null, '2023-07-26 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('c939db71-ceeb-424a-81b5-6817f2e855f1', 'dangkiem9301Sadmin', 'admin', 'Nguyễn Thanh Giang', 'Giang',
        'Nguyễn Thanh', '9301S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem9301Sadmin@vr.org.vn', '1973-09-21 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '1686193856',
        '1686193856', '2024-02-12 00:00:00.000000 +00:00', null, '2024-02-12 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('fa9e0581-8105-4b16-9386-935733e24977', 'dangkiem8501Skdv', 'staff', 'Nhân viên TTDK 8501S', '8501S',
        'Nhân viên TTDK', '8501S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem8501Skdv@vr.org.vn', '1973-10-06 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '1396250958',
        '1396250958', '2023-03-11 00:00:00.000000 +00:00', null, '2023-03-11 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('a389c9d7-1ea7-4ad0-91e8-27a2cd0cc4a9', 'dangkiem2501Skdv', 'staff', 'Nhân viên TTDK 2501S', '2501S',
        'Nhân viên TTDK', '2501S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem2501Skdv@vr.org.vn', '1973-07-29 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '5946394230',
        '5946394230', '2024-02-07 00:00:00.000000 +00:00', null, '2024-02-07 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('59f08754-bf21-4b36-97c1-4a4bb456088b', 'dangkiem1501Vadmin', 'admin', 'Trần Thái Phong', 'Phong', 'Trần Thái',
        '1501V', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem1501Vadmin@vr.org.vn',
        '1970-12-10 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '3078802297', '3078802297',
        '2024-01-28 00:00:00.000000 +00:00', null, '2024-01-28 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('bd47baa8-b922-42f9-a2ce-6757dfdd7f3f', 'dangkiem6701Skdv', 'staff', 'Nhân viên TTDK 6701S', '6701S',
        'Nhân viên TTDK', '6701S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem6701Skdv@vr.org.vn', '1979-04-02 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '6195508740',
        '6195508740', '2023-05-15 00:00:00.000000 +00:00', null, '2023-05-15 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('43aed616-2a3c-46f4-8333-357dccf90b20', 'dangkiem2501Sadmin', 'admin', 'Nguyễn Trung Thọ', 'Thọ',
        'Nguyễn Trung', '2501S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem2501Sadmin@vr.org.vn', '1986-02-03 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '9797570545',
        '9797570545', '2023-05-24 00:00:00.000000 +00:00', null, '2023-05-24 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('e00a7240-2977-49c2-9b99-11c43969e399', 'dangkiem2602Dkdv', 'staff', 'Nhân viên TTDK 2602D', '2602D',
        'Nhân viên TTDK', '2602D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem2602Dkdv@vr.org.vn', '1983-01-15 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '7617918151',
        '7617918151', '2023-01-17 00:00:00.000000 +00:00', null, '2023-01-17 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('5931ca85-7be2-4a63-8366-8ec50a509722', 'dangkiem7801Sadmin', 'admin', 'PHAN TIÊN VIÊN', 'VIÊN', 'PHAN TIÊN',
        '7801S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem7801Sadmin@vr.org.vn',
        '1976-09-04 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '3200552084', '3200552084',
        '2023-07-02 00:00:00.000000 +00:00', null, '2023-07-02 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('22874b5e-2db0-41cf-a78e-e6151bc48b2f', 'dangkiem7302Dadmin', 'admin', 'Đặng Thành Chung', 'Chung',
        'Đặng Thành', '7302D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem7302Dadmin@vr.org.vn', '1975-11-23 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '4794374379',
        '4794374379', '2023-01-18 00:00:00.000000 +00:00', null, '2023-01-18 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('d0739679-d9eb-4861-8c0a-1d95bec7e920', 'dangkiem1401Dkdv', 'staff', 'Nhân viên TTDK 1401D', '1401D',
        'Nhân viên TTDK', '1401D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem1401Dkdv@vr.org.vn', '1982-03-21 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '6711018039',
        '6711018039', '2023-08-24 00:00:00.000000 +00:00', null, '2023-08-24 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('ac314b0e-c535-4159-9b53-f39982a1662a', 'dangkiem9903Dkdv', 'staff', 'Nhân viên TTDK 9903D', '9903D',
        'Nhân viên TTDK', '9903D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem9903Dkdv@vr.org.vn', '1985-03-28 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '6489657037',
        '6489657037', '2023-10-11 00:00:00.000000 +00:00', null, '2023-10-11 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('708df9b9-4ae1-4a27-94a4-82a68b144549', 'dangkiem6105Dadmin', 'admin', 'Nguyễn Duy Khương', 'Khương',
        'Nguyễn Duy', '6105D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem6105Dadmin@vr.org.vn', '1989-11-21 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '3829770246',
        '3829770246', '2024-05-01 00:00:00.000000 +00:00', null, '2024-05-01 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('5637f6f2-8731-4368-8508-815261b6ba88', 'dangkiem3604Dkdv', 'staff', 'Nhân viên TTDK 3604D', '3604D',
        'Nhân viên TTDK', '3604D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem3604Dkdv@vr.org.vn', '1987-11-09 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '7652711496',
        '7652711496', '2023-12-10 00:00:00.000000 +00:00', null, '2023-12-10 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('c9bc180b-553c-42f4-9913-36aa995f00f8', 'dangkiem1407Dadmin', 'admin', 'Vũ Minh Đạt', 'Đạt', 'Vũ Minh', '1407D',
        '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem1407Dadmin@vr.org.vn',
        '1978-09-18 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '9392212508', '9392212508',
        '2023-12-13 00:00:00.000000 +00:00', null, '2023-12-13 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('13416ab0-a5a1-4ceb-b140-4e6dc0cbd4ec', 'dangkiem6003Skdv', 'staff', 'Nhân viên TTDK 6003S', '6003S',
        'Nhân viên TTDK', '6003S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem6003Skdv@vr.org.vn', '1985-07-10 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '9887488113',
        '9887488113', '2023-12-17 00:00:00.000000 +00:00', null, '2023-12-17 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('163c7228-c931-4622-a30a-0c5eaef5bcd3', 'dangkiem1403Dadmin', 'admin', 'Phạm Văn Hoan', 'Hoan', 'Phạm Văn',
        '1403D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem1403Dadmin@vr.org.vn',
        '1989-04-19 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '5677433075', '5677433075',
        '2024-02-24 00:00:00.000000 +00:00', null, '2024-02-24 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('47387a90-01af-4c89-97a5-df32053d3408', 'dangkiem3302Sadmin', 'admin', 'Phan Văn Chính', 'Chính', 'Phan Văn',
        '3302S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem3302Sadmin@vr.org.vn',
        '1986-01-09 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '4809927581', '4809927581',
        '2023-07-27 00:00:00.000000 +00:00', null, '2023-07-27 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('36084c0f-8b37-4446-b958-2fac2e99cb6e', 'dangkiem2904Vkdv', 'staff', 'Nhân viên TTDK 2904V', '2904V',
        'Nhân viên TTDK', '2904V', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem2904Vkdv@vr.org.vn', '1978-05-03 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '9888971945',
        '9888971945', '2023-04-15 00:00:00.000000 +00:00', null, '2023-04-15 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('a8991fd4-ff90-4178-b996-508c4785f68c', 'dangkiem4701Dadmin', 'admin', 'PGĐ Bùi Văn Trường', 'Trường',
        'PGĐ Bùi Văn', '4701D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem4701Dadmin@vr.org.vn', '1972-12-24 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '5702422237',
        '5702422237', '2024-02-23 00:00:00.000000 +00:00', null, '2024-02-23 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('80bfbf56-d0fe-4aaa-8793-470791ad1ef3', 'dangkiem4305Dadmin', 'admin', 'Trần Việt Chung', 'Chung', 'Trần Việt',
        '4305D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem4305Dadmin@vr.org.vn',
        '1989-01-23 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '8285685930', '8285685930',
        '2024-04-21 00:00:00.000000 +00:00', null, '2024-04-21 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('3ad60f31-1512-48c2-aac5-3ca7aaef429e', 'dangkiem2908Dadmin', 'admin', 'Nguyễn Văn Sinh', 'Sinh', 'Nguyễn Văn',
        '2908D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem2908Dadmin@vr.org.vn',
        '1971-09-14 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '6890446681', '6890446681',
        '2023-10-21 00:00:00.000000 +00:00', null, '2023-10-21 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('b72d10b0-25f6-4ae6-85ff-2c3f5d66b9cf', 'dangkiem9905Dadmin', 'admin', 'Trần Kiên', 'Kiên', 'Trần', '9905D',
        '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem9905Dadmin@vr.org.vn',
        '1984-09-30 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '7614954946', '7614954946',
        '2024-01-09 00:00:00.000000 +00:00', null, '2024-01-09 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('68e90da0-af35-478a-803b-926e8ee2358f', 'dangkiem4902Sadmin', 'admin', 'Nguyễn Nguyễn Trí Hải', 'Hải',
        'Nguyễn Nguyễn Trí', '4902S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem4902Sadmin@vr.org.vn', '1978-05-02 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '2807372897',
        '2807372897', '2023-02-09 00:00:00.000000 +00:00', null, '2023-02-09 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('79bdeef3-9868-4e24-9312-4270b70d43cb', 'dangkiem1406Dkdv', 'staff', 'Nhân viên TTDK 1406D', '1406D',
        'Nhân viên TTDK', '1406D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem1406Dkdv@vr.org.vn', '1983-07-02 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '3553516790',
        '3553516790', '2023-05-20 00:00:00.000000 +00:00', null, '2023-05-20 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('8ac060d1-ce3c-489a-8861-6e10c9cc68aa', 'dangkiem9501Sadmin', 'admin', 'Ngô Minh Khang', 'Khang', 'Ngô Minh',
        '9501S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem9501Sadmin@vr.org.vn',
        '1982-01-18 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '5853753941', '5853753941',
        '2023-03-09 00:00:00.000000 +00:00', null, '2023-03-09 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('695e6694-be0f-4d87-bebc-8eaf1b473fed', 'dangkiem1102Dadmin', 'admin', 'Lê Văn Trung', 'Trung', 'Lê Văn',
        '1102D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem1102Dadmin@vr.org.vn',
        '1988-07-13 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '5560850493', '5560850493',
        '2023-10-09 00:00:00.000000 +00:00', null, '2023-10-09 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('c4b2d29a-c176-4d6b-a597-1c4f5915c7a7', 'dangkiem6703Dkdv', 'staff', 'Nhân viên TTDK 6703D', '6703D',
        'Nhân viên TTDK', '6703D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem6703Dkdv@vr.org.vn', '1981-11-18 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '9326923955',
        '9326923955', '2023-05-18 00:00:00.000000 +00:00', null, '2023-05-18 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('4bc39c4d-b64e-47f1-bb63-5ae9c7161e6e', 'dangkiem2902Sadmin', 'admin', 'Nguyễn Khánh Tùng', 'Tùng',
        'Nguyễn Khánh', '2902S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem2902Sadmin@vr.org.vn', '1974-03-16 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '6735218424',
        '6735218424', '2023-11-24 00:00:00.000000 +00:00', null, '2023-11-24 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('7739388f-e16b-4979-9314-b67e6cb11637', 'dangkiem1804Dkdv', 'staff', 'Nhân viên TTDK 1804D', '1804D',
        'Nhân viên TTDK', '1804D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem1804Dkdv@vr.org.vn', '1985-08-06 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '8925576846',
        '8925576846', '2024-02-25 00:00:00.000000 +00:00', null, '2024-02-25 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('d77cdc43-c997-41dd-8522-503bdb0086d8', 'dangkiem6103Dadmin', 'admin', 'Lê Việt Hùng', 'Hùng', 'Lê Việt',
        '6103D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem6103Dadmin@vr.org.vn',
        '1987-08-07 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '7377354991', '7377354991',
        '2023-04-14 00:00:00.000000 +00:00', null, '2023-04-14 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('8d2dd4c1-eeaf-4d42-b02f-67bb793d3eac', 'dangkiem8201Sadmin', 'admin', 'Nguyễn Xuân Đàm', 'Đàm', 'Nguyễn Xuân',
        '8201S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem8201Sadmin@vr.org.vn',
        '1980-12-23 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '8270190953', '8270190953',
        '2023-02-24 00:00:00.000000 +00:00', null, '2023-02-24 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('cb71ffcd-b5e6-484a-9aa5-2b94b9c72ff6', 'dangkiem2907Dadmin', 'admin', 'Nguyễn Như Thanh', 'Thanh',
        'Nguyễn Như', '2907D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem2907Dadmin@vr.org.vn', '1977-02-10 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '4864569214',
        '4864569214', '2023-08-25 00:00:00.000000 +00:00', null, '2023-08-25 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('8c74be3d-e4d5-475f-8282-07937f22b01e', 'dangkiem3608Dkdv', 'staff', 'Nhân viên TTDK 3608D', '3608D',
        'Nhân viên TTDK', '3608D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem3608Dkdv@vr.org.vn', '1984-11-28 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '7392781637',
        '7392781637', '2024-02-02 00:00:00.000000 +00:00', null, '2024-02-02 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('97eada15-c8f2-413d-9487-d46fdf91de65', 'dangkiem2905Vkdv', 'staff', 'Nhân viên TTDK 2905V', '2905V',
        'Nhân viên TTDK', '2905V', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem2905Vkdv@vr.org.vn', '1988-12-25 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '1228656202',
        '1228656202', '2024-04-26 00:00:00.000000 +00:00', null, '2024-04-26 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('5a34df8d-8aeb-43ef-9b3d-b601e2cf6c85', 'dangkiem2902Skdv', 'staff', 'Nhân viên TTDK 2902S', '2902S',
        'Nhân viên TTDK', '2902S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem2902Skdv@vr.org.vn', '1984-11-04 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '1612796651',
        '1612796651', '2023-04-04 00:00:00.000000 +00:00', null, '2023-04-04 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('1a484125-4671-4c05-867c-c8bd81dc6a37', 'dangkiem3707Dkdv', 'staff', 'Nhân viên TTDK 3707D', '3707D',
        'Nhân viên TTDK', '3707D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem3707Dkdv@vr.org.vn', '1973-04-11 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '8629388852',
        '8629388852', '2023-10-15 00:00:00.000000 +00:00', null, '2023-10-15 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('949b6f67-b952-4b98-a4e4-7410875a372c', 'dangkiem2910Dadmin', 'admin', 'Vũ Mạnh Cường', 'Cường', 'Vũ Mạnh',
        '2910D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem2910Dadmin@vr.org.vn',
        '1987-12-08 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '3794666803', '3794666803',
        '2023-10-18 00:00:00.000000 +00:00', null, '2023-10-18 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('3911bad2-162f-4537-aed0-472819671b68', 'dangkiem9806Dadmin', 'admin', 'Ninh Đức Tùng', 'Tùng', 'Ninh Đức',
        '9806D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem9806Dadmin@vr.org.vn',
        '1985-02-07 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '2551973383', '2551973383',
        '2024-01-20 00:00:00.000000 +00:00', null, '2024-01-20 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('379831ee-1092-4cc3-950c-d1301f0387bc', 'dangkiem6108Dkdv', 'staff', 'Nhân viên TTDK 6108D', '6108D',
        'Nhân viên TTDK', '6108D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem6108Dkdv@vr.org.vn', '1978-01-23 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '7041941628',
        '7041941628', '2023-02-13 00:00:00.000000 +00:00', null, '2023-02-13 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('bb1d30b2-d30a-4c73-bb3b-6417a72cd58f', 'dangkiem6503Dadmin', 'admin', 'Đoàn Khánh Quang Trung', 'Trung',
        'Đoàn Khánh Quang', '6503D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem6503Dadmin@vr.org.vn', '1990-05-27 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '9444738840',
        '9444738840', '2023-11-13 00:00:00.000000 +00:00', null, '2023-11-13 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('14e11960-969e-4de3-922b-68e768b83c39', 'dangkiem3805Dadmin', 'admin', 'Phan Trọng Doãn', 'Doãn', 'Phan Trọng',
        '3805D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem3805Dadmin@vr.org.vn',
        '1988-03-07 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '5117815040', '5117815040',
        '2023-04-11 00:00:00.000000 +00:00', null, '2023-04-11 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('4385d915-2b06-448a-8e66-6f7331f7ed0e', 'dangkiem6103Sadmin', 'admin', 'Bùi Thanh Việt', 'Việt', 'Bùi Thanh',
        '6103S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem6103Sadmin@vr.org.vn',
        '1989-05-27 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '4435533408', '4435533408',
        '2023-11-10 00:00:00.000000 +00:00', null, '2023-11-10 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('9888eb7d-a6ac-4283-946a-619b29c5c004', 'dangkiem7603Dkdv', 'staff', 'Nhân viên TTDK 7603D', '7603D',
        'Nhân viên TTDK', '7603D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem7603Dkdv@vr.org.vn', '1980-03-15 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '5585182223',
        '5585182223', '2023-08-07 00:00:00.000000 +00:00', null, '2023-08-07 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('f4a4dc51-ed5b-404e-a84f-7e6d71541e9a', 'dangkiem3701Sadmin', 'admin', 'Nguyễn Quý Khánh', 'Khánh',
        'Nguyễn Quý', '3701S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem3701Sadmin@vr.org.vn', '1976-03-20 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '3766249985',
        '3766249985', '2023-08-17 00:00:00.000000 +00:00', null, '2023-08-17 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('51c17ea6-b074-4119-916b-43d05018cb94', 'dangkiem8905Dadmin', 'admin', 'Nguyễn Trung Hiếu', 'Hiếu',
        'Nguyễn Trung', '8905D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem8905Dadmin@vr.org.vn', '1973-10-30 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '7528134482',
        '7528134482', '2023-12-09 00:00:00.000000 +00:00', null, '2023-12-09 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('7aeee4bd-7afc-4630-85a9-de7798cd3a0c', 'dangkiem6110Dadmin', 'admin', 'Phan Hũu Thọ', 'Thọ', 'Phan Hũu',
        '6110D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem6110Dadmin@vr.org.vn',
        '1981-08-24 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '7686526033', '7686526033',
        '2023-04-23 00:00:00.000000 +00:00', null, '2023-04-23 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('a94071bb-7bdf-41fc-8ca7-f6edbe4cc054', 'dangkiem4301Sadmin', 'admin', 'Bùi Văn Tấn', 'Tấn', 'Bùi Văn', '4301S',
        '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem4301Sadmin@vr.org.vn',
        '1986-02-22 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '7396864805', '7396864805',
        '2024-02-01 00:00:00.000000 +00:00', null, '2024-02-01 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('9b79d838-540a-4e76-b09d-1fd4f038e04e', 'dangkiem8105Dadmin', 'admin', 'Trần Minh Lượng', 'Lượng', 'Trần Minh',
        '8105D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem8105Dadmin@vr.org.vn',
        '1987-06-11 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '9754111650', '9754111650',
        '2023-06-08 00:00:00.000000 +00:00', null, '2023-06-08 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('13f1a39e-cbe4-427a-ae51-377ea850c8e2', 'dangkiem6001Skdv', 'staff', 'Nhân viên TTDK 6001S', '6001S',
        'Nhân viên TTDK', '6001S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem6001Skdv@vr.org.vn', '1982-09-05 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '9333417514',
        '9333417514', '2023-08-26 00:00:00.000000 +00:00', null, '2023-08-26 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('dd22588b-4427-46b4-9f36-cd22c77dffd0', 'dangkiem3603Dkdv', 'staff', 'Nhân viên TTDK 3603D', '3603D',
        'Nhân viên TTDK', '3603D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem3603Dkdv@vr.org.vn', '1986-08-12 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '8232758498',
        '8232758498', '2023-04-13 00:00:00.000000 +00:00', null, '2023-04-13 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('76670ad0-16c6-4d76-b595-4c81142c6222', 'dangkiem1201Dkdv', 'staff', 'Nhân viên TTDK 1201D', '1201D',
        'Nhân viên TTDK', '1201D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem1201Dkdv@vr.org.vn', '1982-11-25 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '1309701724',
        '1309701724', '2023-07-21 00:00:00.000000 +00:00', null, '2023-07-21 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('e4b90b13-3647-49f9-ab0f-519a7d8de32c', 'dangkiem7802Dadmin', 'admin', 'Phạm Xuân Hưng', 'Hưng', 'Phạm Xuân',
        '7802D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem7802Dadmin@vr.org.vn',
        '1987-05-13 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '7781814169', '7781814169',
        '2023-05-12 00:00:00.000000 +00:00', null, '2023-05-12 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('11a88e56-a90f-4974-b0fd-f1a785e9308f', 'dangkiem7303Dkdv', 'staff', 'Nhân viên TTDK 7303D', '7303D',
        'Nhân viên TTDK', '7303D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem7303Dkdv@vr.org.vn', '1989-11-03 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '4231969771',
        '4231969771', '2023-07-11 00:00:00.000000 +00:00', null, '2023-07-11 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('9221cded-5f70-4cdf-af56-97fd1dddda77', 'dangkiem6602Dadmin', 'admin', 'Trần Thanh Nhã', 'Nhã', 'Trần Thanh',
        '6602D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem6602Dadmin@vr.org.vn',
        '1990-09-27 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '8413282446', '8413282446',
        '2023-10-19 00:00:00.000000 +00:00', null, '2023-10-19 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('e724d3a6-4f73-499a-9a91-affca4d9a016', 'dangkiem9801Skdv', 'staff', 'Nhân viên TTDK 9801S', '9801S',
        'Nhân viên TTDK', '9801S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem9801Skdv@vr.org.vn', '1989-01-20 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '7848879761',
        '7848879761', '2023-09-17 00:00:00.000000 +00:00', null, '2023-09-17 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('75ce5ec1-9f24-47a7-917f-cd7f663975e2', 'dangkiem4802Dkdv', 'staff', 'Nhân viên TTDK 4802D', '4802D',
        'Nhân viên TTDK', '4802D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem4802Dkdv@vr.org.vn', '1974-07-12 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '6059638971',
        '6059638971', '2024-04-11 00:00:00.000000 +00:00', null, '2024-04-11 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('bc7ef8d4-a9be-49e4-9ac9-519b26eb48ba', 'dangkiem9304Dkdv', 'staff', 'Nhân viên TTDK 9304D', '9304D',
        'Nhân viên TTDK', '9304D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem9304Dkdv@vr.org.vn', '1989-02-12 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '8206002862',
        '8206002862', '2023-09-04 00:00:00.000000 +00:00', null, '2023-09-04 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('4ab81265-9eeb-4b59-8bfc-ab3989558f72', 'dangkiem2910Dkdv', 'staff', 'Nhân viên TTDK 2910D', '2910D',
        'Nhân viên TTDK', '2910D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem2910Dkdv@vr.org.vn', '1980-03-11 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '2828697764',
        '2828697764', '2023-12-12 00:00:00.000000 +00:00', null, '2023-12-12 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('01259a7a-e732-4eae-9ca8-a6d8ef04aa80', 'dangkiem9502Dkdv', 'staff', 'Nhân viên TTDK 9502D', '9502D',
        'Nhân viên TTDK', '9502D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem9502Dkdv@vr.org.vn', '1980-06-24 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '7646416073',
        '7646416073', '2024-02-03 00:00:00.000000 +00:00', null, '2024-02-03 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('afedff73-5fe2-47ec-ab6e-f2fa720fd28f', 'dangkiem2913Dadmin', 'admin', 'Đoàn Văn Hiếu', 'Hiếu', 'Đoàn Văn',
        '2913D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem2913Dadmin@vr.org.vn',
        '1978-05-26 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '4792657771', '4792657771',
        '2023-07-29 00:00:00.000000 +00:00', null, '2023-07-29 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('72b27140-be19-42be-98fa-526c14da0922', 'dangkiem8601Sadmin', 'admin', 'Trương Ngọc Thiện', 'Thiện',
        'Trương Ngọc', '8601S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem8601Sadmin@vr.org.vn', '1985-05-24 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '1665330419',
        '1665330419', '2023-05-19 00:00:00.000000 +00:00', null, '2023-05-19 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('80cba71b-9aea-4884-a063-bb1a3ca341f1', 'dangkiem6401Vadmin', 'admin', 'Nguyễn Thành Bắc', 'Bắc',
        'Nguyễn Thành', '6401V', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem6401Vadmin@vr.org.vn', '1986-04-26 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '5249596888',
        '5249596888', '2023-04-22 00:00:00.000000 +00:00', null, '2023-04-22 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('ce37f6cb-252c-43b1-b18d-3f7d2d7f20fc', 'dangkiem1501Vkdv', 'staff', 'Nhân viên TTDK 1501V', '1501V',
        'Nhân viên TTDK', '1501V', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem1501Vkdv@vr.org.vn', '1974-10-27 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '1661245972',
        '1661245972', '2024-02-22 00:00:00.000000 +00:00', null, '2024-02-22 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('4745dfa4-6160-40f1-9716-08c20369749b', 'dangkiem1503Dkdv', 'staff', 'Nhân viên TTDK 1503D', '1503D',
        'Nhân viên TTDK', '1503D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem1503Dkdv@vr.org.vn', '1987-11-17 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '2008178763',
        '2008178763', '2023-12-20 00:00:00.000000 +00:00', null, '2023-12-20 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('a2c47170-b10b-4d55-ad63-e24553936d2a', 'dangkiem3504Dkdv', 'staff', 'Nhân viên TTDK 3504D', '3504D',
        'Nhân viên TTDK', '3504D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem3504Dkdv@vr.org.vn', '1973-04-11 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '5915476572',
        '5915476572', '2023-02-25 00:00:00.000000 +00:00', null, '2023-02-25 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('35075a3b-c203-43a4-b236-f8e9b972e11c', 'dangkiem7704Dadmin', 'admin', 'Nguyễn Đức Thạch', 'Thạch',
        'Nguyễn Đức', '7704D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem7704Dadmin@vr.org.vn', '1986-06-28 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '6903394599',
        '6903394599', '2023-07-15 00:00:00.000000 +00:00', null, '2023-07-15 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('24602983-968b-4440-bee6-5146fe55b829', 'dangkiem3705Dkdv', 'staff', 'Nhân viên TTDK 3705D', '3705D',
        'Nhân viên TTDK', '3705D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem3705Dkdv@vr.org.vn', '1979-02-03 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '4245960641',
        '4245960641', '2023-12-14 00:00:00.000000 +00:00', null, '2023-12-14 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('640292cc-c61c-4502-bbc4-f8865c8680bd', 'dangkiem4701Dkdv', 'staff', 'Nhân viên TTDK 4701D', '4701D',
        'Nhân viên TTDK', '4701D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem4701Dkdv@vr.org.vn', '1989-04-13 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '4593901489',
        '4593901489', '2023-01-19 00:00:00.000000 +00:00', null, '2023-01-19 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('399104e8-5677-4bd1-b88c-9bdc5b9bd63c', 'dangkiem7403Dkdv', 'staff', 'Nhân viên TTDK 7403D', '7403D',
        'Nhân viên TTDK', '7403D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem7403Dkdv@vr.org.vn', '1987-04-21 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '5392517625',
        '5392517625', '2024-01-30 00:00:00.000000 +00:00', null, '2024-01-30 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('3d3d9f09-60cb-4cda-83fa-56cb2cbe3cc8', 'dangkiem6701Sadmin', 'admin', 'Nguyễn Thiện Bằng', 'Bằng',
        'Nguyễn Thiện', '6701S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem6701Sadmin@vr.org.vn', '1979-04-11 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '9850964341',
        '9850964341', '2023-04-16 00:00:00.000000 +00:00', null, '2023-04-16 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('45bc524c-e08c-4830-9e69-551358b55dd5', 'dangkiem3503Dadmin', 'admin', 'Nguyễn Hữu Thư', 'Thư', 'Nguyễn Hữu',
        '3503D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem3503Dadmin@vr.org.vn',
        '1985-05-13 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '4602931979', '4602931979',
        '2023-08-05 00:00:00.000000 +00:00', null, '2023-08-05 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('9dbb6dc4-299d-4297-ba43-dd1f5a4d97c8', 'dangkiem8802Dkdv', 'staff', 'Nhân viên TTDK 8802D', '8802D',
        'Nhân viên TTDK', '8802D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem8802Dkdv@vr.org.vn', '1987-03-21 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '2399366185',
        '2399366185', '2024-03-03 00:00:00.000000 +00:00', null, '2024-03-03 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('c0bf73c2-9af5-4b56-94db-45fa30b88c6b', 'dangkiem1904Dkdv', 'staff', 'Nhân viên TTDK 1904D', '1904D',
        'Nhân viên TTDK', '1904D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem1904Dkdv@vr.org.vn', '1972-11-02 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '9758597026',
        '9758597026', '2024-04-09 00:00:00.000000 +00:00', null, '2024-04-09 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('6446eec9-028f-4377-8a00-4300c82cb629', 'dangkiem8102Dadmin', 'admin', 'Nguyễn Viết Tùng', 'Tùng',
        'Nguyễn Viết', '8102D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem8102Dadmin@vr.org.vn', '1972-11-25 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '7574959822',
        '7574959822', '2024-01-25 00:00:00.000000 +00:00', null, '2024-01-25 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('b8d2adba-d9ce-4600-bbb2-b5dd721e480a', 'dangkiem2006Dadmin', 'admin', 'NGUYỄN HỮU THÙY', 'THÙY', 'NGUYỄN HỮU',
        '2006D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem2006Dadmin@vr.org.vn',
        '1982-05-18 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '9636910169', '9636910169',
        '2023-06-03 00:00:00.000000 +00:00', null, '2023-06-03 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('e268f025-6562-4716-90b5-583ae4ad6afd', 'hieunm', 'god', 'Nguyễn Minh Hiếu', 'Hiếu', 'Nguyễn Minh', 'GOD',
        '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'hieunm@vr.org.vn',
        '1977-01-04 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '5733578757', '5733578757',
        '2024-01-13 00:00:00.000000 +00:00', null, '2024-01-13 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('077a650f-b1b2-4cd7-84f8-8e54decb55eb', 'dangkiem2905Vadmin', 'admin', 'Đặng Tuấn Anh', 'Anh', 'Đặng Tuấn',
        '2905V', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem2905Vadmin@vr.org.vn',
        '1983-06-22 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '7151648500', '7151648500',
        '2024-01-26 00:00:00.000000 +00:00', null, '2024-01-26 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('e0f44576-aeda-45af-999e-f776e01cdea7', 'dangkiem1403Dkdv', 'staff', 'Nhân viên TTDK 1403D', '1403D',
        'Nhân viên TTDK', '1403D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem1403Dkdv@vr.org.vn', '1987-10-05 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '1382758134',
        '1382758134', '2023-06-29 00:00:00.000000 +00:00', null, '2023-06-29 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('3d7c89cd-592c-4098-b425-5839f4f68294', 'dangkiem6101Skdv', 'staff', 'Nhân viên TTDK 6101S', '6101S',
        'Nhân viên TTDK', '6101S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem6101Skdv@vr.org.vn', '1980-07-31 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '3920503910',
        '3920503910', '2023-04-21 00:00:00.000000 +00:00', null, '2023-04-21 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('a1227e23-376a-417a-beff-70c081620110', 'dangkiem4304Dadmin', 'admin', 'Lê Văn Long', 'Long', 'Lê Văn', '4304D',
        '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem4304Dadmin@vr.org.vn',
        '1974-01-26 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '3154490818', '3154490818',
        '2023-12-08 00:00:00.000000 +00:00', null, '2023-12-08 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('3211c0bd-223d-4686-9ecd-94b649858fb3', 'dangkiem7401Skdv', 'staff', 'Nhân viên TTDK 7401S', '7401S',
        'Nhân viên TTDK', '7401S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem7401Skdv@vr.org.vn', '1981-02-15 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '5141732710',
        '5141732710', '2023-10-17 00:00:00.000000 +00:00', null, '2023-10-17 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('3fc878ea-2b85-4408-9ddd-0a2a443eeb14', 'dangkiem8802Dadmin', 'admin', 'Đàm Hải Nam', 'Nam', 'Đàm Hải', '8802D',
        '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem8802Dadmin@vr.org.vn',
        '1972-07-25 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '7842539758', '7842539758',
        '2024-01-29 00:00:00.000000 +00:00', null, '2024-01-29 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('40dd4e27-046c-4aa5-bdb4-7c6a67c8c9d4', 'dangkiem7402Dadmin', 'admin', 'Đặng Anh Tuấn', 'Tuấn', 'Đặng Anh',
        '7402D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem7402Dadmin@vr.org.vn',
        '1982-10-18 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '1338997346', '1338997346',
        '2023-03-26 00:00:00.000000 +00:00', null, '2023-03-26 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('a821fd80-a720-4139-a593-2bc92140f8ea', 'dangkiem4704Dadmin', 'admin', 'Nguyễn Xuân Định', 'Định',
        'Nguyễn Xuân', '4704D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem4704Dadmin@vr.org.vn', '1985-08-02 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '4077834320',
        '4077834320', '2023-08-09 00:00:00.000000 +00:00', null, '2023-08-09 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('2b520774-91df-4da1-b612-abf9b04c668f', 'dangkiem2102Dkdv', 'staff', 'Nhân viên TTDK 2102D', '2102D',
        'Nhân viên TTDK', '2102D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem2102Dkdv@vr.org.vn', '1989-11-28 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '4715951976',
        '4715951976', '2023-01-14 00:00:00.000000 +00:00', null, '2023-01-14 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('e3d56f72-6899-40db-bbe8-4f29ea5a2f4d', 'dangkiem8402Dadmin', 'admin', 'Nguyễn Quốc Thống', 'Thống',
        'Nguyễn Quốc', '8402D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem8402Dadmin@vr.org.vn', '1977-11-18 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '2660390590',
        '2660390590', '2023-02-16 00:00:00.000000 +00:00', null, '2023-02-16 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('694d59e0-ff54-4b69-b03d-d271853c2b91', 'dangkiem1507Dadmin', 'admin', 'Nguyễn Văn Thăng', 'Thăng',
        'Nguyễn Văn', '1507D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem1507Dadmin@vr.org.vn', '1980-04-18 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '1381688231',
        '1381688231', '2023-11-30 00:00:00.000000 +00:00', null, '2023-11-30 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('ad4b2c8a-e64c-4aa1-9b12-9712bfdf549b', 'dangkiem8803Dkdv', 'staff', 'Nhân viên TTDK 8803D', '8803D',
        'Nhân viên TTDK', '8803D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem8803Dkdv@vr.org.vn', '1980-07-04 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '6979768647',
        '6979768647', '2023-12-06 00:00:00.000000 +00:00', null, '2023-12-06 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('7689dd76-c80c-4afd-a93e-c835b07c26ca', 'dangkiem4706Dkdv', 'staff', 'Nhân viên TTDK 4706D', '4706D',
        'Nhân viên TTDK', '4706D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem4706Dkdv@vr.org.vn', '1977-08-13 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '6225362709',
        '6225362709', '2024-01-05 00:00:00.000000 +00:00', null, '2024-01-05 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('4c0594f0-7b2e-49f9-9cf6-2a3ceb29a4c9', 'dangkiem4702Dkdv', 'staff', 'Nhân viên TTDK 4702D', '4702D',
        'Nhân viên TTDK', '4702D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem4702Dkdv@vr.org.vn', '1981-06-30 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '7571125453',
        '7571125453', '2023-04-28 00:00:00.000000 +00:00', null, '2023-04-28 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('8a1029b9-41f4-4f0e-a925-2f8fd2a160d0', 'dangkiem3605Dkdv', 'staff', 'Nhân viên TTDK 3605D', '3605D',
        'Nhân viên TTDK', '3605D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem3605Dkdv@vr.org.vn', '1989-07-06 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '4818769608',
        '4818769608', '2024-03-05 00:00:00.000000 +00:00', null, '2024-03-05 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('55fbfbf0-d81e-4723-b4c6-15ef00490777', 'dangkiem2912Dkdv', 'staff', 'Nhân viên TTDK 2912D', '2912D',
        'Nhân viên TTDK', '2912D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem2912Dkdv@vr.org.vn', '1978-12-15 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '9550604010',
        '9550604010', '2024-03-10 00:00:00.000000 +00:00', null, '2024-03-10 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('610437e9-7a3c-4b81-a975-bba8018e89ce', 'dangkiem3703Dadmin', 'admin', 'Nguyễn Quang Doãn', 'Doãn',
        'Nguyễn Quang', '3703D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem3703Dadmin@vr.org.vn', '1986-09-17 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '5123073937',
        '5123073937', '2023-11-15 00:00:00.000000 +00:00', null, '2023-11-15 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('eb3d0019-8001-4d05-a6ab-0f0b3531f55a', 'dangkiem3602Sadmin', 'admin', 'Nguyễn Văn Khoát', 'Khoát',
        'Nguyễn Văn', '3602S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem3602Sadmin@vr.org.vn', '1987-01-17 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '9348299474',
        '9348299474', '2023-12-15 00:00:00.000000 +00:00', null, '2023-12-15 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('c48db7fb-221b-4884-9203-08d391420662', 'dangkiem7705Dadmin', 'admin', 'Thái Lý Dự', 'Dự', 'Thái Lý', '7705D',
        '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem7705Dadmin@vr.org.vn',
        '1973-04-20 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '5087936271', '5087936271',
        '2023-01-24 00:00:00.000000 +00:00', null, '2023-01-24 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('ebb77e88-1e3d-4a5d-b4a6-8eb07b5b0728', 'dangkiem7001Sadmin', 'admin', 'Lê Phan Thanh Vinh', 'Vinh',
        'Lê Phan Thanh', '7001S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem7001Sadmin@vr.org.vn', '1988-07-11 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '5183355888',
        '5183355888', '2023-09-06 00:00:00.000000 +00:00', null, '2023-09-06 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('f8f913c9-6a72-4c99-a4ec-4190c74217f4', 'dangkiem2917Dkdv', 'staff', 'Nhân viên TTDK 2917D', '2917D',
        'Nhân viên TTDK', '2917D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem2917Dkdv@vr.org.vn', '1976-02-11 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '8543770462',
        '8543770462', '2023-12-25 00:00:00.000000 +00:00', null, '2023-12-25 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('0b6ebf65-847a-4082-aca6-b0186c5a4aa0', 'dangkiem6002Sadmin', 'admin', 'Nguyễn Sơn Hải', 'Hải', 'Nguyễn Sơn',
        '6002S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem6002Sadmin@vr.org.vn',
        '1979-05-24 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '4539833382', '4539833382',
        '2024-05-12 00:00:00.000000 +00:00', null, '2024-05-12 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('0d4597b0-5758-40ba-8b95-148d92f9bb28', 'dangkiem7401Sadmin', 'admin', 'Nguyễn Xuân Hà', 'Hà', 'Nguyễn Xuân',
        '7401S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem7401Sadmin@vr.org.vn',
        '1977-05-16 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '7577653941', '7577653941',
        '2023-03-17 00:00:00.000000 +00:00', null, '2023-03-17 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('849a730d-0894-4ee4-8327-4290d8e042b6', 'dangkiem6102Skdv', 'staff', 'Nhân viên TTDK 6102S', '6102S',
        'Nhân viên TTDK', '6102S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem6102Skdv@vr.org.vn', '1975-01-21 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '5798212975',
        '5798212975', '2023-10-08 00:00:00.000000 +00:00', null, '2023-10-08 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('c3d00225-6fa5-45d3-b0b9-25addf900ec9', 'dangkiem7803Dkdv', 'staff', 'Nhân viên TTDK 7803D', '7803D',
        'Nhân viên TTDK', '7803D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem7803Dkdv@vr.org.vn', '1984-01-24 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '8328881980',
        '8328881980', '2023-10-05 00:00:00.000000 +00:00', null, '2023-10-05 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('fa52f61a-68d0-4d93-9bad-87b7e98deb12', 'dangkiem6506Dkdv', 'staff', 'Nhân viên TTDK 6506D', '6506D',
        'Nhân viên TTDK', '6506D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem6506Dkdv@vr.org.vn', '1977-11-25 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '2143948044',
        '2143948044', '2023-07-28 00:00:00.000000 +00:00', null, '2023-07-28 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('66b3c1c1-6979-43e9-97ce-4749c1dbb8b1', 'dangkiem3605Dadmin', 'admin', 'Đỗ Hoàng Long', 'Long', 'Đỗ Hoàng',
        '3605D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem3605Dadmin@vr.org.vn',
        '1972-09-24 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '3286259509', '3286259509',
        '2024-04-04 00:00:00.000000 +00:00', null, '2024-04-04 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('7c3effa3-8c98-4f12-bd7e-fd09c18a6258', 'dangkiem9202Dadmin', 'admin', 'Lê Thanh Tùng', 'Tùng', 'Lê Thanh',
        '9202D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem9202Dadmin@vr.org.vn',
        '1989-07-13 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '2171566555', '2171566555',
        '2023-11-23 00:00:00.000000 +00:00', null, '2023-11-23 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('e6ceb8c5-f03d-4e0e-8524-55875d9b0ce6', 'dangkiem7901Skdv', 'staff', 'Nhân viên TTDK 7901S', '7901S',
        'Nhân viên TTDK', '7901S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem7901Skdv@vr.org.vn', '1982-07-01 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '4610861995',
        '4610861995', '2023-05-16 00:00:00.000000 +00:00', null, '2023-05-16 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('30928bf8-dffb-4dbb-b3ba-370dd9ae3879', 'dangkiem7701Sadmin', 'admin', 'Phạm Đại Lâm', 'Lâm', 'Phạm Đại',
        '7701S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem7701Sadmin@vr.org.vn',
        '1971-04-01 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '9209889845', '9209889845',
        '2023-12-05 00:00:00.000000 +00:00', null, '2023-12-05 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('4ddef7fa-c022-4408-bb3d-13a5e126e27e', 'dangkiem2301Sadmin', 'admin', 'Đàm Quốc Tuấn', 'Tuấn', 'Đàm Quốc',
        '2301S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem2301Sadmin@vr.org.vn',
        '1976-09-08 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '2783768368', '2783768368',
        '2023-09-22 00:00:00.000000 +00:00', null, '2023-09-22 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('38939a01-a1db-4af3-83cd-b140b210ad3f', 'dangkiem1102Dkdv', 'staff', 'Nhân viên TTDK 1102D', '1102D',
        'Nhân viên TTDK', '1102D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem1102Dkdv@vr.org.vn', '1983-08-22 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '9064207332',
        '9064207332', '2024-01-11 00:00:00.000000 +00:00', null, '2024-01-11 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('de117108-0490-40aa-adce-2407aca03a18', 'dangkiem1402Dkdv', 'staff', 'Nhân viên TTDK 1402D', '1402D',
        'Nhân viên TTDK', '1402D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem1402Dkdv@vr.org.vn', '1977-10-19 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '8992926047',
        '8992926047', '2023-05-14 00:00:00.000000 +00:00', null, '2023-05-14 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('75301082-0881-4898-acfe-cccb1c8f079c', 'dangkiem6504Dkdv', 'staff', 'Nhân viên TTDK 6504D', '6504D',
        'Nhân viên TTDK', '6504D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem6504Dkdv@vr.org.vn', '1988-07-07 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '7818941472',
        '7818941472', '2023-07-01 00:00:00.000000 +00:00', null, '2023-07-01 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('61fe84b7-aeb7-4ca7-b65b-80aa87efcad2', 'dangkiem2201Skdv', 'staff', 'Nhân viên TTDK 2201S', '2201S',
        'Nhân viên TTDK', '2201S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem2201Skdv@vr.org.vn', '1979-05-30 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '4604367748',
        '4604367748', '2023-07-31 00:00:00.000000 +00:00', null, '2023-07-31 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('ae00e45c-3960-43aa-a515-1264f159804b', 'dangkiem9301Skdv', 'staff', 'Nhân viên TTDK 9301S', '9301S',
        'Nhân viên TTDK', '9301S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem9301Skdv@vr.org.vn', '1973-05-24 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '4479017735',
        '4479017735', '2024-04-18 00:00:00.000000 +00:00', null, '2024-04-18 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('ea373ef5-d71b-40c7-895f-9933fa59047e', 'dangkiem2911Dkdv', 'staff', 'Nhân viên TTDK 2911D', '2911D',
        'Nhân viên TTDK', '2911D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem2911Dkdv@vr.org.vn', '1972-02-24 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '6796858910',
        '6796858910', '2024-04-10 00:00:00.000000 +00:00', null, '2024-04-10 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('df9691ba-b126-44f5-b580-604c03a595ab', 'dangkiem9805Dkdv', 'staff', 'Nhân viên TTDK 9805D', '9805D',
        'Nhân viên TTDK', '9805D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem9805Dkdv@vr.org.vn', '1978-05-02 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '1987339944',
        '1987339944', '2023-08-10 00:00:00.000000 +00:00', null, '2023-08-10 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('8c3848d1-7dce-4d38-ba55-dc05ab1cc6b9', 'dangkiem6506Dadmin', 'admin', 'Nguyễn Đức Vui', 'Vui', 'Nguyễn Đức',
        '6506D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem6506Dadmin@vr.org.vn',
        '1979-06-18 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '9204551398', '9204551398',
        '2023-05-07 00:00:00.000000 +00:00', null, '2023-05-07 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('4b5731fe-7355-4eb7-8271-359e70a90355', 'dangkiem3709Dkdv', 'staff', 'Nhân viên TTDK 3709D', '3709D',
        'Nhân viên TTDK', '3709D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem3709Dkdv@vr.org.vn', '1973-10-08 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '5821321783',
        '5821321783', '2023-06-21 00:00:00.000000 +00:00', null, '2023-06-21 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('f66308cb-7151-4367-8029-8bead7ee3bc1', 'dangkiem9002Dadmin', 'admin', 'Nguyễn Văn Tuấn', 'Tuấn', 'Nguyễn Văn',
        '9002D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem9002Dadmin@vr.org.vn',
        '1986-08-13 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '3923249011', '3923249011',
        '2023-07-19 00:00:00.000000 +00:00', null, '2023-07-19 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('b128fbe4-f4ac-49ab-b771-98838fb6333b', 'dangkiem3705Dadmin', 'admin', 'Lê Ngọc Thực', 'Thực', 'Lê Ngọc',
        '3705D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem3705Dadmin@vr.org.vn',
        '1988-04-28 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '5306608878', '5306608878',
        '2023-01-08 00:00:00.000000 +00:00', null, '2023-01-08 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('802d7480-ee41-4ed7-99e0-85653adeb15d', 'dangkiem2901Skdv', 'staff', 'Nhân viên TTDK 2901S', '2901S',
        'Nhân viên TTDK', '2901S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem2901Skdv@vr.org.vn', '1978-01-28 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '5715151734',
        '5715151734', '2024-03-12 00:00:00.000000 +00:00', null, '2024-03-12 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('0885fe05-0864-4bf3-8709-43fdd4478ac8', 'dangkiem8301Vkdv', 'staff', 'Nhân viên TTDK 8301V', '8301V',
        'Nhân viên TTDK', '8301V', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem8301Vkdv@vr.org.vn', '1989-07-15 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '2958649736',
        '2958649736', '2023-12-23 00:00:00.000000 +00:00', null, '2023-12-23 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('348b10c5-1e0d-4d95-8230-23a5a4249e30', 'dangkiem1702Dkdv', 'staff', 'Nhân viên TTDK 1702D', '1702D',
        'Nhân viên TTDK', '1702D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem1702Dkdv@vr.org.vn', '1971-12-10 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '4094627401',
        '4094627401', '2024-04-27 00:00:00.000000 +00:00', null, '2024-04-27 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('6b0f2f81-7fdb-4f46-9cff-912956a5292a', 'dangkiem2913Dkdv', 'staff', 'Nhân viên TTDK 2913D', '2913D',
        'Nhân viên TTDK', '2913D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem2913Dkdv@vr.org.vn', '1980-12-01 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '2886185753',
        '2886185753', '2024-04-06 00:00:00.000000 +00:00', null, '2024-04-06 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('b2eb84ef-92a2-47da-a622-2039591f5e43', 'dangkiem2801Sadmin', 'admin', 'Anh Tân', 'Tân', 'Anh', '2801S',
        '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem2801Sadmin@vr.org.vn',
        '1971-08-14 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '9942867963', '9942867963',
        '2023-12-28 00:00:00.000000 +00:00', null, '2023-12-28 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('aa3f289b-52a7-4000-968f-97c948eb175f', 'dangkiem4901Sadmin', 'admin', 'Đinh Văn Đổi', 'Đổi', 'Đinh Văn',
        '4901S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem4901Sadmin@vr.org.vn',
        '1984-10-25 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '3695243043', '3695243043',
        '2024-04-12 00:00:00.000000 +00:00', null, '2024-04-12 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('0bad2c17-0aa3-4fd9-85d4-03af7758c043', 'dangkiem6303Dkdv', 'staff', 'Nhân viên TTDK 6303D', '6303D',
        'Nhân viên TTDK', '6303D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem6303Dkdv@vr.org.vn', '1990-07-06 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '6179317967',
        '6179317967', '2023-02-08 00:00:00.000000 +00:00', null, '2023-02-08 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('0047845f-5487-421a-8593-eb19fb6efab1', 'dangkiem3707Dadmin', 'admin', 'Hồ Hữu Hưng', 'Hưng', 'Hồ Hữu', '3707D',
        '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem3707Dadmin@vr.org.vn',
        '1987-03-15 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '8071787950', '8071787950',
        '2023-12-27 00:00:00.000000 +00:00', null, '2023-12-27 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('ef734263-e9e1-45cc-8d8f-002c4e3d8149', 'dangkiem7801Skdv', 'staff', 'Nhân viên TTDK 7801S', '7801S',
        'Nhân viên TTDK', '7801S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem7801Skdv@vr.org.vn', '1983-08-02 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '2891399594',
        '2891399594', '2024-05-09 00:00:00.000000 +00:00', null, '2024-05-09 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('2a743d6d-7495-4d04-ade3-a8afabc2cec8', 'dangkiem1906Dkdv', 'staff', 'Nhân viên TTDK 1906D', '1906D',
        'Nhân viên TTDK', '1906D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem1906Dkdv@vr.org.vn', '1985-10-20 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '5740410143',
        '5740410143', '2024-05-05 00:00:00.000000 +00:00', null, '2024-05-05 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('0c6b27ec-d017-4e2c-af36-6b2b9dd6ea46', 'dangkiem7902Sadmin', 'admin', 'Trần Xuân Khánh', 'Khánh', 'Trần Xuân',
        '7902S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem7902Sadmin@vr.org.vn',
        '1990-07-26 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '6006759384', '6006759384',
        '2023-07-04 00:00:00.000000 +00:00', null, '2023-07-04 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('38567fe5-61cd-4ad9-92d6-30b0f7ec12af', 'dangkiem3805Dkdv', 'staff', 'Nhân viên TTDK 3805D', '3805D',
        'Nhân viên TTDK', '3805D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem3805Dkdv@vr.org.vn', '1990-03-25 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '9666952641',
        '9666952641', '2023-01-29 00:00:00.000000 +00:00', null, '2023-01-29 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('f2e37c4f-91bb-4d34-b464-1ad842a02c17', 'dangkiem3803Dadmin', 'admin', 'Trần Đình Tịnh', 'Tịnh', 'Trần Đình',
        '3803D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem3803Dadmin@vr.org.vn',
        '1975-12-23 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '4347129789', '4347129789',
        '2023-06-14 00:00:00.000000 +00:00', null, '2023-06-14 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('75ba1621-a9c0-44cc-ae83-e722ba854b0d', 'dangkiem6003Sadmin', 'admin', 'Nguyễn Hoàng Dũng', 'Dũng',
        'Nguyễn Hoàng', '6003S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem6003Sadmin@vr.org.vn', '1983-08-01 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '2403772138',
        '2403772138', '2024-04-25 00:00:00.000000 +00:00', null, '2024-04-25 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('d3ea436e-e1d5-4140-bf57-8c45d15b1af3', 'dangkiem2202Dadmin', 'admin', 'Vũ Đình Hào', 'Hào', 'Vũ Đình', '2202D',
        '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem2202Dadmin@vr.org.vn',
        '1984-08-03 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '1910172453', '1910172453',
        '2024-01-31 00:00:00.000000 +00:00', null, '2024-01-31 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('f18d024b-c292-4e3d-92d2-cd1622e0069d', 'staff2', 'vrstaff', 'Nhân viên VR2', 'VR2', 'Nhân viên', 'VR',
        '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'staff2@vr.org.vn',
        '1981-06-13 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '9445396284', '9445396284',
        '2023-01-07 00:00:00.000000 +00:00', null, '2023-01-07 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('798b8031-481b-4988-9c47-7e1af0252085', 'dangkiem7706Dkdv', 'staff', 'Nhân viên TTDK 7706D', '7706D',
        'Nhân viên TTDK', '7706D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem7706Dkdv@vr.org.vn', '1975-04-03 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '9305549986',
        '9305549986', '2023-12-03 00:00:00.000000 +00:00', null, '2023-12-03 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('22c047b0-a24b-439b-be27-2e2a9b382286', 'dangkiem9902Skdv', 'staff', 'Nhân viên TTDK 9902S', '9902S',
        'Nhân viên TTDK', '9902S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem9902Skdv@vr.org.vn', '1978-01-07 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '5915810936',
        '5915810936', '2024-02-11 00:00:00.000000 +00:00', null, '2024-02-11 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('a8620c17-6ce3-4eaf-9957-6dce35d133e5', 'dangkiem2009Dadmin', 'admin', 'Lê Kế Phong', 'Phong', 'Lê Kế', '2009D',
        '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem2009Dadmin@vr.org.vn',
        '1975-01-13 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '4859352562', '4859352562',
        '2023-09-26 00:00:00.000000 +00:00', null, '2023-09-26 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('949d6568-7b77-4cc7-a2f4-a44558aa8f10', 'dangkiem1804Dadmin', 'admin', 'Phùng Mạnh Huấn', 'Huấn', 'Phùng Mạnh',
        '1804D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem1804Dadmin@vr.org.vn',
        '1981-01-24 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '4926500781', '4926500781',
        '2023-04-02 00:00:00.000000 +00:00', null, '2023-04-02 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('456f165d-277b-4c16-a723-6b8d4f7095d5', 'dangkiem1504Dkdv', 'staff', 'Nhân viên TTDK 1504D', '1504D',
        'Nhân viên TTDK', '1504D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem1504Dkdv@vr.org.vn', '1990-05-28 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '9842271839',
        '9842271839', '2023-09-19 00:00:00.000000 +00:00', null, '2023-09-19 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('f0272c33-d74f-4a6a-8f15-9506b6e7756d', 'dangkiem4904Dadmin', 'admin', 'Nguyễn Lương Tuân', 'Tuân',
        'Nguyễn Lương', '4904D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem4904Dadmin@vr.org.vn', '1989-11-07 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '5170959747',
        '5170959747', '2023-07-08 00:00:00.000000 +00:00', null, '2023-07-08 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('c4a9e095-6750-4aad-b839-40bd93a30102', 'staff5', 'vrstaff', 'Nhân viên VR5', 'VR5', 'Nhân viên', 'VR',
        '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'staff5@vr.org.vn',
        '1980-08-01 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '8230872358', '8230872358',
        '2023-02-18 00:00:00.000000 +00:00', null, '2023-02-18 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('f1eb8f7c-e06e-433c-abf6-be5dd606dd3e', 'dangkiem8103Dkdv', 'staff', 'Nhân viên TTDK 8103D', '8103D',
        'Nhân viên TTDK', '8103D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem8103Dkdv@vr.org.vn', '1979-06-01 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '1637494163',
        '1637494163', '2023-02-12 00:00:00.000000 +00:00', null, '2023-02-12 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('a03cf29a-786b-40e2-8aa0-2154bd42c449', 'dangkiem2903Sadmin', 'admin', 'Đỗ Văn Sơn', 'Sơn', 'Đỗ Văn', '2903S',
        '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem2903Sadmin@vr.org.vn',
        '1986-05-07 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '4804688118', '4804688118',
        '2023-12-30 00:00:00.000000 +00:00', null, '2023-12-30 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('921c580f-3b4c-4177-aa5c-25d5ac43a89e', 'dangkiem1803Dkdv', 'staff', 'Nhân viên TTDK 1803D', '1803D',
        'Nhân viên TTDK', '1803D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem1803Dkdv@vr.org.vn', '1978-10-03 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '8801870455',
        '8801870455', '2023-05-22 00:00:00.000000 +00:00', null, '2023-05-22 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('88e991b5-4273-4410-b366-87f72f2b5673', 'dangkiem4801Dadmin', 'admin', 'Nguyễn Xuân Diện', 'Diện',
        'Nguyễn Xuân', '4801D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem4801Dadmin@vr.org.vn', '1972-04-14 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '9108633012',
        '9108633012', '2023-07-06 00:00:00.000000 +00:00', null, '2023-07-06 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('5f6ba74e-8361-4cd4-8f3a-a4579713fd11', 'dangkiem4703Dadmin', 'admin', 'Trương Văn Minh', 'Minh', 'Trương Văn',
        '4703D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem4703Dadmin@vr.org.vn',
        '1971-02-09 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '9614596050', '9614596050',
        '2024-01-14 00:00:00.000000 +00:00', null, '2024-01-14 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('c8749ef6-08a2-4525-b80b-5d65417b376c', 'dangkiem2401Dadmin', 'admin', 'Phạm Mạnh Tường', 'Tường', 'Phạm Mạnh',
        '2401D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem2401Dadmin@vr.org.vn',
        '1988-02-14 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '5361545798', '5361545798',
        '2023-03-22 00:00:00.000000 +00:00', null, '2023-03-22 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('05b809b6-5606-4ad3-8be4-bab97a18e1a4', 'dangkiem1407Dkdv', 'staff', 'Nhân viên TTDK 1407D', '1407D',
        'Nhân viên TTDK', '1407D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem1407Dkdv@vr.org.vn', '1978-05-24 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '7322983901',
        '7322983901', '2023-11-17 00:00:00.000000 +00:00', null, '2023-11-17 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('29fd261e-e445-4a90-b3bb-23284a742d89', 'dangkiem6005Dkdv', 'staff', 'Nhân viên TTDK 6005D', '6005D',
        'Nhân viên TTDK', '6005D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem6005Dkdv@vr.org.vn', '1972-10-18 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '4367587535',
        '4367587535', '2024-01-07 00:00:00.000000 +00:00', null, '2024-01-07 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('be739549-7491-4cdf-af1b-317f9ab9a1e3', 'dangkiem2904Vadmin', 'admin', 'Cao Văn Tư', 'Tư', 'Cao Văn', '2904V',
        '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem2904Vadmin@vr.org.vn',
        '1971-04-23 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '9619380289', '9619380289',
        '2023-09-05 00:00:00.000000 +00:00', null, '2023-09-05 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('4a96af46-e03b-4b15-ab86-034b3a93070b', 'dangkiem6103Skdv', 'staff', 'Nhân viên TTDK 6103S', '6103S',
        'Nhân viên TTDK', '6103S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem6103Skdv@vr.org.vn', '1983-03-21 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '4300951298',
        '4300951298', '2023-03-10 00:00:00.000000 +00:00', null, '2023-03-10 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('f3893baf-830d-461d-9735-5f0eb38837c6', 'dangkiem3405Dadmin', 'admin', 'Phùng Quang Thịnh', 'Thịnh',
        'Phùng Quang', '3405D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem3405Dadmin@vr.org.vn', '1977-02-26 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '8638059920',
        '8638059920', '2023-12-04 00:00:00.000000 +00:00', null, '2023-12-04 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('9baed84f-f086-43c7-9090-a553721b2175', 'dangkiem8502Dkdv', 'staff', 'Nhân viên TTDK 8502D', '8502D',
        'Nhân viên TTDK', '8502D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem8502Dkdv@vr.org.vn', '1977-10-08 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '2213575029',
        '2213575029', '2023-12-19 00:00:00.000000 +00:00', null, '2023-12-19 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('a8524d32-0a6d-499b-8cf3-19568bc8c409', 'dangkiem8602Dkdv', 'staff', 'Nhân viên TTDK 8602D', '8602D',
        'Nhân viên TTDK', '8602D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem8602Dkdv@vr.org.vn', '1988-07-27 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '9843649158',
        '9843649158', '2023-01-20 00:00:00.000000 +00:00', null, '2023-01-20 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('ed3dc990-ce5f-4dd2-afec-077696c125fa', 'dangkiem8401Vadmin', 'admin', 'Hà Văn Út', 'Út', 'Hà Văn', '8401V',
        '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem8401Vadmin@vr.org.vn',
        '1982-05-01 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '3634762428', '3634762428',
        '2023-09-29 00:00:00.000000 +00:00', null, '2023-09-29 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('730db532-675b-40c3-a960-c86e9b78d1ff', 'dangkiem7402Dkdv', 'staff', 'Nhân viên TTDK 7402D', '7402D',
        'Nhân viên TTDK', '7402D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem7402Dkdv@vr.org.vn', '1979-11-25 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '6636522458',
        '6636522458', '2023-09-13 00:00:00.000000 +00:00', null, '2023-09-13 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('bf2d48d1-f9e6-42d0-953d-f51c8d1ee9aa', 'dangkiem1405Dadmin', 'admin', 'Nguyễn Nghị', 'Nghị', 'Nguyễn', '1405D',
        '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem1405Dadmin@vr.org.vn',
        '1981-07-20 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '7293277419', '7293277419',
        '2023-12-24 00:00:00.000000 +00:00', null, '2023-12-24 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('ac696394-e793-47e2-b37e-6c43bc32c980', 'dangkiem6302Dkdv', 'staff', 'Nhân viên TTDK 6302D', '6302D',
        'Nhân viên TTDK', '6302D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem6302Dkdv@vr.org.vn', '1979-01-23 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '2306295768',
        '2306295768', '2024-04-23 00:00:00.000000 +00:00', null, '2024-04-23 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('5c470472-e398-48be-aa55-fcabc6b2fe41', 'dangkiem6106Dkdv', 'staff', 'Nhân viên TTDK 6106D', '6106D',
        'Nhân viên TTDK', '6106D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem6106Dkdv@vr.org.vn', '1971-02-28 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '8516805274',
        '8516805274', '2023-09-27 00:00:00.000000 +00:00', null, '2023-09-27 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('73475102-f485-4a39-8247-6f48f4964335', 'dangkiem2008Dkdv', 'staff', 'Nhân viên TTDK 2008D', '2008D',
        'Nhân viên TTDK', '2008D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem2008Dkdv@vr.org.vn', '1976-07-28 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '2157615539',
        '2157615539', '2023-04-03 00:00:00.000000 +00:00', null, '2023-04-03 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('3d9a2de0-f53f-4803-bf80-7ab726daedbd', 'dangkiem6111Dadmin', 'admin', 'Đoàn Văn Chiến', 'Chiến', 'Đoàn Văn',
        '6111D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem6111Dadmin@vr.org.vn',
        '1987-04-18 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '9816109775', '9816109775',
        '2024-05-08 00:00:00.000000 +00:00', null, '2024-05-08 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('0526fbd9-ccf0-4fde-9875-dcac7d2d4217', 'dangkiem8904Dadmin', 'admin', 'Đỗ Hải Nam', 'Nam', 'Đỗ Hải', '8904D',
        '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem8904Dadmin@vr.org.vn',
        '1990-04-11 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '9752306872', '9752306872',
        '2024-04-14 00:00:00.000000 +00:00', null, '2024-04-14 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('ac42eb62-eab2-4ff2-b56d-81ded5593d9a', 'staff4', 'vrstaff', 'Nhân viên VR4', 'VR4', 'Nhân viên', 'VR',
        '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'staff4@vr.org.vn',
        '1985-10-30 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '3371972253', '3371972253',
        '2023-10-02 00:00:00.000000 +00:00', null, '2023-10-02 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('527bc8a0-957e-46ab-bfdb-68587a159493', 'dangkiem2001Skdv', 'staff', 'Nhân viên TTDK 2001S', '2001S',
        'Nhân viên TTDK', '2001S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem2001Skdv@vr.org.vn', '1984-03-12 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '2930577651',
        '2930577651', '2023-05-05 00:00:00.000000 +00:00', null, '2023-05-05 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('f75fa902-7185-45d1-b25e-7c07410a446a', 'dangkiem6303Dadmin', 'admin', 'Nguyễn Hữu Nghĩa', 'Nghĩa',
        'Nguyễn Hữu', '6303D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem6303Dadmin@vr.org.vn', '1980-06-22 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '4468004641',
        '4468004641', '2023-02-27 00:00:00.000000 +00:00', null, '2023-02-27 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('52bc1fe7-c214-4e5e-9999-ed93cefdf674', 'dangkiem6202Dkdv', 'staff', 'Nhân viên TTDK 6202D', '6202D',
        'Nhân viên TTDK', '6202D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem6202Dkdv@vr.org.vn', '1973-01-26 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '6115700652',
        '6115700652', '2023-02-19 00:00:00.000000 +00:00', null, '2023-02-19 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('7196f777-0294-4903-beb5-f0d7a3ddc502', 'dangkiem2903Vkdv', 'staff', 'Nhân viên TTDK 2903V', '2903V',
        'Nhân viên TTDK', '2903V', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem2903Vkdv@vr.org.vn', '1989-01-18 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '4634981694',
        '4634981694', '2023-05-21 00:00:00.000000 +00:00', null, '2023-05-21 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('d560bbf8-849a-422f-aad6-57e9297d8dcb', 'dangkiem2007Dkdv', 'staff', 'Nhân viên TTDK 2007D', '2007D',
        'Nhân viên TTDK', '2007D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem2007Dkdv@vr.org.vn', '1980-11-14 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '9393850676',
        '9393850676', '2023-10-31 00:00:00.000000 +00:00', null, '2023-10-31 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('37ebd16c-cefd-4612-aa59-b230d4958909', 'dangkiem7101Dadmin', 'admin', 'Huỳnh Nguyên Thạch', 'Thạch',
        'Huỳnh Nguyên', '7101D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem7101Dadmin@vr.org.vn', '1971-03-13 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '4710259473',
        '4710259473', '2024-04-02 00:00:00.000000 +00:00', null, '2024-04-02 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('cfc189cf-396a-4ced-97de-86b7f2ce5638', 'dangkiem3601Skdv', 'staff', 'Nhân viên TTDK 3601S', '3601S',
        'Nhân viên TTDK', '3601S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem3601Skdv@vr.org.vn', '1971-09-01 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '6874919558',
        '6874919558', '2023-09-16 00:00:00.000000 +00:00', null, '2023-09-16 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('e3dfa732-d1be-4bcc-a51c-c04ea0671831', 'dangkiem8902Skdv', 'staff', 'Nhân viên TTDK 8902S', '8902S',
        'Nhân viên TTDK', '8902S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem8902Skdv@vr.org.vn', '1985-04-05 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '7728029334',
        '7728029334', '2023-01-06 00:00:00.000000 +00:00', null, '2023-01-06 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('dae922b4-bb7a-4ed7-ae36-9ecc18a196e1', 'dangkiem2701Skdv', 'staff', 'Nhân viên TTDK 2701S', '2701S',
        'Nhân viên TTDK', '2701S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem2701Skdv@vr.org.vn', '1976-09-01 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '8263691657',
        '8263691657', '2023-01-11 00:00:00.000000 +00:00', null, '2023-01-11 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('11f0450d-4a62-4462-9748-6842e6812c29', 'dangkiem9802Dkdv', 'staff', 'Nhân viên TTDK 9802D', '9802D',
        'Nhân viên TTDK', '9802D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem9802Dkdv@vr.org.vn', '1989-11-06 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '1877178997',
        '1877178997', '2023-08-14 00:00:00.000000 +00:00', null, '2023-08-14 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('abb42bb8-8ba7-4572-957e-399662c98ddc', 'dangkiem3401Dadmin', 'admin', 'Nguyễn Ngọc Hiếu', 'Hiếu',
        'Nguyễn Ngọc', '3401D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem3401Dadmin@vr.org.vn', '1982-11-11 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '5843116978',
        '5843116978', '2023-03-03 00:00:00.000000 +00:00', null, '2023-03-03 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('8042ce0c-bcb3-4e49-af00-1050c81a6644', 'dangkiem2603Dkdv', 'staff', 'Nhân viên TTDK 2603D', '2603D',
        'Nhân viên TTDK', '2603D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem2603Dkdv@vr.org.vn', '1978-01-10 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '2123333684',
        '2123333684', '2023-12-11 00:00:00.000000 +00:00', null, '2023-12-11 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('0480f352-c79c-4676-b732-694d4b1fe010', 'dangkiem9905Dkdv', 'staff', 'Nhân viên TTDK 9905D', '9905D',
        'Nhân viên TTDK', '9905D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem9905Dkdv@vr.org.vn', '1989-03-19 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '7059894495',
        '7059894495', '2024-03-02 00:00:00.000000 +00:00', null, '2024-03-02 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('6f468ecf-37d6-43f0-96eb-ed0d14e36b54', 'dangkiem1509Dadmin', 'admin', 'Phạm Quang Vinh', 'Vinh', 'Phạm Quang',
        '1509D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem1509Dadmin@vr.org.vn',
        '1977-04-14 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '3844951606', '3844951606',
        '2024-01-27 00:00:00.000000 +00:00', null, '2024-01-27 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('83cec467-ebee-4500-b9e0-ba6e2714eef1', 'dangkiem1505Dkdv', 'staff', 'Nhân viên TTDK 1505D', '1505D',
        'Nhân viên TTDK', '1505D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem1505Dkdv@vr.org.vn', '1989-01-30 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '8098094904',
        '8098094904', '2023-09-01 00:00:00.000000 +00:00', null, '2023-09-01 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('a25fd7b9-fac7-446c-96bd-dfe378a80639', 'dangkiem2915Dkdv', 'staff', 'Nhân viên TTDK 2915D', '2915D',
        'Nhân viên TTDK', '2915D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem2915Dkdv@vr.org.vn', '1990-06-09 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '8549084418',
        '8549084418', '2023-01-05 00:00:00.000000 +00:00', null, '2023-01-05 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('82905e4e-6867-406a-bb74-a0d2ae5a8137', 'dangkiem6202Dadmin', 'admin', 'Trần Hoàng Thái', 'Thái',
        'Trần Hoàng', '6202D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem6202Dadmin@vr.org.vn', '1982-11-21 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '4654674712',
        '4654674712', '2024-03-23 00:00:00.000000 +00:00', null, '2024-03-23 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('4592c072-4b64-4982-bea9-461e5ce2f01f', 'dangkiem3502Dadmin', 'admin', 'Chu Mạnh Đức', 'Đức', 'Chu Mạnh',
        '3502D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem3502Dadmin@vr.org.vn',
        '1975-04-01 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '8946356362', '8946356362',
        '2023-06-11 00:00:00.000000 +00:00', null, '2023-06-11 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('bbb0dda4-a1ea-49fe-96f9-52ecb114a6f8', 'dangkiem8806Dkdv', 'staff', 'Nhân viên TTDK 8806D', '8806D',
        'Nhân viên TTDK', '8806D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem8806Dkdv@vr.org.vn', '1986-05-07 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '5721441847',
        '5721441847', '2023-05-26 00:00:00.000000 +00:00', null, '2023-05-26 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('65bea7bd-3e23-448e-a484-01d5e817eef0', 'dangkiem3606Dkdv', 'staff', 'Nhân viên TTDK 3606D', '3606D',
        'Nhân viên TTDK', '3606D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem3606Dkdv@vr.org.vn', '1974-10-03 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '3452724831',
        '3452724831', '2024-01-06 00:00:00.000000 +00:00', null, '2024-01-06 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('33fcc6df-aa4f-4a31-b05c-a5457170639a', 'dangkiem2003Dkdv', 'staff', 'Nhân viên TTDK 2003D', '2003D',
        'Nhân viên TTDK', '2003D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem2003Dkdv@vr.org.vn', '1975-11-08 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '3127093126',
        '3127093126', '2023-06-28 00:00:00.000000 +00:00', null, '2023-06-28 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('b263d999-eb36-4556-b7ec-b59d286f7d9c', 'dangkiem3704Dadmin', 'admin', 'Hoàng Mạnh Huynh', 'Huynh',
        'Hoàng Mạnh', '3704D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem3704Dadmin@vr.org.vn', '1979-10-04 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '7239858457',
        '7239858457', '2024-04-08 00:00:00.000000 +00:00', null, '2024-04-08 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('b3b4ccb6-cd63-485a-a0ba-1e94ee6123dc', 'dangkiem4305Dkdv', 'staff', 'Nhân viên TTDK 4305D', '4305D',
        'Nhân viên TTDK', '4305D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem4305Dkdv@vr.org.vn', '1987-07-17 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '9599883707',
        '9599883707', '2023-10-14 00:00:00.000000 +00:00', null, '2023-10-14 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('a0170519-24e0-4e2f-be40-b11716646691', 'dangkiem7501Sadmin', 'admin', 'Nguyễn Thanh Tuệ', 'Tuệ',
        'Nguyễn Thanh', '7501S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem7501Sadmin@vr.org.vn', '1983-06-27 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '8399100451',
        '8399100451', '2023-01-21 00:00:00.000000 +00:00', null, '2023-01-21 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('4dd29615-6769-40bb-bae4-42f06ff5eec5', 'dangkiem2603Dadmin', 'admin', 'Trần Tiến Dũng', 'Dũng', 'Trần Tiến',
        '2603D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi', 'dangkiem2603Dadmin@vr.org.vn',
        '1975-05-20 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '5271355284', '5271355284',
        '2023-06-19 00:00:00.000000 +00:00', null, '2023-06-19 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('1923ecf2-99f5-44da-b4f3-6cd5e8d160b5', 'dangkiem6505Dkdv', 'staff', 'Nhân viên TTDK 6505D', '6505D',
        'Nhân viên TTDK', '6505D', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem6505Dkdv@vr.org.vn', '1983-01-16 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '6649168623',
        '6649168623', '2023-01-30 00:00:00.000000 +00:00', null, '2023-01-30 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('af72bde4-c4b1-4c2d-956c-8403b106c8f3', 'dangkiem1801Sadmin', 'admin', 'Nguyễn Đình Phong', 'Phong',
        'Nguyễn Đình', '1801S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem1801Sadmin@vr.org.vn', '1989-08-16 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '9143492181',
        '9143492181', '2023-04-17 00:00:00.000000 +00:00', null, '2023-04-17 00:00:00 +00:00');
INSERT INTO public.users (user_id, user_name, role, full_name, first_name, last_name, station_code, password, email,
                          date_of_birth, gender, about, avatar, phone_number, identity_no, created_at, updated_at,
                          login_date)
VALUES ('52ed7782-4caa-427f-9dde-b93dc86ad1bf', 'dangkiem7402Skdv', 'staff', 'Nhân viên TTDK 7402S', '7402S',
        'Nhân viên TTDK', '7402S', '$2a$10$h7A2gZQhDur0.DWme0Jdv./6PIuIVZwcLWNdgIpESFjFGy.LgLGNi',
        'dangkiem7402Skdv@vr.org.vn', '1973-09-01 00:00:00.000000 +00:00', 'Nam', 'none', 'none', '6979415177',
        '6979415177', '2023-03-15 00:00:00.000000 +00:00', null, '2023-03-15 00:00:00 +00:00');


-- Insert to inspection
INSERT INTO public.inspection (no, inspection_id, registration_id, inspection_date, expiry_date, station_code)
VALUES (1, '12358', '29A00111', '2022-12-06', '2023-06-04', '2901V');
INSERT INTO public.inspection (no, inspection_id, registration_id, inspection_date, expiry_date, station_code)
VALUES (2, '12359', '29A80157', '2022-11-17', '2023-05-16', '2902S');
INSERT INTO public.inspection (no, inspection_id, registration_id, inspection_date, expiry_date, station_code)
VALUES (3, '12360', '30A18821', '2022-12-31', '2023-06-29', '2902V');
INSERT INTO public.inspection (no, inspection_id, registration_id, inspection_date, expiry_date, station_code)
VALUES (4, '12361', '30A54084', '2022-11-08', '2023-05-07', '2902V');
INSERT INTO public.inspection (no, inspection_id, registration_id, inspection_date, expiry_date, station_code)
VALUES (5, '12362', '30A38454', '2022-11-27', '2023-05-26', '2902V');
INSERT INTO public.inspection (no, inspection_id, registration_id, inspection_date, expiry_date, station_code)
VALUES (6, '12363', '30A44435', '2022-11-28', '2023-05-27', '2902S');
INSERT INTO public.inspection (no, inspection_id, registration_id, inspection_date, expiry_date, station_code)
VALUES (7, '12364', '29A01234', '2022-06-08', '2023-06-03', '2902S');
INSERT INTO public.inspection (no, inspection_id, registration_id, inspection_date, expiry_date, station_code)
VALUES (8, '12365', '29A15045', '2022-05-08', '2023-05-03', '2901S');
INSERT INTO public.inspection (no, inspection_id, registration_id, inspection_date, expiry_date, station_code)
VALUES (9, '12366', '30A06747', '2022-06-28', '2023-06-23', '2901V');
INSERT INTO public.inspection (no, inspection_id, registration_id, inspection_date, expiry_date, station_code)
VALUES (10, '12367', '30A61911', '2022-05-07', '2023-05-02', '2901V');
INSERT INTO public.inspection (no, inspection_id, registration_id, inspection_date, expiry_date, station_code)
VALUES (11, '12368', '30A82935', '2022-06-30', '2023-06-25', '2901V');
INSERT INTO public.inspection (no, inspection_id, registration_id, inspection_date, expiry_date, station_code)
VALUES (12, '12369', '30A47830', '2022-06-02', '2023-05-28', '2901S');
INSERT INTO public.inspection (no, inspection_id, registration_id, inspection_date, expiry_date, station_code)
VALUES (13, '12370', '30A79645', '2022-05-21', '2023-05-16', '2902V');
INSERT INTO public.inspection (no, inspection_id, registration_id, inspection_date, expiry_date, station_code)
VALUES (14, '12371', '30A31127', '2022-05-30', '2023-05-25', '2902S');
INSERT INTO public.inspection (no, inspection_id, registration_id, inspection_date, expiry_date, station_code)
VALUES (15, '12372', '30A35425', '2022-06-11', '2023-06-06', '2902V');
INSERT INTO public.inspection (no, inspection_id, registration_id, inspection_date, expiry_date, station_code)
VALUES (16, '12373', '30A56792', '2022-05-15', '2023-05-10', '2902V');
INSERT INTO public.inspection (no, inspection_id, registration_id, inspection_date, expiry_date, station_code)
VALUES (17, '12374', '29A68688', '2021-09-07', '2024-08-22', '2902S');
INSERT INTO public.inspection (no, inspection_id, registration_id, inspection_date, expiry_date, station_code)
VALUES (18, '12375', '30A41968', '2021-09-07', '2024-08-22', '2901S');
INSERT INTO public.inspection (no, inspection_id, registration_id, inspection_date, expiry_date, station_code)
VALUES (19, '12376', '29A01975', '2019-12-05', '2022-11-19', '2901V');
INSERT INTO public.inspection (no, inspection_id, registration_id, inspection_date, expiry_date, station_code)
VALUES (20, '12377', '29A99999', '2021-02-02', '2024-01-18', '2902S');
INSERT INTO public.inspection (no, inspection_id, registration_id, inspection_date, expiry_date, station_code)
VALUES (21, '12378', '30A111111', '2022-12-12', '2025-11-26', '2902V');
INSERT INTO public.inspection (no, inspection_id, registration_id, inspection_date, expiry_date, station_code)
VALUES (22, '12379', '29A19798', '2019-12-05', '2022-11-19', '2902S');
INSERT INTO public.inspection (no, inspection_id, registration_id, inspection_date, expiry_date, station_code)
VALUES (23, '12380', '29A67247', '2019-12-05', '2022-11-19', '2902V');
INSERT INTO public.inspection (no, inspection_id, registration_id, inspection_date, expiry_date, station_code)
VALUES (24, '12381', '30A65866', '2022-10-31', '2025-10-15', '2901S');
INSERT INTO public.inspection (no, inspection_id, registration_id, inspection_date, expiry_date, station_code)
VALUES (25, '12382', '30A21901', '2021-10-06', '2024-09-20', '2902V');
INSERT INTO public.inspection (no, inspection_id, registration_id, inspection_date, expiry_date, station_code)
VALUES (26, '12383', '30A02943', '2022-12-12', '2025-11-26', '2902V');
INSERT INTO public.inspection (no, inspection_id, registration_id, inspection_date, expiry_date, station_code)
VALUES (27, '12384', '30A87829', '2021-10-06', '2024-09-20', '2902S');
INSERT INTO public.inspection (no, inspection_id, registration_id, inspection_date, expiry_date, station_code)
VALUES (28, '12385', '29A03038', '2023-01-02', '2025-12-17', '2902S');
INSERT INTO public.inspection (no, inspection_id, registration_id, inspection_date, expiry_date, station_code)
VALUES (29, '12386', '30A12345', '2021-05-05', '2024-04-19', '2901S');
INSERT INTO public.inspection (no, inspection_id, registration_id, inspection_date, expiry_date, station_code)
VALUES (30, '12387', '30A00056', '2021-10-06', '2024-09-20', '2902S');
INSERT INTO public.inspection (no, inspection_id, registration_id, inspection_date, expiry_date, station_code)
VALUES (31, '12388', '30A41975', '2021-03-08', '2024-02-21', '2901V');
INSERT INTO public.inspection (no, inspection_id, registration_id, inspection_date, expiry_date, station_code)
VALUES (32, '12389', '29A62164', '2021-10-06', '2024-09-20', '2902V');
INSERT INTO public.inspection (no, inspection_id, registration_id, inspection_date, expiry_date, station_code)
VALUES (33, '12390', '30A36382', '2023-01-02', '2025-12-17', '2902S');
INSERT INTO public.inspection (no, inspection_id, registration_id, inspection_date, expiry_date, station_code)
VALUES (34, '12391', '30A24155', '2021-03-08', '2024-02-21', '2901S');
INSERT INTO public.inspection (no, inspection_id, registration_id, inspection_date, expiry_date, station_code)
VALUES (35, '12392', '29A67890', '2022-10-31', '2025-10-15', '2902S');
INSERT INTO public.inspection (no, inspection_id, registration_id, inspection_date, expiry_date, station_code)
VALUES (36, '12393', '29A55555', '2023-01-02', '2025-12-17', '2902S');
INSERT INTO public.inspection (no, inspection_id, registration_id, inspection_date, expiry_date, station_code)
VALUES (37, '12394', '30A22234', '2021-10-06', '2024-09-20', '2902V');
INSERT INTO public.inspection (no, inspection_id, registration_id, inspection_date, expiry_date, station_code)
VALUES (38, '12395', '29A50424', '2023-01-02', '2025-12-17', '2902V');
INSERT INTO public.inspection (no, inspection_id, registration_id, inspection_date, expiry_date, station_code)
VALUES (39, '12396', '29A38356', '2021-10-06', '2024-09-20', '2901V');
INSERT INTO public.inspection (no, inspection_id, registration_id, inspection_date, expiry_date, station_code)
VALUES (40, '12397', '29A40008', '2021-09-07', '2024-08-22', '2902V');
INSERT INTO public.inspection (no, inspection_id, registration_id, inspection_date, expiry_date, station_code)
VALUES (41, '12398', '29A56834', '2019-12-05', '2022-11-19', '2902V');
INSERT INTO public.inspection (no, inspection_id, registration_id, inspection_date, expiry_date, station_code)
VALUES (42, '12399', '29A91690', '2023-04-04', '2026-03-19', '2902V');
INSERT INTO public.inspection (no, inspection_id, registration_id, inspection_date, expiry_date, station_code)
VALUES (43, '12400', '30A00666', '2023-04-04', '2026-03-19', '2902V');
INSERT INTO public.inspection (no, inspection_id, registration_id, inspection_date, expiry_date, station_code)
VALUES (44, '12401', '30A62626', '2023-04-04', '2026-03-19', '2902S');
INSERT INTO public.inspection (no, inspection_id, registration_id, inspection_date, expiry_date, station_code)
VALUES (45, '12402', '29A36364', '2023-04-04', '2026-03-19', '2901V');
INSERT INTO public.inspection (no, inspection_id, registration_id, inspection_date, expiry_date, station_code)
VALUES (46, '12403', '29A74070', '2022-12-12', '2025-11-26', '2902S');
INSERT INTO public.inspection (no, inspection_id, registration_id, inspection_date, expiry_date, station_code)
VALUES (47, '12404', '30A77211', '2021-03-08', '2024-02-21', '2902V');
INSERT INTO public.inspection (no, inspection_id, registration_id, inspection_date, expiry_date, station_code)
VALUES (48, '12405', '30A16161', '2019-12-05', '2022-11-19', '2902S');


