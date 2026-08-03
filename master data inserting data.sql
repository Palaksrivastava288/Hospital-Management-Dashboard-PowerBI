-- =========================
-- Departments
-- =========================

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

-- =========================
-- Doctors (25)
-- =========================

INSERT INTO doctors(doctor_name,specialization,department_id,experience)
SELECT
'Doctor '||g,
CASE ((g-1)%10)
WHEN 0 THEN 'Cardiologist'
WHEN 1 THEN 'Neurologist'
WHEN 2 THEN 'Orthopedic'
WHEN 3 THEN 'Pediatrician'
WHEN 4 THEN 'Dermatologist'
WHEN 5 THEN 'ENT Specialist'
WHEN 6 THEN 'General Physician'
WHEN 7 THEN 'Gynecologist'
WHEN 8 THEN 'Psychiatrist'
ELSE 'Emergency Specialist'
END,
((g-1)%10)+1,
(2+floor(random()*20))::int
FROM generate_series(1,25) g;

-- =========================
-- Rooms (50)
-- =========================

INSERT INTO rooms(room_number,room_type,status)
SELECT
100+g,
CASE
WHEN random()<0.33 THEN 'General'
WHEN random()<0.66 THEN 'ICU'
ELSE 'Private'
END,
CASE
WHEN random()<0.75 THEN 'Available'
ELSE 'Occupied'
END
FROM generate_series(1,50) g;

-- =========================
-- Medicines (80)
-- =========================

INSERT INTO medicines(medicine_name,company,price,stock)
SELECT
'Medicine '||g,
CASE ((g-1)%8)
WHEN 0 THEN 'Sun Pharma'
WHEN 1 THEN 'Cipla'
WHEN 2 THEN 'Dr Reddy'
WHEN 3 THEN 'Mankind'
WHEN 4 THEN 'Abbott'
WHEN 5 THEN 'Pfizer'
WHEN 6 THEN 'Lupin'
ELSE 'Zydus'
END,
round((50+random()*950)::numeric,2),
(20+floor(random()*300))::int
FROM generate_series(1,80) g;