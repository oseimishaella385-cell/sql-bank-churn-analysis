-- Churn Rate by Balance Group --
SELECT
    CASE
        WHEN Balance = 0 THEN '£0'
        WHEN Balance < 50000 THEN '£1 - £49,999'
        WHEN Balance < 100000 THEN '£50,000 - £99,999'
        ELSE '£100,000+'
    END AS Balance_Group,

    COUNT(*) AS Total_Customers,

    SUM(Exited) AS Churned_Customers,

    ROUND(
        SUM(Exited) / COUNT(*) * 100,
        2
    ) AS Churn_Rate
FROM customers
GROUP BY Balance_Group
ORDER BY Churn_Rate DESC;

-- Average Balance: Stayed vs Churned --

SELECT
    CASE
        WHEN Exited = 1 THEN 'Churned'
        ELSE 'Stayed'
    END AS Customer_Status,
    COUNT(*) AS Total_Customers,
    ROUND(AVG(Balance), 2) AS Average_Balance
FROM customers
GROUP BY Customer_Status;

-- Median Salary: Stayed vs Churned --

WITH ranked_salary AS (
    SELECT
        Exited,
        EstimatedSalary,
        ROW_NUMBER() OVER (
            PARTITION BY Exited
            ORDER BY EstimatedSalary
        ) AS row_num,
        COUNT(*) OVER (
            PARTITION BY Exited
        ) AS total_rows
    FROM customers
)

SELECT
    CASE
        WHEN Exited = 1 THEN 'Churned'
        ELSE 'Stayed'
    END AS Customer_Status,
    ROUND(AVG(EstimatedSalary), 2) AS Median_Salary
FROM ranked_salary
WHERE row_num IN (
    FLOOR((total_rows + 1) / 2),
    CEIL((total_rows + 1) / 2)
)
GROUP BY Exited;

-- Average Credit Score: Stayed vs Churned --

SELECT
    CASE
        WHEN Exited = 1 THEN 'Churned'
        ELSE 'Stayed'
    END AS Customer_Status,
    COUNT(*) AS Total_Customers,
    ROUND(AVG(CreditScore), 0) AS Average_Credit_Score
FROM customers
GROUP BY Customer_Status;