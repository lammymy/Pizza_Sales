--1 Total Revenue
SELECT 
	SUM(total_price) AS Total_Revenue 
FROM pizza_sales

--2 Average Order Value
SELECT 
	SUM(total_price) /COUNT(DISTINCT order_id) AS AOV 
FROM pizza_sales

--3 Total Pizzas Sold
SELECT 
	SUM(quantity) AS Total_Pizzas_Sold
FROM pizza_sales

--4 Total Orders
SELECT 
	COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales

--5 Average Pizzas Per Order
SELECT 
	CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) /
	CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2)) AS Avg_Pizzas_Per_Order
FROM pizza_sales

-- 6 Daily Trend For Total Orders
SELECT DATENAME(DW, order_date) AS Order_Day
		, COUNT(DISTINCT order_id) AS No_Of_Orders
FROM pizza_sales
GROUP BY DATENAME(DW, order_date)

-- 7 Monthly Trend For Total Orders
SELECT DATENAME(MONTH, order_date) AS Order_Month
		, COUNT(DISTINCT order_id) AS No_Of_Orders
FROM pizza_sales
GROUP BY DATENAME(MONTH, order_date)
ORDER BY COUNT(DISTINCT order_id) DESC

-- 8 Percentage of Sales by Pizza Category in January
SELECT
	pizza_category
	, SUM(total_price) AS Total_Price
	, SUM(total_price) *100 /(SELECT SUM(total_price) FROM pizza_sales WHERE MONTH(order_date) = 1)  AS Percetage
FROM pizza_sales
WHERE 
	MONTH(order_date) = 1
GROUP BY pizza_category

-- 9 Percentage of Sales by Pizza Size
SELECT
	pizza_size
	, CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_Price
	, CAST(SUM(total_price) *100 /(SELECT SUM(total_price) FROM pizza_sales) AS DECIMAL(10,2)) AS Percetage
FROM pizza_sales
GROUP BY pizza_size
ORDER BY Percetage DESC

-- 10 Top 5 best sellers Pizzas by Revenue
SELECT TOP 5 
	pizza_name
	, CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue DESC
-- 11 Top 5 best sellers Pizzas by Quantity
SELECT TOP 5 
	pizza_name
	, SUM(quantity) AS Total_Quantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Quantity DESC

-- 12 Top 5 best sellers Pizzas by Total Orders
SELECT TOP 5 
	pizza_name
	, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders DESC