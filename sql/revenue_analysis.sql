-- REVENUE & SPENDING ANALYSIS


-- Monthly Revenue Trend
SELECT 
    year,
    month,
    ROUND(SUM(total_payment), 2) AS revenue
FROM orders
GROUP BY year, month
ORDER BY year, month;


-- Average Order Value (AOV)
SELECT 
    year,
    month,
    ROUND(AVG(total_payment), 2) AS avg_order_value
FROM orders
GROUP BY year, month
ORDER BY year, month;