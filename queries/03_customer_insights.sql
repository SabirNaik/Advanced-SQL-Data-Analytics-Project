-- ==============================================================================
-- Query 1: Find the best customer
-- Description: Retrieves the customer who has spent the most money overall.
-- ==============================================================================
SELECT c.customer_id, c.first_name, c.last_name, SUM(i.total) AS total_spent
FROM customer AS c
INNER JOIN invoice AS i
    ON c.customer_id = i.customer_id
GROUP BY c.customer_id
ORDER BY total_spent DESC
LIMIT 1;

-- ==============================================================================
-- Query 2: Get a list of all Rock music listeners
-- Description: Returns the email, first name, and last name of all customers
--              who listen to Rock music, ordered alphabetically by email.
-- ==============================================================================
SELECT DISTINCT c.email, c.first_name, c.last_name
FROM customer AS c
JOIN invoice AS i
    ON c.customer_id = i.customer_id
JOIN invoice_line AS il
    ON i.invoice_id = il.invoice_id
WHERE il.track_id IN (
    SELECT t.track_id
    FROM track AS t
    JOIN genre AS g
        ON t.genre_id = g.genre_id
    WHERE g.name = 'Rock'
)
ORDER BY c.email ASC;

-- ==============================================================================
-- Query 3: Find the top 10 rock bands
-- Description: Retrieves the artist name and total track count of the top 10
--              rock bands based on the number of tracks they have.
-- ==============================================================================
SELECT a.artist_id, a.name AS artist_name,
       COUNT(t.track_id) AS total_tracks,
       g.name AS genre_name
FROM artist AS a
JOIN album AS al
    ON a.artist_id = al.artist_id
JOIN track AS t
    ON t.album_id = al.album_id
JOIN genre AS g
    ON g.genre_id = t.genre_id
WHERE g.name = 'Rock'
GROUP BY a.artist_id, a.name, g.name
ORDER BY total_tracks DESC
LIMIT 10;

-- ==============================================================================
-- Query 4: Find tracks longer than average length
-- Description: Returns track names and milliseconds for tracks that are longer
--              than the average track length, ordered descending by length.
-- ==============================================================================
SELECT name, milliseconds
FROM track
WHERE milliseconds > (
    SELECT ROUND(AVG(milliseconds), 2) AS avg_len
    FROM track
)
ORDER BY milliseconds DESC;
