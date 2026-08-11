CREATE VIEW customer_analysis AS

SELECT
    -- Core customer fields
    CustomerId,
    CreditScore,
    Geography,
    Gender,
    Age,
    Tenure,
    Balance,
    NumOfProducts,
    EstimatedSalary,
    HasCrCard,
    IsActiveMember,
    Exited,

    -- Age groups
    CASE
        WHEN Age BETWEEN 18 AND 29 THEN '18-29'
        WHEN Age BETWEEN 30 AND 39 THEN '30-39'
        WHEN Age BETWEEN 40 AND 49 THEN '40-49'
        WHEN Age BETWEEN 50 AND 59 THEN '50-59'
        WHEN Age BETWEEN 60 AND 69 THEN '60-69'
        WHEN Age BETWEEN 70 AND 79 THEN '70-79'
        ELSE '80+'
    END AS Age_Group,

    -- Balance groups
    CASE
        WHEN Balance = 0 THEN '0'
        WHEN Balance < 50000 THEN '1-49,999'
        WHEN Balance < 100000 THEN '50,000-99,999'
        ELSE '100,000+'
    END AS Balance_Group,

    -- Income groups
    CASE
        WHEN EstimatedSalary >= 100000 THEN 'High Income (100k+)'
        WHEN EstimatedSalary >= 50000 THEN 'Middle Income (50k-99k)'
        ELSE 'Lower Income (<50k)'
    END AS Income_Group,

    -- Active / inactive label
    CASE
        WHEN IsActiveMember = 1 THEN 'Active'
        ELSE 'Inactive'
    END AS Membership_Status,

    -- Credit card label
    CASE
        WHEN HasCrCard = 1 THEN 'Has Credit Card'
        ELSE 'No Credit Card'
    END AS Credit_Card_Status,

    -- Churn label
    CASE
        WHEN Exited = 1 THEN 'Churned'
        ELSE 'Stayed'
    END AS Customer_Status,

    -- Product + activity segment
    CONCAT(
        NumOfProducts,
        CASE
            WHEN NumOfProducts = 1 THEN ' Product + '
            ELSE ' Products + '
        END,
        CASE
            WHEN IsActiveMember = 1 THEN 'Active'
            ELSE 'Inactive'
        END
    ) AS Customer_Segment

FROM customers;