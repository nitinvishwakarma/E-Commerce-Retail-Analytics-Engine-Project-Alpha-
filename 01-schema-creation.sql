```sql
-- E-Commerce Retail Analytics Database Schema
-- Optimized for Customer Segmentation & Inventory Analysis
-- Author: Nitin Vishwakarma | Ex-Swiggy Operations | Data Analytics

CREATE DATABASE RetailAnalyticsDB;
GO

USE RetailAnalyticsDB;
GO

-- Dimension: Customers (Demographics & Cohorts)
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY IDENTITY(1,1),
    CustomerCity VARCHAR(100),
    CustomerState CHAR(2),
    RegistrationDate DATE
);

-- Dimension: Products (Categories & Physical Attributes)
CREATE TABLE Products (
    ProductID INT PRIMARY KEY IDENTITY(1,1),
    CategoryName VARCHAR(100),
    Weight_grams DECIMAL(10,2),
    Dimensions_cm VARCHAR(50)
);

-- Fact: Orders (Transaction Header)
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY IDENTITY(1,1),
    CustomerID INT,
    OrderDate DATETIME,
    DeliveryDate DATETIME,
    OrderStatus VARCHAR(50),
    CONSTRAINT FK_Orders_Customers 
        FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Fact: Order_Items (Transaction Line Items - Grain: Product per Order)
CREATE TABLE Order_Items (
    OrderItemID INT PRIMARY KEY IDENTITY(1,1),
    OrderID INT,
    ProductID INT,
    SellerID INT,
    Price DECIMAL(10,2),
    FreightValue DECIMAL(10,2),
    CONSTRAINT FK_OrderItems_Orders 
        FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    CONSTRAINT FK_OrderItems_Products 
        FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Fact: Reviews (Sentiment Data)
CREATE TABLE Reviews (
    ReviewID INT PRIMARY KEY IDENTITY(1,1),
    OrderID INT,
    ReviewScore INT CHECK (ReviewScore BETWEEN 1 AND 5),
    ReviewText NVARCHAR(MAX),
    ReviewDate DATETIME,
    CONSTRAINT FK_Reviews_Orders 
        FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Sample Data for Demonstration
INSERT INTO Customers VALUES 
('New York', 'NY', '2023-01-15'),
('Los Angeles', 'CA', '2023-02-20'),
('Chicago', 'IL', '2023-03-05'),
('Austin', 'TX', '2023-03-10');

INSERT INTO Products VALUES 
('Electronics', 1500.00, '30x20x10'),
('Home Appliances', 4500.00, '50x40x30'),
('Books', 300.00, '20x15x2'),
('Toys', 800.00, '25x25x25');

INSERT INTO Orders VALUES 
(1, '2023-04-01', '2023-04-05', 'Delivered'),
(2, '2023-04-02', '2023-04-06', 'Delivered'),
(1, '2023-05-15', '2023-05-18', 'Delivered'),
(3, '2023-06-10', NULL, 'Shipped');

INSERT INTO Order_Items VALUES 
(1, 1, 101, 299.99, 15.00),
(1, 3, 102, 19.99, 5.00),
(2, 2, 103, 150.00, 25.00),
(3, 1, 101, 299.99, 15.00),
(4, 4, 104, 45.50, 10.00);

INSERT INTO Reviews VALUES 
(1, 5, 'Great laptop and book!', '2023-04-06'),
(2, 3, 'Slow delivery but fine product', '2023-04-08'),
(3, 5, 'Repeat customer, love it', '2023-05-19');

