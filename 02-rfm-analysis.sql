-- RFM (Recency, Frequency, Monetary) Customer Segmentation
-- Purpose: Automated marketing segmentation using SQL Window Functions
-- Output: Customer segments (Champions, Loyal, At-Risk, Hibernating)

CREATE OR ALTER VIEW vw_Customer_RFM_Segmentation AS

WITH CustomerMetrics AS (
    -- Calculate base metrics for each customer
    SELECT 
        c.CustomerID,
        c.CustomerCity,
        MAX(o.OrderDate) as LastPurchaseDate,
        -- Recency: Days since last purchase (lower is better)
        DATEDIFF(DAY, MAX(o.OrderDate), (SELECT MAX(OrderDate) FROM Orders)) as RecencyDays,
        -- Frequency: Count of orders
        COUNT(DISTINCT o.OrderID) as Frequency,
        -- Monetary: Total spent including freight
        SUM(oi.Price + oi.FreightValue) as MonetaryValue
    FROM Customers c
    LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
    LEFT JOIN Order_Items oi ON o.OrderID = oi.OrderID
    WHERE o.OrderStatus IN ('Delivered', 'Shipped')
    GROUP BY c.CustomerID, c.CustomerCity
),
RFMScored AS (
    -- Assign quartile scores (1-4) using NTILE
    SELECT 
        CustomerID,
        CustomerCity,
        RecencyDays,
        Frequency,
        MonetaryValue,
        -- R_Score: 4 = Most recent (best), 1 = Least recent
        NTILE(4) OVER (ORDER BY RecencyDays ASC) as R_Score,
        -- F_Score: 4 = Most frequent (best), 1 = Least frequent  
        NTILE(4) OVER (ORDER BY Frequency DESC) as F_Score,
        -- M_Score: 4 = Highest spender (best), 1 = Lowest spender
        NTILE(4) OVER (ORDER BY MonetaryValue DESC) as M_Score
    FROM CustomerMetrics
)
SELECT 
    CustomerID,
    CustomerCity,
    RecencyDays,
    Frequency,
    ROUND(MonetaryValue, 2) as MonetaryValue,
    R_Score,
    F_Score,
    M_Score,
    -- RFM Cell for visualization (e.g., "444" = Perfect customer)
    CONCAT(R_Score, F_Score, M_Score) as RFM_Cell,
    -- Business Logic for Actionable Segments
    CASE 
        WHEN R_Score >= 3 AND F_Score >= 3 AND M_Score >= 3 THEN 'Champions'
        WHEN R_Score >= 3 AND F_Score >= 2 THEN 'Loyal Customers'
        WHEN R_Score >= 3 AND F_Score <= 2 THEN 'Recent/New Customers'
        WHEN R_Score <= 2 AND F_Score >= 3 AND M_Score >= 3 THEN 'At Risk (Big Spenders)'
        WHEN R_Score <= 2 AND F_Score >= 2 THEN 'At Risk'
        WHEN R_Score <= 2 AND F_Score <= 2 AND M_Score >= 2 THEN 'Hibernating'
        ELSE 'Lost Customers'
    END as CustomerSegment,
    -- Action Recommendation
    CASE 
        WHEN R_Score >= 3 AND F_Score >= 3 AND M_Score >= 3 THEN 'Reward them, early adopter for new products'
        WHEN R_Score >= 3 AND F_Score <= 2 THEN 'Welcome series, onboarding to increase frequency'
        WHEN R_Score <= 2 AND F_Score >= 3 THEN 'Win-back campaign, special discount'
        ELSE 'Re-engagement email or remove from list'
    END as RecommendedAction
FROM RFMScored;

-- Usage:
-- SELECT * FROM vw_Customer_RFM_Segmentation ORDER BY MonetaryValue DESC;

