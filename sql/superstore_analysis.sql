
CREATE TABLE superstore_orders (
    row_id INTEGER,
    order_id VARCHAR(30),
    order_date_text VARCHAR(20),
    ship_date_text VARCHAR(20),
    ship_mode VARCHAR(50),
    customer_id VARCHAR(30),
    customer_name VARCHAR(100),
    segment VARCHAR(50),
    country_region VARCHAR(100),
    city VARCHAR(100),
    state_province VARCHAR(100),
    postal_code VARCHAR(20),
    region VARCHAR(50),
    product_id VARCHAR(30),
    category VARCHAR(100),
    sub_category VARCHAR(100),
    product_name TEXT,
    sales NUMERIC(14,4),
    quantity INTEGER,
    discount NUMERIC(8,4),
    profit NUMERIC(14,4)
);

SELECT COUNT(*) FROM superstore_orders;

-- Verifing the record count

SELECT 
	COUNT(*) AS total_records,
	COUNT(DISTINCT order_id) AS unique_orders,
	COUNT(DISTINCT customer_id) AS unique_customers,
	COUNT(DISTINCT product_id) AS unique_products
FROM superstore_orders;

-- Checking missing values

SELECT
	COUNT(*) FILTER (WHERE order_id IS NULL) AS missing_order_ids,
	COUNT(*) FILTER (WHERE customer_id IS NULL) AS missing_customer_ids,
	COUNT(*) FILTER (WHERE sales IS NULL) AS missing_sales,
	COUNT(*) FILTER (WHERE profit IS NULL) AS missing_profit,
	COUNT(*) FILTER (WHERE order_date_text IS NULL) AS missing_order_dates
FROM superstore_orders;

SELECT order_id, order_date_text, ship_date_text, sales, profit
FROM superstore_orders
LIMIT 10;

ALTER TABLE superstore_orders
ADD COLUMN IF NOT EXISTS order_date DATE;

ALTER TABLE superstore_orders
ADD COLUMN IF NOT EXISTS ship_date DATE;

UPDATE superstore_orders
SET
	order_date = TO_DATE(order_date_text, 'MM/DD/YYYY'),
	ship_date = TO_DATE(ship_date_text, 'MM/DD/YYYY');

-- Validatation the transformed data

SELECT order_id, order_date_text, order_date, ship_date_text, ship_date
FROM superstore_orders
LIMIT 10;

SELECT
	COUNT(*) AS total_rows,
	COUNT(*) FILTER (WHERE order_date IS NULL) AS missing_order_dates,
	COUNT(*) FILTER (WHERE ship_date IS NULL) AS missing_ship_dates,
	
	COUNT(*) FILTER (WHERE ship_date < order_date) AS invalid_shipping_dates,
	COUNT(*) FILTER (WHERE sales < 0) AS negative_sales,
	COUNT(*) FILTER (WHERE quantity <= 0) AS invalid_quantities
FROM superstore_orders;

-- Overall sales performance

SELECT
	ROUND(SUM(sales), 2) AS total_sales,
	ROUND(SUM(profit), 2) AS total_profit,
	ROUND(100.0 * SUM(profit) / NULLIF(SUM(sales), 0), 2) AS profit_margin_prct,
	COUNT(DISTINCT order_id) AS total_orders,
	COUNT(DISTINCT customer_id) AS total_customers,
	SUM(quantity) AS units_sold
FROM superstore_orders;

-- Regional sales and profitabilities

SELECT region,
	ROUND(SUM(sales), 2) AS total_sales,
	ROUND(SUM(profit), 2) AS total_profit,

	ROUND(100.0 * SUM(profit) / NULLIF(SUM(sales), 0), 2) AS profit_margin_prct,

	COUNT(DISTINCT order_id) AS total_orders
FROM superstore_orders
GROUP BY region
ORDER BY total_sales DESC;

-- Customer segment analysis

SELECT segment,
	COUNT(DISTINCT customer_id) AS customers,
	COUNT(DISTINCT order_id) AS orders,

	ROUND(SUM(sales), 2) AS total_sales,
	ROUND(SUM(profit), 2) AS total_profit,

	ROUND(SUM(sales) / NULLIF(COUNT(DISTINCT order_id), 0), 2) AS avg_order_value
FROM superstore_orders
GROUP BY segment
ORDER BY total_sales DESC;

-- Monthly sales trends -- 
-- How are sales changing month over month? --

WITH monthly_sales AS (
	SELECT
		DATE_TRUNC('month', order_date) :: DATE AS sales_month,
		ROUND(SUM(sales), 2) AS total_sales,
		ROUND(SUM(profit), 2) AS total_profit
	FROM superstore_orders
	WHERE order_date IS NOT NULL
	GROUP BY 1
),
sales_growth AS (
	SELECT sales_month, total_sales, total_profit,
		LAG(total_sales) OVER (
			ORDER BY sales_month
			) AS pre_month_sales
	FROM monthly_sales
)
SELECT sales_month, total_sales, total_profit,
	ROUND(100.0 * (total_sales - pre_month_sales) / NULLIF(pre_month_sales, 0), 2)
		AS monthly_growth_prct
FROM sales_growth
ORDER BY sales_month;
		
-- Top 5 products in each category --
-- Which products generate the most revenue within each category? --

WITH product_sales AS (
	SELECT category, product_id, product_name,
		ROUND(SUM(sales), 2) AS total_sales,
		ROUND(SUM(profit), 2) AS total_profit
	FROM superstore_orders
	GROUP BY category, product_id, product_name
),
ranked_products AS (
	SELECT *, DENSE_RANK() OVER(
		PARTITION BY category
		ORDER BY total_sales DESC
	)
		AS sales_rank
	FROM product_sales
)
SELECT *
FROM ranked_products
WHERE sales_rank <= 5
ORDER BY category, sales_rank;

-- Identifing loss-making subcategories --
-- Which product subcategories are reducing profitability? --


SELECT category, sub_category,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
	
    ROUND(100.0 * SUM(profit) / NULLIF(SUM(sales), 0), 2 ) 
	AS profit_margin_prct,
    ROUND(AVG(discount) * 100, 2)
        AS average_discount_prct
		
FROM superstore_orders
GROUP BY category, sub_category
ORDER BY total_profit ASC;

-- Customer lifetime sales and rankings --
-- Who are the highest-value customers in the dataset? --


WITH customer_metrics AS (
    SELECT
        customer_id, customer_name, segment,
        COUNT(DISTINCT order_id) AS total_orders,
        ROUND(SUM(sales), 2) AS lifetime_sales,
        ROUND(SUM(profit), 2) AS lifetime_profit
    FROM superstore_orders
    GROUP BY  customer_id, customer_name, segment

)
SELECT *,
    ROW_NUMBER() OVER (
        ORDER BY lifetime_sales DESC, customer_id
    ) AS customer_rank
FROM customer_metrics
ORDER BY customer_rank
LIMIT 20;


-- Customers orders frequency --
--- How many customers placed repeat orders? ---


WITH customer_orders AS (
    SELECT
        customer_id,
        COUNT(DISTINCT order_id) AS order_count
    FROM superstore_orders
    GROUP BY customer_id
),
customer_details AS (
    SELECT DISTINCT
        customer_id,
        customer_name,
        segment
    FROM superstore_orders
)
SELECT
    d.segment,
    COUNT(*) AS total_customers,
    COUNT(*) FILTER (
        WHERE o.order_count = 1
    ) AS one_time_customers,
    COUNT(*) FILTER (
        WHERE o.order_count > 1
    ) AS repeat_customers,
    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE o.order_count > 1
        ) / NULLIF(COUNT(*), 0),
        2
    ) AS repeat_customer_pct
FROM customer_orders o
JOIN customer_details d
    ON o.customer_id = d.customer_id
GROUP BY d.segment
ORDER BY repeat_customer_pct DESC;
