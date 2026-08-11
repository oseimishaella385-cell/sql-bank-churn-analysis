
--  Tenure Hypothesis:
-- Customers with very short tenure are more likely to churn.

--  Churn rate by individual tenure year

SELECT
    Tenure,
    COUNT(*) AS Total_Customers,
    SUM(Exited) AS Churned_Customers,
    ROUND(
        SUM(Exited) * 100.0 / COUNT(*),
        2
    ) AS Churn_Rate
FROM customers
GROUP BY Tenure
ORDER BY Tenure ASC;


--  Compare new customers with longer-tenure customers

SELECT
    CASE
        WHEN Tenure = 0 THEN 'New Customer (0 Years)'
        WHEN Tenure BETWEEN 1 AND 3 THEN '1-3 Years'
        WHEN Tenure BETWEEN 4 AND 7 THEN '4-7 Years'
        ELSE '8-10 Years'
    END AS Tenure_Group,

    COUNT(*) AS Total_Customers,
    SUM(Exited) AS Churned_Customers,

    ROUND(
        SUM(Exited) * 100.0 / COUNT(*),
        2
    ) AS Churn_Rate

FROM customers

GROUP BY Tenure_Group

ORDER BY
    CASE
        WHEN Tenure_Group = 'New Customer (0 Years)' THEN 1
        WHEN Tenure_Group = '1-3 Years' THEN 2
        WHEN Tenure_Group = '4-7 Years' THEN 3
        ELSE 4
    END;