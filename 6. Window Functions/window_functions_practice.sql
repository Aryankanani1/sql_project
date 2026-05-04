-- ============================================================
-- WINDOW FUNCTIONS PRACTICE – 20 Questions
-- Topics: ROW_NUMBER | RANK | DENSE_RANK | LAG | LEAD | NTILE
-- Dataset: monthly_sales
-- ============================================================

-- ------------------------------------------------------
-- DATASET SETUP
-- ------------------------------------------------------
-- A retail company tracks monthly sales by rep and region.
-- Each row is one month's result for one sales rep.

CREATE TABLE monthly_sales (
    sale_id      SERIAL PRIMARY KEY,
    rep_name     VARCHAR(50),
    region       VARCHAR(30),
    sale_month   DATE,          -- always the 1st of the month
    revenue      DECIMAL(10,2),
    units_sold   INT,
    returns      INT
);

INSERT INTO monthly_sales (rep_name, region, sale_month, revenue, units_sold, returns) VALUES
('Priya Sharma',    'Ontario',  '2024-01-01',  48200.00, 310,  8),
('Priya Sharma',    'Ontario',  '2024-02-01',  52400.00, 340,  5),
('Priya Sharma',    'Ontario',  '2024-03-01',  47800.00, 295, 12),
('Priya Sharma',    'Ontario',  '2024-04-01',  61000.00, 400,  6),
('Priya Sharma',    'Ontario',  '2024-05-01',  55300.00, 360,  9),
('Priya Sharma',    'Ontario',  '2024-06-01',  70200.00, 450,  4),

('Jordan Lee',      'Ontario',  '2024-01-01',  39500.00, 260, 10),
('Jordan Lee',      'Ontario',  '2024-02-01',  52400.00, 340,  7),  -- tie with Priya Feb
('Jordan Lee',      'Ontario',  '2024-03-01',  60100.00, 390,  5),
('Jordan Lee',      'Ontario',  '2024-04-01',  58700.00, 380,  3),
('Jordan Lee',      'Ontario',  '2024-05-01',  43200.00, 280, 11),
('Jordan Lee',      'Ontario',  '2024-06-01',  67800.00, 430,  6),

('Aisha Malik',     'Quebec',   '2024-01-01',  55600.00, 360,  6),
('Aisha Malik',     'Quebec',   '2024-02-01',  49300.00, 320,  9),
('Aisha Malik',     'Quebec',   '2024-03-01',  62000.00, 410,  4),
('Aisha Malik',     'Quebec',   '2024-04-01',  62000.00, 410,  3),  -- tie with herself (Apr repeat)
('Aisha Malik',     'Quebec',   '2024-05-01',  71500.00, 460,  2),
('Aisha Malik',     'Quebec',   '2024-06-01',  80000.00, 510,  1),

('Carlos Rivera',   'Quebec',   '2024-01-01',  33100.00, 215, 14),
('Carlos Rivera',   'Quebec',   '2024-02-01',  44700.00, 290,  8),
('Carlos Rivera',   'Quebec',   '2024-03-01',  62000.00, 410,  7),  -- tie with Aisha Mar
('Carlos Rivera',   'Quebec',   '2024-04-01',  50200.00, 325,  5),
('Carlos Rivera',   'Quebec',   '2024-05-01',  58900.00, 380,  6),
('Carlos Rivera',   'Quebec',   '2024-06-01',  65400.00, 420,  3),

('Mei Zhang',       'BC',       '2024-01-01',  41000.00, 268,  9),
('Mei Zhang',       'BC',       '2024-02-01',  46500.00, 302, 11),
('Mei Zhang',       'BC',       '2024-03-01',  53800.00, 350,  7),
('Mei Zhang',       'BC',       '2024-04-01',  59200.00, 385,  4),
('Mei Zhang',       'BC',       '2024-05-01',  66700.00, 435,  3),
('Mei Zhang',       'BC',       '2024-06-01',  72100.00, 465,  2),

('Derek Osei',      'BC',       '2024-01-01',  37400.00, 243, 13),
('Derek Osei',      'BC',       '2024-02-01',  41900.00, 272, 10),
('Derek Osei',      'BC',       '2024-03-01',  53800.00, 350,  8),  -- tie with Mei Mar
('Derek Osei',      'BC',       '2024-04-01',  61500.00, 400,  5),
('Derek Osei',      'BC',       '2024-05-01',  55000.00, 358,  6),
('Derek Osei',      'BC',       '2024-06-01',  48300.00, 315,  9);


-- ============================================================
-- SECTION 1 – ROW_NUMBER
-- Gives every row a UNIQUE sequential number within a partition.
-- No ties. First is first, no matter what.
-- ============================================================

-- Q1.
-- Assign a unique row number to each sales record for every rep,
-- ordered by sale_month ascending.
-- Columns: rep_name, region, sale_month, revenue, row_num
SELECT
    rep_name,
    region,
    sale_month,
    revenue,
    ROW_NUMBER() OVER (PARTITION BY rep_name ORDER BY sale_month) AS row_num
FROM monthly_sales;


-- Q2.
-- For each region, rank the monthly records by revenue (highest first).
-- Return only the #1 record per region — the best single month per region.
-- Columns: region, rep_name, sale_month, revenue
SELECT *
FROM (
    SELECT
        region,
        rep_name,
        sale_month,
        revenue,
        ROW_NUMBER() OVER (PARTITION BY region ORDER BY revenue DESC) AS rn
    FROM monthly_sales
) ranked
WHERE rn = 1;


-- Q3.
-- Find the most recent sales record for each rep.
-- (Hint: ROW_NUMBER ordered by sale_month DESC)
-- Columns: rep_name, region, sale_month, revenue
SELECT *
FROM (
    SELECT
        rep_name,
        region,
        sale_month,
        revenue,
        ROW_NUMBER() OVER (PARTITION BY rep_name ORDER BY sale_month DESC) AS rn
    FROM monthly_sales
) t
WHERE rn = 1;


-- Q4.
-- Number all rows globally across the entire table ordered by revenue DESC.
-- This shows the all-time revenue ranking with no ties allowed.
-- Columns: row_num, rep_name, region, sale_month, revenue
SELECT
    ROW_NUMBER() OVER (ORDER BY revenue DESC) AS row_num,
    rep_name,
    region,
    sale_month,
    revenue
FROM monthly_sales;


-- ============================================================
-- SECTION 2 – RANK
-- Like ROW_NUMBER but SKIPS rank positions after ties.
-- Two people tied at #2 → next rank is #4.
-- ============================================================

-- Q5.
-- Within each region, rank sales reps by their TOTAL revenue (sum all months).
-- Ties get the same rank; next rank is skipped.
-- Columns: region, rep_name, total_revenue, revenue_rank
SELECT
    region,
    rep_name,
    SUM(revenue)                                              AS total_revenue,
    RANK() OVER (PARTITION BY region ORDER BY SUM(revenue) DESC) AS revenue_rank
FROM monthly_sales
GROUP BY region, rep_name;


-- Q6.
-- Within each month, rank reps by units_sold.
-- Show what rank each rep holds in their month.
-- Columns: sale_month, rep_name, units_sold, rank_in_month
SELECT
    sale_month,
    rep_name,
    units_sold,
    RANK() OVER (PARTITION BY sale_month ORDER BY units_sold DESC) AS rank_in_month
FROM monthly_sales;


-- Q7.
-- Find every record where a rep is ranked #1 in their region for revenue
-- in a given month. Notice that RANK can produce multiple #1s if there's a tie.
SELECT *
FROM (
    SELECT
        rep_name,
        region,
        sale_month,
        revenue,
        RANK() OVER (PARTITION BY region, sale_month ORDER BY revenue DESC) AS rev_rank
    FROM monthly_sales
) t
WHERE rev_rank = 1;


-- ============================================================
-- SECTION 3 – DENSE_RANK
-- Like RANK but does NOT skip numbers after a tie.
-- Two people tied at #2 → next rank is #3 (not #4).
-- ============================================================

-- Q8.
-- Using DENSE_RANK, rank every row within each region by revenue DESC.
-- Compare how dense_rank and rank would differ on tied values.
-- Columns: region, rep_name, sale_month, revenue, dense_rnk, rnk
SELECT
    region,
    rep_name,
    sale_month,
    revenue,
    DENSE_RANK() OVER (PARTITION BY region ORDER BY revenue DESC) AS dense_rnk,
    RANK()       OVER (PARTITION BY region ORDER BY revenue DESC) AS rnk
FROM monthly_sales;


-- Q9.
-- Within each month, use DENSE_RANK to rank reps by returns (fewer returns = better rank).
-- Columns: sale_month, rep_name, returns, performance_rank
SELECT
    sale_month,
    rep_name,
    returns,
    DENSE_RANK() OVER (PARTITION BY sale_month ORDER BY returns ASC) AS performance_rank
FROM monthly_sales;


-- Q10.
-- For each rep, identify what "revenue tier" their months fall into using DENSE_RANK.
-- A new tier starts whenever revenue is lower — i.e., rank within rep ordered DESC.
-- Columns: rep_name, sale_month, revenue, revenue_tier
SELECT
    rep_name,
    sale_month,
    revenue,
    DENSE_RANK() OVER (PARTITION BY rep_name ORDER BY revenue DESC) AS revenue_tier
FROM monthly_sales;


-- ============================================================
-- SECTION 4 – LAG
-- Pulls a value from a PREVIOUS row within a partition.
-- Great for month-over-month comparisons.
-- ============================================================

-- Q11.
-- For each rep, show their current month's revenue and last month's revenue.
-- Columns: rep_name, sale_month, revenue, prev_month_revenue
SELECT
    rep_name,
    sale_month,
    revenue,
    LAG(revenue) OVER (PARTITION BY rep_name ORDER BY sale_month) AS prev_month_revenue
FROM monthly_sales;


-- Q12.
-- For each rep, calculate the month-over-month revenue change (current - previous).
-- Also label it as 'Growth', 'Decline', or 'First Month'.
-- Columns: rep_name, sale_month, revenue, mom_change, trend
SELECT
    rep_name,
    sale_month,
    revenue,
    revenue - LAG(revenue) OVER (PARTITION BY rep_name ORDER BY sale_month) AS mom_change,
    CASE
        WHEN LAG(revenue) OVER (PARTITION BY rep_name ORDER BY sale_month) IS NULL
            THEN 'First Month'
        WHEN revenue > LAG(revenue) OVER (PARTITION BY rep_name ORDER BY sale_month)
            THEN 'Growth'
        ELSE 'Decline'
    END AS trend
FROM monthly_sales;


-- Q13.
-- Find months where a rep's returns INCREASED compared to the previous month.
-- (Higher returns = bad sign.)
-- Columns: rep_name, sale_month, returns, prev_returns
SELECT *
FROM (
    SELECT
        rep_name,
        sale_month,
        returns,
        LAG(returns) OVER (PARTITION BY rep_name ORDER BY sale_month) AS prev_returns
    FROM monthly_sales
) t
WHERE returns > prev_returns;


-- Q14.
-- For each region, show the gap in revenue between the current month's TOTAL
-- regional revenue and the previous month's TOTAL regional revenue.
-- Columns: region, sale_month, total_revenue, prev_total_revenue, revenue_gap
SELECT
    region,
    sale_month,
    total_revenue,
    LAG(total_revenue) OVER (PARTITION BY region ORDER BY sale_month) AS prev_total_revenue,
    total_revenue - LAG(total_revenue) OVER (PARTITION BY region ORDER BY sale_month) AS revenue_gap
FROM (
    SELECT region, sale_month, SUM(revenue) AS total_revenue
    FROM monthly_sales
    GROUP BY region, sale_month
) monthly_totals
ORDER BY region, sale_month;


-- ============================================================
-- SECTION 5 – LEAD
-- Pulls a value from a FUTURE row within a partition.
-- Great for spotting upcoming trends.
-- ============================================================

-- Q15.
-- For each rep, show the NEXT month's revenue alongside the current month.
-- Columns: rep_name, sale_month, revenue, next_month_revenue
SELECT
    rep_name,
    sale_month,
    revenue,
    LEAD(revenue) OVER (PARTITION BY rep_name ORDER BY sale_month) AS next_month_revenue
FROM monthly_sales;


-- Q16.
-- Flag any month where a rep's units_sold in the NEXT month will be lower.
-- This tells managers when a slowdown is coming.
-- Columns: rep_name, sale_month, units_sold, next_units_sold, is_upcoming_decline
SELECT
    rep_name,
    sale_month,
    units_sold,
    LEAD(units_sold) OVER (PARTITION BY rep_name ORDER BY sale_month)               AS next_units_sold,
    CASE
        WHEN LEAD(units_sold) OVER (PARTITION BY rep_name ORDER BY sale_month) < units_sold
            THEN 'Yes'
        ELSE 'No'
    END AS is_upcoming_decline
FROM monthly_sales;


-- Q17.
-- For each rep, calculate the revenue DIFFERENCE between next month and current month.
-- A positive number means they are growing; negative means declining.
-- Columns: rep_name, sale_month, revenue, next_revenue, growth_outlook
SELECT
    rep_name,
    sale_month,
    revenue,
    LEAD(revenue) OVER (PARTITION BY rep_name ORDER BY sale_month) AS next_revenue,
    ROUND(
        LEAD(revenue) OVER (PARTITION BY rep_name ORDER BY sale_month) - revenue, 2
    ) AS growth_outlook
FROM monthly_sales;


-- ============================================================
-- SECTION 6 – NTILE
-- Divides rows into N equal buckets (quartiles, deciles, etc.).
-- Useful for categorising performance bands.
-- ============================================================

-- Q18.
-- Divide all reps into 4 performance quartiles based on their total revenue
-- across all months. Quartile 1 = top performers.
-- Columns: rep_name, total_revenue, quartile
SELECT
    rep_name,
    SUM(revenue)                                         AS total_revenue,
    NTILE(4) OVER (ORDER BY SUM(revenue) DESC)           AS quartile
FROM monthly_sales
GROUP BY rep_name;


-- Q19.
-- Within each region, split monthly records into 3 equal tiers by units_sold.
-- Tier 1 = highest sellers in that region.
-- Columns: region, rep_name, sale_month, units_sold, sales_tier
SELECT
    region,
    rep_name,
    sale_month,
    units_sold,
    NTILE(3) OVER (PARTITION BY region ORDER BY units_sold DESC) AS sales_tier
FROM monthly_sales;


-- Q20.
-- Label each monthly record as 'Top', 'Middle', or 'Bottom' based on returns.
-- Use NTILE(3) across the whole table ordered by returns ASC (fewer returns = better).
-- Columns: rep_name, sale_month, returns, return_bucket
SELECT
    rep_name,
    sale_month,
    returns,
    CASE NTILE(3) OVER (ORDER BY returns ASC)
        WHEN 1 THEN 'Top'      -- fewest returns
        WHEN 2 THEN 'Middle'
        WHEN 3 THEN 'Bottom'   -- most returns
    END AS return_bucket
FROM monthly_sales;
