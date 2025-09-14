# BM Stores Sales Performance Analysis – SQL and Power Bi Dashboard
## Project Overview

This project focuses on analyzing BM Stores’ sales data using SQL for data cleaning, querying, and insight generation, followed by an Excel dashboard for visualization and storytelling.
The objective was to uncover key trends in sales, profit, customer behavior, and product performance to help the sales team and management make data-driven decisions.

## Project Goals

Clean & Prepare Data: Identify and remove duplicates, handle NULL values, and standardize columns.

Perform EDA (Exploratory Data Analysis): Use SQL to answer key business questions on sales, customers, and products.

Visualize Insights: Build an interactive Power BI dashboard showing KPIs, trends, and category breakdowns.

Communicate Findings: Provide actionable recommendations to improve sales strategy and efficiency.

⚙️ Implementation
🔧 1. Data Cleaning (SQL)

Created Database: RetailSales and imported flat file data.

Checked for NULL Values: Removed rows with missing key data (transactions_id, sale_date, quantity, etc.).

Checked for Duplicates: Used ROW_NUMBER() and removed duplicate transactions.

Renamed Columns: Fixed typos (e.g., quantiy → quantity) for consistency.
