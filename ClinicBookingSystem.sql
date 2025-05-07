-- Create Database

CREATE DATABASE ClinicBookingSystem;
-- Use the created database

USE ClinicBookingSystem;

-- Users Table (patients, admins, receptionists)
CREATE TABLE Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    phone_number VARCHAR(15),
    user_role ENUM('patient', 'admin', 'receptionist') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Doctors Table
CREATE TABLE Doctors (
    doctor_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100) NOT NULL,
    specialty VARCHAR(100) NOT NULL,
    phone_number VARCHAR(15),
    email VARCHAR(100) UNIQUE,
    room_number VARCHAR(10)
);

-- Appointments Table
CREATE TABLE Appointments (
    appointment_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_date DATETIME NOT NULL,
    status ENUM('scheduled', 'completed', 'cancelled') DEFAULT 'scheduled',
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (patient_id) REFERENCES Users(user_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
);

-- Treatments Table
CREATE TABLE Treatments (
    treatment_id INT PRIMARY KEY AUTO_INCREMENT,
    appointment_id INT NOT NULL,
    treatment_description TEXT NOT NULL,
    prescribed_medication TEXT,
    treatment_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (appointment_id) REFERENCES Appointments(appointment_id)
);

-- Billing Table
CREATE TABLE Billing (
    bill_id INT PRIMARY KEY AUTO_INCREMENT,
    appointment_id INT NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    payment_status ENUM('paid', 'unpaid') DEFAULT 'unpaid',
    payment_method ENUM('cash', 'card', 'insurance'),
    billing_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (appointment_id) REFERENCES Appointments(appointment_id)
);
-- Insert users (patients, admin, receptionist)
INSERT INTO Users (full_name, email, password_hash, phone_number, user_role)
VALUES 
('John Duke', 'john@example.com', 'hashed_pw_123', '1234567890', 'patient'),
('Bela Pope', 'bela@example.com', 'hashed_pw_456', '0987654321', 'patient'),
('Alice Admin', 'admin@clinic.com', 'admin_pw', '1122334455', 'admin'),
('Bob Bob', 'reception@clinic.com', 'recep_pw', '5566778899', 'receptionist');

-- Insert doctors
INSERT INTO Doctors (full_name, specialty, phone_number, email, room_number)
VALUES 
('Dr. Gregory House', 'Internal Medicine', '1112223333', 'house@clinic.com', 'A29'),
('Dr. Meredith Grey', 'Surgery', '2223334444', 'grey@clinic.com', 'B20');

-- Insert appointments
INSERT INTO Appointments (patient_id, doctor_id, appointment_date, status, notes)
VALUES 
(1, 1, '2025-05-05 10:00:00', 'scheduled', 'Check-up for cold symptoms'),
(2, 2, '2025-05-06 14:30:00', 'scheduled', 'Pre-surgery consultation');

-- Insert treatments
INSERT INTO Treatments (appointment_id, treatment_description, prescribed_medication)
VALUES 
(1, 'Examination and diagnosis of common cold', 'Paracetamol, Vitamin C'),
(2, 'Consultation and lab tests ordered', 'None yet');

-- Insert billing
INSERT INTO Billing (appointment_id, amount, payment_status, payment_method)
VALUES 
(1, 50.00, 'paid', 'cash'),
(2, 100.00, 'unpaid', NULL);