-- Ex 1
WITH yoy_spend AS 
(
SELECT EXTRACT(YEAR FROM transaction_date) AS year,
       product_id,
       spend AS curr_year_spend,
       LAG(spend, 1) OVER(PARTITION BY product_id) AS prev_year_spend
FROM user_transactions
)

SELECT *,
       ROUND(100*(curr_year_spend - prev_year_spend)/prev_year_spend, 2) AS yoy_rate
FROM yoy_spend;

-- Ex 2
WITH issuance_date AS
(
SELECT *,
       RANK() OVER(PARTITION BY card_name ORDER BY issue_year, issue_month) AS rank_date
FROM monthly_cards_issued
)

SELECT card_name, issued_amount
FROM issuance_date
WHERE rank_date = 1
ORDER BY issued_amount DESC
;

-- Ex 3
WITH transactions_by_users AS
(
SELECT *,
       RANK() OVER(PARTITION BY user_id ORDER BY transaction_date) AS no_transactions
FROM transactions
)

SELECT user_id, spend, transaction_date
FROM transactions_by_users
WHERE no_transactions = 3
;

-- Ex 4
WITH no_purchase AS (
    SELECT *,
           COUNT(*) OVER(PARTITION BY user_id, transaction_date) AS purchase_count,
           RANK() OVER(PARTITION BY user_id ORDER BY transaction_date DESC) AS sort_date
    FROM user_transactions
)

SELECT DISTINCT transaction_date, user_id, purchase_count
FROM no_purchase
WHERE sort_date = 1
ORDER BY transaction_date;

-- Ex 5
SELECT 
    user_id,
    tweet_date,
    ROUND(AVG(tweet_count) OVER(PARTITION BY user_id ORDER BY tweet_date ROWS BETWEEN 2 PRECEDING AND CURRENT ROW), 2) AS rolling_avg_3d
FROM 
    tweets;

-- Ex 6
WITH repeated_transactions AS
(
SELECT *,
       LEAD(transaction_timestamp) OVER(PARTITION BY merchant_id, credit_card_id, amount) AS next_trans
FROM transactions
)
SELECT COUNT(*) - 1 AS payment_count
FROM repeated_transactions
WHERE EXTRACT(MINUTE FROM next_trans - transaction_timestamp) <= 10
;

-- Ex 7
WITH spend_by_category AS
(
	SELECT category,
	       product,
		     SUM(spend) AS total_spend,
		     RANK() OVER(PARTITION BY category ORDER BY SUM(spend) DESC) AS spend_rank
	FROM product_spend
	WHERE EXTRACT(year FROM transaction_date) = '2022'
	GROUP BY category, product
)

SELECT category, product, total_spend
FROM spend_by_category
WHERE spend_rank <= 2
;

-- Ex 8
WITH top_10_ranking AS
(
SELECT a.artist_name,
       DENSE_RANK() OVER(ORDER BY COUNT(*) DESC) AS artist_rank
FROM  global_song_rank AS gb
JOIN songs AS s ON gb.song_id = s.song_id
JOIN artists AS a ON s.artist_id = a.artist_id
WHERE gb.rank <= 10
GROUP BY a.artist_name
)
SELECT *
FROM top_10_ranking
WHERE artist_rank <= 5;
