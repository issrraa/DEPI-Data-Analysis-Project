
-- Cleaning the Dataset
-- Drop unnecessary tables
DROP TABLE lab_tests ;
----------------------------------------------------------------
-- Remove unnecessary columns in encounters table
ALTER TABLE encounters
DROP COLUMN length_of_stay,
DROP COLUMN discharge_date ;

-- change date format
ALTER TABLE encounters
ADD COLUMN updated_visit_date DATE;


UPDATE encounters
SET updated_visit_date = 
    CASE
        WHEN visit_date LIKE '%-%-%' AND LENGTH(visit_date) = 10 
            THEN STR_TO_DATE(visit_date, '%d-%m-%Y')   -- day-month-year first
		WHEN visit_date LIKE '%/%/%' AND LENGTH(visit_date) = 10 
			THEN STR_TO_DATE(visit_date, '%d/%m/%Y')   -- day/month/year
        ELSE NULL
    END;
    
-- For verification  
SELECT COUNT(updated_visit_date)
FROM encounters
WHERE updated_visit_date IS NULL;

-- Drop old table and CHANGE data type to DATE
ALTER TABLE  encounters
DROP COLUMN visit_date;
ALTER TABLE encounters 
CHANGE updated_visit_date visit_date DATE;


SELECT visit_date FROM encounters;

-- we didn't have duplicates in encounters 
------------------------------------------
-- SHOW COLUMNS FROM claims_and_billing;


-- replace NULL values to 0
-- UPDATE claims_and_billing
-- SET claim_id = IFNULL(claim_id, 'NO Claim');

-- UPDATE claims_and_billing
-- SET denial_reason = IFNULL(denial_reason,'successfully paid');
-------------------------------------------
-- Remove unnecessary columns in  Pateint table
ALTER TABLE patients
DROP COLUMN email,
-- DROP COLUMN phone,
DROP COLUMN address,
DROP COLUMN zip;

-- Merge first name and last name in one column(full name)
ALTER TABLE patients
ADD COLUMN full_name VARCHAR(50);

UPDATE patients
SET full_name = CONCAT(first_name, ' ', last_name);

-- replace NULL values to Unknown Location( in city and state columns) in patient table
-- UPDATE patients
-- SET city= IFNULL(city, 'Unknown location');

-- replace NULL values to 0
-- UPDATE patients
-- SET state = IFNULL(state, "Unknown location");

-- set the full name of state 
UPDATE patients
SET state = CASE state
    WHEN 'CA' THEN 'California'
    WHEN 'TX' THEN 'Texas'
    WHEN 'OR' THEN 'Oregon'
    WHEN 'WA' THEN 'Washington'
    WHEN 'AZ' THEN 'Arizona'
    WHEN 'NV' THEN 'Nevada'
    ELSE state
END; 

-- change date format in dob and registration_date
ALTER TABLE patients
ADD COLUMN updated_dob DATE,
ADD COLUMN updated_registration_date DATE;

UPDATE patients
SET updated_registration_date =
    CASE
        WHEN registration_date LIKE '__-__-____'
            THEN STR_TO_DATE(registration_date, '%d-%m-%Y')
        WHEN registration_date LIKE '____-__-__'
            THEN STR_TO_DATE(registration_date, '%Y-%m-%d')
        WHEN registration_date LIKE '__/__/____'
            THEN STR_TO_DATE(registration_date, '%d/%m/%Y')
        WHEN registration_date LIKE '____/__/__'
            THEN STR_TO_DATE(registration_date, '%Y/%m/%d')
        ELSE NULL
    END;

UPDATE patients
SET updated_dob = 
	CASE 
		WHEN dob LIKE '%-%-%'AND LENGTH(dob) = 10
			THEN STR_TO_DATE(dob,'%d-%m-%Y')
		WHEN dob LIKE "%/%/%" AND LENGTH(dob) = 10
			THEN STR_TO_DATE(dob,'%d/%m/%Y')
		ELSE NULL
	END;

--  for Varification
SELECT updated_registration_date FROM patients;

SELECT COUNT(updated_dob)
FROM patients
WHERE updated_dob IS NULL;		

SELECT COUNT(updated_registration_date)
FROM patients
WHERE updated_registration_date IS NULL;	

-- DROP old columns and change Data type to DATE 
ALTER TABLE patients
DROP COLUMN dob,
DROP COLUMN registration_date;

ALTER TABLE patients
CHANGE updated_registration_date registration_date DATE,
CHANGE updated_dob dob DATE;

SELECT COUNT(registration_date) FROM patients
WHERE registration_date IS NULL ;

SELECT dob, registration_date FROM patients;
 -----------------------------------------

-- *------------------------------------------------*
-- Remove unnecessary columns in  medications table

ALTER TABLE medications
DROP COLUMN dosage,
DROP COLUMN route,
DROP COLUMN frequency;

-- Convert the prescribed_date column to a proper DATE type so that MySQL can read it correctly
ALTER TABLE medications
ADD COLUMN clean_date DATE;

UPDATE medications
SET clean_date =
    CASE
        WHEN prescribed_date LIKE '__-__-____'
            THEN STR_TO_DATE(prescribed_date, '%d-%m-%Y')
        WHEN prescribed_date LIKE '____-__-__'
            THEN STR_TO_DATE(prescribed_date, '%Y-%m-%d')
        WHEN prescribed_date LIKE '__/__/____'
            THEN STR_TO_DATE(prescribed_date, '%d/%m/%Y')
        WHEN prescribed_date LIKE '____/__/__'
            THEN STR_TO_DATE(prescribed_date, '%Y/%m/%d')
        ELSE NULL
    END;
    
ALTER TABLE medications
DROP COLUMN prescribed_date;

ALTER TABLE medications
CHANGE clean_date prescribed_date DATE;

-- For Varification
SELECT prescribed_date FROM medications;

-------------------------------------------------

-- -- Remove unnecessary columns in  providers table
ALTER TABLE providers
DROP COLUMN email,
DROP COLUMN contact_info,
DROP COLUMN npi;
--  ------------------------------------------------
-- Handle incosistant Data

UPDATE patients
SET marital_status = "Single"
WHERE age < 16 AND marital_status = 'Married';


--------------------------------------
UPDATE patients
SET marital_status = "Single"
WHERE age < 16 AND marital_status = "Unknown";
