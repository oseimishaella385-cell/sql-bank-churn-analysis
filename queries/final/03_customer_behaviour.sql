
-- Churn Rate by Tenure --
SELECT
    Tenure,
    COUNT(*) AS Customers,
    SUM(Exited) AS Churned,
    ROUND(AVG(Exited) * 100,2) AS ChurnRate
FROM customers
GROUP BY Tenure
ORDER BY ChurnRate DESC;

-- Churn Rate by Number of Products --
SELECT
NumOfProducts,
COUNT(*) AS Customers,
SUM(Exited) AS Churned,
ROUND(AVG(Exited) * 100, 2) as ChurnRate
FROM Customers
GROUP BY NumOfProducts;

-- Churn Rate by activity --
SELECT 
IsActiveMember,
COUNT(*) AS Customers,
SUM(Exited) AS Churned,
ROUND(AVG(Exited) * 100, 2) AS ChurnRate
FROM customers
GROUP BY IsActiveMember;

-- Churn Rate by Credit Card Ownership --
SELECT 
HasCrCard,
COUNT(*) AS Customers,
SUM(Exited) AS Churned,
ROUND(AVG(Exited) * 100, 2) AS ChurnRate
FROM Customers
GROUP BY HasCrCard;
