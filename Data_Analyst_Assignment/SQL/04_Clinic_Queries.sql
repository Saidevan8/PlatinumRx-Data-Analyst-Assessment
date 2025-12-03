-- -------------------------------------------------------
-- Q1: Revenue by sales channel for a given year
-- Description: sum(amount) grouped by sales_channel for sales whose datetime falls in the given year.
-- Set: replace 2021 with the target year or set a variable: SET @year = 2021;
-- -------------------------------------------------------
SET @year = 2021;

SELECT
  cs.sales_channel,
  COALESCE(SUM(cs.amount),0) AS total_revenue
FROM clinic_sales cs
WHERE YEAR(cs.datetime) = @year
GROUP BY cs.sales_channel
ORDER BY total_revenue DESC;


-- -------------------------------------------------------
-- Q2: Top 10 most valuable customers for a given year
-- Description: rank customers by their total spend (sum of clinic_sales.amount) in the given year.
-- Set: replace 2021 with the desired year or set variable: SET @year = 2021;
-- -------------------------------------------------------
SET @year = 2021;

SELECT
  c.uid,
  c.name,
  COALESCE(SUM(cs.amount),0) AS total_spend
FROM customer c
LEFT JOIN clinic_sales cs
  ON cs.uid = c.uid
  AND YEAR(cs.datetime) = @year
GROUP BY c.uid, c.name
ORDER BY total_spend DESC
LIMIT 10;


-- -------------------------------------------------------
-- Q3: Month-wise revenue, expense, profit, and status for a given year
-- Description: for each month of the year compute revenue, expenses, profit (rev - exp), and status ('profitable'/'not-profitable')
-- Set: SET @year = 2021; (replace as needed)
-- -------------------------------------------------------
SET @year = 2021;

WITH revenue_monthly AS (
  SELECT DATE_FORMAT(cs.datetime, '%Y-%m-01') AS month_start,
         SUM(cs.amount) AS revenue
  FROM clinic_sales cs
  WHERE YEAR(cs.datetime) = @year
  GROUP BY month_start
),
expenses_monthly AS (
  SELECT DATE_FORMAT(e.datetime, '%Y-%m-01') AS month_start,
         SUM(e.amount) AS expenses
  FROM expenses e
  WHERE YEAR(e.datetime) = @year
  GROUP BY month_start
)
SELECT
  COALESCE(r.month_start, e.month_start) AS month_start,
  COALESCE(r.revenue, 0) AS revenue,
  COALESCE(e.expenses, 0) AS expenses,
  (COALESCE(r.revenue, 0) - COALESCE(e.expenses, 0)) AS profit,
  CASE WHEN (COALESCE(r.revenue, 0) - COALESCE(e.expenses, 0)) > 0 THEN 'profitable' ELSE 'not-profitable' END AS status
FROM revenue_monthly r
FULL OUTER JOIN expenses_monthly e
  ON r.month_start = e.month_start
ORDER BY month_start;


-- -------------------------------------------------------
-- Q4: For each city, find the most profitable clinic for a given month
-- Description:
--  1) compute each clinic's revenue and expenses for the given month,
--  2) compute profit = revenue - expenses,
--  3) rank clinics within each city by profit descending and pick the top (most profitable).
-- Parameters:
--   @year = 2021
--   @month = 9    -- numeric month (1..12) OR supply @month_start as '2021-09-01'
-- -------------------------------------------------------
SET @year = 2021;
SET @month = 9;

WITH clinic_profit AS (
  SELECT
    cl.cid,
    cl.clinic_name,
    cl.city,
    COALESCE(SUM(cs.amount), 0) AS revenue,
    COALESCE(SUM(e.amount), 0)  AS expenses
  FROM clinics cl
  LEFT JOIN clinic_sales cs
    ON cs.cid = cl.cid
    AND YEAR(cs.datetime) = @year
    AND MONTH(cs.datetime) = @month
  LEFT JOIN expenses e
    ON e.cid = cl.cid
    AND YEAR(e.datetime) = @year
    AND MONTH(e.datetime) = @month
  GROUP BY cl.cid, cl.clinic_name, cl.city
),
ranked AS (
  SELECT cp.*,
         (cp.revenue - cp.expenses) AS profit,
         ROW_NUMBER() OVER (PARTITION BY cp.city ORDER BY (cp.revenue - cp.expenses) DESC, cp.cid) AS rn
  FROM clinic_profit cp
)
SELECT city, cid, clinic_name, revenue, expenses, profit
FROM ranked
WHERE rn = 1
ORDER BY city;


-- -------------------------------------------------------
-- Q5: For each state find the second least profitable clinic for a given month
-- Description:
--  1) compute profit per clinic for the given month,
--  2) rank clinics inside each state by profit ASC (least to most),
--  3) pick the second row (strict second least) per state.
-- Parameters:
--   SET @year = 2021;
--   SET @month = 9;
-- Note: If you prefer to treat ties differently, replace ROW_NUMBER() with DENSE_RANK()/RANK() accordingly.
-- -------------------------------------------------------
SET @year = 2021;
SET @month = 9;

WITH clinic_profit AS (
  SELECT
    cl.cid,
    cl.clinic_name,
    cl.state,
    COALESCE(SUM(cs.amount), 0) AS revenue,
    COALESCE(SUM(e.amount), 0)  AS expenses
  FROM clinics cl
  LEFT JOIN clinic_sales cs
    ON cs.cid = cl.cid
    AND YEAR(cs.datetime) = @year
    AND MONTH(cs.datetime) = @month
  LEFT JOIN expenses e
    ON e.cid = cl.cid
    AND YEAR(e.datetime) = @year
    AND MONTH(e.datetime) = @month
  GROUP BY cl.cid, cl.clinic_name, cl.state
),
ranked AS (
  SELECT cp.*,
         (cp.revenue - cp.expenses) AS profit,
         ROW_NUMBER() OVER (PARTITION BY cp.state ORDER BY (cp.revenue - cp.expenses) ASC, cp.cid) AS rn
  FROM clinic_profit cp
)
SELECT state, cid, clinic_name, revenue, expenses, profit
FROM ranked
WHERE rn = 2
ORDER BY state;
