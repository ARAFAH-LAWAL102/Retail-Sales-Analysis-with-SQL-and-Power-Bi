--Data Cleaning

--i. Creating database and importing Flat File
CREATE DATABASE RetailSales;  
GO

--ii. Previewing the Dataset
SELECT * FROM sales;

--iii. Checking for NULL
SELECT * 
FROM sales 
WHERE transactions_id IS NULL 
   OR sale_date IS NULL 
   OR sale_time IS NULL 
   OR customer_id IS NULL
   OR gender IS NULL
   OR age IS NULL
   OR category IS NULL
   OR quantiy IS NULL
   OR price_per_unit IS NULL
   OR cogs IS NULL
   OR total_sale IS NULL;  

   --iv. Handling NULL
DELETE FROM sales
WHERE transactions_id IS NULL
   OR sale_date IS NULL
   OR sale_time IS NULL
   OR customer_id IS NULL
   OR gender IS NULL
   OR age IS NULL
   OR category IS NULL
   OR quantiy IS NULL
   OR price_per_unit IS NULL
   OR cogs IS NULL
   OR total_sale IS NULL;
 
--v. Checking for Duplicates: I checked the dataset for duplicate transactions using the query:
SELECT transactions_id, COUNT (*) AS count
FROM sales
GROUP BY transactions_id
HAVING COUNT (*) > 1;

--vi Removing Duplicates
WITH Duplicate AS(
SELECT transactions_id,
	ROW_NUMBER() OVER(
		PARTITION BY transactions_id ORDER BY transactions_id) 
	AS RN
FROM sales
)
	SELECT *
	FROM Duplicate 
	WHERE RN > 1;

--iv. Renaming Columns: I changed column quantiy to quantity using this query:

EXEC sp_rename 'sales.quantiy', 'quantity', 'COLUMN';

