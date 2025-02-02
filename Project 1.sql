--Question 1 : How is the senior most employee Based on job title?
SELECT * FROM employee
ORDER BY levels DESC
LIMIT 1;

--Question 2 : Which countries have the most invoices?

SELECT billing_country, COUNT(invoice_id) AS total_invoice
FROM invoice
GROUP BY billing_country
ORDER BY total_invoice DESC;


--Question 3 : What are top 3 values of total invoices?
SELECT invoice_id, (ROUND(total),2) 
FROM invoice
ORDER BY total DESC
LIMIT 3;

--Question 4 : 
SELECT billing_city, SUM(total) AS Total_Invoice
FROM invoice
GROUP BY billing_city
ORDER BY Total_Invoice DESC
LIMIT 1;


--Question 5:
SELECT C.customer_id, C.first_name, C.last_name, SUM(I.Total) AS Total
FROM customer AS C
INNER JOIN invoice AS I
ON C.customer_id = I.customer_id
GROUP BY C.customer_id
ORDER BY Total DESC
LIMIT 1;

SELECT * FROM genre
--Moderate Questions 
--Question 1:
SELECT DISTINCT C.Email, C.first_name, C.last_name
FROM customer AS C
JOIN invoice AS I ON C.customer_id = I.customer_id
JOIN invoice_line AS IL ON I.invoice_id = IL.invoice_id
WHERE IL.track_id IN (
    SELECT T.track_id 
    FROM track AS T
    JOIN genre AS G ON T.genre_id = G.genre_id
    WHERE G.name = 'Rock'
)
ORDER BY C.Email ASC;


--Question 2
SELECT A.artist_id, A.name AS artist_name, 
       COUNT(T.track_id) AS total_tracks, 
       G.name AS genre_name
FROM artist AS A
JOIN album AS AL ON A.artist_id = AL.artist_id 
JOIN track AS T ON T.album_id = AL.album_id
JOIN genre AS G ON G.genre_id = T.genre_id
WHERE G.name = 'Rock'
GROUP BY A.artist_id, A.name, G.name
ORDER BY total_tracks DESC
LIMIT 10;

--Question 3
SELECT ROUND(AVG(milliseconds),2) AS AVG_Len
FROM track;


SELECT name, milliseconds 
FROM track
WHERE milliseconds > (SELECT ROUND(AVG(milliseconds),2) AS AVG_Len
FROM track)
ORDER BY milliseconds DESC; 


--Advance Questions
--Questions 1
WITH best_selling AS (
    SELECT A.artist_id AS artist_id, A.name AS artist_name,
           SUM(IL.unit_price * IL.quantity) AS total_sales
    FROM invoice_line IL
    JOIN track AS T ON T.track_id = IL.track_id
    JOIN album AS Ab ON Ab.album_id = T.album_id
    JOIN artist AS A ON A.artist_id = Ab.artist_id
    GROUP BY 1
    ORDER BY 3 DESC
    LIMIT 1
)

SELECT C.customer_id, C.first_name, C.last_name, BS.artist_name, 
       SUM(IL.unit_price * IL.quantity) AS amount_spent
FROM invoice I
JOIN customer C ON C.customer_id = I.customer_id
JOIN invoice_line IL ON IL.invoice_id = I.invoice_id
JOIN track T ON T.track_id = IL.track_id
JOIN album Ab ON Ab.album_id = T.album_id
JOIN best_selling BS ON BS.artist_id = Ab.artist_id
GROUP BY 1, 2, 3, 4
ORDER BY 5 DESC;



SELECT * FROM customer

--Question 2
WITH popular_genre AS (
SELECT COUNT(IL.Quantity) AS Purchases, C.country, G.name, g.genre_id,
ROW_NUMBER() OVER(PARTITION BY C.country ORDER BY COUNT(IL.Quantity) DESC) AS Row_num
FROM invoice_line AS Il
JOIN invoice AS I ON I.invoice_id = Il.invoice_id
JOIN customer AS C ON C.customer_id = I.customer_id
JOIN track AS T ON T.track_id = IL.track_id
JOIN genre AS G ON G.genre_id = T.genre_id
GROUP BY 2, 3, 4
ORDER BY 2 ASC, 1 DESC
)
SELECT * FROM popular_genre 
WHERE Row_num = 1 ;


--Question 3
WITH Customers_with_country AS (
SELECT C.customer_id, C.first_name, C.last_name, I.billing_country, SUM(I.total) AS Total_spending,
ROW_NUMBER() OVER(PARTITION BY I.billing_country ORDER BY SUM(I.total) DESC) AS Row_num
FROM invoice AS I
JOIN customer AS C ON C.customer_id = I.customer_id 
GROUP BY 1,2,3,4
ORDER BY 4 ASC, 5 DESC)
SELECT * FROM Customers_with_country WHERE Row_num <= 1; 
