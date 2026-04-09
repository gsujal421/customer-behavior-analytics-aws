
-- 1. Customer Segmentation by Revenue Contribution (Top 20% vs Bottom)

-- Purpose: Segment customers into 5 groups based on spending and calculate revenue contribution percentage of each segment

WITH ranked_customers AS (
    SELECT 
        customer_unique_id,
        SUM(total_payment) AS total_spent,
        NTILE(5) OVER (ORDER BY SUM(total_payment) DESC) AS segment
    FROM orders
    GROUP BY customer_unique_id
),
segment_revenue AS (
    SELECT 
        segment,
        SUM(total_spent) AS revenue
    FROM ranked_customers
    GROUP BY segment
),
total AS (
    SELECT SUM(revenue) AS total_revenue FROM segment_revenue
)
SELECT 
    segment,
    revenue,
    ROUND(100 * revenue / total.total_revenue, 2) AS revenue_pct
FROM segment_revenue, total
ORDER BY segment;



-- 2. Monthly Revenue Trend Analysis
-- Purpose: Track revenue growth/decline over time

SELECT 
    year,
    month,
    ROUND(SUM(total_payment), 2) AS revenue
FROM orders
GROUP BY year, month
ORDER BY year, month;



-- 3. Average Order Value (AOV) Trend
-- Purpose: Understand how customer spending per order changes over time

SELECT 
    year,
    month,
    ROUND(AVG(total_payment), 2) AS avg_order_value
FROM orders
GROUP BY year, month
ORDER BY year, month;


-- 4. Order Status Distribution
-- Purpose: Analyze order lifecycle (delivered, canceled, etc.)

SELECT 
    order_status,
    COUNT(*) AS total_orders,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS percentage
FROM orders
GROUP BY order_status;



-- 5. Delivery Delay Rate Analysis
-- Purpose: Measure operational efficiency via delay percentage

SELECT 
    COUNT(*) AS total_orders,
    SUM(CASE 
        WHEN order_delivered_customer_date > order_estimated_delivery_date THEN 1 
        ELSE 0 
    END) AS delayed_orders,
    ROUND(
        100.0 * SUM(CASE 
            WHEN order_delivered_customer_date > order_estimated_delivery_date THEN 1 
            ELSE 0 
        END) / COUNT(*), 2
    ) AS delay_percentage
FROM orders
WHERE order_delivered_customer_date IS NOT NULL;



-- 6. Customer Type Analysis (Repeat vs One-time)
-- Purpose: Compare spending behavior of repeat vs one-time customers

SELECT 
    customer_type,
    COUNT(*) AS customers,
    ROUND(AVG(total_spent), 2) AS avg_spent
FROM customers
GROUP BY customer_type;



-- 7. Impact of Delivery Performance on Customer Retention
-- Purpose: Analyze relationship between delays and repeat customers

WITH delivery_status AS (
    SELECT 
        customer_unique_id,
        CASE 
            WHEN order_delivered_customer_date > order_estimated_delivery_date THEN 'Delayed'
            ELSE 'On-time'
        END AS delivery_status
    FROM orders
),
customer_repeat AS (
    SELECT 
        customer_unique_id,
        CASE 
            WHEN COUNT(order_id) > 1 THEN 'Repeat'
            ELSE 'One-time'
        END AS customer_type
    FROM orders
    GROUP BY customer_unique_id
)
SELECT 
    d.delivery_status,
    c.customer_type,
    COUNT(*) AS customers
FROM delivery_status d
JOIN customer_repeat c
ON d.customer_unique_id = c.customer_unique_id
GROUP BY 1,2;



-- 8. Average Delivery Time (Days)
-- Purpose: Measure logistics efficiency in days

SELECT 
    ROUND(AVG(
        date_diff(
            'day',
            from_unixtime(order_purchase_timestamp / 1000000000),
            date_parse(order_delivered_customer_date, '%Y-%m-%d %H:%i:%s')
        )
    ), 2) AS avg_delivery_days
FROM orders
WHERE order_delivered_customer_date IS NOT NULL;



-- 9. Customer Count by Delivery Experience
-- Purpose: Compare how many customers faced delays vs on-time delivery

SELECT 
    CASE 
        WHEN order_delivered_customer_date > order_estimated_delivery_date THEN 'Delayed'
        ELSE 'On-time'
    END AS delivery_status,
    COUNT(DISTINCT customer_unique_id) AS customers
FROM orders
GROUP BY 1;



-- 10. Top Customers by Total Spending
-- Purpose: Identify high-value customers for targeting

SELECT 
    customer_unique_id,
    SUM(total_payment) AS total_spent
FROM orders
GROUP BY customer_unique_id
ORDER BY total_spent DESC;