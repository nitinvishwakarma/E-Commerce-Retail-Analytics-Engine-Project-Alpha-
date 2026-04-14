# Solution Architecture

This project uses a centralized relational database approach to process and analyze retail data efficiently.

### 1. Database & Storage
- **RDBMS:** Microsoft SQL Server (`RetailAnalyticsDB`). 
- **Design:** A 5-table normalized schema handling customers, products, sales facts, and qualitative feedback.

### 2. Data Transformation Engine
The heavy lifting is done server-side using T-SQL Views to ensure reporting tools only pull clean, aggregated metrics.
-  **vw_RFM_Segmentation_analysis:** Uses CTEs and the `NTILE(4)` window function to assign 1-4 scores for Recency, Frequency, and Monetary          value, outputting a definitive customer segment.
-  **vw_MarketBasket_Recommendations_Analysis:** Uses strict self-joins on the `Order_Items` table (`ProductID < ProductID`) to prevent              duplicate mirrored pairs while finding products bought in the same transaction.
- **vw_Pareto_Analysis_cumulative:** Chains CTEs to calculate raw revenue, running totals (`SUM OVER UNBOUNDED PRECEDING`), and a final             cumulative percentage metric.

### 3. Why Views vs. Tables?
- **Real-time:** Marketing team sees yesterday's data, not last week's
- **Storage:** 150K transactions × 3 analyses = expensive materialization; views are compute-on-demand
- **Flexibility:** Business logic changes? Alter view definition, no ETL pipeline rebuild

## Performance Optimization Strategy

### Indexing
- Clustered Index on Orders(OrderDate) for time-based filtering
- Non-clustered on Order_Items(ProductID) for join performance
- Covering index on Customers(City, State) for geographic rollups

### Query Optimization
- CTEs used for readability AND performance (query folding in Power BI)
- Window functions (`NTILE`, `SUM OVER`) instead of correlated subqueries
- Self-join inequality (`<`) prevents Cartesian products in Market Basket analysis

## Business Logic Implementation

### RFM Scoring Methodology
- **Recency:** Days since last purchase (lower = better)
  - Score 4: 0-30 days (Hot)
  - Score 3: 31-90 days (Warm)
  - Score 2: 91-180 days (Cool)
  - Score 1: 180+ days (Cold)

- **Frequency:** Purchase count (higher = better)
  - Quartiled using NTILE(4) against active customer base

- **Monetary:** Total spend (higher = better)
  - Sum of (Price + Freight) to capture true revenue, not just product value

### Segment Definitions
| Segment | RFM Profile | Marketing Action | Expected LTV |
|---------|-------------|------------------|--------------|
| Champions | 444, 443, 434 | New product launches, VIP treatment | High |
| Loyal Customers | 344, 333, 343 | Referral programs, upsell | High |
| Recent/New | 411, 412, 413 | Onboarding series, education | Medium |
| At Risk | 144, 134, 143 | Win-back discounts, surveys | Low (recoverable) |
| Hibernating | 111, 112, 121 | Re-engagement or purge | Very Low |

## Integration Points

### Power BI Connection
```sql
-- DirectQuery mode for real-time data
SELECT * FROM vw_Customer_RFM_Segmentation 
WHERE CustomerSegment = 'Champions'
