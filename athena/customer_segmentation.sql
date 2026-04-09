
-- CUSTOMER SEGMENTATION & HIGH-VALUE USERS


-- Customer Segmentation by Revenue Contribution
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


-- Top Customers by Total Spending
SELECT 
    customer_unique_id,
    SUM(total_payment) AS total_spent
FROM orders
GROUP BY customer_unique_id
ORDER BY total_spent DESC;