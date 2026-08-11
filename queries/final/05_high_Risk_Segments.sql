-- High Risk Customer Segments --
SELECT
    CASE
        WHEN EstimatedSalary >= 100000 THEN 'High Income (£100k+)'
        WHEN EstimatedSalary >= 50000 THEN 'Middle Income (£50k-£99k)'
        ELSE 'Lower Income (<£50k)'
    END AS Income_Group,

    CASE
        WHEN Balance = 0 THEN 'Zero Balance'
        ELSE 'Has Balance'
    END AS Balance_Status,

    NumOfProducts,

    CASE
        WHEN IsActiveMember = 1 THEN 'Active'
        ELSE 'Inactive'
    END AS Membership_Status,

    COUNT(*) AS Total_Customers,
    SUM(Exited) AS Churned_Customers,
    ROUND(AVG(Exited) * 100, 2) AS Churn_Rate

FROM customers

GROUP BY
    Income_Group,
    Balance_Status,
    NumOfProducts,
    IsActiveMember

HAVING COUNT(*) >= 100

ORDER BY Churn_Rate DESC;

-- Difference from overall Churn Rate by Income group --
SELECT
    CASE
        WHEN EstimatedSalary >= 100000 THEN 'High Income (£100k+)'
        WHEN EstimatedSalary >= 50000 THEN 'Middle Income (£50k-£99k)'
        ELSE 'Lower Income (<£50k)'
    END AS Income_Group,

    CASE
        WHEN Balance = 0 THEN 'Zero Balance'
        ELSE 'Has Balance'
    END AS Balance_Status,

    COUNT(*) AS Total_Customers,
    SUM(Exited) AS Churned_Customers,

    ROUND(
        AVG(Exited) * 100,
        2
    ) AS Churn_Rate,

    ROUND(
        (AVG(Exited) * 100)
        -
        (SELECT AVG(Exited) * 100 FROM customers),
        2
    ) AS Difference_From_Overall

FROM customers

GROUP BY
    Income_Group,
    Balance_Status

ORDER BY
    Difference_From_Overall DESC;
    
    -- Churn rate by NOP + Membership Status --
    SELECT
    NumOfProducts,

    CASE
        WHEN IsActiveMember = 1 THEN 'Active'
        ELSE 'Inactive'
    END AS Membership_Status,

    COUNT(*) AS Total_Customers,
    SUM(Exited) AS Churned_Customers,

    ROUND(AVG(Exited) * 100, 2) AS Churn_Rate

FROM customers

GROUP BY
    NumOfProducts,
    IsActiveMember

ORDER BY
    NumOfProducts,
    IsActiveMember;