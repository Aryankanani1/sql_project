# SQL Case Studies

---

These 5 projects are chosen specifically because they mirror real data analyst and data engineer work in Canada. Each one demonstrates a distinct SQL skill set and comes with a free public dataset so you can start immediately.

---

## Project 1 — Ecommerce Sales Analysis

### What It Is

Analyze Google Merchandise Store data using real Google Analytics records to answer business questions about revenue, traffic, and customer behaviour.

### Why It Impresses Employers

This is the closest thing to a real data analyst's daily work. Every data job interview at a Canadian company will have some version of this problem — revenue by region, top products, funnel analysis. Using a real Google dataset instead of a toy dataset signals you are ready for production work.

### Skills It Demonstrates

Groupby and aggregation, window functions, date functions, filtering with WHERE and HAVING, subqueries, business-oriented query writing

### Dataset

BigQuery Public Data — Google Merchandise Store

Project: `data-to-insights`

Dataset: `ecommerce`

Table: `all_sessions`

How to access: Go to [console.cloud.google.com/bigquery](http://console.cloud.google.com/bigquery), click Add Data, Star a project by name, enter `data-to-insights`. Free tier gives 1TB of queries per month at no cost.

### High Level Architecture

```
BigQuery Public Dataset
(data-to-insights.ecommerce.all_sessions)
        |
        v
SQL Queries
(aggregations, joins, window functions)
        |
        v
Business Insights
(revenue by city, top products, churn signals, funnel drop-off)
        |
        v
Visualization (optional)
(Looker Studio or Google Sheets — both connect directly to BigQuery)
```

### Sample Business Questions to Answer

- Which cities generated the highest total revenue?
- What are the top 10 products by units sold?
- What percentage of sessions resulted in a transaction?
- Which traffic channel (organic, paid, direct) has the highest conversion rate?
- Identify customers who added to cart but never completed checkout

### Skills for Resume

`BigQuery` `SQL` `Google Analytics data` `Funnel analysis` `Conversion rate analysis`

### Stretch Goal

Connect your BigQuery results to Looker Studio (free) and build a visual dashboard. Now you have both the SQL project and a data visualization portfolio piece.

---

## Project 2 — Customer Churn Analysis

### What It Is

Identify customers who stopped purchasing after a certain period and analyze the patterns that predict churn.

### Why It Impresses Employers

Churn analysis is one of the most common real-world business problems in Canada — especially at telecom companies (Bell, Telus, Rogers) and banks (RBC, TD, Scotiabank). Interviewers at these companies have often worked on churn themselves and will have real follow-up questions. This project gives you something credible to discuss.

### Skills It Demonstrates

Date functions and date arithmetic, subqueries and NOT IN logic, cohort analysis, CTEs, business thinking around customer lifetime value

### Datasets

Option A — Telco Customer Churn (recommended for telecom context)

Kaggle: [kaggle.com/datasets/blastchar/telco-customer-churn](http://kaggle.com/datasets/blastchar/telco-customer-churn)

Contains: Customer demographics, services subscribed, monthly charges, churn status

Option B — Bank Customer Churn (recommended for banking context)

Kaggle: [kaggle.com/datasets/gauravtopre/bank-customer-churn-dataset](http://kaggle.com/datasets/gauravtopre/bank-customer-churn-dataset)

Contains: Credit score, account balance, tenure, whether customer exited

Both are free to download with a Kaggle account. Load into SQLite, DBeaver, or PostgreSQL locally.

### High Level Architecture

```
CSV Dataset (Kaggle)
        |
        v
Load into SQLite or PostgreSQL
        |
        v
SQL Analysis
(identify churned customers, date of last activity, patterns)
        |
        v
Churn Profile
(which customer segments churn most, average tenure before churn)
        |
        v
Business Recommendation
(which customers to target for retention campaigns)
```

### Sample Business Questions to Answer

- What percentage of customers churned in the last 6 months?
- Which customer segment (by contract type, tenure, product) has the highest churn rate?
- What is the average monthly charge for churned vs retained customers?
- Identify customers who have been active for less than 12 months — are they more likely to churn?
- Which geographic region has the highest churn rate?

### Skills for Resume

`SQL` `Churn analysis` `Cohort analysis` `Customer segmentation` `Date functions` `PostgreSQL`

### Stretch Goal

Add a risk score column. Write a SQL query that assigns each active customer a churn risk label (High, Medium, Low) based on their tenure, monthly charges, and contract type using CASE WHEN logic.

---

## Project 3 — Employee Performance Dashboard

### What It Is

Use an HR dataset to rank employees by department, analyze salary distributions, and identify high performers and outliers.

### Why It Impresses Employers

This project tests window functions in a business context — ranking, partitioning, comparing individuals to their group average. These are exactly the SQL skills that data analyst roles at Canadian banks, consulting firms, and large enterprises require. It also shows you can translate data into HR business insights, which is a cross-functional skill.

### Skills It Demonstrates

Window functions (RANK, DENSE_RANK, ROW_NUMBER, NTILE), PARTITION BY, aggregations by group, CASE WHEN for categorization, identifying outliers with statistical logic

### Dataset

IBM HR Analytics Employee Dataset

Kaggle: [kaggle.com/datasets/ravindrasinghrana/employeedataset](http://kaggle.com/datasets/ravindrasinghrana/employeedataset)

Contains: Department, job role, monthly income, performance rating, years at company, attrition status

Free download with Kaggle account.

### High Level Architecture

```
CSV Dataset (Kaggle — IBM HR)
        |
        v
Load into SQLite or PostgreSQL
        |
        v
SQL Window Function Queries
(rank employees within department, compare to averages)
        |
        v
Performance Insights
(top earners per department, salary outliers, attrition patterns)
```

### Sample Business Questions to Answer

- Rank employees within each department by monthly income
- What is the average salary per department and how does each employee compare to their department average?
- Which employees are in the top 10% of earners company-wide?
- What is the attrition rate by job role and department?
- Identify employees who have been in the same role for more than 5 years without a promotion

### Skills for Resume

`SQL` `Window functions` `PARTITION BY` `HR analytics` `Salary analysis` `PostgreSQL`

### Stretch Goal

Build a salary band analysis. Divide each department's salary range into quartiles using NTILE(4) and label each employee as Bottom 25%, Lower Mid, Upper Mid, or Top 25%. This is exactly how compensation teams at banks and consulting firms analyze pay equity.

---

## Project 4 — Food Delivery SQL Case Study

### What It Is

Analyze a multi-table relational dataset modelling orders, customers, restaurants, and delivery times to answer operational business questions.

### Why It Impresses Employers

This is the gold standard for testing SQL joins and relational thinking. Most entry-level candidates can write queries on a single table. Candidates who can confidently navigate 5+ related tables stand out. The food delivery context also makes for an engaging interview conversation.

### Skills It Demonstrates

Multi-table JOINs (INNER, LEFT, multiple joins), grouping across tables, aggregations with conditions, date and time functions, query optimization thinking

### Dataset

Brazilian E-commerce Public Dataset by Olist

Kaggle: [kaggle.com/datasets/olistbr/brazilian-ecommerce](http://kaggle.com/datasets/olistbr/brazilian-ecommerce)

Contains 9 tables: orders, customers, order items, products, sellers, payments, reviews, geolocation, product category translations

Free download with Kaggle account. This is widely regarded as the best multi-table SQL practice dataset available.

### High Level Architecture

```
9 CSV Tables (Kaggle — Olist)
        |
        v
Load all tables into PostgreSQL
(define foreign key relationships)
        |
        v
Multi-table SQL Queries
(join across orders, customers, products, payments, reviews)
        |
        v
Operational Insights
(delivery times, revenue by category, seller performance, customer repeat rate)
```

### Sample Business Questions to Answer

- What is the average delivery time by state?
- Which product categories generate the most revenue?
- Identify orders that were delivered later than the estimated delivery date
- What is the repeat purchase rate for customers within 6 months?
- Which sellers have the highest average review score with more than 50 orders?

### Skills for Resume

`SQL` `Multi-table JOINs` `Relational databases` `PostgreSQL` `Operational analytics` `E-commerce data`

### Stretch Goal

Write a query that creates a seller scorecard — combining revenue, average review score, on-time delivery rate, and order volume into a single ranked table. This tests your ability to combine multiple aggregations into one output, which is a common interview challenge.

---

## Project 5 — Financial Transactions Fraud Detection

### What It Is

Write SQL logic to flag suspicious financial transactions based on rules — unusual amounts, high frequency in a short period, transactions at odd hours.

### Why It Impresses Employers

Fraud detection is a real, high-stakes problem that every Canadian bank deals with. Building this project and explaining your logic clearly in an interview at RBC, TD, or Scotiabank immediately signals domain relevance. It also tests your ability to write conditional logic, CTEs, and self-joins — more advanced SQL than most candidates practice.

### Skills It Demonstrates

CASE WHEN for rule-based flagging, CTEs for multi-step logic, self-joins for comparing transactions within the same account, window functions for detecting frequency patterns, timestamp and time-based logic

### Dataset

Credit Card Fraud Detection Dataset

Kaggle: [kaggle.com/datasets/mlg-ulb/creditcardfraud](http://kaggle.com/datasets/mlg-ulb/creditcardfraud)

Contains: Real anonymized credit card transactions with a fraud label. 284,807 transactions, 492 fraudulent. Features are anonymized via PCA.

Free download with Kaggle account.

Alternative: Use the Olist dataset from Project 4 and create your own fraud rules based on order amounts and patterns.

### High Level Architecture

```
CSV Dataset (Kaggle — Credit Card Fraud)
        |
        v
Load into PostgreSQL
        |
        v
SQL Rule Engine
(CASE WHEN flags: large amount, unusual hour, high frequency)
        |
        v
CTE Layer
(combine multiple rules into a fraud score per transaction)
        |
        v
Flagged Transactions Output
(transactions marked High Risk, Medium Risk, Low Risk)
```

### Sample Business Questions to Answer

- Flag all transactions above 3 standard deviations from the account's average transaction amount
- Identify accounts that made more than 5 transactions within any 1-hour window
- What percentage of transactions flagged by your rules are actually fraudulent (precision)?
- What percentage of actual fraud did your rules catch (recall)?
- Which rule catches the most fraud with the fewest false positives?

### Skills for Resume

`SQL` `Fraud detection` `CASE WHEN` `CTEs` `Window functions` `Risk analysis` `PostgreSQL`

### Stretch Goal

Build a fraud scoring system. Instead of a binary flag, assign each transaction a score from 0 to 100 based on how many rules it triggers. Write the full CTE chain that produces the final score and rank all flagged transactions by risk level.

---

## How to Set Up Your SQL Environment

### Option A — BigQuery (for Project 1)

Go to [console.cloud.google.com/bigquery](http://console.cloud.google.com/bigquery). Create a free Google Cloud account. The first 1TB of queries per month is free. No setup needed — query directly in the browser.

### Option B — Local PostgreSQL (for Projects 2 to 5)

Download PostgreSQL from [postgresql.org](http://postgresql.org) (free). Use DBeaver (free) as your SQL client. Download the CSV from Kaggle, create a table, and import the data. DBeaver has a built-in CSV import wizard that takes under 5 minutes.

### Option C — SQLite with DB Browser (beginner friendly)

Download DB Browser for SQLite from [sqlitebrowser.org](http://sqlitebrowser.org) (free). The lightest setup — no server required. Good for learning but mention PostgreSQL in interviews as it is more industry-standard.

---

## How to Present These on GitHub

Every project on GitHub should have a README with these five things:

1. What the project does and what business problem it solves
2. The dataset used and where to find it
3. The key SQL queries you wrote and what they answer
4. A screenshot of sample output or results
5. What you learned or what you would do differently

Name your repos descriptively. `sql-churn-analysis` is better than `project2` or `sql-practice`.

Pin your best 2 or 3 SQL projects on your GitHub profile so they appear first.

---

## Free Resources to Improve Your SQL

Mode Analytics SQL Tutorial — [mode.com/sql-tutorial](http://mode.com/sql-tutorial) (free, beginner to advanced)

Stratascratch — [stratascratch.com](http://stratascratch.com) (real company interview questions, SQL and Python)

LeetCode Database — [leetcode.com/problemset/database](http://leetcode.com/problemset/database) (free SQL practice problems)

HackerRank SQL — [hackerrank.com/domains/sql](http://hackerrank.com/domains/sql) (structured SQL challenges with difficulty levels)

Kaggle SQL courses — [kaggle.com/learn/intro-to-sql](http://kaggle.com/learn/intro-to-sql) and [kaggle.com/learn/advanced-sql](http://kaggle.com/learn/advanced-sql) (free, uses BigQuery)

---

*For mentorship, live sessions, and community support: [joinoru.com](http://joinoru.com)*