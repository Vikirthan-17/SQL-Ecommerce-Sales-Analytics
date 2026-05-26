SELECT COUNT(*) FROM customers;

SELECT COUNT(*) FROM orders;

SELECT COUNT(*) FROM order_items;

SELECT order_status, COUNT(*) AS total_orders
FROM orders
GROUP BY order_status
ORDER BY total_orders DESC;
LIMIT 10;

SELECT ROUND(SUM(price + freight_value), 2) AS total_revenue
FROM order_items;

SELECT seller_id, ROUND(SUM(price + freight_value), 2) AS revenue
FROM order_items
GROUP BY seller_id
ORDER BY revenue DESC
LIMIT 10;

SELECT ROUND(AVG(price), 2) AS average_price
FROM order_items;

SELECT
      DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m') AS month,
      ROUND(SUM(oi.price + oi.freight_value), 2) AS monthly_revenue
FROM orders o
JOIN order_items oi
ON o.order_id = oi.order_id
GROUP BY month
ORDER BY month;

SELECT
    p.product_category_name,
    ROUND(SUM(oi.price + oi.freight_value), 2) AS revenue
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY revenue DESC
LIMIT 10;

SELECT
      p.product_category_name,
      COUNT(oi.order_id) AS total_items_sold
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY total_items_sold DESC
LIMIT 10;

SELECT
    c.customer_city,
    c.customer_state,
    ROUND(SUM(oi.price + oi.freight_value), 2) AS revenue
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
JOIN order_items oi 
ON o.order_id = oi.order_id
GROUP BY c.customer_city, c.customer_state
ORDER BY revenue DESC
LIMIT 10;

SELECT
payment_type,
COUNT(*) AS total_payments,
ROUND(AVG(payment_value), 2) AS average_payment_value
FROM order_payments
GROUP BY payment_type
ORDER BY total_payments DESC;

SELECT 
    ROUND(AVG(DATEDIFF(`order_delivered_customer_date`, `order_purchase_timestamp`)), 2) AS avg_delivery_days
FROM orders
WHERE order_status = 'delivered';