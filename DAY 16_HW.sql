-- Ex 1
WITH delivery_status AS
(
    SELECT *,
           RANK() OVER (PARTITION BY customer_id ORDER BY order_date) AS order_rank,
           CASE
               WHEN customer_pref_delivery_date = order_date THEN 'immediate'
               ELSE 'scheduled'
           END AS order_status
    FROM delivery
)

SELECT ROUND(100 * (SUM(CASE WHEN order_status = 'immediate' THEN 1 ELSE 0 END) / COUNT(*)), 2) AS immediate_percentage
FROM delivery_status
WHERE order_rank = 1;

-- Ex 2


-- Ex 3


-- Ex 4


-- Ex 5


-- Ex 6


-- Ex 7


-- Ex 8
