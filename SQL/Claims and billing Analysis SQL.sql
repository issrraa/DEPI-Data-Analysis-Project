-- Claims and Billing Analysis
SELECT  COUNT(billing_id) AS NO_of_billings
FROM claims_and_billing;
-- we have 70000 billing

SELECT COUNT(claim_id) AS Total_claims
FROM claims_and_billing
WHERE claim_id <> "";
-- We have 59638 claims

SELECT SUM(billed_amount) AS Total_Revenue
FROM claims_and_billing; 
-- Total Revenue is 112 Million

SELECT claim_status,
COUNT(claim_status)AS status, 
ROUND(COUNT(claim_status)*100/(SELECT COUNT(*)FROM claims_and_billing),2) AS Total_percetage
FROM claims_and_billing
GROUP BY claim_status;

-----------------------------------------------------------
SELECT denial_reason
FROM claims_and_billing;

SELECT COUNT(DISTINCT denial_reason) AS No_denial_reason
FROM claims_and_billing;
-- We have 15 reason for claim rejection


SELECT denial_reason_description, COUNT(denial_id) AS total_denials
FROM denials
GROUP BY denial_reason_description
ORDER BY total_denials DESC;


SELECT denial_reason , COUNT(claim_id) AS total_denied
FROM claims_and_billing
WHERE claim_status ='Denied' AND denial_reason <> '' AND denial_reason IS NOT NULL
GROUP BY denial_reason
ORDER BY total_denied DESC
LIMIT 5;

