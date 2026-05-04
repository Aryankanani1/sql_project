-- ============================================================
-- Full reset: drop and recreate mini_crm from scratch
-- Run this entire file in MySQL Workbench
-- ============================================================

DROP DATABASE IF EXISTS mini_crm;
CREATE DATABASE mini_crm;
USE mini_crm;

-- Tables
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name   VARCHAR(100) NOT NULL,
    email       VARCHAR(100) UNIQUE NOT NULL,
    phone       VARCHAR(15),
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE products (
    product_id   INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category     VARCHAR(50),
    price        DECIMAL(10,2) NOT NULL,
    is_active    BOOLEAN DEFAULT TRUE
);

CREATE TABLE orders (
    order_id     INT AUTO_INCREMENT PRIMARY KEY,
    customer_id  INT,
    order_date   DATE DEFAULT (CURRENT_DATE),
    total_amount DECIMAL(10,2),
    status       VARCHAR(20) DEFAULT 'Pending',
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id      INT,
    product_id    INT,
    quantity      INT CHECK (quantity > 0),
    unit_price    DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id)   REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- ============================================================
-- 15 customers
-- ============================================================
INSERT INTO customers (full_name, email, phone) VALUES
('Aditi Sharma',   'aditi@example.com',     '9876543210'),
('Rohan Mehta',    'rohan@example.com',      '9123456789'),
('Priya Verma',    'priya@example.com',      '9988776655'),
('Karan Patel',    'karan@example.com',      '8877665544'),
('Neha Joshi',     'neha@example.com',       '9765432101'),
('Siddharth Roy',  'siddharth@example.com',  '9654321870'),
('Tanvi Desai',    'tanvi@example.com',      '9543218765'),
('Vikram Singh',   'vikram@example.com',     '9432109876'),
('Meera Iyer',     'meera@example.com',      '9321098765'),
('Aman Khan',      'aman@example.com',       '9210987654'),
('Divya Nair',     'divya@example.com',      '9112233445'),
('Arjun Kapoor',   'arjun@example.com',      '9223344556'),
('Sneha Mishra',   'sneha@example.com',      '9334455667'),
('Rahul Sinha',    'rahul@example.com',      '9445566778'),
('Isha Jain',      'isha@example.com',       '9556677889');

-- ============================================================
-- 30 products
-- ============================================================
INSERT INTO products (product_name, category, price) VALUES
('Margherita Pizza',    'Main Course', 4.99),
('Veg Burger',          'Snacks',      2.99),
('French Fries',        'Sides',       2.49),
('Chocolate Milkshake', 'Beverages',   3.99),
('Caesar Salad',        'Starters',    3.49),
('Paneer Tikka',        'Starters',    4.99),
('Garlic Bread',        'Sides',       2.49),
('Cheese Burger',       'Snacks',      3.99),
('Pasta Alfredo',       'Main Course', 7.99),
('Mojito',              'Beverages',   3.49),
('Tandoori Chicken',    'Main Course', 8.99),
('Greek Salad',         'Starters',    4.49),
('Cold Coffee',         'Beverages',   3.29),
('Veg Sandwich',        'Snacks',      2.99),
('Brownie Sundae',      'Desserts',    4.49),
('Butter Chicken',      'Main Course', 9.49),
('Lemonade',            'Beverages',   2.49),
('Spring Rolls',        'Starters',    3.49),
('Onion Rings',         'Sides',       2.99),
('Mushroom Soup',       'Starters',    3.29),
('Peach Iced Tea',      'Beverages',   2.99),
('Falafel Wrap',        'Snacks',      3.99),
('Chicken Nuggets',     'Sides',       4.29),
('Chocolate Lava Cake', 'Desserts',    4.99),
('Chicken Biryani',     'Main Course', 8.49),
('Schezwan Noodles',    'Main Course', 6.99),
('Masala Dosa',         'Main Course', 3.99),
('Vanilla Milkshake',   'Beverages',   2.99),
('Veg Thali',           'Main Course', 7.49),
('Fruit Salad',         'Desserts',    3.99);

-- ============================================================
-- 30 orders (explicit IDs to match order_items below)
-- ============================================================
INSERT INTO orders (order_id, customer_id, total_amount, status) VALUES
( 1,  1,  6.99, 'Confirmed'),
( 2,  3,  4.99, 'Shipped'),
( 3,  4,  7.98, 'Pending'),
( 4,  5,  2.49, 'Delivered'),
( 5,  7,  7.98, 'Confirmed'),
( 6, 11,  9.97, 'Confirmed'),
( 7, 12, 14.47, 'Delivered'),
( 8, 13, 12.48, 'Shipped'),
( 9, 14,  6.98, 'Pending'),
(10, 15,  8.98, 'Confirmed'),
(11,  1, 16.47, 'Delivered'),
(12,  2, 13.97, 'Pending'),
(13,  3,  7.48, 'Confirmed'),
(14,  4, 10.98, 'Shipped'),
(15,  5, 12.97, 'Delivered'),
(16,  6, 15.96, 'Delivered'),
(17,  7, 11.97, 'Shipped'),
(18,  8,  8.48, 'Pending'),
(19,  9, 10.48, 'Confirmed'),
(20, 10,  7.48, 'Delivered'),
(21, 11, 11.98, 'Confirmed'),
(22, 13,  9.47, 'Shipped'),
(23, 14, 10.98, 'Delivered'),
(24, 15, 13.47, 'Pending'),
(25,  2,  9.99, 'Delivered'),
(26,  4, 12.96, 'Confirmed'),
(27,  5, 11.97, 'Delivered'),
(28,  6,  8.49, 'Shipped'),
(29,  8,  7.98, 'Confirmed'),
(30, 10,  6.49, 'Delivered');

-- ============================================================
-- Order items
-- ============================================================
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
( 1,  1, 1, 4.99), ( 1,  2, 1, 1.99),
( 2,  1, 1, 4.99),
( 3,  4, 1, 3.99), ( 3,  5, 1, 1.99),
( 4,  3, 1, 2.49),
( 5,  1, 1, 4.99), ( 5,  2, 1, 2.99),
( 6,  3, 1, 2.49), ( 6,  4, 1, 3.99), ( 6,  5, 1, 3.49),
( 7,  1, 1, 4.99), ( 7, 10, 1, 4.49), ( 7,  8, 1, 4.99),
( 8,  6, 1, 3.49), ( 8, 14, 1, 2.99),
( 9, 13, 1, 3.49), ( 9,  7, 1, 3.49),
(10, 17, 1, 3.99), (10, 18, 1, 4.49),
(11, 12, 1, 2.49), (11, 20, 1, 8.49), (11, 28, 1, 4.99),
(12, 23, 1, 2.99), (12,  9, 1, 2.99),
(13, 16, 1, 2.99), (13, 24, 1, 5.49),
(14, 21, 1, 6.99), (14, 19, 1, 3.49),
(15, 25, 1, 3.99), (15,  2, 1, 2.99),
(16, 11, 1, 4.99), (16, 30, 1, 6.99),
(17, 22, 1, 3.99), (17, 26, 1, 3.99), (17,  8, 1, 1.49),
(18, 10, 1, 4.49), (18,  6, 1, 3.49),
(19,  1, 1, 4.99), (19, 27, 1, 3.49), (19,  5, 1, 4.99),
(20, 29, 1, 4.99), (20, 30, 1, 4.99),
(21,  4, 1, 3.99), (21, 12, 1, 2.49), (21, 13, 1, 3.49),
(22, 17, 1, 3.99), (22,  7, 1, 3.49), (22, 23, 1, 2.99),
(23,  6, 1, 3.49), (23, 14, 1, 2.99),
(24, 19, 1, 3.49), (24,  2, 1, 2.99), (24,  8, 1, 1.49),
(25, 15, 1, 3.49), (25, 18, 1, 2.99),
(26,  9, 1, 2.99), (26, 30, 1, 5.99),
(27, 21, 1, 6.99), (27,  3, 1, 2.49),
(28, 20, 1, 8.49),
(29,  5, 1, 3.49), (29,  6, 1, 3.49),
(30, 27, 1, 2.99), (30, 29, 1, 3.49);

-- ============================================================
-- Verify
-- ============================================================
SELECT 'customers' AS tbl, COUNT(*) AS total FROM customers
UNION ALL
SELECT 'products',  COUNT(*) FROM products
UNION ALL
SELECT 'orders',    COUNT(*) FROM orders
UNION ALL
SELECT 'order_items', COUNT(*) FROM order_items;
