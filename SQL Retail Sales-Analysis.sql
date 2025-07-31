-- SQL Retail Sales Analysis - p1
CREATE DATABASE sql_project_p1

DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales
             (
                transactions_id INT PRIMARY KEY,
	            sale_date DATE,
	            sale_time TIME,
	            customer_id INT,
	            gender VARCHAR(15),
	            age INT,
	            category VARCHAR(15),
	            quantiy INT,
	            price_per_unit FLOAT,
	            cogs FLOAT,
	            total_sale FLOAT
             );

 SELECT * FROM retail_sales
 LIMIT 10

 SELECT 
   COUNT(*) 
 FROM retail_sales

 SELECT * FROM retail_sales
 WHERE transactions_id is NULL

 SELECT * FROM retail_sales
 WHERE sale_date is NULL

-- Data Cleaning 

 SELECT * FROM retail_sales
 WHERE
     transactions_id is NULL
	 OR
	 sale_date is NULL
	 OR
	 sale_time is NULL
	 OR
	 customer_id is NULL
	 OR
	 gender is NULL
	 OR
	 age is NULL
	 OR
	 category is NULL
	 OR
	 quantiy is NULL
	 OR
	 price_per_unit is NULL
	 OR
	 cogs is NULL
	 OR
	 total_sale is NULL;

	 
 DELETE FROM retail_sales
 WHERE
     transactions_id is NULL
	 OR
	 sale_date is NULL
	 OR
	 sale_time is NULL
	 OR
	 customer_id is NULL
	 OR
	 gender is NULL
	 OR
	 age is NULL
	 OR
	 category is NULL
	 OR
	 quantiy is NULL
	 OR
	 price_per_unit is NULL
	 OR
	 cogs is NULL
	 OR
	 total_sale is NULL;


	 -- Data Exploration

	 -- How many sales we have?
	 SELECT COUNT(*) as total_sale FROM retail_sales;

	 -- how many unique customers we have?
	 SELECT COUNT( DISTINCT customer_id) as total_sale FROM retail_sales;

	 SELECT DISTINCT category FROM retail_sales;

	 


	 -- Data Analysis & Business key Problems & Answers

	 -- My Analysis & Findings
	 -- Q.1 Write a SQL query to retrieve all culomns for sales made on 2022-11-05
	 -- Q.2 Write a SQL query to retrieve all transactions where the category 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022
	 -- Q.3 Write a SQL query to culculate the total sales (total_sale) for each category.
	 -- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' Category.
	 -- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
	 -- Write a SQL query to find the total number of transactions (transaction_id) made by each gender in the category
	 -- Write a SQL query to calculate the average sale for each month.Find the best selling month in each yaer.
	 -- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales
	-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category
	-- Q.10 write a SQL query to create each shifa and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)



	 Q.1 Write a SQL query to retrieve all culomns for sales made on 2022-11-05

	 SELECT * FROM retail_sales
	 WHERE sale_date = '2022-11-05';


	 -- Q.2 Write a SQL query to retrieve all transactions where the category 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022
	 SELECT * FROM retail_sales
	 WHERE category = 'Clothing'
	 AND
	 TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
	 AND
	 quantiy >= 4;


	 -- Q.3 Write a SQL query to culculate the total sales (total_sale) for each category
	 SELECT 
	    category,
		SUM(total_sale) as net_sale
	 FROM retail_sales
	 GROUP BY 1


	 -- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' Category
	 SELECT 
	     ROUND(AVG(age),2) as avg_age
	 FROM retail_sales
	 WHERE category = 'Beauty';


	 -- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
	 SELECT * FROM retail_sales
	 WHERE total_sale > 1000


	 -- Write a SQL query to find the total number of transactions (transaction_id) made by each gender in the category
	 SELECT 
	 category,
	 gender,
	 COUNT(*) as total_trans
	 FROM retail_sales
	 GROUP BY 
	 category,
	 gender
	 ORDER BY 1



	 -- Write a SQL query to calculate the average sale for each month.Find the best selling month in each yaer.
	SELECT 
	      year,
		  month,
		 avg_sale
	FROM
	(
	SELECT 
	      EXTRACT(YEAR FROM sale_date) as year,
		  EXTRACT(MONTH FROM sale_date) as month,
		  AVG(total_sale) as avg_sale,
		  RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC)
     FROM retail_sales
	 GROUP BY 1,2
	 ) as t1
	 WHERE rank = 1
	 
	 -- ORDER BY 1,3 DESC 



	-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales
	SELECT 
	  customer_id,
	  -- category,
	  SUM(total_sale)as total_sales
	  FROM retail_sales
	-- WHERE category = 'Clothing'
	GROUP BY 1
	ORDER BY 2 DESC
	LIMIT 5



	-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
	SELECT 
	     category,
		 COUNT(DISTINCT customer_id) as cnt_unique_cust
    FROM retail_sales
	GROUP BY category 



	-- Q.10 write a SQL query to create each shifa and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)
	WITH hourly_sale
	AS
	(
	SELECT *,
	     CASE
		     WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
			 WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
			 ELSE 'Evening'
		END as shift
   FROM retail_sales
	)
	SELECT 
	     Shift,
		 COUNT(*) as total_orders
	FROM hourly_sale
    GROUP BY Shift

	-- End The Project