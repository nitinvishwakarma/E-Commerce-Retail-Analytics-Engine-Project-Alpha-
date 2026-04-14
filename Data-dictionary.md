# Data Dictionary

The database schema consists of 5 interconnected tables that handle customer details, transactions, product catalog, and feedback.

### 1. `Customers` [DIMENTION TABLE]
Contains demographic and contact information for buyers.
| Column | Type | Description |
| :--- | :--- | :--- |
| `customer_id` | STRING (PK) | Unique identifier for the customer. |
| `customer_name` | STRING | Full name of the customer. |
| `email` | STRING | Contact email address. |
| `location` | STRING | Geographic location (City/State/Country). |

### 2. `Orders` [FACT TABLE]
Tracks high-level order events and ties transactions to specific customers. 
| Column | Type | Description |
| :--- | :--- | :--- |
| `order_id` | STRING (PK) | Unique identifier for the order. |
| `customer_id` | STRING (FK) | Links to the `Customers` table. |
| `order_date` | DATE | Date the order was placed. |
| `order_status` | STRING | Current state of the order (e.g., Delivered, Shipped, Cancelled). |

### 3. `Order_Items` [FACT TABLE]
Breaks down each order into individual line items. This table is crucial for monetary calculations and joins with `Orders` using `order_id`.
| Column | Type | Description |
| :--- | :--- | :--- |
| `order_item_id` | STRING (PK) | Unique identifier for the line item. |
| `order_id` | STRING (FK) | Links to the `Orders` table. |
| `product_id` | STRING (FK) | Links to the `Products` table. |
| `quantity` | INTEGER | Number of units purchased in this specific line item. |
| `unit_price` | DECIMAL | Price of the product at the time of purchase. |

### 4. `Products` [DIMENTION TABLE]
Holds the details for the e-commerce inventory.
| Column | Type | Description |
| :--- | :--- | :--- |
| `product_id` | STRING (PK) | Unique identifier for the product. |
| `product_name` | STRING | Name of the item. |
| `category` | STRING | Product category (e.g., Electronics, Apparel). |
| `cost_price` | DECIMAL | Base cost of the product. |

### 5. `Reviews` [DIMENTION TABLE]
Captures customer feedback and ratings for purchased products.
| Column | Type | Description |
| :--- | :--- | :--- |
| `review_id` | STRING (PK) | Unique identifier for the review. |
| `product_id` | STRING (FK) | Links to the `Products` table. |
| `customer_id` | STRING (FK) | Links to the `Customers` table. |
| `rating` | INTEGER | Numerical score given by the customer (e.g., 1-5). |
| `review_text` | STRING | Written feedback provided by the customer. |
