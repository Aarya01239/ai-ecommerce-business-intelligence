-- AI-Powered E-Commerce Business Intelligence
-- Core SQL Analysis
-- Dataset table name assumed: ecommerce_orders

-- 1. Overall KPI summary
SELECT
    COUNT(DISTINCT order_id) AS total_orders,
    COUNT(DISTINCT customer_id) AS unique_customers,
    SUM(revenue) AS total_revenue,
    SUM(profit) AS total_profit,
    AVG(revenue) AS average_order_value,
    SUM(profit) / NULLIF(SUM(revenue), 0) AS profit_margin
FROM ecommerce_orders;

-- 2. Category performance
SELECT
    category,
    COUNT(DISTINCT order_id) AS orders,
    SUM(revenue) AS revenue,
    SUM(profit) AS profit,
    SUM(profit) / NULLIF(SUM(revenue), 0) AS profit_margin
FROM ecommerce_orders
GROUP BY category
ORDER BY revenue DESC;

-- 3. Sales-channel performance
SELECT
    sales_channel,
    COUNT(DISTINCT order_id) AS orders,
    SUM(revenue) AS revenue,
    SUM(profit) AS profit,
    SUM(profit) / NULLIF(SUM(revenue), 0) AS profit_margin
FROM ecommerce_orders
GROUP BY sales_channel
ORDER BY revenue DESC;

-- 4. Regional performance
SELECT
    region,
    COUNT(DISTINCT order_id) AS orders,
    SUM(revenue) AS revenue,
    SUM(profit) AS profit,
    SUM(profit) / NULLIF(SUM(revenue), 0) AS profit_margin
FROM ecommerce_orders
GROUP BY region
ORDER BY revenue DESC;

-- 5. Customer-segment performance
SELECT
    customer_segment,
    COUNT(DISTINCT customer_id) AS customers,
    COUNT(DISTINCT order_id) AS orders,
    SUM(revenue) AS revenue,
    SUM(profit) AS profit
FROM ecommerce_orders
GROUP BY customer_segment
ORDER BY revenue DESC;

-- 6. Monthly revenue and profit trend
SELECT
    DATE_TRUNC('month', order_date) AS month,
    SUM(revenue) AS revenue,
    SUM(profit) AS profit,
    COUNT(DISTINCT order_id) AS orders
FROM ecommerce_orders
GROUP BY DATE_TRUNC('month', order_date)
ORDER BY month;

-- 7. Payment-method performance
SELECT
    payment_method,
    COUNT(DISTINCT order_id) AS orders,
    SUM(revenue) AS revenue,
    SUM(profit) AS profit
FROM ecommerce_orders
GROUP BY payment_method
ORDER BY revenue DESC;

-- 8. Discount impact
SELECT
    discount_pct,
    COUNT(DISTINCT order_id) AS orders,
    SUM(revenue) AS revenue,
    SUM(profit) AS profit,
    SUM(profit) / NULLIF(SUM(revenue), 0) AS profit_margin
FROM ecommerce_orders
GROUP BY discount_pct
ORDER BY discount_pct;

-- 9. Top products by revenue
SELECT
    product_id,
    category,
    SUM(quantity) AS units_sold,
    SUM(revenue) AS revenue,
    SUM(profit) AS profit
FROM ecommerce_orders
GROUP BY product_id, category
ORDER BY revenue DESC
LIMIT 10;

-- 10. High-value customers
SELECT
    customer_id,
    COUNT(DISTINCT order_id) AS orders,
    SUM(revenue) AS revenue,
    SUM(profit) AS profit
FROM ecommerce_orders
GROUP BY customer_id
ORDER BY revenue DESC
LIMIT 20;
