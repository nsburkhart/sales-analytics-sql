-- Final analysis queries
-- Sales Analytics Portfolio Project

-- 1. Revenue by Product
SELECT
    product_name,
    SUM(price * quantity) AS total_revenue
FROM products
JOIN order_items
    ON products.product_id = order_items.product_id
GROUP BY products.product_id, product_name
ORDER BY total_revenue DESC;


-- 2. Top 10 Customers by Total Spending
SELECT
    first_name,
    last_name,
    SUM(price * quantity) AS total_spent
FROM customers
JOIN orders
    ON customers.customer_id = orders.customer_id
JOIN order_items
    ON orders.order_id = order_items.order_id
JOIN products
    ON order_items.product_id = products.product_id
GROUP BY customers.customer_id, first_name, last_name
ORDER BY total_spent DESC
LIMIT 10;


-- 3. Revenue by Category
SELECT
    category,
    SUM(price * quantity) AS total_revenue
FROM products
JOIN order_items
    ON products.product_id = order_items.product_id
GROUP BY category
ORDER BY total_revenue DESC;


-- 4. Top 10 Customers by Number of Orders
SELECT
    first_name,
    last_name,
    COUNT(orders.order_id) AS total_orders
FROM customers
JOIN orders
    ON customers.customer_id = orders.customer_id
GROUP BY customers.customer_id, first_name, last_name
ORDER BY total_orders DESC, last_name, first_name
LIMIT 10;


-- 5. Average Order Value
SELECT
    ROUND(AVG(order_total), 2) AS average_order_value
FROM (
    SELECT
        orders.order_id,
        SUM(price * quantity) AS order_total
    FROM orders
    JOIN order_items
        ON orders.order_id = order_items.order_id
    JOIN products
        ON order_items.product_id = products.product_id
    GROUP BY orders.order_id
) AS order_totals;


-- 6. Top 5 Products by Units Sold
SELECT
    product_name,
    SUM(quantity) AS total_units_sold
FROM products
JOIN order_items
    ON products.product_id = order_items.product_id
GROUP BY products.product_id, product_name
ORDER BY total_units_sold DESC
LIMIT 5;


-- 7. Revenue by State
SELECT
    state,
    SUM(price * quantity) AS total_revenue
FROM customers
JOIN orders
    ON customers.customer_id = orders.customer_id
JOIN order_items
    ON orders.order_id = order_items.order_id
JOIN products
    ON order_items.product_id = products.product_id
GROUP BY state
ORDER BY total_revenue DESC;


-- 8. Monthly Revenue
SELECT
    TO_CHAR(DATE_TRUNC('month', order_date), 'YYYY-MM') AS month,
    SUM(price * quantity) AS total_revenue
FROM orders
JOIN order_items
    ON orders.order_id = order_items.order_id
JOIN products
    ON order_items.product_id = products.product_id
GROUP BY DATE_TRUNC('month', order_date)
ORDER BY DATE_TRUNC('month', order_date) ASC;
