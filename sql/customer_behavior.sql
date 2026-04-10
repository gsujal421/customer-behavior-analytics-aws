-- CUSTOMER BEHAVIOR & RETENTION ANALYSIS


-- Repeat vs One-time Customers
SELECT 
    customer_type,
    COUNT(*) AS customers,
    ROUND(AVG(total_spent), 2) AS avg_spent
FROM customers
GROUP BY customer_type;


-- Impact of Delivery on Retention
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


-- Order Status Distribution
SELECT 
    order_status,
    COUNT(*) AS total_orders,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS percentage
FROM orders
GROUP BY order_status;
