/* 04_Clinic_Queries.sql*/

/*  Q1) Revenue from each sales channel in a given year (2021) */

SELECT 
    sales_channel,
    SUM(amount) AS total_revenue
FROM clinic_sales
WHERE EXTRACT(YEAR FROM datetime) = 2021
GROUP BY sales_channel;


/* Q2) Top 10 most valuable customers for a given year*/

SELECT 
    uid,
    SUM(amount) AS total_spent
FROM clinic_sales
WHERE EXTRACT(YEAR FROM datetime) = 2021
GROUP BY uid
ORDER BY total_spent DESC
LIMIT 10;

/* Q3) Month-wise revenue, expense, profit, and status*/

WITH revenue AS (
    SELECT 
        EXTRACT(MONTH FROM datetime) AS month,
        SUM(amount) AS total_revenue
    FROM clinic_sales
    WHERE EXTRACT(YEAR FROM datetime) = 2021
    GROUP BY EXTRACT(MONTH FROM datetime)
),
expense AS (
    SELECT 
        EXTRACT(MONTH FROM datetime) AS month,
        SUM(amount) AS total_expense
    FROM expenses
    WHERE EXTRACT(YEAR FROM datetime) = 2021
    GROUP BY EXTRACT(MONTH FROM datetime)
)
SELECT 
    r.month,
    r.total_revenue,
    e.total_expense,
    (r.total_revenue - e.total_expense) AS profit,
    CASE 
        WHEN (r.total_revenue - e.total_expense) > 0 THEN 'Profitable'
        ELSE 'Not Profitable'
    END AS status
FROM revenue r
JOIN expense e 
    ON r.month = e.month
ORDER BY r.month;

/* Q4) For each city, find the most profitable clinic (given month) Example) November 2021*/

WITH profit_data AS (
    SELECT 
        c.cid,
        c.clinic_name,
        c.city,
        SUM(cs.amount) - COALESCE(SUM(e.amount), 0) AS profit
    FROM clinics c
    LEFT JOIN clinic_sales cs 
        ON c.cid = cs.cid 
        AND EXTRACT(MONTH FROM cs.datetime) = 11
    LEFT JOIN expenses e 
        ON c.cid = e.cid 
        AND EXTRACT(MONTH FROM e.datetime) = 11
    GROUP BY c.cid, c.clinic_name, c.city
),
ranked AS (
    SELECT *,
        RANK() OVER (
            PARTITION BY city 
            ORDER BY profit DESC
        ) AS rnk
    FROM profit_data
)
SELECT *
FROM ranked
WHERE rnk = 1;



/* Q5) For each state, find the second least profitable clinic  Example) November 2021 */

WITH profit_data AS (
    SELECT 
        c.cid,
        c.clinic_name,
        c.state,
        SUM(cs.amount) - COALESCE(SUM(e.amount), 0) AS profit
    FROM clinics c
    LEFT JOIN clinic_sales cs 
        ON c.cid = cs.cid 
        AND EXTRACT(MONTH FROM cs.datetime) = 11
    LEFT JOIN expenses e 
        ON c.cid = e.cid 
        AND EXTRACT(MONTH FROM e.datetime) = 11
    GROUP BY c.cid, c.clinic_name, c.state
),
ranked AS (
    SELECT *,
        RANK() OVER (
            PARTITION BY state 
            ORDER BY profit ASC
        ) AS rnk
    FROM profit_data
)
SELECT *
FROM ranked
WHERE rnk = 2;
