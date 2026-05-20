-- ==============================================================================
-- Query: Monthly Revenue Growth and Rolling Averages
-- Description: Uses advanced window functions (LAG and AVG) to calculate the
--              month-over-month revenue growth and a 3-month rolling average.
-- ==============================================================================
WITH monthly_revenue AS (
    SELECT
        STRFTIME('%Y-%m', invoice_date) AS month,
        SUM(total) AS revenue
    FROM invoice
    GROUP BY 1
)
SELECT
    month,
    revenue,
    LAG(revenue) OVER (ORDER BY month) AS prev_month_revenue,
    revenue - LAG(revenue) OVER (ORDER BY month) AS mom_growth,
    AVG(revenue) OVER (ORDER BY month ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS rolling_3_month_avg
FROM monthly_revenue
ORDER BY month;

-- ==============================================================================
-- Query: Customer Lifetime Value (CLTV) Quartiles
-- Description: Calculates total spend per customer and assigns them to quartiles
--              using the NTILE window function to segment high/low value customers.
-- ==============================================================================
WITH customer_spend AS (
    SELECT
        c.customer_id,
        c.first_name,
        c.last_name,
        SUM(i.total) AS total_spent
    FROM customer c
    JOIN invoice i ON c.customer_id = i.customer_id
    GROUP BY c.customer_id, c.first_name, c.last_name
)
SELECT
    customer_id,
    first_name,
    last_name,
    total_spent,
    NTILE(4) OVER (ORDER BY total_spent DESC) AS spend_quartile
FROM customer_spend
ORDER BY total_spent DESC;
