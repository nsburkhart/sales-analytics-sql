-- Synthetic data generator for the Sales Analytics Portfolio Project
-- Run AFTER schema.sql.
-- Creates 100 customers, 30 products, 400 orders, and 1,200 order items.

INSERT INTO customers (first_name, last_name, email, city, state, join_date)
SELECT
    first_names[((n - 1) % array_length(first_names, 1)) + 1],
    last_names[(((n - 1) / array_length(first_names, 1))::int % array_length(last_names, 1)) + 1],
    'customer' || n || '@example.com',
    cities[((n - 1) % array_length(cities, 1)) + 1],
    states[((n - 1) % array_length(states, 1)) + 1],
    DATE '2024-01-01' + ((n * 3) % 365)
FROM generate_series(1, 100) AS n
CROSS JOIN (
    SELECT
        ARRAY['James','Emma','Michael','Olivia','Daniel',
              'Sophia','David','Ava','Ryan','Mia',
              'Andrew','Isabella','Matthew','Emily','Ethan',
              'Charlotte','Jacob','Amelia','Nathan','Grace'] AS first_names,
        ARRAY['Anderson','Martinez','Thompson','Robinson','Clark',
              'Lewis','Walker','Hall','Allen','Young',
              'King','Wright','Scott','Green','Baker',
              'Adams','Nelson','Carter','Mitchell','Turner'] AS last_names,
        ARRAY['Denver','Chicago','Austin','Seattle','Phoenix'] AS cities,
        ARRAY['Colorado','Illinois','Texas','Washington','Arizona'] AS states
) AS names;

INSERT INTO products (product_name, category, price) VALUES
('Laptop', 'Electronics', 1200.00),
('Monitor', 'Electronics', 300.00),
('Keyboard', 'Accessories', 75.00),
('Mouse', 'Accessories', 45.00),
('Office Chair', 'Furniture', 200.00),
('Webcam', 'Electronics', 125.00),
('USB Hub', 'Accessories', 55.00),
('Desk Lamp', 'Office', 80.00),
('Wireless Charger', 'Accessories', 60.00),
('Bookshelf', 'Furniture', 240.00),
('Standing Desk', 'Furniture', 650.00),
('Bluetooth Speaker', 'Electronics', 150.00),
('Laptop Stand', 'Accessories', 95.00),
('Filing Cabinet', 'Office', 275.00),
('Desk Organizer', 'Office', 50.00),
('Ergonomic Keyboard', 'Accessories', 140.00),
('External Hard Drive', 'Electronics', 175.00),
('Printer', 'Office', 250.00),
('Office Desk', 'Furniture', 525.00),
('Noise-Canceling Headphones', 'Electronics', 325.00),
('Tablet', 'Electronics', 450.00),
('Document Scanner', 'Office', 310.00),
('Surge Protector', 'Accessories', 40.00),
('Conference Chair', 'Furniture', 185.00),
('Ultrawide Monitor', 'Electronics', 700.00),
('Mechanical Keyboard', 'Accessories', 130.00),
('Portable SSD', 'Electronics', 220.00),
('Adjustable Monitor Arm', 'Office', 160.00),
('Executive Desk', 'Furniture', 800.00),
('Projector', 'Electronics', 600.00);

INSERT INTO orders (customer_id, order_date)
SELECT
    ((n - 1) % 100) + 1,
    DATE '2025-01-01' + ((n * 2) % 365)
FROM generate_series(1, 400) AS n;

INSERT INTO order_items (order_id, product_id, quantity)
SELECT
    o.order_id,
    ((o.order_id * g.n + g.n * 7) % 30) + 1,
    ((o.order_id + g.n) % 4) + 1
FROM orders AS o
CROSS JOIN generate_series(1, 3) AS g(n);
