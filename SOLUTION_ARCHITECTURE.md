# Solution Architecture

This project uses a centralized relational database to process and analyze retail data efficiently.

### 1. Database & Storage
- **RDBMS:** Microsoft SQL Server (`RetailAnalyticsDB`). 
- **Design:** A 5-table normalized schema handling customers, products, sales facts, and qualitative feedback.

### 2. Data Transformation Engine
The heavy lifting is done server-side using T-SQL Views to ensure reporting tools only pull clean, aggregated metrics.
- **vw_RFM_Segmentation_analysis:** Uses CTEs and the `NTILE(4)` window function to assign 1-4 scores for Recency, Frequency, and Monetary value, outputting a definitive customer segment.
- **vw_MarketBasket_Recommendations_Analysis:** Uses strict self-joins on the `Order_Items` table (`ProductID < ProductID`) to prevent duplicate mirrored pairs while finding products bought in the same transaction.
- **vw_Pareto_Analysis_cumulative:** Chains CTEs to calculate raw revenue, running totals (`SUM OVER UNBOUNDED PRECEDING`), and a final cumulative percentage metric.

### 3. Why Views vs. Tables?
- **Real-time:** Marketing teams see today's data, not last week's batch-processed data.
- **Storage & Compute:** Materializing millions of transactions across three separate analytical tables is expensive; views provide compute-on-demand flexibility.
- **Maintainability:** When business logic changes, altering a view definition is instantaneous compared to rebuilding an ETL pipeline.

## Performance Optimization Strategy

### Indexing
- **Clustered Index** on `Orders(OrderDate)` for rapid time-based filtering.
- **Non-clustered Index** on `Order_Items(ProductID)` to accelerate heavy analytical joins.
- **Covering Index** on `Customers(City, State)` to speed up geographic rollups without hitting the base table.

### Query Optimization
- **CTEs** are utilized for readability and to leverage Query Folding when connected to Power BI.
- **Window functions** (`NTILE`, `SUM OVER`) are used in place of expensive, resource-heavy correlated subqueries.
- **Self-join inequalities** (`<`) are strictly enforced to prevent massive Cartesian products during Market Basket computations.

## Business Logic Implementation

### RFM Scoring Methodology (Dynamic Percentiles)
Rather than using static, hardcoded day or dollar thresholds, this engine uses the `NTILE(4)` window function to dynamically score customers relative to the active database. 

- **Recency (R):** Days since last purchase. The dataset is ordered descending, assigning a '4' to the top 25% most recent buyers.
- **Frequency (F):** Total unique purchase count. Ordered ascending, assigning a '4' to the top 25% most frequent buyers.
- **Monetary (M):** Total spend calculated as `SUM(Price + FreightValue)` to capture true gross revenue, not just product value. Ordered ascending, assigning a '4' to the top 25% highest spenders.

### Segment Definitions
| Segment | RFM Profile | Marketing Action | Expected LTV |
|---------|-------------|------------------|--------------|
| **Champions** | 444, 443, 434 | New product launches, VIP treatment | High |
| **Loyal Customers** | 344, 333, 343 | Referral programs, upsell opportunities | High |
| **Recent/New** | 411, 412, 413 | Onboarding series, product education | Medium |
| **At Risk** | 144, 134, 143 | Win-back discounts, satisfaction surveys | Low (Recoverable) |
| **Hibernating** | 111, 112, 121 | Aggressive re-engagement or list purge | Very Low |

## Integration Points

### Power BI Connection
The architecture is designed for immediate ingestion into Business Intelligence tools via DirectQuery or Scheduled Refresh.

```sql
-- Example: DirectQuery extraction for targeted marketing dashboards
SELECT * FROM vw_RFM_Segmentation_analysis 
WHERE CustomerSegment = 'Champions';
