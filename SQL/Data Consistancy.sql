 /*                              ============================================                               
                                 -- Data inconsistency resolution strategy --
								=============================================
*/
-- We implemented a data inconsistency resolution strategy to ensure data accuracy across patient records
SELECT * FROM patients;

/*-- we need to extract Area code from Phone Number, and add column for area code
ALTER TABLE patients ADD COLUMN area_code VARCHAR(3);


SELECT area_code FROM patients;


CREATE INDEX idx_patients_area ON patients(area_code);
CREATE INDEX idx_area_codes_area ON us_area_code_cities(area_code);


-- UPDATE patients AS p
-- JOIN us_area_code_cities AS a
-- ON p.area_code = a.area_code
-- SET 
--     p.city = COALESCE(p.city, a.city),
--     p.state = COALESCE(p.state, a.state)
-- WHERE p.city IS NULL OR p.state IS NULL;

UPDATE patients AS p
JOIN us_area_code_cities AS a
ON p.area_code = a.area_code
SET 
    p.city = CASE 
                WHEN TRIM(p.city) = '' OR p.city IS NULL THEN a.city 
                ELSE p.city 
             END,
    p.state = CASE 
                WHEN TRIM(p.state) = '' OR p.state IS NULL THEN a.state 
                ELSE p.state 
              END;


SELECT city FROM patients ;

SELECT COUNT(*) FROM patients WHERE TRIM(city) = '' OR city IS NULL;

SELECT DISTINCT city 
FROM patients 
WHERE city IS NULL OR city = '' OR city LIKE ' %';

UPDATE patients
SET city = NULL
WHERE city = '' OR city LIKE ' %';

UPDATE patients
SET state = NULL
WHERE state = '' OR state LIKE ' %';

UPDATE patients AS p
JOIN us_area_code_cities AS a
ON p.area_code = a.area_code
SET 
    p.city = COALESCE(p.city, a.city),
    p.state = COALESCE(p.state, a.state)
WHERE p.city IS NULL OR p.state IS NULL;

SELECT city, state , area_code FROM patients;

-- SELECT 
--     COUNT(*) AS total_records,
--     SUM(CASE WHEN city IS NULL OR city = '' OR city LIKE ' %' THEN 1 ELSE 0 END) AS empty_city,
--     SUM(CASE WHEN state IS NULL OR state = '' OR state LIKE ' %' THEN 1 ELSE 0 END) AS empty_state
-- FROM patients;

-- SELECT p.area_code, a.area_code, COUNT(*) AS matching_rows
-- FROM patients AS p
-- LEFT JOIN us_area_code_cities AS a
-- ON p.area_code = a.area_code
-- WHERE a.area_code IS NOT NULL
-- GROUP BY p.area_code
-- ORDER BY matching_rows DESC
-- LIMIT 10;*/
-- ===================================================================
ALTER TABLE us_area_code_cities MODIFY area_code VARCHAR(3);

ALTER TABLE patients ADD COLUMN clean_area_code VARCHAR(3);
ALTER TABLE patients MODIFY clean_area_code VARCHAR(20);


UPDATE patients
SET clean_area_code = 
    TRIM(LEADING '+1' FROM
    REPLACE(REPLACE(REPLACE(REPLACE(phone, '(', ''), ')', ''), '-', ''), ' ', '')
    );

SELECT phone, clean_area_code
FROM patients
LIMIT 10;

UPDATE patients
SET area_code = LEFT(clean_area_code, 3);


SELECT phone, clean_area_code, area_code
FROM patients
LIMIT 10;

UPDATE patients AS p
JOIN us_area_code_cities AS a
ON p.area_code = a.area_code
SET 
    p.city = COALESCE(NULLIF(p.city, ''), a.city),
    p.state = COALESCE(NULLIF(p.state, ''), a.state)
WHERE 
    (p.city IS NULL OR p.city = '' OR p.city LIKE ' %')
    OR (p.state IS NULL OR p.state = '' OR p.state LIKE ' %');
    
SELECT DISTINCT p.area_code
FROM patients AS p
LEFT JOIN us_area_code_cities AS a
ON p.area_code = a.area_code
WHERE a.area_code IS NULL
AND p.area_code IS NOT NULL;

UPDATE patients
SET area_code = TRIM(LEADING '0' FROM TRIM(area_code));

UPDATE patients AS p
JOIN us_area_code_cities AS a
ON p.area_code = a.area_code
SET 
    p.city = COALESCE(NULLIF(p.city, ''), a.city),
    p.state = COALESCE(NULLIF(p.state, ''), a.state)
WHERE 
    (p.city IS NULL OR p.city = '' OR p.city LIKE ' %')
    OR (p.state IS NULL OR p.state = '' OR p.state LIKE ' %');
    
SELECT DISTINCT p.area_code
FROM patients AS p
LEFT JOIN us_area_code_cities AS a
    ON p.area_code = a.area_code
WHERE a.area_code IS NULL
  AND p.area_code IS NOT NULL;
  
SELECT area_code, city, state
FROM us_area_code_cities
WHERE area_code IN ('232','233','235','236','237','238','241');

SELECT * FRom us_area_code_cities
WHERE country_code = "CA";

SELECT 
    COUNT(*) AS total,
    SUM(CASE WHEN city IS NULL OR city = '' THEN 1 ELSE 0 END) AS missing_city,
    SUM(CASE WHEN state IS NULL OR state = '' THEN 1 ELSE 0 END) AS missing_state
FROM patients;
-- missing_city and state 5937

UPDATE patients
SET area_code = SUBSTRING(
    REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(phone, '+1', ''), '(', ''), ')', ''), '-', ''), ' ', ''), 
    1, 3
);

UPDATE patients AS p
JOIN us_area_code_cities AS a
ON p.area_code = a.area_code
SET 
    p.city = COALESCE(NULLIF(p.city, ''), a.city),
    p.state = COALESCE(NULLIF(p.state, ''), a.state)
WHERE 
    (p.city IS NULL OR p.city = '' OR p.city LIKE ' %')
    OR (p.state IS NULL OR p.state = '' OR p.state LIKE ' %');
-- i have error for varchar lengh

ALTER TABLE patients MODIFY COLUMN state VARCHAR(100);
ALTER TABLE patients MODIFY COLUMN city VARCHAR(100);

UPDATE patients AS p
JOIN us_area_code_cities AS a
ON p.area_code = a.area_code
SET 
    p.city = COALESCE(NULLIF(p.city, ''), a.city),
    p.state = COALESCE(NULLIF(p.state, ''), a.state)
WHERE 
    (p.city IS NULL OR p.city = '' OR p.city LIKE ' %')
    OR (p.state IS NULL OR p.state = '' OR p.state LIKE ' %');
    
-- Varification
SELECT 
    COUNT(*) AS total,
    SUM(CASE WHEN city IS NULL OR city = '' THEN 1 ELSE 0 END) AS missing_city,
    SUM(CASE WHEN state IS NULL OR state = '' THEN 1 ELSE 0 END) AS missing_state
FROM patients;
-- we have 4058 missing values

SELECT city , state, phone
from patients
where city is NULL and phone is NULL;

SELECT COUNT(p.patient_id)
FROM patients AS p
JOIN encounters AS e 
ON p.patient_id = e.patient_id
WHERE age < 16
AND admission_type = 'Maternity' AND reason_for_visit = "Prenatal visit";


DELETE e
FROM encounters AS e
JOIN patients AS p 
ON e.patient_id = p.patient_id
WHERE 
    p.age < 16
    AND e.admission_type = 'Maternity'
    AND e.reason_for_visit = 'Prenatal visit';
    


