
-- ===========================
-- HOSPITAL DATABASE
-- ===========================

CREATE TABLE departments(
department_id SERIAL PRIMARY KEY,
department_name VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE doctors(
doctor_id SERIAL PRIMARY KEY,
doctor_name VARCHAR(100) NOT NULL,
specialization VARCHAR(100),
department_id INT REFERENCES departments(department_id),
experience INT
);

CREATE TABLE patients(
patient_id SERIAL PRIMARY KEY,
patient_name VARCHAR(100) NOT NULL,
age INT,
gender VARCHAR(20),
phone VARCHAR(20),
city VARCHAR(100)
);

CREATE TABLE rooms(
room_id SERIAL PRIMARY KEY,
room_number INT UNIQUE,
room_type VARCHAR(50),
status VARCHAR(50)
);

CREATE TABLE medicines(
medicine_id SERIAL PRIMARY KEY,
medicine_name VARCHAR(100),
company VARCHAR(100),
price DECIMAL(10,2),
stock INT
);

CREATE TABLE appointments(
appointment_id SERIAL PRIMARY KEY,
patient_id INT REFERENCES patients(patient_id),
doctor_id INT REFERENCES doctors(doctor_id),
appointment_date DATE
);

CREATE TABLE prescriptions(
prescription_id SERIAL PRIMARY KEY,
patient_id INT REFERENCES patients(patient_id),
doctor_id INT REFERENCES doctors(doctor_id),
medicine_id INT REFERENCES medicines(medicine_id),
dosage VARCHAR(100),
prescription_date DATE
);

CREATE TABLE bills(
bill_id SERIAL PRIMARY KEY,
patient_id INT REFERENCES patients(patient_id),
total_amount DECIMAL(10,2),
payment_status VARCHAR(30),
bill_date DATE
);



