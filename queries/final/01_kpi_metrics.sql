-- KPI'S--

SELECT
    COUNT(*) AS TotalCustomers,

    SUM(Exited) AS ChurnedCustomers,

    COUNT(*) - SUM(Exited) AS RetainedCustomers,

    ROUND(
        SUM(Exited) * 100.0 / COUNT(*),
        2
    ) AS ChurnRate,

    ROUND(
        AVG(Balance),
        2
    ) AS AverageBalance,

    ROUND(
        SUM(CASE
            WHEN Exited = 1 THEN Balance
            ELSE 0
        END),
        2
    ) AS BalanceHeldByChurnedCustomers

FROM customers;
 