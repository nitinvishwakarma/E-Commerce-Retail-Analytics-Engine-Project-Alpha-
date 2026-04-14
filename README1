# E-Commerce Retail Analytics Engine (Project Alpha)

Raw data is useless without a story. **Project Alpha** turns messy e-commerce logs into high-impact visuals. This engine automates the journey from raw CSVs to executive-level insights using Snowflake, SQL, and Power BI.

---

# Problem Statement

Retail businesses today are drowning in data but starving for insights. 

### The Challenge
Most mid-sized e-commerce platforms struggle with:
* **Static Reporting:** Reliance on manual Excel sheets that are outdated the moment they are shared.
* **Blind Spots:** Inability to distinguish between high-value loyalists and one-time shoppers.
* **Data Quality:** Messy transactional logs with missing values and inconsistent formats that lead to "garbage in, garbage out" reporting.
* **Scalability:** Systems that crawl when trying to process millions of rows of historical data.

### The Objective
To build an automated analytics engine that takes raw transactional data and delivers a clear, executive-level view of business health, customer segmentation, and inventory performance.

---

# Solution Architecture

This project follows a modern data stack approach to ensure speed, reliability, and clear visualization.

### 1. Data Ingestion & Storage
* **Source:** Raw e-commerce transaction data (CSVs / SQL Server).
* **Data Warehouse:** **Snowflake**. All raw data is staged and stored in a centralized cloud environment to handle large-scale processing.

### 2. Data Transformation (The Engine)
* **SQL (Snowflake):** Used for intensive data cleaning, handling nulls, and schema enforcement.
* **Advanced Analytics:** * **RFM Analysis:** Custom SQL scripts to calculate Recency, Frequency, and Monetary scores for every customer.
    * **Pareto Analysis (80/20 Rule):** Identifying the top 20% of products and customers driving 80% of the revenue.

### 3. Visualization & Reporting
* **Power BI:** A dynamic, executive-facing dashboard connected directly to Snowflake. 
* **Insights:** Interactive views for sales trends, customer segments, and regional performance.

---

# Data Dictionary

The following tables form the core of the **Project Alpha** schema.

### Table: `SALES`
The primary table containing all transactional events.
| Column | Type | Description |
| :--- | :--- | :--- |
| `TransactionID` | STRING (PK) | Unique identifier for each order. |
| `CustomerID` | STRING (FK) | Links to the Customer dimension. |
| `ProductID` | STRING (FK) | Links to the Product dimension. |
| `OrderDate` | DATE | Date the transaction occurred. |
| `Quantity` | INTEGER | Number of items purchased. |
| `UnitPrice` | DECIMAL | Price per unit at the time of sale. |
| `TotalAmount` | DECIMAL | (Quantity * UnitPrice) — Primary metric for revenue. |

### Table: `CUSTOMERS`
Contains descriptive attributes for customer segmentation.
| Column | Type | Description |
| :--- | :--- | :--- |
| `CustomerID` | STRING (PK) | Unique identifier. |
| `CustomerName` | STRING | Full name or masked identifier. |
| `Country` | STRING | Geographic location for regional analysis. |
| `RFM_Segment` | STRING | Categorization (e.g., "Champion", "At Risk", "New"). |

### Table: `PRODUCTS`
Detailed information about the product catalog.
| Column | Type | Description |
| :--- | :--- | :--- |
| `ProductID` | STRING (PK) | Unique identifier. |
| `ProductName` | STRING | Name of the item. |
| `Category` | STRING | Product category (Electronics, Home, etc.). |
| `CostPrice` | DECIMAL | Internal cost used to calculate profit margins. |

---

## Key Features
* **RFM Modeling:** Automatically segmenting customers based on their buying behavior.
* **Pareto Analysis:** Highlighting the products that actually move the needle.

## Tech
* **SQL
