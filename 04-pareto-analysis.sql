-- This is the new query--updated
-- ==============================================================================
-- PROJECT ALPHA: Pareto (80/20) Inventory & Revenue Analysis
-- Purpose: Calculates cumulative revenue percentages to identify top-performing 
-- product categories using advanced Window Functions.
-- ==============================================================================
CREATE OR ALTER VIEW vw_Pareto_Analysis_cumulative AS

WITH CategoryRevenue AS (
    -- STEP 1: Calculate total revenue per category

	SELECT	oit.ProductID,p.CategoryName, SUM(oit.price) AS TotalRevenue
	FROM Order_Items AS oit
	JOIN Products AS p ON oit.ProductID = p.ProductID
	GROUP BY oit.ProductID,p.CategoryName
	),
	
	CumulativeTotals AS (
    -- STEP 2: Calculate the running total and the grand total
	SELECT	CategoryName,
			TotalRevenue,
			-- Running total of revenue
			SUM(TotalRevenue) over (ORDER BY TotalRevenue DESC ROWS UNBOUNDED PRECEDING) AS RunningTotalRevenue,
			-- Grand Total revenue for percentage calc
			SUM(TotalRevenue) over() AS GrandTotalRevenue

	FROM CategoryRevenue
	)

-- STEP 3: Calculate the cumulative percentage
	SELECT	CategoryName,
			TotalRevenue,
			RunningTotalRevenue,
			GrandTotalRevenue,
			-- Cumulative percentage (the Pareto line) and round it to 2 decimal places
			CAST((RunningTotalRevenue / GrandTotalRevenue) * 100.0 AS DECIMAL(5,2)) AS CumulativePercentage

	FROM  CumulativeTotals;

-- ==============================================================================
-- TEST THE VIEW
-- ==============================================================================
-- Run the line below. Look at the "CumulativePercentage" column!

SELECT * FROM vw_Pareto_Analysis_cumulative ORDER BY TotalRevenue DESC




/*
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
*/
