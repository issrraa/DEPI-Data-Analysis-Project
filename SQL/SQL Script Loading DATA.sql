-- for loading large dataset
-------------------
SET GLOBAL local_infile = 1;
CREATE DATABASE IF NOT EXISTS SmartCare_Hospital;
USE SmartCare_Hospital;

-- Load the encounters Table 
CREATE TABLE IF NOT EXISTS encounters (
    encounter_id VARCHAR(20) PRIMARY KEY ,
    patient_id VARCHAR(20),
    provider_id VARCHAR(20),
    visit_date VARCHAR(20),
    -- identify the date firstly an int then alter to date 
    visit_type VARCHAR(50),
    department VARCHAR(50),
    reason_for_visit VARCHAR(50),
    diagnosis_code VARCHAR(20),
    admission_type VARCHAR(20),
    discharge_date VARCHAR(20),
    length_of_stay VARCHAR(20),
    status VARCHAR(10),
    readmitted_flag VARCHAR(10)
);
LOAD DATA LOCAL INFILE "D:\\SmartCare Hospital\\encounters.csv"
INTO TABLE encounters
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS(encounter_id,	patient_id,	provider_id,	visit_date,	visit_type,	department, reason_for_visit,
diagnosis_code,	admission_type,	discharge_date,	length_of_stay,	status,	readmitted_flag);

-- Validation the imported data
SELECT * FROM encounters;
SELECT COUNT(encounter_id) FROM encounters;
SELECT visit_date FROM encounters;

-- Load the providers table

CREATE TABLE IF NOT EXISTS providers (
    provider_id VARCHAR(30) PRIMARY KEY ,
    name VARCHAR(30) NOT NULL,
    department VARCHAR(60),
    specialty VARCHAR(50),
    npi VARCHAR(30),
    inhouse VARCHAR(3),
    location VARCHAR(5),
    years_experience INT,
    contact_info VARCHAR(20),
    email VARCHAR(40)
);
LOAD DATA LOCAL INFILE "D:\\SmartCare Hospital\\providers.csv"
INTO TABLE providers
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


-- For data validation
SELECT * FROM providers;
SELECT COUNT(name) FROM providers;

-- Load claims and billing table

CREATE TABLE IF NOT EXISTS claims_and_billing (
    billing_id VARCHAR(20) PRIMARY KEY,
    patient_id VARCHAR(20) NOT NULL,
    encounter_id VARCHAR(20),
    insurance_provider VARCHAR(20),
    payment_method VARCHAR(50),
    claim_id VARCHAR(50),
    claim_billing_date VARCHAR(20),
    billed_amount DECIMAL(10,2),
    paid_amount DECIMAL(10,2),
    claim_status VARCHAR(50),
    denial_reason VARCHAR(100)
);
-- DROP TABLE claims_and_billing;
LOAD DATA LOCAL INFILE "D:\\SmartCare Hospital\\claims_and_billing.csv"
INTO TABLE claims_and_billing
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(billing_id, patient_id, encounter_id, insurance_provider, payment_method, claim_id,
 claim_billing_date, billed_amount, paid_amount, claim_status, denial_reason
 );

-- To validate data 
SELECT * FROM claims_and_billing;
SELECT count(claim_id) FROM claims_and_billing;
SELECT claim_billing_date FROM claims_and_billing;

-- Load the patients Table
-- DROP TABLE patients;
CREATE TABLE IF NOT EXISTS patients (
    patient_id VARCHAR(20) PRIMARY KEY ,
    first_name VARCHAR(20),
	last_name VARCHAR(20),
    dob VARCHAR(30),
    age INT,
    gender VARCHAR(10),
    ethnicity VARCHAR(20),
    insurance_type VARCHAR(20),
    marital_status VARCHAR(30),
    address VARCHAR(100),
    city VARCHAR(20),
    state VARCHAR(20),
    zip VARCHAR(20),
    phone VARCHAR(15),
    email VARCHAR(40),
    registration_date VARCHAR(30)
);

LOAD DATA LOCAL INFILE "D:\\SmartCare Hospital\\patients.csv"
INTO TABLE patients
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(patient_id, first_name, last_name, dob, age, gender, ethnicity, insurance_type,
 marital_status, address, city,	state,	zip, phone, email, registration_date
);


-- For Validation
SELECT * FROM patients;
SELECT dob, registration_date FROM patients;

-- Load The medications Table 
DROP TABLE medications;
CREATE TABLE IF NOT EXISTS medications (
    medication_id VARCHAR(20) ,
    encounter_id VARCHAR(20),
    drug_name VARCHAR(70),
    dosage VARCHAR(50),
    route VARCHAR(50),
    frequency VARCHAR(50),
    duration VARCHAR(50),
    prescribed_date VARCHAR(20) ,
    provider_id VARCHAR(10),
    cost DECIMAL(10,2)
);

LOAD DATA LOCAL INFILE "D:\\SmartCare Hospital\\medications.csv"
INTO TABLE medications
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS(medication_id, encounter_id, drug_name, dosage, route,
 frequency, duration, prescribed_date , provider_id, cost
);

-- For Validation 
SELECT * FROM medications;
SELECT COUNT(medication_id) FROM medications;

-- Load the claim_denials Table

CREATE TABLE IF NOT EXISTS denials (
    claim_id VARCHAR(20),
    denial_id VARCHAR(20) PRIMARY KEY,
    denial_reason_code VARCHAR(20),
    denial_reason_description VARCHAR(100),
    denied_amount DECIMAL(10,2),
    denial_date VARCHAR(20),
    appeal_filed VARCHAR(3),
    appeal_status VARCHAR(50),
    appeal_resolution_date VARCHAR(20),
    final_outcome VARCHAR(20)
);

LOAD DATA LOCAL INFILE "D:\\SmartCare Hospital\\denials.csv"
INTO TABLE denials
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(claim_id, denial_id, denial_reason_code, denial_reason_description, denied_amount,denial_date,
 appeal_filed, appeal_status, appeal_resolution_date, final_outcome
);

-- For Valdiation
SELECT * FROM denials;
SELECT COUNT(denial_id) FROM denials;
SELECT appeal_resolution_date , denial_date FROM denials;


-- Load the procedures Table  
DROP TABLE procedures;
CREATE TABLE IF NOT EXISTS procedures (
	procedure_id VARCHAR(20) ,
	encounter_id VARCHAR(20),
	procedure_code VARCHAR(20),
	procedure_description VARCHAR(100),
	procedure_date VARCHAR(20),
    provider_id VARCHAR(20),
    procedure_cost DECIMAL(10,3)
);
LOAD DATA LOCAL INFILE "D:\\SmartCare Hospital\\procedures.csv"
INTO TABLE procedures
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(procedure_id, encounter_id, procedure_code, procedure_description, procedure_date, provider_id, procedure_cost);

-- For Validation 
SELECT * FROM procedures;
SELECT COUNT(procedure_id) FROM procedures;
SELECT procedure_date FROM procedures;


-- Load the diagnosis Table

CREATE TABLE IF NOT EXISTS diagnosis (	
	diagnosis_id VARCHAR(10) PRIMARY KEY ,
    encounter_id VARCHAR(10),
    diagnosis_code VARCHAR(10),
    diagnosis_discription VARCHAR(100),
    primary_flag BOOLEAN,
    chronic_flag BOOLEAN
);

LOAD DATA LOCAL INFILE "D:\\SmartCare Hospital\\diagnoses.csv"
INTO TABLE diagnosis
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- For Validation 
SELECT * FROM diagnosis;
SELECT COUNT(diagnosis_code) FROM diagnosis;

-- load the Lab_tests Table 
CREATE TABLE IF NOT EXISTS lab_tests (
	lab_id VARCHAR(10) PRIMARY KEY ,
    encounter_id VARCHAR(20),
    test_name VARCHAR(100),
    test_code VARCHAR(10),
    specimen_type VARCHAR(20),
    test_result VARCHAR(10),
    units VARCHAR(10),
    normal_range VARCHAR(10),
    test_date DATE,
    status VARCHAR(10)
);
LOAD DATA LOCAL INFILE "D:\\SmartCare Hospital\\lab_tests.csv"
INTO TABLE lab_tests
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;   

-- For Validation 
SELECT * FROM lab_tests ;
SELECT COUNT(lab_id) FROM lab_tests;



-- import bridging table to create many to many relationship between Providers and procedures

CREATE TABLE IF NOT EXISTS provider_procedure_bridge(	
	provider_procedure_id VARCHAR(20) PRIMARY KEY,
    provider_id VARCHAR(20),
    procedure_id VARCHAR(20)
);
LOAD DATA LOCAL INFILE "D:\SmartCare Hospital\Provider_Procedure_bridge.csv"
INTO TABLE Provider_Procedure_bridge
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;   


DROP TABLE us_area_code_cities;
CREATE TABLE us_area_code_cities (
    area_code VARCHAR(10) ,
    city VARCHAR(100),
    state VARCHAR(100),
    country_code VARCHAR(5)
);

 
LOAD DATA LOCAL INFILE "D:\\SmartCare Hospital\\us_area_code_cities.csv"
INTO TABLE us_area_code_cities
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(area_code, city, state, country_code);