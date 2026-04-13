-- Pareto Analysis (80/20 Rule)
-- Purpose: Identify vital few categories driving majority of revenue
-- Use Case: Inventory optimization, ABC analysis

CREATE OR ALTER VIEW vw_Pareto_Revenue_Analysis AS

WITH CategoryRevenue AS (
    -- Revenue by category
    SELECT 
        p.CategoryName,
        SUM(oi.Price) as CategoryRevenue,
        COUNT(DISTINCT oi.ProductID) as SKU_Count
    FROM Order_Items oi
    JOIN Products p ON oi.ProductID = p.ProductID
    GROUP BY p.CategoryName
),
CumulativeCalc AS (
    SELECT 
        CategoryName,
        CategoryRevenue,
        SKU_Count,
        -- Running total of revenue
        SUM(CategoryRevenue) OVER (
            ORDER BY CategoryRevenue DESC 
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) as RunningRevenue,
        -- Total revenue for percentage calc
        SUM(CategoryRevenue) OVER () as TotalRevenue
    FROM CategoryRevenue
)
SELECT 
    CategoryName,
    CategoryRevenue,
    SKU_Count,
    RunningRevenue,
    -- Cumulative percentage (the Pareto line)
    ROUND((RunningRevenue / TotalRevenue) * 100, 2) as CumulativePercentage,
    -- Classification
    CASE 
        WHEN (RunningRevenue / TotalRevenue) <= 0.80 THEN 'A - Critical (Top 80%)'
        WHEN (RunningRevenue / TotalRevenue) <= 0.95 THEN 'B - Important (Next 15%)'
        ELSE 'C - Trivial (Bottom 5%)'
    END as ABC_Classification,
    -- Strategic recommendation
    CASE 
        WHEN (RunningRevenue / TotalRevenue) <= 0.80 THEN 'Ensure stock availability, prioritize marketing'
        WHEN (RunningRevenue / TotalRevenue) <= 0.95 THEN 'Monitor monthly, seasonal promotions'
        ELSE 'Liquidate stock, minimize inventory investment'
    END as InventoryStrategy
FROM CumulativeCalc
ORDER BY 
    CategoryRevenue DESC;

-- Usage: Identify which categories to prioritize for next quarter
-- SELECT * FROM vw_Pareto_Revenue_Analysis WHERE ABC_Classification LIKE 'A%';

