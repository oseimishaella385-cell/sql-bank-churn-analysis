
-- Churn Rate by Gender--
 SELECT
 Gender,
 COUNT(*) AS Customers,
 SUM(Exited) AS Churned,
 ROUND(AVG(Exited) * 100,2) AS ChurnRate
 FROM Customers
 GROUP BY Gender;
 
 -- Churn Rate by Geography --
 SELECT 
geography,
COUNT(*) AS Customers,
SUM(Exited) AS Churned,
ROUND(AVG(Exited)*100,2) AS ChurnRate
FROM customers
GROUP BY Geography
Order by ChurnRate DESC;

-- Churn Rate by Age --

SELECT
    CASE
        WHEN Age < 30 THEN '18-29'
        WHEN Age < 40 THEN '30-39'
        WHEN Age < 50 THEN '40-49'
        WHEN Age < 60 THEN '50-59'
        WHEN Age < 70 THEN '60-69'
        WHEN Age < 80 THEN '70-79'
        ELSE '80+'
    END AS AgeGroup,
    COUNT(*) AS Customers,
    SUM(Exited) AS Churned,
    ROUND(AVG(Exited) * 100, 2) AS ChurnRate
FROM customers
GROUP BY AgeGroup
ORDER BY MIN(Age);

 