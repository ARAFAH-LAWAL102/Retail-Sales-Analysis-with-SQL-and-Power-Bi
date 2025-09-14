
--Exploratory Data Analysis (EDA) Axia Project
--Author: Arafah Adesewa Lawal


--1. Write a SQL query to retrieve all columns for sales made on '2022-11-05
SELECT * from sales
WHERE sale_date = '2022-11-05';

--ii. Write a SQL query to retrieve all transactions where the category
--is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022
SELECT * FROM sales
WHERE category='Clothing'
AND quantity > 4
AND sale_date BETWEEN '2022-11-01' AND '2022-11-30';

--iii. Write a SQL query to calculate the total sales (total_sale) for each category.
SELECT category,SUM (total_sale) AS Totalsales
FROM sales
GROUP BY category;

--iv. Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
SELECT AVG(age) AS Average_age
FROM sales
WHERE category= 'Beauty';

--v. Write a SQL query to find all transactions where the total_sale is greater than 1000.
SELECT * FROM sales
WHERE total_sale > 1000;

--vi. Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
SELECT gender, category, COUNT(transactions_id) AS No_of_Transactions
FROM sales
GROUP BY gender, category;

--vii. Write a SQL query to calculate the average sale for each month. Find out best-selling month in each year.
SELECT MONTH(sale_date) AS Month, AVG(total_sale) AS Avg_sales
fROM sales 
GROUP BY  MONTH(sale_date)
ORDER BY Avg_sales DESC;

--Best-selling month in each year
WITH Monthlysales AS (
	SELECT MONTH(sale_date) as Month, YEAR(sale_date) AS Year,SUM (total_sale) AS Totalsales,
	ROW_NUMBER() OVER(
	PARTITION BY YEAR(sale_date) ORDER BY SUM(total_sale) DESC) AS rn
FROM sales
GROUP BY YEAR(sale_date),MONTH(sale_date)
)
	SELECT Year, Month, Totalsales
	 FROM Monthlysales
	WHERE rn=1;

--viii. Write a SQL query to find the top 5 customers based on the highest total sales.
SELECT TOP 5 customer_id, SUM(total_sale) AS Totalsales
FROM sales
GROUP BY customer_id
order by Totalsales desc

--ix. Write a SQL query to find the number of unique customers who purchased items from each category.
SELECT category, 
	COUNT( DISTINCT customer_id) AS unique_customers
FROM sales
GROUP BY category;

--x. Write a SQL query to create each shift and number of orders (Example
--Morning <12, Afternoon Between 12 & 17, Evening >17)
SELECT COUNT(quantity) AS No_of_orders,
	CASE 
		WHEN sale_time < '12:00:00' THEN 'Morning'
		WHEN sale_time BETWEEN '12:00:00' AND '17:00:00' THEN 'Afternoon'
		WHEN sale_time> '17:00:00' THEN 'Evening'
	ELSE 'Midnight'
 END AS shift
FROM sales
GROUP BY
	CASE 
		WHEN sale_time < '12:00:00' THEN 'Morning'
		WHEN sale_time BETWEEN '12:00:00' AND '17:00:00' THEN 'Afternoon'
		WHEN sale_time> '17:00:00' THEN 'Evening'
	ELSE 'Midnight'
 END;