-- Ex 1
WITH no_duplicates AS
(
  SELECT company_id, COUNT(*) AS count
  FROM job_listings
  GROUP BY company_id
  HAVING COUNT(*) > 1
)
SELECT COUNT(*) AS duplicate_companies
FROM no_duplicates;

-- Ex 2
WITH
  total_spend_1 AS
  (
	SELECT category,
	       product,
		     SUM(spend) AS total_spend
	FROM product_spend
	WHERE category = 'appliance'
		AND EXTRACT(year FROM transaction_date) = '2022'
	GROUP BY product, category
	ORDER BY total_spend DESC
	LIMIT 2
	),
  total_spend_2 AS
  (
	SELECT category,
		     product,
		     SUM(spend) AS total_spend
	FROM product_spend
	WHERE category = 'electronics'
		AND EXTRACT(year FROM transaction_date) = '2022'
	GROUP BY product, category
	ORDER BY total_spend DESC
	LIMIT 2
	)
SELECT *
FROM total_spend_1
UNION ALL
SELECT *
FROM total_spend_2;

-- Ex 3
WITH calls_count AS
(
  SELECT policy_holder_id, COUNT(*) AS no_of_calls
  FROM callers
  GROUP BY policy_holder_id
  HAVING COUNT(*) >= 3
)
SELECT COUNT(*) AS member_count
FROM calls_count;

-- Ex 4
SELECT page_id
FROM pages
WHERE page_id NOT IN (SELECT page_id FROM page_likes);

-- Ex 5
WITH june_user AS
(
    SELECT  DISTINCT user_id
    FROM user_actions
    WHERE EXTRACT(MONTH FROM event_date) = 6
)

SELECT EXTRACT(MONTH FROM event_date) AS month,
       COUNT(DISTINCT user_actions.user_id) AS monthly_active_users
FROM user_actions
JOIN june_user ON user_actions.user_id = june_user.user_id
GROUP BY EXTRACT(MONTH FROM event_date)
HAVING EXTRACT(MONTH FROM event_date) = 7;

-- Ex 6
SELECT DATE_FORMAT(trans_date, '%Y-%m') AS month,
       country,
       COUNT(*) AS trans_count,
       SUM(CASE WHEN state = 'approved' THEN 1 ELSE 0 END) AS approved_count,
       SUM(amount) AS trans_total_amount,
       SUM(CASE WHEN state = 'approved' THEN amount ELSE 0 END) AS approved_total_amount
FROM transactions
GROUP BY month, country;

-- Ex 7
SELECT product_id, year AS first_year, quantity, price
FROM sales
WHERE (product_id, year) IN (SELECT product_id, MIN(year) FROM sales GROUP BY product_id);

-- Ex 8
SELECT customer_id
FROM customer
WHERE product_key IN (SELECT product_key FROM product)
GROUP BY customer_id
HAVING COUNT(DISTINCT product_key) = (SELECT COUNT(*) FROM product);

-- Ex 9
SELECT employee_id
FROM employees
WHERE salary < 30000
AND manager_id NOT IN (SELECT employee_id FROM employees)
ORDER BY employee_id;

-- Ex 10
-- Bài tập bị gắn nhầm link của Exercise 1

-- Ex 11
SELECT name AS results
FROM users
WHERE user_id = (
    SELECT m1.user_id
    FROM movierating AS m1
    JOIN users AS u1 ON m1.user_id = u1.user_id
    GROUP BY m1.user_id
    ORDER BY COUNT(m1.rating) DESC, u1.name
    LIMIT 1)

UNION ALL

SELECT title
FROM movies
WHERE movie_id = (
    SELECT m1.movie_id
    FROM movierating AS m1
    JOIN movies AS m2 ON m1.movie_id = m2.movie_id
    WHERE EXTRACT(YEAR FROM m1.created_at) = 2020
        AND EXTRACT(MONTH FROM m1.created_at) = 02
    GROUP BY m1.movie_id
    ORDER BY AVG(m1.rating) DESC, m2.title
    LIMIT 1);

-- Ex 12
WITH main AS
    (SELECT requester_id AS id
    FROM requestaccepted
    UNION ALL
    SELECT accepter_id AS id
    FROM requestaccepted)

SELECT id, COUNT(*) AS num
FROM main
GROUP BY id
ORDER BY num DESC
LIMIT 1;
