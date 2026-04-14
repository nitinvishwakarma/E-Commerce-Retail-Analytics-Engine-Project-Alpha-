# Data Dictionary

The database schema consists of 5 interconnected tables that handle customer demographics, transactions, product details, and reviews.

### 1. `Customers` [DIMENSION TABLE]
Enables demographic segmentation and cohort grouping.
| Column | Type | Description |
| :--- | :--- | :--- |
| `CustomerID` | INT (PK) | Unique identifier (Identity 1,1). |
| `CustomerCity` | VARCHAR(100) | Customer's city. |
| `CustomerState` | CHAR(2) | 2-letter state code. |
| `RegistrationDate` | DATE | Date the customer joined. |

### 2. `Orders` [FACT TABLE]
Central fact table linking customers to temporal purchasing behavior.
| Column | Type | Description |
| :--- | :--- | :--- |
| `OrderID` | INT (PK) | Unique order identifier. |
| `CustomerID` | INT (FK) | Links to `Customers` table. |
| `OrderDate` | DATETIME | Timestamp of purchase. |
| `DeliveryDate` | DATETIME | Timestamp of delivery. |
| `OrderStatus` | VARCHAR(50) | Current state (e.g., Delivered, Shipped). |

### 3. `Order_Items` [FACT TABLE]
Provides granular monetary data for revenue tracking and market basket combinations.
| Column | Type | Description |
| :--- | :--- | :--- |
| `OrderItemID` | INT (PK) | Unique identifier for the line item. |
| `OrderID` | INT (FK) | Links to `Orders` table. |
| `ProductID` | INT (FK) | Links to `Products` table. |
| `SellerID` | INT | Identifier for the specific seller. |
| `Price` | DECIMAL(10,2) | Base price of the item. |
| `FreightValue` | DECIMAL(10,2) | Shipping/freight cost applied. |

### 4. `Products` [DIMENSION TABLE]
Facilitates category-level performance tracking and inventory optimization.
| Column | Type | Description |
| :--- | :--- | :--- |
| `ProductID` | INT (PK) | Unique identifier. |
| `CategoryName` | VARCHAR(100) | Product category classification. |
| `Weight_grams` | DECIMAL(10,2) | Physical weight. |
| `Dimensions_cm` | VARCHAR(50) | Physical dimensions. |

### 5. `Reviews` [FACT TABLE]
Primary data source for qualitative sentiment analysis and satisfaction modeling.
| Column | Type | Description |
| :--- | :--- | :--- |
| `ReviewID` | INT (PK) | Unique review identifier. |
| `OrderID` | INT (FK) | Links back to the specific `Orders` record. |
| `ReviewScore` | INT | Rating strictly enforced between 1 and 5. |
| `ReviewText` | NVARCHAR(MAX) | Written customer feedback. |
| `ReviewDate` | DATETIME | Timestamp of the review. |
