# Problem Statement: E-Commerce Retail Analytics Engine

## 🏢 Executive Summary
Despite generating thousands of daily transactions and maintaining a rich database of customer activity, the fictional mid-sized e-commerce retailer was suffering from "Data Rich, Insight Poor" syndrome. The business was tracking high-level metrics (total sales, total customers) but lacked the granular, actionable intelligence required to optimize supply chain logistics, personalize marketing, and proactively prevent customer churn.

## ⚠️ The Core Business Challenges

### 1. Inefficient Marketing Spend & Unidentified Churn
* The Issue: The marketing team utilized a "batch and blast" strategy, sending the same promotional discounts to all customers. 
* The Impact: This resulted in wasted ad spend on customers who had already abandoned the brand, while simultaneously failing to reward the highest-value, most loyal customers. The business had no mathematical way to define a "VIP" versus an "At-Risk" customer.

### 2. Inventory Bloat and Capital Misallocation
* The Issue: Procurement and warehouse teams lacked visibility into which specific product categories were driving the majority of the revenue.
* The Impact: The warehouse suffered from inventory bloat, paying high holding costs for slow-moving "dead stock," while frequently facing stockouts on high-margin products. They were treating all inventory equally rather than prioritizing based on revenue contribution.

### 3. Stagnant Average Order Value (AOV)
* The Issue: The e-commerce platform had no intelligent recommendation engine. Customers frequently checked out with single items in their cart.
* The Impact: The company was leaving significant revenue on the table. Without knowing which products had high purchasing affinity (e.g., customers who buy a laptop also buy a mouse), the business could not effectively bundle items or cross-sell at checkout.

### 4. Fragmented and Delayed Reporting
* The Issue: Executive leadership relied on static, manual Excel exports compiled weekly by data analysts.
* The Impact: Decision-making was reactive rather than proactive. By the time leadership reviewed the data, the trends were already outdated.

---

## 🎯 Project Objective
The objective of the Project Alpha Analytics Engine is to transform raw, transactional SQL data into a strategic command center. By engineering advanced T-SQL models and deploying an interactive SSRS dashboard, this project aims to:
1. Segment Customers: Implement an RFM (Recency, Frequency, Monetary) model to categorize customers into actionable marketing cohorts.
2. Optimize Inventory: Execute a Pareto (80/20) analysis to identify the top revenue-driving product categories.
3. Drive Cross-Selling: Develop a Market Basket Analysis engine using complex self-joins to uncover product purchasing affinities.
4. Automate Insights: Deliver a dynamic, parameter-driven reporting layer for executive leadership.
