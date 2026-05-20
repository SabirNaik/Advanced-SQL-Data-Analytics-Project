-- ==============================================================================
-- Query 1: Find the amount spent by each customer on the best-selling artist
-- Description: Uses a CTE to identify the best-selling artist by total sales,
--              then finds out how much each customer spent on that specific artist.
-- ==============================================================================
WITH best_selling AS (
    SELECT a.artist_id AS artist_id, a.name AS artist_name,
           SUM(il.unit_price * il.quantity) AS total_sales
    FROM invoice_line il
    JOIN track AS t ON t.track_id = il.track_id
    JOIN album AS ab ON ab.album_id = t.album_id
    JOIN artist AS a ON a.artist_id = ab.artist_id
    GROUP BY 1, 2
    ORDER BY 3 DESC
    LIMIT 1
)
SELECT c.customer_id, c.first_name, c.last_name, bs.artist_name,
       SUM(il.unit_price * il.quantity) AS amount_spent
FROM invoice i
JOIN customer c ON c.customer_id = i.customer_id
JOIN invoice_line il ON il.invoice_id = i.invoice_id
JOIN track t ON t.track_id = il.track_id
JOIN album ab ON ab.album_id = t.album_id
JOIN best_selling bs ON bs.artist_id = ab.artist_id
GROUP BY 1, 2, 3, 4
ORDER BY 5 DESC;

-- ==============================================================================
-- Query 2: Find the most popular music genre for each country
-- Description: Determines the most popular genre by highest amount of purchases
--              using a CTE and the ROW_NUMBER() window function.
-- ==============================================================================
WITH popular_genre AS (
    SELECT COUNT(il.quantity) AS purchases, c.country, g.name AS genre_name, g.genre_id,
           ROW_NUMBER() OVER(PARTITION BY c.country ORDER BY COUNT(il.quantity) DESC) AS row_num
    FROM invoice_line AS il
    JOIN invoice AS i ON i.invoice_id = il.invoice_id
    JOIN customer AS c ON c.customer_id = i.customer_id
    JOIN track AS t ON t.track_id = il.track_id
    JOIN genre AS g ON g.genre_id = t.genre_id
    GROUP BY 2, 3, 4
)
SELECT *
FROM popular_genre
WHERE row_num = 1
ORDER BY country ASC;

-- ==============================================================================
-- Query 3: Find the top customer that has spent the most on music for each country
-- Description: Uses a CTE and ROW_NUMBER() window function to find the top
--              spending customer per country.
-- ==============================================================================
WITH customers_with_country AS (
    SELECT c.customer_id, c.first_name, c.last_name, i.billing_country, SUM(i.total) AS total_spending,
           ROW_NUMBER() OVER(PARTITION BY i.billing_country ORDER BY SUM(i.total) DESC) AS row_num
    FROM invoice AS i
    JOIN customer AS c ON c.customer_id = i.customer_id
    GROUP BY 1, 2, 3, 4
)
SELECT *
FROM customers_with_country
WHERE row_num <= 1
ORDER BY billing_country ASC;
