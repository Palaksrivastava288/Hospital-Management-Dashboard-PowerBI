-- ===========================
-- HOSPITAL DATABASE
-- ===========================
CREATE TABLES

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

INSERTING INTO DATA


-- ===========================
-- DEPARTMENTS
-- ===========================
INSERT INTO departments(department_name)
VALUES
('Cardiology'),
('Neurology'),
('Orthopedics'),
('Pediatrics'),
('Dermatology'),
('ENT'),
('General Medicine'),
('Gynecology'),
('Psychiatry'),
('Emergency');

-- ===========================
-- DOCTORS
-- ===========================
INSERT INTO doctors
(doctor_name,specialization,department_id,experience)

SELECT
'Doctor '||g,
(ARRAY[
'Cardiologist',
'Neurologist',
'Orthopedic',
'Pediatrician',
'Dermatologist',
'ENT Specialist',
'General Physician',
'Gynecologist',
'Psychiatrist',
'Emergency Specialist'
])[((g-1)%10)+1],
((g-1)%10)+1,
(random()*18+2)::INT
FROM generate_series(1,25) g;

-- ===========================
-- ROOMS
-- ===========================
INSERT INTO rooms
(room_number,room_type,status)

SELECT
100+g,
CASE
WHEN random()<0.33 THEN 'General'
WHEN random()<0.66 THEN 'Private'
ELSE 'ICU'
END,
CASE
WHEN random()<0.8 THEN 'Available'
ELSE 'Occupied'
END
FROM generate_series(1,50) g;

-- ===========================
-- MEDICINES
-- ===========================
INSERT INTO medicines
(medicine_name,company,price,stock)

SELECT
'Medicine '||g,

(ARRAY[
'Cipla',
'Sun Pharma',
'Dr Reddy',
'Abbott',
'Pfizer',
'Mankind',
'Lupin',
'Zydus'
])[floor(random()*8+1)],
round((random()*900+100)::numeric,2),
(random()*400+20)::INT
FROM generate_series(1,80) g;


-- ===========================
-- PATIENTS
-- ===========================
INSERT INTO patients
(patient_name, age, gender, phone, city)

SELECT
'Patient ' || g,
(random() * 62 + 18)::INT,
CASE
    WHEN random() < 0.5 THEN 'Male'
    ELSE 'Female'
END,
'9' || LPAD((floor(random() * 1000000000))::TEXT, 9, '0'),
(ARRAY[
'Mumbai',
'Delhi',
'Bangalore',
'Hyderabad',
'Chennai',
'Pune',
'Kolkata',
'Ahmedabad',
'Jaipur',
'Lucknow'
])[floor(random() * 10 + 1)]
FROM generate_series(1,250) g;


-- ===========================================
-- APPOINTMENTS (1000)
-- ===========================================
INSERT INTO appointments
(patient_id, doctor_id, appointment_date)

SELECT
(random()*249+1)::INT,
(random()*24+1)::INT,
CURRENT_DATE - (random()*365)::INT
FROM generate_series(1,1000);

-- ===========================================
-- PRESCRIPTIONS (700)
-- ===========================================
INSERT INTO prescriptions
(patient_id, doctor_id, medicine_id, dosage, prescription_date)

SELECT
(random()*249+1)::INT,
(random()*24+1)::INT,
(random()*79+1)::INT,

(ARRAY[
'1 Tablet Daily',
'2 Tablets Daily',
'After Food',
'Before Food',
'Morning Only',
'Night Only',
'Twice Daily',
'Three Times Daily'
])[floor(random()*8+1)],

CURRENT_DATE - (random()*365)::INT
FROM generate_series(1,700);

-- ===========================================
-- BILLS (1000)
-- ===========================================

INSERT INTO bills
(patient_id, total_amount, payment_status, bill_date)

SELECT
(random()*249+1)::INT,
ROUND((random()*19000+1000)::NUMERIC,2),
CASE
WHEN random()<0.70 THEN 'Paid'
ELSE 'Pending'
END,
CURRENT_DATE - (random()*365)::INT
FROM generate_series(1,1000);
COMMIT;