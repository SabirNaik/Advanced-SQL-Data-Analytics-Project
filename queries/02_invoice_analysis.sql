-- ==============================================================================
-- Query 1: Find countries with the most invoices
-- Description: Counts the number of invoices per country and orders them descending.
-- ==============================================================================
SELECT billing_country, COUNT(invoice_id) AS total_invoice
FROM invoice
GROUP BY billing_country
ORDER BY total_invoice DESC;

-- ==============================================================================
-- Query 2: Find the top 3 values of total invoices
-- Description: Retrieves the top 3 highest invoice totals.
-- Note: Fixed syntax error in the original file around ROUND(total).
-- ==============================================================================
SELECT invoice_id, ROUND(total, 2) AS rounded_total
FROM invoice
ORDER BY total DESC
LIMIT 3;

-- ==============================================================================
-- Query 3: Find the city that generated the highest sum of invoice totals
-- Description: Groups invoices by city and returns the one with the highest total.
-- ==============================================================================
SELECT billing_city, SUM(total) AS total_invoice
FROM invoice
GROUP BY billing_city
ORDER BY total_invoice DESC
LIMIT 1;
