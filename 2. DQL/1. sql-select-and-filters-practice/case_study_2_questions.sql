-- Case Study 2: Intermediate filtering, string functions, and conditional logic
-- Dataset: mini_crm (customers, products, orders, order_items)

-- 1. Retrieve a list of all distinct product categories.
-- Concept: DISTINCT — removes duplicate values, returns only unique entries

-- 2. Show all product names in uppercase.
-- Concept: UPPER() string function — transforms text to all caps; useful for normalizing output

-- 3. Select all customers who have not provided a phone number.
-- Concept: IS NULL filter — same as case study 1 Q6; reinforces that NULL != empty string

-- 4. Show the first 5 customers sorted alphabetically by name.
-- Concept: ORDER BY + LIMIT — sort first, then slice the top N rows

-- 5. Show the 6th to 10th customers alphabetically.
-- Concept: LIMIT with OFFSET — LIMIT 5 OFFSET 5 skips the first 5 rows (pagination)

-- 6. Show products with a price between $5 and $15.
-- Concept: BETWEEN — inclusive range filter; equivalent to price >= 5 AND price <= 15

-- 7. List orders and label them as "High" if total_amount > $50, "Medium" if between $20-$50, and "Low" otherwise.
-- Concept: CASE WHEN — conditional logic inside SELECT; think of it as an if/else for SQL columns

-- 8. Display orders with total_amount NULL, and replace it with 0.
-- Concept: IFNULL(col, fallback) — MySQL's shorthand for replacing NULL with a default value

-- 9. Show full_name and the first word from their name only.
-- Concept: SUBSTRING_INDEX(str, delimiter, count) — splits a string and returns the part before the first space

-- 10. Show all orders placed today (assume CURRENT_DATE).
-- Concept: CURDATE() / CURRENT_DATE — date function; compare order_date to today's date

-- 11. List orders sorted by priority: Delivered > Confirmed > Shipped > Pending.
-- Concept: ORDER BY CASE WHEN — custom sort order; assign a numeric rank to each status value

-- 12. Show current date, and how many days ago each order was placed.
-- Concept: DATEDIFF(date1, date2) — returns the number of days between two dates

-- 13. Show a list of customers with NULL phone numbers labeled as 'Missing'.
-- Concept: IFNULL() or COALESCE() — replace NULL with a display label in the output

-- 14. List products whose name contains the word 'Pizza'.
-- Concept: LIKE '%keyword%' — wildcard on both sides matches the pattern anywhere in the string

-- 15. Display total number of characters in each product name.
-- Concept: CHAR_LENGTH(str) — returns character count; use instead of LENGTH() for multi-byte safety
