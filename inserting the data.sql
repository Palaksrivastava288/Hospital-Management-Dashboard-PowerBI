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

select current_database();

SELECT 'patients', COUNT(*) FROM patients
UNION ALL
SELECT 'doctors', COUNT(*) FROM doctors
UNION ALL
SELECT 'departments', COUNT(*) FROM departments
UNION ALL
SELECT 'appointments', COUNT(*) FROM appointments
UNION ALL
SELECT 'bills', COUNT(*) FROM bills
UNION ALL
SELECT 'medicines', COUNT(*) FROM medicines
UNION ALL
SELECT 'prescriptions', COUNT(*) FROM prescriptions
UNION ALL
SELECT 'rooms', COUNT(*) FROM rooms;