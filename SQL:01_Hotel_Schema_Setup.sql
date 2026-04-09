
/* CREATE TABLES */

/*USERS TABLE*/
CREATE TABLE users (
    user_id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100),
    phone_number VARCHAR(15),
    mail_id VARCHAR(100),
    billing_address VARCHAR(255)
);


/*BOOKINGS TABLE*/
CREATE TABLE bookings (
    booking_id VARCHAR(50) PRIMARY KEY,
    booking_date TIMESTAMP,
    room_no VARCHAR(20),
    user_id VARCHAR(50),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);


/*ITEMS TABLE*/
CREATE TABLE items (
    item_id VARCHAR(50) PRIMARY KEY,
    item_name VARCHAR(100),
    item_rate DECIMAL(10,2)
);


/*BOOKING COMMERCIALS TABLE*/
CREATE TABLE booking_commercials (
    id VARCHAR(50) PRIMARY KEY,
    booking_id VARCHAR(50),
    bill_id VARCHAR(50),
    bill_date TIMESTAMP,
    item_id VARCHAR(50),
    item_quantity DECIMAL(10,2),
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id),
    FOREIGN KEY (item_id) REFERENCES items(item_id)
);

/*    INSERT SAMPLE DATA */

/*USERS DATA*/
INSERT INTO users VALUES
('U1', 'John Doe', '9876543210', 'john@example.com', 'Street A'),
('U2', 'Alice Smith', '9123456780', 'alice@example.com', 'Street B'),
('U3', 'Bob Johnson', '9988776655', 'bob@example.com', 'Street C');


/*BOOKINGS DATA*/
INSERT INTO bookings VALUES
('B1', '2021-10-05 10:30:00', 'R101', 'U1'),
('B2', '2021-10-20 12:00:00', 'R102', 'U1'),
('B3', '2021-11-10 09:15:00', 'R201', 'U2'),
('B4', '2021-11-25 18:45:00', 'R202', 'U3'),
('B5', '2021-09-15 14:20:00', 'R103', 'U2');


/*ITEMS DATA*/
INSERT INTO items VALUES
('I1', 'Tawa Paratha', 20),
('I2', 'Mix Veg', 100),
('I3', 'Paneer Butter Masala', 250),
('I4', 'Rice', 80);


/*BOOKING COMMERCIALS DATA*/

INSERT INTO booking_commercials VALUES
('C1', 'B1', 'BL1', '2021-10-05 12:00:00', 'I1', 3),
('C2', 'B1', 'BL1', '2021-10-05 12:00:00', 'I2', 2),

('C3', 'B2', 'BL2', '2021-10-20 13:00:00', 'I3', 2),
('C4', 'B2', 'BL2', '2021-10-20 13:00:00', 'I4', 5),

('C5', 'B3', 'BL3', '2021-11-10 11:00:00', 'I1', 5),
('C6', 'B3', 'BL3', '2021-11-10 11:00:00', 'I3', 1),

('C7', 'B4', 'BL4', '2021-11-25 20:00:00', 'I2', 4),
('C8', 'B4', 'BL4', '2021-11-25 20:00:00', 'I4', 3),

('C9', 'B5', 'BL5', '2021-09-15 15:30:00', 'I1', 2),
('C10', 'B5', 'BL5', '2021-09-15 15:30:00', 'I2', 1);