# Data Dictionary: E-Commerce Analytics Schema

## Fact Tables

### Orders
| Column | Type | Description | Source |
|--------|------|-------------|---------|
| OrderID | PK INT | Unique order identifier | System generated |
| CustomerID | FK INT | Links to Customers dimension | Customer table |
| OrderDate | DATETIME | When order was placed | Transaction system |
| DeliveryDate | DATETIME | Actual delivery timestamp | Logistics system |
| OrderStatus | VARCHAR(50) | Delivered/Shipped/Cancelled | Operational status |

### Order_Items (Transaction Grain)
| Column | Type | Description |
|--------|------|-------------|
| OrderItemID | PK INT | Line item identifier |
| OrderID | FK INT | Parent order |
| ProductID | FK INT | Product purchased |
| Price | DECIMAL | Unit price at transaction time |
| FreightValue | DECIMAL | Shipping cost allocated |

## Dimension Tables

### Customers
- **Grain:** One row per customer
- **Slowly Changing:** Type 2 (track historical changes)
- **Attributes:** City, State, RegistrationDate (for cohort analysis)

### Products
- **Grain:** One row per SKU
- **Hierarchy:** Category → Subcategory → SKU
- **Attributes:** Weight (for logistics cost), Dimensions (for packaging)

### Reviews
- **Grain:** One row per order review
- **Sentiment:** Score 1-5, Text for NLP (future enhancement)

## Key Relationships
- Orders → Customers (Many-to-One)
- Order_Items → Orders (Many-to-One)
- Order_Items → Products (Many-to-One)
- Reviews → Orders (One-to-One)

