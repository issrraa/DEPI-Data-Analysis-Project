-- Provider Analysis
SELECT COUNT(provider_id) AS Total_Doctors
FROM providers ;
-- we have 1491 doctors or providers

SELECT specialty, COUNT(specialty) AS specialty_no
FROM providers
GROUP BY specialty;

SELECT MAX(years_experience) AS Max_experience, 
MIN(years_experience)AS Min_experience,
ROUND(AVG(years_experience),0) AS Avg_experience
FROM providers;
-- max years experience = 40
-- min years experience = 1
-- avg years experience = 13

SELECT inhouse, COUNT(inhouse)
FROM providers
WHERE inhouse = 'Yes';
-- we have 1263 inhouse Doctors

SELECT inhouse, COUNT(inhouse)
FROM providers
WHERE inhouse = 'No';

SELECT inhouse,
COUNT(inhouse) AS inhouse_doctors,
ROUND(COUNT(inhouse)*100/(SELECT COUNT(*)FROM providers)) AS percentage
FROM providers
GROUP BY inhouse;

----------------------------------------

SELECT d.provider_id, d.name, COUNT(b.procedure_id) AS total_procedures
FROM providers AS d
JOIN provider_procedure_bridge AS b
ON d.provider_id = b.provider_id
GROUP BY d.provider_id, d.name
ORDER BY total_procedures DESC;

-- According to the data analysis, Dr. Roy Williams recorded the highest number of performed procedures 
-- a total of 489 surgeries during the last three months.

