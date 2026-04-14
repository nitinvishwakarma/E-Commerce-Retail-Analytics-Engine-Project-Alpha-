# E-Commerce Retail Analytics Engine (Project Alpha)

Raw data is useless without a story. **Project Alpha** turns messy e-commerce logs into high-impact visuals. This engine automates the journey from raw CSVs to executive-level insights using SQL Server, Microsoft SQL (SSMS), and Power BI.

---

### 🎯The Objective
To build an automated analytics engine that takes raw transactional data and delivers a clear, executive-level view of business health, customer segmentation, and inventory performance.

1. Segment Customers: Implement an RFM (Recency, Frequency, Monetary) model to categorize customers into actionable marketing cohorts.
2. Optimize Inventory: Execute a Pareto (80/20) analysis to identify the top revenue-driving product categories.
3. Drive Cross-Selling: Develop a Market Basket Analysis engine using complex self-joins to uncover product purchasing affinities.
4. Automate Insights: Deliver a dynamic, parameter-driven reporting layer for executive leadership.

-------------------------------------------------------------------------------------------------------------

## 📋 Project Documentation
- **[Problem Statement](PROBLEM_STATEMENT.md)** - Business pain points and success metrics
- **[Solution Architecture](SOLUTION_ARCHITECTURE.md)** - Technical design decisions and data flow
- **[Data Dictionary](data-dictionary.md)** - Schema documentation and field definitions
- **[Screenshot](screenshots)** - Screenshot of each analysis
  
-------------------------------------------------------------------------------------------------------------

**Business Context:** End-to-end customer analytics for an e-commerce platform ($11M+ GMV simulated)  
**Tech Stack:** Microsoft SQL Server • T-SQL • Window Functions • CTEs  
**Impact:** Segmentation logic ready for Power BI integration & automated marketing campaigns

## 📊 Three Business Problems Solved

### 1. RFM Customer Segmentation (`02-rfm-analysis.sql`)
**Problem:** Marketing team blasting the same offers to all customers → Low ROI  
**Solution:** Automated scoring system categorizing customers into Champions, Loyal, At-Risk, Hibernating

**Key SQL Techniques:**
- Window Functions: `NTILE(4)` for quartile scoring
- CTEs for modular calculation (Recency → Frequency → Monetary)
- Business logic: `CASE` statements translating scores into actionable segments

---

### 2. Market Basket Analysis (`03-market-basket.sql`)
**Problem:** Recommendation engine showing random products → Cart abandonment  
**Solution:** Self-join SQL identifying product pairs frequently bought together

**Key SQL Techniques:**
- Self-joins with inequality (`oi1.ProductID < oi2.ProductID`) to prevent duplicates
- Association rule mining without Python/ML libraries (pure SQL)
- Category-level affinity scoring

**Insight Generated:**
Electronics + Books = co-purchase → Triggers automated "Frequently Bought Together" prompts at checkout.

---

### 3. Pareto 80/20 Analysis (`04-pareto-analysis.sql`)
**Problem:** Inventory team optimizing for all categories equally → Working capital stuck in slow movers  
**Solution:** Cumulative revenue analysis identifying top 20% categories driving 80% sales

**Key SQL Techniques:**
- Running totals using `SUM() OVER (ORDER BY ... ROWS UNBOUNDED PRECEDING)`
- Cumulative percentage calculation for threshold identification
- Financial impact quantification

**Strategic Output:**
- **Category A (Electronics):** 23% of SKUs → 78% of revenue → Priority stock
- **Category D (Toys):** 35% of SKUs → 4% of revenue → Liquidate/Discount

---
## 🎯 Business Impact Summary

| Analysis | Architectural Capability | Automation Ready |
|----------|---------------|------------------|
| **RFM** | Enables targeted marketing to Champions and win-back campaigns for Hibernating users | ✅ View created for Power BI direct query |
| **Market Basket** | Exposes cross-sell opportunities to increase Average Order Value (AOV) | ✅ Daily refresh via SQL Agent |
| **Pareto** | Provides category-level visibility for smarter inventory allocation | ✅ Weekly executive reporting |


## 🛠️ Technical Architecture

**Schema Design:**
- **Fact Table:** Orders, Order_Items (transaction grain)
- **Dimensions:** Customers, Products (slowly changing)
- **Bridge:** Reviews (fact-like dimension)

**Performance Optimization:**
- Foreign key constraints for referential integrity
- Indexed views (`vw_RFM_Segmentation_analysis`) for sub-second Power BI refresh
- CTEs over subqueries for readability and performance

# Data Dictionary

The database schema consists of 5 interconnected tables that handle customer details, transactions, product catalog, and feedback.

### 1. `Customers`
| Column | Type | Description |
| :--- | :--- | :--- |
| `CustomerID` | INT (PK) | Unique identifier (Identity 1,1). |
| `CustomerCity` | VARCHAR(100) | Customer's city. |
| `CustomerState` | CHAR(2) | 2-letter state code. |
| `RegistrationDate` | DATE | Date the customer joined. |

### 2. `Orders`
| Column | Type | Description |
| :--- | :--- | :--- |
| `OrderID` | INT (PK) | Unique order identifier. |
| `CustomerID` | INT (FK) | Links to `Customers` table. |
| `OrderDate` | DATETIME | Timestamp of purchase. |
| `DeliveryDate` | DATETIME | Timestamp of delivery. |
| `OrderStatus` | VARCHAR(50) | Current state (e.g., Delivered, Shipped). |

### 3. `Order_Items`
| Column | Type | Description |
| :--- | :--- | :--- |
| `OrderItemID` | INT (PK) | Unique identifier for the line item. |
| `OrderID` | INT (FK) | Links to `Orders` table. |
| `ProductID` | INT (FK) | Links to `Products` table. |
| `SellerID` | INT | Identifier for the specific seller. |
| `Price` | DECIMAL(10,2) | Base price of the item. |
| `FreightValue` | DECIMAL(10,2) | Shipping/freight cost applied. |

### 4. `Products`
| Column | Type | Description |
| :--- | :--- | :--- |
| `ProductID` | INT (PK) | Unique identifier. |
| `CategoryName` | VARCHAR(100) | Product category classification. |
| `Weight_grams` | DECIMAL(10,2) | Physical weight. |
| `Dimensions_cm` | VARCHAR(50) | Physical dimensions. |

### 5. `Reviews`
| Column | Type | Description |
| :--- | :--- | :--- |
| `ReviewID` | INT (PK) | Unique review identifier. |
| `OrderID` | INT (FK) | Links back to the specific `Orders` record. |
| `ReviewScore` | INT | Rating strictly enforced between 1 and 5. |
| `ReviewText` | NVARCHAR(MAX) | Written customer feedback. |

---

## Key Features
* **RFM Modeling:** Automatically segmenting customers based on their buying behavior.
* **Pareto Analysis:** Highlighting the products that actually move the needle.
* **End-to-End Automation:** A seamless pipeline from SQL Server to Power BI.

## Tech Stack
* **Database:** SQL Server
* **Transformation:** SQL
* **BI Tool:** Power BI
