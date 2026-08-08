--------------------------------------------------
-- Question: How is the senior most employee based on job title?
-- Purpose: Identify the employee with the highest level value.
--------------------------------------------------
SELECT *
FROM employee
ORDER BY levels DESC
LIMIT 1;

--------------------------------------------------
-- Question: Which countries have the most invoices?
-- Purpose: Find the total number of invoices per billing country.
--------------------------------------------------
SELECT billing_country, COUNT(invoice_id) AS total_invoice
FROM invoice
GROUP BY billing_country
ORDER BY total_invoice DESC;

--------------------------------------------------
-- Question: What are top 3 values of total invoices?
-- Purpose: Retrieve the top 3 highest invoice totals.
--------------------------------------------------
SELECT invoice_id, ROUND(total, 2)
FROM invoice
ORDER BY total DESC
LIMIT 3;

--------------------------------------------------
-- Question: Which city has the best customers?
-- Purpose: Determine the city with the highest sum of invoice totals.
--------------------------------------------------
SELECT billing_city, SUM(total) AS Total_Invoice
FROM invoice
GROUP BY billing_city
ORDER BY Total_Invoice DESC
LIMIT 1;

--------------------------------------------------
-- Question: Who is the best customer?
-- Purpose: Identify the customer who has spent the most money.
--------------------------------------------------
SELECT C.customer_id, C.first_name, C.last_name, SUM(I.Total) AS Total
FROM customer AS C
INNER JOIN invoice AS I
    ON C.customer_id = I.customer_id
GROUP BY C.customer_id, C.first_name, C.last_name
ORDER BY Total DESC
LIMIT 1;

--------------------------------------------------
-- Reference: Genre Table
--------------------------------------------------
SELECT * FROM genre;

-- ==================================================
-- Moderate Questions
-- ==================================================

--------------------------------------------------
-- Question: Identify customers who listen to Rock music
-- Purpose: Return the email, first name, and last name of
--          all Rock Music listeners ordered alphabetically by email.
--------------------------------------------------
SELECT DISTINCT C.Email, C.first_name, C.last_name
FROM customer AS C
JOIN invoice AS I
    ON C.customer_id = I.customer_id
JOIN invoice_line AS IL
    ON I.invoice_id = IL.invoice_id
WHERE IL.track_id IN (
    SELECT T.track_id
    FROM track AS T
    JOIN genre AS G
        ON T.genre_id = G.genre_id
    WHERE G.name = 'Rock'
)
ORDER BY C.Email ASC;

--------------------------------------------------
-- Question: Who are the top 10 Rock bands?
-- Purpose: Return the artist name and total track count of the
--          top 10 rock bands.
--------------------------------------------------
SELECT A.artist_id, A.name AS artist_name,
       COUNT(T.track_id) AS total_tracks,
       G.name AS genre_name
FROM artist AS A
JOIN album AS AL
    ON A.artist_id = AL.artist_id
JOIN track AS T
    ON T.album_id = AL.album_id
JOIN genre AS G
    ON G.genre_id = T.genre_id
WHERE G.name = 'Rock'
GROUP BY A.artist_id, A.name, G.name
ORDER BY total_tracks DESC
LIMIT 10;

--------------------------------------------------
-- Question: What is the average track length?
-- Purpose: Calculate the average length of a track in milliseconds.
--------------------------------------------------
SELECT ROUND(AVG(milliseconds), 2) AS AVG_Len
FROM track;

--------------------------------------------------
-- Question: Which tracks are longer than average?
-- Purpose: Return all track names and lengths for tracks that are
--          longer than the average track length.
--------------------------------------------------
SELECT name, milliseconds
FROM track
WHERE milliseconds > (
    SELECT ROUND(AVG(milliseconds), 2) AS AVG_Len
    FROM track
)
ORDER BY milliseconds DESC;

-- ==================================================
-- Advance Questions
-- ==================================================

--------------------------------------------------
-- Question: How much has each customer spent on the best selling artist?
-- Purpose: Identify the best selling artist and calculate total
--          spending per customer on that artist.
--------------------------------------------------
WITH best_selling AS (
    SELECT A.artist_id AS artist_id, A.name AS artist_name,
           SUM(IL.unit_price * IL.quantity) AS total_sales
    FROM invoice_line IL
    JOIN track AS T
        ON T.track_id = IL.track_id
    JOIN album AS Ab
        ON Ab.album_id = T.album_id
    JOIN artist AS A
        ON A.artist_id = Ab.artist_id
    GROUP BY 1, 2
    ORDER BY 3 DESC
    LIMIT 1
)
SELECT C.customer_id, C.first_name, C.last_name, BS.artist_name,
       SUM(IL.unit_price * IL.quantity) AS amount_spent
FROM invoice I
JOIN customer C
    ON C.customer_id = I.customer_id
JOIN invoice_line IL
    ON IL.invoice_id = I.invoice_id
JOIN track T
    ON T.track_id = IL.track_id
JOIN album Ab
    ON Ab.album_id = T.album_id
JOIN best_selling BS
    ON BS.artist_id = Ab.artist_id
GROUP BY 1, 2, 3, 4
ORDER BY 5 DESC;

--------------------------------------------------
-- Reference: Customer Table
--------------------------------------------------
SELECT * FROM customer;

--------------------------------------------------
-- Question: What is the most popular music genre for each country?
-- Purpose: Identify the genre with the highest amount of purchases
--          for each country.
--------------------------------------------------
WITH popular_genre AS (
    SELECT COUNT(IL.Quantity) AS Purchases, C.country, G.name, G.genre_id,
           ROW_NUMBER() OVER(PARTITION BY C.country ORDER BY COUNT(IL.Quantity) DESC) AS Row_num
    FROM invoice_line AS Il
    JOIN invoice AS I
        ON I.invoice_id = Il.invoice_id
    JOIN customer AS C
        ON C.customer_id = I.customer_id
    JOIN track AS T
        ON T.track_id = IL.track_id
    JOIN genre AS G
        ON G.genre_id = T.genre_id
    GROUP BY 2, 3, 4
    ORDER BY 2 ASC, 1 DESC
)
SELECT *
FROM popular_genre
WHERE Row_num = 1;

--------------------------------------------------
-- Question: Who is the top customer for each country?
-- Purpose: Identify the customer that has spent the most on music
--          for each country.
--------------------------------------------------
WITH Customers_with_country AS (
    SELECT C.customer_id, C.first_name, C.last_name, I.billing_country, SUM(I.total) AS Total_spending,
           ROW_NUMBER() OVER(PARTITION BY I.billing_country ORDER BY SUM(I.total) DESC) AS Row_num
    FROM invoice AS I
    JOIN customer AS C
        ON C.customer_id = I.customer_id
    GROUP BY 1, 2, 3, 4
    ORDER BY 4 ASC, 5 DESC
)
SELECT *
FROM Customers_with_country
WHERE Row_num <= 1;