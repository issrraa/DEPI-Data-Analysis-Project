-- Encounter Analysis

SELECT COUNT(encounter_id) FROM encounters;
-- we have 70000 encounters

SELECT department, COUNT(department) AS departement,
ROUND(COUNT(department)*100/(SELECT COUNT(*)FROM encounters)) AS Total_percentage
FROM encounters
GROUP BY department
ORDER BY Total_percentage DESC;
-- The highest workload and patient flow departement in our hospital is Emergency Departement

SELECT visit_type, COUNT(visit_type) AS The_visit_type
FROM encounters
GROUP BY visit_type
ORDER BY The_visit_type DESC;
-- The most visit type we have is Outpatient

SELECT readmitted_flag,
COUNT(readmitted_flag) AS readmitted_flag,
ROUND(COUNT(readmitted_flag)*100/(SELECT COUNT(*)FROM encounters)) AS percentage
FROM encounters
GROUP BY readmitted_flag;
-- 16% of patients were readmitted after discharge, while 84% were not readmitted.
-- This indicates that the majority of patients (over four-fifths) did not require readmission.
SELECT reason_for_visit, COUNT(*) AS count_readmitted
FROM encounters
WHERE readmitted_flag LIKE '%Yes%'
GROUP BY reason_for_visit
ORDER BY count_readmitted DESC;





