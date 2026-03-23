# E-Commerce-Retail-Analytics-Engine-Project-Alpha-
Built using Microsoft SQL Server and SQL Server Reporting Services (SSRS), this engine focuses on maximizing Customer Lifetime Value (CLV) and optimizing inventory management.


🛒 E-Commerce Retail Analytics Engine (Project Alpha)

📌 Project Overview

This project is an end-to-end data analytics pipeline designed to extract actionable business intelligence from e-commerce transaction data. Built using Microsoft SQL Server and SQL Server Reporting Services (SSRS), this engine focuses on maximizing Customer Lifetime Value (CLV) and optimizing inventory management.

🏗️ Architecture & Tech Stack

Database: Microsoft SQL Server (T-SQL)

Visualization: SQL Server Reporting Services (SSRS) / Report Builder

Techniques Used: Advanced Window Functions, Common Table Expressions (CTEs), Self-Joins, Conditional Aggregation.

📊 Core Analytical Modules

1. RFM Customer Segmentation

Identified high-value and at-risk customers by calculating Recency, Frequency, and Monetary metrics.

SQL Highlight: Utilized the NTILE() window function to dynamically rank and quartile customers based on purchasing behavior.

2. Pareto (80/20) Inventory Analysis

Analyzed product categories to determine which items drive the vast majority of revenue.

SQL Highlight: Leveraged advanced running totals using SUM() OVER (ORDER BY ... ROWS UNBOUNDED PRECEDING) to calculate cumulative revenue percentages.

3. Market Basket Analysis (Cross-Selling)

Developed a recommendation engine foundation by finding products frequently bought together in the same order.

SQL Highlight: Implemented complex Self-Joins with inequality conditions to prevent duplicate pairing and self-matching.

📸 Dashboard Preview

(Note to self: Upload the screenshot of your SSRS Dashboard here! Name the image file dashboard.png and put it in the same folder as this README)

💻 Database Schema

The relational database consists of 5 normalized tables:

Customers: Demographic data and registration dates.

Products: Inventory categories and physical attributes.

Orders: Central fact table for temporal purchasing behavior.

Order_Items: Granular line-item data for revenue tracking.

Reviews: Qualitative sentiment tracking.

🚀 How to Run

Execute project_alpha_schema.sql in SQL Server Management Studio (SSMS) to build the database and insert mock data.

Execute the view scripts (rfm_analysis.sql, pareto_analysis.sql, market_basket.sql) to generate the analytical models.

Open Retail_Dashboard.rdl in Microsoft Report Builder and update the Data Source connection to your local instance.
