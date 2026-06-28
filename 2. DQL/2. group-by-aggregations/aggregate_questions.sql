
-- Aggregate Function Questions
-- Only use GROUP BY, COUNT, SUM, AVG, MIN, MAX
-- Tables: orders, products, order_items

-- Q1. Find the total number of orders for each status.
SELECT 
status,
COUNT(*) AS total_order
FROM orders 
GROUP BY status;
-- Q2. What is the average order value for each order status?
SELECT 
status,
ROUND(AVG(total_amount),2) AS avg_order_value
FROM orders 
GROUP BY status;
-- Q3. Find the total revenue generated on each order date.
SELECT 
order_date,
SUM(total_amount) AS total_revenue
FROM orders 
GROUP BY order_date;
-- Q4. What is the highest, lowest, and average order amount across all orders?
SELECT 
MAX(total_amount) AS highest_order,
MIN(total_amount) AS lowest_order,
AVG(total_amount) AS average_order
FROM orders;
-- Q5. How many products are available in each category?
-- Q6. What is the average price of products in each category?
-- Q7. Find the highest and lowest price among all products.
-- Q8. How many units of each product_id were sold (based on order_items)?
-- Q9. What is the average unit price for each product_id in order_items?
-- Q10. How many times was each product_id ordered (count of appearances in order_items)?
