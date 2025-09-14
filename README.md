

#  BM Stores Sales Performance Analysis – SQL + Excel Dashboard

## Project Overview

This project analyzes BM Stores’ sales data using **SQL** for data cleaning & querying and an **Excel dashboard** for visualization. The goal was to uncover trends in sales, profit, product performance, shipping, and customer behavior to support data-driven decisions.

---

##  Project Goals

* Clean & prepare the data
* Perform EDA (Exploratory Data Analysis) via SQL
* Build an interactive Power BI dashboard 
* Communicate actionable recommendations to stakeholders

---

##  Implementation

### 1. Create database & import data

```sql

CREATE DATABASE RetailSales;
GO
```

### 2. Data preview

```sql
-- Preview the dataset
SELECT * FROM sales;
```

### 3. Check for NULL values

```sql
-- Check for NULLs in critical columns
SELECT *
FROM sales
WHERE transactions_id IS NULL
   OR sale_date IS NULL
   OR sale_time IS NULL
   OR customer_id IS NULL
   OR gender IS NULL
   OR age IS NULL
   OR category IS NULL
   OR quantity IS NULL
   OR price_per_unit IS NULL
   OR cogs IS NULL
   OR total_sale IS NULL;
```

### 4. Handle NULLs 

```sql
-- Delete rows with missing values
DELETE FROM sales
WHERE transactions_id IS NULL
   OR sale_date IS NULL
   OR sale_time IS NULL
   OR customer_id IS NULL
   OR gender IS NULL
   OR age IS NULL
   OR category IS NULL
   OR quantity IS NULL
   OR price_per_unit IS NULL
   OR cogs IS NULL
   OR total_sale IS NULL;
```

### 5. Check for duplicates

```sql
-- Find duplicate transactions_id
SELECT transactions_id, COUNT(*) AS count
FROM sales
GROUP BY transactions_id
HAVING COUNT(*) > 1;
```

### 6. Remove duplicates

```sql

WITH Duplicate AS (
  SELECT transactions_id,
         ROW_NUMBER() OVER (PARTITION BY transactions_id ORDER BY transactions_id) AS RN
  FROM sales
)
SELECT *
FROM Duplicate
WHERE RN > 1;
```

### 7. Rename column (fix typo)

```sql
-- Rename column quantiy -> quantity (SQL Server example)
EXEC sp_rename 'sales.quantiy', 'quantity', 'COLUMN';
```

---

## 📊 Exploratory Queries (common EDA examples)

```sql
-- i) Retrieve all columns for sales on a specific date
SELECT *
FROM sales
WHERE sale_date = '2022-11-05';
```

```sql
-- ii) Write a SQL query to retrieve all transactions where the category is 'Clothing' and the
quantity sold is more than 4 in the month of Nov-2022
SELECT *
FROM sales
WHERE category = 'Clothing'
  AND quantity > 4
  AND sale_date BETWEEN '2022-11-01' AND '2022-11-30';
```

```sql
-- iii) Total sales per category
SELECT category,
       SUM(total_sale) AS TotalSales
FROM sales
GROUP BY category;
```

```sql
-- iv) Average age of customers who purchased from 'Beauty'
SELECT AVG(age) AS Average_age
FROM sales
WHERE category = 'Beauty';
```

```sql
-- v) Transactions where total_sale > 1000
SELECT *
FROM sales
WHERE total_sale > 1000;
```

```sql
-- vi) Number of transactions by gender in each category
SELECT gender,
       category,
       COUNT(transactions_id) AS No_of_Transactions
FROM sales
GROUP BY gender, category;
```

```sql
-- vii) Average sale per month
SELECT MONTH(sale_date) AS Month,
       AVG(total_sale) AS Avg_sales
FROM sales
GROUP BY MONTH(sale_date)
ORDER BY Avg_sales DESC;
```

```sql
-- Best-selling month in each year
WITH Monthlysales AS (
  SELECT YEAR(sale_date) AS Year,
         MONTH(sale_date) AS Month,
         SUM(total_sale) AS Totalsales,
         ROW_NUMBER() OVER (PARTITION BY YEAR(sale_date) ORDER BY SUM(total_sale) DESC) AS rn
  FROM sales
  GROUP BY YEAR(sale_date), MONTH(sale_date)
)
SELECT Year, Month, Totalsales
FROM Monthlysales
WHERE rn = 1;
```

```sql
-- viii) Top 5 customers by total sales 
SELECT TOP 5 customer_id,
       SUM(total_sale) AS TotalSales
FROM sales
GROUP BY customer_id
ORDER BY TotalSales DESC;
```

```sql
-- ix) Number of unique customers per category
SELECT category,
       COUNT(DISTINCT customer_id) AS unique_customers
FROM sales
GROUP BY category;
```

```sql
-- x) Create time shifts and number of orders
SELECT COUNT(*) AS No_of_orders,
       CASE
         WHEN sale_time < '12:00:00' THEN 'Morning'
         WHEN sale_time BETWEEN '12:00:00' AND '17:00:00' THEN 'Afternoon'
         WHEN sale_time > '17:00:00' THEN 'Evening'
         ELSE 'Midnight'
       END AS shift
FROM sales
GROUP BY
       CASE
         WHEN sale_time < '12:00:00' THEN 'Morning'
         WHEN sale_time BETWEEN '12:00:00' AND '17:00:00' THEN 'Afternoon'
         WHEN sale_time > '17:00:00' THEN 'Evening'
         ELSE 'Midnight'
       END;
```

---

##  Dashboard (Power BI)

Built an interactive Power BI dashboard with:

* KPI cards (Sales, Profit, Quantity, Avg Shipping Days)
* Monthly trend charts for Sales and Profit
* Category breakdowns (Sales / Quantity / Profit)
* Demographic visuals (Age, Gender)
* Time-of-day analysis (Morning/Afternoon/Evening)
  ![VIEW](https://github.com/ARAFAH-LAWAL102/Retail-Sales-Analysis-with-SQL-and-Power-Bi/blob/main/Screenshot%202025-09-12%20105857.png)



---

## Key Insights
* Top Category: Clothing generated the highest profit (₦143K) and quantity sold (1,780 units).

* Sales Timing: Evening accounted for ₦572K in sales – the most profitable time shift.

* Demographics: Age group 18–35 drove the highest revenue (₦366K).

* Monthly Trend: Sales and profit spiked from August onward, indicating seasonal demand.

---

##  Recommendations

*Boost Evening Campaigns: Run more promotions in evening hours since they drive most sales.

* Target Younger Customers: Offer loyalty rewards for 18–35 age group — they generate the most revenue.

* Promote High-Margin Categories: Focus marketing on Clothing & Beauty products to sustain profit growth.

* Plan for Seasonal Demand: Prepare stock and campaigns ahead of August–December to maximize sales.
*Upsell in Low-Quantity Categories: Encourage bundles or discounts for categories with lower quantity sold.
---

## 🛠 Tools & Skills

SQL, Power BI , data cleaning, EDA, dashboard design, data storytelling

---





