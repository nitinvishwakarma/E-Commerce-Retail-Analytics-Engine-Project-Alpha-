# E-Commerce Retail Analytics Engine (Project Alpha)

Raw data is useless without a story. **Project Alpha** turns messy e-commerce logs into high-impact visuals. This engine automates the journey from raw CSVs to executive-level insights using SQL Server, Microsoft SQL (SSMS), and Power BI.

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
* **Database:** **SQL Server** All raw data is stored in SQL Server to handle large-scale processing.

### 2. Data Transformation (The Engine)
* **SQL:** Used for intensive data cleaning, handling nulls, and schema enforcement across our 5 core relational tables (Orders, Order_Items, Customers, Products, Reviews).
* **Advanced Analytics:** * **RFM Analysis:** Custom SQL scripts to calculate Recency, Frequency, and Monetary scores for every customer.
    * **Pareto Analysis (80/20 Rule):** Identifying the top 20% of products and customers driving 80% of the revenue.

### 3. Visualization & Reporting
* **Power BI:** A dynamic, executive-facing dashboard connected directly to SQL Server. 
* **Insights:** Interactive views for sales trends, customer segments, and regional performance.

---

# Data Dictionary

The database schema consists of 5 interconnected tables that handle customer details, transactions, product catalog, and feedback.

### 1. `Customers`
Contains demographic and contact information for buyers.
| Column | Type | Description |
| :--- | :--- | :--- |
| `customer_id` | STRING (PK) | Unique identifier for the customer. |
| `customer_name` | STRING | Full name of the customer. |
| `email` | STRING | Contact email address. |
| `location` | STRING | Geographic location (City/State/Country). |

### 2. `Orders`
Tracks high-level order events and ties transactions to specific customers. 
| Column | Type | Description |
| :--- | :--- | :--- |
| `order_id` | STRING (PK) | Unique identifier for the order. |
| `customer_id` | STRING (FK) | Links to the `Customers` table. |
| `order_date` | DATE | Date the order was placed. |
| `order_status` | STRING | Current state of the order (e.g., Delivered, Shipped, Cancelled). |

### 3. `Order_Items`
Breaks down each order into individual line items. This table is crucial for monetary calculations and joins with `Orders` using `order_id`.
| Column | Type | Description |
| :--- | :--- | :--- |
| `order_item_id` | STRING (PK) | Unique identifier for the line item. |
| `order_id` | STRING (FK) | Links to the `Orders` table. |
| `product_id` | STRING (FK) | Links to the `Products` table. |
| `quantity` | INTEGER | Number of units purchased in this specific line item. |
| `unit_price` | DECIMAL | Price of the product at the time of purchase. |

### 4. `Products`
Holds the details for the e-commerce inventory.
| Column | Type | Description |
| :--- | :--- | :--- |
| `product_id` | STRING (PK) | Unique identifier for the product. |
| `product_name` | STRING | Name of the item. |
| `category` | STRING | Product category (e.g., Electronics, Apparel). |
| `cost_price` | DECIMAL | Base cost of the product. |

### 5. `Reviews`
Captures customer feedback and ratings for purchased products.
| Column | Type | Description |
| :--- | :--- | :--- |
| `review_id` | STRING (PK) | Unique identifier for the review. |
| `product_id` | STRING (FK) | Links to the `Products` table. |
| `customer_id` | STRING (FK) | Links to the `Customers` table. |
| `rating` | INTEGER | Numerical score given by the customer (e.g., 1-5). |
| `review_text` | STRING | Written feedback provided by the customer. |

---

## Key Features
* **RFM Modeling:** Automatically segmenting customers based on their buying behavior.
* **Pareto Analysis:** Highlighting the products that actually move the needle.
* **End-to-End Automation:** A seamless pipeline from SQL Server to Power BI.

## Tech Stack
* **Database:** SQL Server
* **Transformation:** SQL
* **BI Tool:** Power BI
