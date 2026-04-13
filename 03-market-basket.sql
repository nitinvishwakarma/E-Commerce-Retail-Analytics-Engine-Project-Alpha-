-- Market Basket Analysis (Association Rules)
-- Purpose: Identify product pairs frequently bought together for cross-selling
-- Technique: Self-join with inequality to prevent duplicates

CREATE OR ALTER VIEW vw_Market_Basket_Analysis AS

SELECT 
    p1.CategoryName as Product_A,
    p2.CategoryName as Product_B,
    COUNT(*) as CoPurchase_Frequency,
    -- Calculate confidence % (simplified version)
    ROUND(
        COUNT(*) * 100.0 / 
        (SELECT COUNT(DISTINCT OrderID) FROM Order_Items), 
        2
    ) as CoPurchase_Percentage
FROM Order_Items oi1
JOIN Order_Items oi2 
    ON oi1.OrderID = oi2.OrderID
    AND oi1.ProductID < oi2.ProductID  -- Critical: prevents self-pairs and duplicates
JOIN Products p1 ON oi1.ProductID = p1.ProductID
JOIN Products p2 ON oi2.ProductID = p2.ProductID
GROUP BY 
    p1.CategoryName, 
    p2.CategoryName
HAVING COUNT(*) > 1  -- Only significant associations
ORDER BY 
    CoPurchase_Frequency DESC;

-- Business Insight Example:
-- Electronics + Books bought together 42% of the time
-- Action: Show "Frequently bought together" book recommendations on electronics pages

