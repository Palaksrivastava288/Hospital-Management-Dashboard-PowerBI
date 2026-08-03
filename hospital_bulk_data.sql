-- Bulk demo data
BEGIN;
INSERT INTO departments(department_name) VALUES
('Cardiology'),
('Neurology'),
('Orthopedics'),
('Pediatrics'),
('Dermatology'),
('ENT'),
('Oncology'),
('Radiology'),
('General Medicine'),
('Gynecology') ON CONFLICT DO NOTHING;

INSERT INTO doctors(doctor_name,specialization,department_id,experience)
SELECT 'Doctor_'||g,
       (ARRAY['Cardiologist','Neurologist','Orthopedic','Pediatrician','Dermatologist','ENT','Oncologist','Radiologist','Physician','Gynecologist'])[((g-1)%10)+1],
       ((g-1)%10)+1,
       (random()*20+1)::int
FROM generate_series(1,25) g;

INSERT INTO patients(patient_name,age,gender,phone,city)
SELECT 'Patient_'||g,
       (random()*60+18)::int,
       (ARRAY['Male','Female'])[(random()*1)::int+1],
       '98'||lpad((10000000+g)::text,8,'0'),
       (ARRAY['Delhi','Mumbai','Lucknow','Noida','Jaipur','Pune','Bhopal','Kolkata'])[(random()*7)::int+1]
FROM generate_series(1,250) g;

INSERT INTO rooms(room_number,room_type,status)
SELECT 100+g,
       (ARRAY['General','Private','ICU'])[(random()*2)::int+1],
       (ARRAY['Available','Occupied'])[(random()*1)::int+1]
FROM generate_series(1,50) g;

INSERT INTO medicines(medicine_name,company,price,stock)
SELECT 'Medicine_'||g,
       'Company_'||((g-1)%10+1),
       round((random()*900+100)::numeric,2),
       (random()*500)::int
FROM generate_series(1,80) g;

INSERT INTO appointments(patient_id,doctor_id,appointment_date)
SELECT (random()*249+1)::int,
       (random()*24+1)::int,
       CURRENT_DATE-((random()*365)::int)
FROM generate_series(1,1000);

INSERT INTO prescriptions(patient_id,doctor_id,medicine_id,dosage,prescription_date)
SELECT (random()*249+1)::int,
       (random()*24+1)::int,
       (random()*79+1)::int,
       (ARRAY['1-0-1','0-1-0','1-1-1','1-0-0'])[(random()*3)::int+1],
       CURRENT_DATE-((random()*365)::int)
FROM generate_series(1,700);

INSERT INTO bills(patient_id,total_amount,payment_status,bill_date)
SELECT (random()*249+1)::int,
       round((random()*9000+500)::numeric,2),
       (ARRAY['Paid','Pending'])[(random()*1)::int+1],
       CURRENT_DATE-((random()*365)::int)
FROM generate_series(1,1000);

COMMIT;
