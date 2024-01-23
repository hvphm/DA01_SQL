-- Ex 1
SELECT Name
FROM STUDENTS
WHERE Marks > 75
ORDER BY RIGHT(Name, 3), ID;

-- Ex 2
SELECT user_id,
  CONCAT(UPPER(LEFT(name, 1)), LOWER(RIGHT(name, LENGTH(name) - 1))) AS name
FROM Users;

-- Ex 3
SELECT manufacturer, '$' || ROUND(SUM(total_sales), -6)/10^6 || ' million' AS sale
FROM pharmacy_sales
GROUP BY manufacturer
ORDER BY SUM(total_sales) DESC, manufacturer;

-- Ex 4
SELECT EXTRACT(MONTH FROM submit_date) AS mth,
  product_id AS product,
  ROUND(AVG(stars), 2) AS avg_stars
FROM reviews
GROUP BY EXTRACT(MONTH FROM submit_date), product_id
ORDER BY mth, product;

-- Ex 5
SELECT sender_id,
  COUNT(message_id) AS count
FROM messages
WHERE EXTRACT(YEAR from sent_date) = 2022
  AND EXTRACT(MONTH from sent_date) = 8
GROUP BY sender_id
ORDER BY count DESC
LIMIT 2;

-- Ex 6
SELECT tweet_id
FROM Tweets
WHERE LENGTH(content) > 15;

-- Ex 7
SELECT activity_date AS day,
  COUNT(DISTINCT user_id) AS active_users
FROM Activity
WHERE activity_date BETWEEN '2019-06-28' AND '2019-07-27'
GROUP BY activity_date;

-- Ex 8
SELECT COUNT(id)
FROM employees
WHERE EXTRACT(YEAR FROM joining_date) = 2022
  AND EXTRACT(MONTH FROM joining_date) BETWEEN 1 AND 7;

-- Ex 9
SELECT POSITION('a' IN 'Amitah');

-- Ex 10
SELECT SUBSTRING(title, LENGTH(winery) + 2, 4)
FROM winemag_p2
WHERE country = 'Macedonia';
