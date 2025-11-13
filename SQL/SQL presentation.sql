/*
					       ============================================================
										SMARTCARE HOSPITAL ANALYTICS SYSTEM
                           ============================================================

** Overview:
This project was developed to enhance hospital performance 
through intelligent data analytics and integration. 
The system analyzes patient records, provider activities, 
billing claims, and encounters to uncover key insights 
for better decision-making and resource management.

------------------------------------------------------------
** Dataset Description:
------------------------------------------------------------
The dataset includes multiple interconnected tables:

1️ patients — demographic and medical background data  
2️ encounters — admission details, reasons for visits, and readmission flags  
3️ providers — healthcare professionals and their specialties  
4️ procedures — medical procedures performed during encounters  
5️ claims_and_billing — insurance, payments, and denial reasons 
6 denials — denials details, reasons , appeal status
7 medication — medications details

8 us_area_code_cities — area code reference for city and state mapping  

------------------------------------------------------------
		**Step 1: Data Loading**
------------------------------------------------------------
-- Import CSV files into MySQL tables
-- Using SET GLOBAL local_infile = 1;
-- Example:
-- LOAD DATA LOCAL INFILE 'path/patients.csv'
-- INTO TABLE patients
-- FIELDS TERMINATED BY ','
-- ENCLOSED BY '"'
-- LINES TERMINATED BY '\n'
-- IGNORE 1 ROWS;

-- Each table was successfully loaded into the MySQL database.

------------------------------------------------------------
	   **Step 2: Data Cleaning and Consistency**
------------------------------------------------------------
-- -- Drop unnecessary tables
    Such as lab_tests, and diagnosis tables

-- Fill missing city/state using area_code mapping;


-- Fix inconsistent marital status for children;

-- /All missing or inconsistent data points were standardized./

------------------------------------------------------------
	     **Step 3: Data modeling**
------------------------------------------------------------

All hospital datasets were linked using primary and foreign keys to ensure data consistency 
and enable efficient analytical queries across the system.

------------------------------------------------------------
        **Step 4: Data Analysis**
------------------------------------------------------------

-- 4.1 Most Common Reasons for Patient Visits

-- 4.2 Cities with the Highest Accidental Injuries

-- 4.3 Top Performing Doctors by Number of Procedures

-- 4.4 Top Reasons for Claim Denials

-- 4.5 Most Common Reasons for Readmission

------------------------------------------------------------
		**Step 5: Key Insights**
------------------------------------------------------------
1️ Fresno, California recorded the highest number of accidental injuries (438).
2️ Sacramento, CA showed a notable concentration of Hepatitis C cases.
3️ Dr. Roy performed the most procedures — 489 within 3 months.
4️ Major denial reasons include "Duplicate Claims" and "Prior Authorization Required".
5️ Data inconsistencies were successfully resolved through area code mapping and 
  age–marital status validation.

------------------------------------------------------------
		**Step 6: Conclusion**
------------------------------------------------------------
The analysis successfully transformed raw hospital data into actionable insights.  
It identified operational inefficiencies, high-risk regions, and provider performance metrics.  
Future automation can include scheduled data updates and real-time dashboard visualization 
using Power BI or Tableau.

============================================================
             **Author: Insight Squad Team**
                       Radwa Haridy 
					   Esraa Mohamed
                       Merna Hossam
                       Shorouq Mohamed
					   Dalia Sherif
	       **Supervisied By: DR. Amal Mahmoud**
                   Date: November 2025  
============================================================
*/
==================================