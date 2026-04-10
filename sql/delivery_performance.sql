-- DELIVERY PERFORMANCE ANALYSIS


-- Delivery Delay Percentage
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


-- Average Delivery Time (Days)
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


-- Delivery Status Distribution
SELECT 
    CASE 
        WHEN order_delivered_customer_date > order_estimated_delivery_date THEN 'Delayed'
        ELSE 'On-time'
    END AS delivery_status,
    COUNT(DISTINCT customer_unique_id) AS customers
FROM orders
GROUP BY 1;