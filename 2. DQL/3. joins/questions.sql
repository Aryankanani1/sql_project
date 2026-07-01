-- INNER JOIN Examples

-- 1. Show customer names along with their order IDs. (Hint: Use orders and customers)
SELECT 
c.customer_id,
c.full_name,
o.order_id
FROM customers c
JOIN orders o USING(customer_id);

-- 2. List the names of products and their prices that have been ordered. (Hint: Use products and order_items)
SELECT 
p.product_name,
p.price
FROM products p
JOIN order_items oi USING(product_id);
-- LEFT JOIN Examples

-- 3. Show each customer's name and the total amount of their order. Include customers even if they haven't placed an order. (Hint: Use customers and orders)
SELECT 
c.full_name,
SUM(o.total_amount) AS total_amount
FROM customers c 
LEFT JOIN orders o USING(customer_id)
GROUP BY c.full_name;
-- 4. Show all products and whether they have been ordered. (Hint: Use LEFT JOIN between products and order_items)
SELECT
DISTINCT p.product_name,
oi.order_item_id
FROM products p
LEFT JOIN order_items oi USING(product_id);

-- FULL OUTER JOIN Examples

-- 5. Show a list of all customers and orders. Include customers with no orders and orders with missing customer information. (Hint: Use FULL OUTER JOIN)
SELECT 
c.full_name,
o.order_id
FROM customers c
LEFT OUTER JOIN orders o USING(customer_id)
UNION 
SELECT 
c.full_name,
o.order_id
FROM customers c
RIGHT OUTER JOIN orders o USING(customer_id);
-- 6. List all products and orders. Include products never ordered and orders with missing products. (Hint: Use FULL OUTER JOIN)

-- SELF JOIN Example

-- 7. Show customers who share the same phone number. (Hint: SELF JOIN on customers table)

-- Remaining Join Practice Questions

-- 8. Show order IDs along with the full name of the customer and the order status. (Hint: Use orders and customers)

-- 9. List all products ordered in each order. Show order_id and product_name. (Hint: Use order_items and products)

-- 10. Display all order items with product name, quantity, and unit_price. (Hint: Use order_items and products)

-- 11. Show all customers who have placed an order, along with their email. (Hint: Use DISTINCT if needed)

-- 12. List all orders that include "Pizza" in the product name. Show order_id and product_name.

-- 13. Show all orders with their customer's full name, product name, and quantity. (Hint: Use three tables!)

-- 14. Bonus: Show all products that have **never** been ordered. (Hint: LEFT JOIN and IS NULL)