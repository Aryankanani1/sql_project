-- You're a junior data analyst at a growing food delivery startup.
-- The company wants to understand customer behavior, product popularity,
-- and order performance.


-- 1. Retrieve all customer names and their email addresses.
-- Concept: Basic SELECT with specific columns (projection — only pull what you need)
SELECT
full_name,
email
FROM customers;

-- 2. Get a list of products with aliases: product_name as Item and price as Cost.
-- Concept: Column aliasing with AS — makes output readable for reports
SELECT
product_name AS Item,
price AS Cost
FROM products;

-- 3. Find all products in the 'Beverages' category.
-- Concept: WHERE with equality filter on a string — always case-sensitive in MySQL by default
SELECT
product_name AS Item
FROM products
WHERE category = 'Beverages';

-- 4. Show all products that cost more than $5.
-- Concept: WHERE with numeric comparison operator (>)
SELECT
product_name AS Item,
price
FROM products
WHERE price > 5;

-- 5. Retrieve all orders with total amount greater than or equal to $10.
-- Concept: WHERE with >= comparison — includes the boundary value, unlike >
SELECT
order_id,
total_amount
FROM orders
WHERE total_amount >= 10;

-- 6. Are there any customers without phone numbers?
-- Concept: NULL check — missing data is stored as NULL, not empty string; use IS NULL not = NULL

-- 7. Find all products priced between $3 and $6.
-- Concept: BETWEEN operator — inclusive on both ends (equivalent to price >= 3 AND price <= 6)

-- 8. Find products named 'French Fries', 'Veg Burger', or 'Margherita Pizza'.
-- Concept: IN operator — cleaner than chaining multiple OR conditions

-- 9. Find customers whose name starts with 'A'.
-- Concept: LIKE with % wildcard — 'A%' means starts with A, followed by anything

-- 10. List all customers who have placed at least one order.
-- Concept: Filtering with a subquery (IN/EXISTS) or JOIN — links two tables on a shared key

-- 11. Find all orders that are not in 'Delivered' status.
-- Concept: Negation with != (or <>) — excludes a specific value from results

-- 12. Show products that are not priced between $4 and $6.
-- Concept: NOT BETWEEN — excludes the range, opposite of BETWEEN

-- 13. List products not in 'Main Course', 'Snacks', or 'Beverages' categories.
-- Concept: NOT IN — excludes multiple values, cleaner than chaining != conditions

-- 14. Find customers whose names don't start with 'S'.
-- Concept: NOT LIKE — negates a pattern match

-- 15. Find 'total_price' for each order item (quantity * unit_price).
-- Concept: Derived/calculated column — arithmetic inside SELECT creates a new column on the fly

-- 16. List the top 10 most expensive products, sorted descending by price.
-- Concept: ORDER BY DESC + LIMIT — sort first, then cap the rows returned

-- 17. Show customers sorted alphabetically by name.
-- Concept: ORDER BY ASC (default) — alphabetical sort on a text column

-- 18. Show the 5 most recent customers based on 'created_at'.
-- Concept: ORDER BY timestamp DESC + LIMIT — newest records come first

-- 19. Display any 3 random products.
-- Concept: ORDER BY RAND() LIMIT 3 — non-deterministic sort, different result each run
