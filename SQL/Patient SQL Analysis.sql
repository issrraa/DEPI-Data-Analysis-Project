-- Analysis For patients
SELECT COUNT(patient_id) AS Total_Patients
 FROM patients;
-- we have 60000 patients 

SELECT ROUND(AVG(age)) FROM patients;
-- the avarge of patient age is 47

SElECT COUNT(gender) FROM patients
WHERE gender = "Female";
-- we have 36036 female patients

SElECT COUNT(gender) FROM patients
WHERE gender = "Male";


SELECT gender,
COUNT(*) AS Total_Patients,
ROUND(COUNT(*) *100/(SELECT COUNT(*)FROM patients)) AS Percentage_of_Total
FROM patients
GROUP BY gender;
-- we have 23964 Male patients As 40% and 36036 Female patients As 60%.

SELECT ethnicity,
COUNT(*) AS Total_patients,
ROUND(COUNT(*)*100/(SELECT COUNT(*)FROM patients)) AS Percentage_of_Ethnicity
FROM patients
GROUP BY ethnicity;
-- Our patients are 40% of hispanic , 36% of White and 24% of Asian

SELECT insurance_type, COUNT(insurance_type) AS insurance_company
FROM patients
GROUP BY insurance_type
ORDER BY insurance_company DESC;
-- the most our cases are from Medicaid company

SELECT marital_status,
COUNT(marital_status) AS marital_state,
ROUND(COUNT(marital_status)*100/(SELECT COUNT(*)FROM patients)) AS Percentage 
FROM patients
GROUP BY marital_status
ORDER BY marital_state DESC;
-- 45% of our patients are married, 25% are Widowed or divorced or separated, 20% are single and 10% are missed

SELECT city, 
COUNT(city) AS total_city
FROM patients
GROUP BY city
ORDER BY total_city DESC;
-- most of our cases we didn't know where are from 

SELECT state, 
COUNT(state) AS total_state
FROM patients
GROUP BY state
ORDER BY total_state DESC;

-- The most of our cases are from California state 

SELECT p.marital_status, e.reason_for_visit, COUNT(*) AS total_visits
FROM encounters AS e
JOIN patients AS p 
    ON p.patient_id = e.patient_id
GROUP BY p.marital_status, e.reason_for_visit
ORDER BY p.marital_status, total_visits DESC;




SELECT readmitted_flag, reason_for_visit
FROM encounters
WHERE readmitted_flag LIKE '%Yes%';
