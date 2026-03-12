use olist_analysis;

-- main queries

-- ================================================
-- OLIST CHURN ANALYSIS - SQL QUERIES
-- Author: Your Name
-- Date: March 2026
-- ================================================

-- QUERY 1: Check Order Status
SELECT order_status, COUNT(*) AS total
FROM orders
GROUP BY order_status
ORDER BY total DESC;

-- QUERY 2: Churn Rate Analysis
SELECT 
  CASE 
    WHEN total_orders = 1 THEN 'Churned'
    WHEN total_orders >= 2 THEN 'Retained'
  END AS customer_type,
  COUNT(*) AS total_customers
FROM (
  SELECT
    c.customer_unique_id,
    COUNT(o.order_id) AS total_orders
  FROM customers c
  JOIN orders o ON c.customer_id = o.customer_id
  WHERE o.order_status = 'delivered'
  GROUP BY c.customer_unique_id
) AS customer_orders
GROUP BY customer_type;

-- QUERY 3: Delivery Analysis
SELECT 
  CASE 
    WHEN DATEDIFF(
      order_delivered_customer_date, 
      order_estimated_delivery_date) < 0 
    THEN 'Early Delivery'
    WHEN DATEDIFF(
      order_delivered_customer_date, 
      order_estimated_delivery_date) = 0 
    THEN 'On Time'
    WHEN DATEDIFF(
      order_delivered_customer_date, 
      order_estimated_delivery_date) BETWEEN 1 AND 7
    THEN 'Slight Delay'
    ELSE 'High Delay'
  END AS delivery_category,
  COUNT(*) AS total_orders
FROM orders
WHERE order_status = 'delivered'
AND order_delivered_customer_date IS NOT NULL
AND order_estimated_delivery_date IS NOT NULL
GROUP BY delivery_category
ORDER BY total_orders DESC;

-- QUERY 4: Review Score Analysis
SELECT 
  r.review_score,
  COUNT(*) AS total_reviews,
  ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) AS percentage
FROM reviews r
JOIN orders o ON r.order_id = o.order_id
WHERE o.order_status = 'delivered'
GROUP BY r.review_score
ORDER BY r.review_score DESC;

-- QUERY 5: Customer Segments
SELECT 
  CASE
    WHEN total_spent >= 500 THEN 'High Value'
    WHEN total_spent BETWEEN 100 AND 499 THEN 'Mid Value'
    ELSE 'Low Value'
  END AS customer_segment,
  COUNT(*) AS total_customers,
  ROUND(AVG(total_spent), 2) AS avg_spending
FROM (
  SELECT 
    c.customer_unique_id,
    SUM(p.payment_value) AS total_spent
  FROM customers c
  JOIN orders o ON c.customer_id = o.customer_id
  JOIN payments p ON o.order_id = p.order_id
  WHERE o.order_status = 'delivered'
  GROUP BY c.customer_unique_id
) AS customer_spending
GROUP BY customer_segment
ORDER BY avg_spending DESC;





