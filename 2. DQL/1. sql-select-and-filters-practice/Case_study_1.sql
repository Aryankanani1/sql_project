USE mini_crm; 
-- 1. Retrieve all customer names and their email addresses.
SELECT 
full_name, 
email
FROM customers;

-- 2. Get a list of products with aliases: product_name as Item and price as Cost.
SELECT 
product_name AS Item,
price AS Cost
FROM products;

-- 3. Find all products in the 'Beverages' category.
EXPLAIN SELECT 
product_name AS Item
FROM products 
WHERE category = 'Beverages';
CREATE INDEX indx_1_category ON products (category);

-- 4. Show all products that cost more than $5.
SELECT 
product_name AS Item,
price
FROM products 
WHERE price > 5;

-- 5. Retrieve all orders with total amount greater than or equal to $10.
SELECT 
order_id,
total_amount 
FROM orders 
WHERE total_amount >= 10;

-- 6. Are there any customers without phone numbers?
-- Concept: NULL check — missing data is stored as NULL, not empty string; use IS NULL not = NULL
SELECT 
* 
FROM customers 
WHERE phone IS NULL;

-- 7. Find all products priced between $3 and $6.
-- Concept: BETWEEN operator — inclusive on both ends (equivalent to price >= 3 AND price <= 6)
SELECT 
product_id,
product_name,
price
FROM products 
WHERE price BETWEEN 3 AND 6;

-- 8. Find products named 'French Fries', 'Veg Burger', or 'Margherita Pizza'.
-- Concept: IN operator — cleaner than chaining multiple OR conditions
SELECT 
product_id,
product_name
FROM products 
WHERE product_name IN ('French Fries','Veg Burger','Margherita Pizza');


-- 9. Find customers whose name starts with 'A'.
-- Concept: LIKE with % wildcard — 'A%' means starts with A, followed by anything
SELECT 
customer_id,
full_name
FROM customers 
WHERE full_name LIKE 'A%';

-- 10. List all customers who have placed at least one order.
-- Concept: Filtering with a subquery (IN/EXISTS) or JOIN — links two tables on a shared key
SELECT 
DISTINCT c.customer_id,
c.full_name
FROM customers c
JOIN orders o USING(customer_id);

-- with subquery
SELECT 
c.customer_id,
c.full_name
FROM customers c
WHERE EXISTS(
SELECT 
1 
FROM orders o
WHERE o.customer_id = c.customer_id
);

-- 11. Find all orders that are not in 'Delivered' status.
-- Concept: Negation with != (or <>) — excludes a specific value from results
SELECT 
order_id,
status
FROM orders 
WHERE status <> 'Delivered';

-- Negation 
SELECT 
order_id,
status
FROM orders 
WHERE status != 'Delivered';

-- 12. Show products that are not priced between $4 and $6.
-- Concept: NOT BETWEEN — excludes the range, opposite of BETWEEN
SELECT 
product_id,
product_name,
price
FROM products 
WHERE price NOT BETWEEN 4 AND 6;

-- 13. List products not in 'Main Course', 'Snacks', or 'Beverages' categories.
-- Concept: NOT IN — excludes multiple values, cleaner than chaining != conditions
SELECT 
product_id,
product_name
FROM products 
WHERE category NOT IN ('Main Course','Snacks','Beverages');

-- 14. Find customers whose names don't start with 'S'.
-- Concept: NOT LIKE — negates a pattern match
SELECT 
customer_id,
full_name
FROM customers 
WHERE full_name NOT LIKE 'S%';

-- 15. Find 'total_price' for each order item (quantity * unit_price).
-- Concept: Derived/calculated column — arithmetic inside SELECT creates a new column on the fly
SELECT 
order_item_id,
order_id,
product_id,
quantity,
quantity * unit_price
FROM order_items;

-- 16. List the top 10 most expensive products, sorted descending by price.
-- Concept: ORDER BY DESC + LIMIT — sort first, then cap the rows returned
SELECT 
product_id,
product_name,
category,
price 
FROM products 
ORDER BY price DESC
LIMIT 1;

-- 17. Show customers sorted alphabetically by name.
-- Concept: ORDER BY ASC (default) — alphabetical sort on a text column
SELECT 
customer_id,
full_name,
email,
phone
FROM customers 
ORDER BY full_name ASC;

-- 18. Show the 5 most recent customers based on 'created_at'.
-- Concept: ORDER BY timestamp DESC + LIMIT — newest records come first
SELECT 
customer_id,
full_name,
created_at
FROM customers 
ORDER BY created_At DESC
LIMIT 5;


-- 19. Display any 3 random products.
-- Concept: ORDER BY RAND() LIMIT 3 — non-deterministic sort, different result each run
SELECT 
product_id,
product_name,
category
FROM products 
ORDER BY RAND()
LIMIT 3;