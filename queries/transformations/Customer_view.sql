CREATE VIEW customer_analysis AS

SELECT
    CreditScore,
    Geography,
    Gender,
    Age,
    Tenure,
    Balance,
    NumOfProducts,
    EstimatedSalary,

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
        WHEN Balance = 0 THEN '£0'
        WHEN Balance < 50000 THEN '£1-£49,999'
        WHEN Balance < 100000 THEN '£50,000-£99,999'
        ELSE '£100,000+'
    END AS Balance_Group,

    -- Active membership
    CASE
        WHEN IsActiveMember = 1 THEN 'Active'
        ELSE 'Inactive'
    END AS Membership_Status,

    -- Credit card ownership
    CASE
        WHEN HasCrCard = 1 THEN 'Yes'
        ELSE 'No'
    END AS Credit_Card_Status,

    -- Customer churn status
    CASE
        WHEN Exited = 1 THEN 'Churned'
        ELSE 'Stayed'
    END AS Customer_Status,

    Exited

FROM customers;