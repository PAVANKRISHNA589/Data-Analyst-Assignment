/*03_Clinic_Schema_Setup.sql*/

/* CREATE TABLES*/

/*CLINICS TABLE */

CREATE TABLE clinics (
    cid VARCHAR(50) PRIMARY KEY,
    clinic_name VARCHAR(100),
    city VARCHAR(100),
    state VARCHAR(100),
    country VARCHAR(100)
);


/* CUSTOMER TABLE */

CREATE TABLE customer (
    uid VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100),
    mobile VARCHAR(15)
);


/* CLINIC SALES TABLE */

CREATE TABLE clinic_sales (
    oid VARCHAR(50) PRIMARY KEY,
    uid VARCHAR(50),
    cid VARCHAR(50),
    amount DECIMAL(10,2),
    datetime TIMESTAMP,
    sales_channel VARCHAR(50),
    FOREIGN KEY (uid) REFERENCES customer(uid),
    FOREIGN KEY (cid) REFERENCES clinics(cid)
);


/* EXPENSES TABLE */

CREATE TABLE expenses (
    eid VARCHAR(50) PRIMARY KEY,
    cid VARCHAR(50),
    description VARCHAR(255),
    amount DECIMAL(10,2),
    datetime TIMESTAMP,
    FOREIGN KEY (cid) REFERENCES clinics(cid)
);


/* INSERT SAMPLE DATA */

/* CLINICS DATA */
INSERT INTO clinics VALUES
('C1', 'HealthCare Clinic', 'Hyderabad', 'Telangana', 'India'),
('C2', 'Wellness Center', 'Hyderabad', 'Telangana', 'India'),
('C3', 'City Hospital', 'Bangalore', 'Karnataka', 'India'),
('C4', 'MediCare', 'Chennai', 'Tamil Nadu', 'India');


/* CUSTOMER DATA */
INSERT INTO customer VALUES
('U1', 'John Doe', '9876543210'),
('U2', 'Alice Smith', '9123456780'),
('U3', 'Bob Johnson', '9988776655'),
('U4', 'David Lee', '9090909090');


/* CLINIC SALES DATA */
INSERT INTO clinic_sales VALUES
('O1', 'U1', 'C1', 2000, '2021-10-10 10:00:00', 'online'),
('O2', 'U2', 'C1', 3000, '2021-10-15 12:00:00', 'offline'),
('O3', 'U3', 'C2', 1500, '2021-10-20 14:00:00', 'online'),
('O4', 'U1', 'C2', 2500, '2021-11-05 11:00:00', 'offline'),
('O5', 'U4', 'C3', 4000, '2021-11-10 16:00:00', 'online'),
('O6', 'U2', 'C3', 3500, '2021-11-15 18:00:00', 'offline'),
('O7', 'U3', 'C4', 1800, '2021-11-20 09:00:00', 'online');


/* EXPENSES DATA */
INSERT INTO expenses VALUES
('E1', 'C1', 'Equipment', 1000, '2021-10-10 08:00:00'),
('E2', 'C1', 'Staff Salary', 1200, '2021-10-15 09:00:00'),
('E3', 'C2', 'Maintenance', 800, '2021-10-20 10:00:00'),
('E4', 'C2', 'Supplies', 700, '2021-11-05 08:00:00'),
('E5', 'C3', 'Equipment', 2000, '2021-11-10 10:00:00'),
('E6', 'C3', 'Salary', 1500, '2021-11-15 11:00:00'),
('E7', 'C4', 'Utilities', 900, '2021-11-20 07:00:00');
