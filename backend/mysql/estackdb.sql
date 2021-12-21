-- This version of the database is intended to work with legacy versions of MySQL

-- -------------------------------------------------
-- ENTER YOUR QUERY SOLUTIONS STARTING AT LINE 116
-- -------------------------------------------------

drop database if exists estackdb;
create database if not exists estackdb;
use estackdb;

-- -----------------------------------------------
-- table structures
-- -----------------------------------------------

create table users (
uname VARCHAR(40),
email VARCHAR(40) NOT NULL,
password VARCHAR(256) NOT NULL,
fname VARCHAR(100),
lname VARCHAR(100),
birthdate DATE,
street VARCHAR(200),
city VARCHAR(85),
state CHAR(2) CHECK(length(state) = 2),
zip_code CHAR(5) CHECK(length(Zip_Code) = 5),
PRIMARY KEY (email),
unique key (street, city, state, zip_code),
unique key(uname)
) engine = innodb;

create table owners (
email VARCHAR(40) NOT NULL,
cvv VARCHAR(4) CHECK(length(cvv) = 3 or length(cvv) = 4),
card_number VARCHAR(23) CHECK(length(card_number) >= 9),
expiration_date DATE,
upgraded BOOLEAN default false,
PRIMARY KEY (email)
) engine = innodb;

create table landlords (
email VARCHAR(40) NOT NULL,
PRIMARY KEY(email)
) engine = innodb;

create table sellers (
email VARCHAR(40) NOT NULL,
PRIMARY KEY(email)
) engine = innodb;

create table customers (
email VARCHAR(40) NOT NULL,
cvv VARCHAR(4) CHECK(length(cvv) = 3 or length(cvv) = 4),
card_number VARCHAR(23) CHECK(length(card_number) >= 9),
expiration_date DATE,
PRIMARY KEY (email)
) engine = innodb;


create table properties (
	-- address
    street VARCHAR(200) NOT NULL,
    city VARCHAR(85) NOT NULL,
    state CHAR(2) NOT NULL CHECK(length(State) = 2),
    zip CHAR(5) NOT NULL CHECK(length(Zip) = 5),

    
    type VARCHAR(20) NOT NULL,
    numBedrooms INT NOT NULL CHECK (numBedrooms >= 1),
    numBathrooms INT NOT NULL CHECK (numBathrooms >= 1),
    sqaureft DECIMAL(6, 2) NOT NULL CHECK (sqaureft >= 0),
    yearBuilt DATE,
    garageParking INT,
    ac BOOLEAN,
    wheelChairAcces BOOLEAN,
    offStreetParking BOOLEAN,
    balcony BOOLEAN,
    furnished BOOLEAN,
    hardWood BOOLEAN,
    listingPrice DECIMAL(10, 2),

    property_name VARCHAR(50) NOT NULL,
    owner_email VARCHAR(50) NOT NULL,
    descr VARCHAR(500) NOT NULL,
    -- image file name
    filename VARCHAR(64),
    PRIMARY KEY (property_Name, owner_Email),
    FOREIGN KEY (Owner_Email) REFERENCES owners (email),
    UNIQUE KEY (street, city, state, zip)
);



-- users (uname, email, password, fname, lname, birthdate, street, city, state, zip_code)
insert into users values
('jstone5', 'jared@gmail.com', 'passwordP!', 'Jared', 'Stone', '1961-01-06', '101 Five Finger Way', 'Atlanta', 'GA', '30333'),
('johnDoe1', 'JohnD1@gmail.com', 'passwordP!', 'John', 'Doe', '1999-12-31', '123 Maple Street', 'Anytown', 'PA', '20522'),
(NULL, 'sarahprince@gmail.com', 'passwordP!', 'Sarah', 'Prince', NULL,  NULL, NULL, NULL, NULL);

insert into owners values
('jared@gmail.com', '123', '4040 4040 4040 4040 404', '1920-03-01', false),
('JohnD1@gmail.com', '1234', '1234 5678', '2022-01-01', false);

insert into properties values
('Front Street', 'Ann Arbor', 'MI', '40044', "Apartment", 2, 2, 860, '1980-01-01', 5, true, true, true, true, true, true, 200000.43, "White House", "jared@gmail.com", "This is the first selling house!", NULL);

insert into properties values
('Back Street', 'Ann Arbor', 'MI', '40045', "Apartment", 2, 2, 860, '1980-01-01', 5, true, true, true, true, true, true, 200000.43, "White House 2", "jared@gmail.com", "This is the second selling house!", NULL);