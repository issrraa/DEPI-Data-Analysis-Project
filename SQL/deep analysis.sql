-- Advanced analysis
-- Accidental Injury
SELECT reason_for_visit, COUNT(*) AS total_visits
FROM encounters
GROUP BY reason_for_visit
ORDER BY total_visits DESC;
-- the highest reason for visit is Accidental Injury with 5483


SELECT p.city, p.state, COUNT(DISTINCT p.patient_id) AS total_patients_with_injury
FROM encounters AS e
JOIN patients AS p
ON p.patient_id = e.patient_id
WHERE e.reason_for_visit = 'Accidental Injury'
GROUP BY p.city, p.state
ORDER BY total_patients_with_injury DESC;
-- Website Accidential injuries in Fresno city : "https://www.singhahluwalia.com/most-dangerous-intersections-in-fresno/"

SELECT p.city, p.state, COUNT(DISTINCT p.patient_id) AS total_patients_with_injury
FROM encounters AS e
JOIN patients AS p
ON p.patient_id = e.patient_id
WHERE e.reason_for_visit = 'Hepatitis C'
GROUP BY p.city, p.state
ORDER BY total_patients_with_injury DESC;
-- Sacramento city in CA has the highst rate in Heoatitis C
-- 
-- Website"https://dhs.saccounty.gov/PUB/Documents/Epidemiology/RT-HepatitisFactSheet2016.pdf"
