INSERT INTO users(email, name, last_name, driver, hashed_password)
VALUES ('a', 'a', 'a', false, 'a');

SELECT * FROM users;
SELECT * FROM rides;

CREATE TABLE rides(
    id uuid primary key default(gen_random_uuid()),
    user_id uuid references users(id) on delete set null,
    driver_id uuid references users(id) on delete set null,
    start_lat float,
    start_lon float,
    end_lat float,
    end_lon float
);
DROP TABLE rides;

CREATE TABLE users(
    id uuid primary key default(gen_random_uuid()),
    email varchar(254) unique,
    hashed_password varchar(256),
    name varchar(100),
    last_name varchar(100),
    driver bool
);
DROP TABLE users;

CREATE TYPE ride_state as enum ('CREATED', 'RUNNING', 'COMPLETED', 'DELETED');

ALTER TABLE rides alter column end_lat type double precision;

select * from rides;

CREATE TABLE reviews(
    id uuid primary key default(gen_random_uuid()),
    ride_id uuid references rides(id) not null unique,
    driver_review text,
    user_review text,
    driver_stars int,
    user_stars int,
    check (driver_stars > 0 AND driver_stars < 6),
    check (user_stars > 0 AND user_stars < 6)
);

INSERT INTO reviews(ride_id, driver_stars, user_stars) VALUES ('aa45e46f-68bb-478c-b2a0-ede012788979', 3, 5)
