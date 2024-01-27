--- Mid-course Test ---
-- Ex 1
SELECT DISTINCT replacement_cost
FROM film
ORDER BY replacement_cost;

-- Ex 2
SELECT 
    CASE
        WHEN replacement_cost BETWEEN 9.99 AND 19.99 THEN 'low'
        WHEN replacement_cost BETWEEN 20.00 AND 24.99 THEN 'medium'
        ELSE 'high'
    END AS price_category,
    COUNT(*) AS count
FROM 
    film
GROUP BY 
    CASE
        WHEN replacement_cost BETWEEN 9.99 AND 19.99 THEN 'low'
        WHEN replacement_cost BETWEEN 20.00 AND 24.99 THEN 'medium'
        ELSE 'high'
    END;

-- Ex 3
SELECT
	film.title,
	film.length,
	ctg.name AS category
FROM film
LEFT JOIN film_category AS fc
     ON film.film_id = fc.film_id
LEFT JOIN category AS ctg
     ON fc.category_id = ctg.category_id
WHERE ctg.name IN ('Drama', 'Sports')
ORDER BY length DESC;

-- Ex 4
SELECT
	ctg.name AS category,
	COUNT(film.title) AS total
FROM film
LEFT JOIN film_category AS fc
     ON film.film_id = fc.film_id
LEFT JOIN category AS ctg
     ON fc.category_id = ctg.category_id
GROUP BY category
ORDER BY total DESC;

-- Ex 5
SELECT
	actor.first_name,
	actor.last_name,
	COUNT(fa.film_id) AS total_film
FROM actor
LEFT JOIN film_actor AS fa
     ON actor.actor_id = fa.actor_id
GROUP BY actor.first_name, actor.last_name
ORDER BY total_film DESC;

-- Ex 6
SELECT
	COUNT(add.address_id)
FROM address AS add
LEFT JOIN customer AS cst
     ON add.address_id = cst.address_id
WHERE customer_id IS NULL;

-- Ex 7
SELECT
	city.city,
	SUM(pmt.amount) AS total_revenue
FROM customer AS cst
LEFT JOIN payment AS pmt
     ON cst.customer_id = pmt.customer_id
LEFT JOIN address AS add
     ON cst.address_id = add.address_id
LEFT JOIN city
     ON add.city_id = city.city_id
GROUP BY city.city
ORDER BY total_revenue DESC;

-- Ex 8
SELECT
	CONCAT(city.city, ', ', country.country) AS place,
	SUM(pmt.amount) AS total_revenue
FROM customer AS cst
LEFT JOIN payment AS pmt
     ON cst.customer_id = pmt.customer_id
LEFT JOIN address AS add
     ON cst.address_id = add.address_id
LEFT JOIN city
     ON add.city_id = city.city_id
LEFT JOIN country
     ON city.country_id = country.country_id
GROUP BY country.country, city.city
ORDER BY total_revenue DESC;

--- Practice Exercises ---
-- Ex 1
SELECT
    country.continent,
    FLOOR(AVG(city.population)) AS avg_pop
FROM country
LEFT JOIN city
ON country.code = city.countrycode
GROUP BY country.continent
HAVING avg_pop IS NOT NULL;

-- Ex 2
SELECT ROUND(CAST(COUNT(texts.email_id) AS DECIMAL)/CAST(COUNT(emails.email_id) AS DECIMAL), 2) AS confirm_rate
FROM emails AS emails
LEFT JOIN texts
ON emails.email_id = texts.email_id
AND texts.signup_action = 'Confirmed';

-- Ex 3
SELECT
    age.age_bucket,
    ROUND(100*SUM(CASE WHEN act.activity_type = 'send' THEN act.time_spent ELSE 0 END) / SUM(act.time_spent), 2) AS send_perc,
    ROUND(100*SUM(CASE WHEN act.activity_type = 'open' THEN act.time_spent ELSE 0 END) / SUM(act.time_spent), 2) AS open_perc
FROM 
    age_breakdown AS age
LEFT JOIN 
    activities AS act
ON 
    age.user_id = act.user_id
WHERE act.activity_type <> 'chat'
GROUP BY 
    age.age_bucket;

-- Ex 4
SELECT cst.customer_id
FROM customer_contracts AS cst
LEFT JOIN products AS prd
ON cst.product_id = prd.product_id
GROUP BY cst.customer_id
HAVING COUNT(DISTINCT product_category) = 3;

-- Ex 5
SELECT
    mng.employee_id,
    mng.name,
    COUNT(emp.reports_to) AS reports_count,
    ROUND(AVG(emp.age)) AS average_age
FROM Employees AS mng
INNER JOIN Employees AS emp
ON mng.employee_id = emp.reports_to
GROUP BY mng.employee_id
ORDER BY employee_id;

-- Ex 6
SELECT
    prd.product_name,
    SUM(ord.unit) AS unit
FROM Orders AS ord
LEFT JOIN Products AS prd
ON ord.product_id = prd.product_id
WHERE ord.order_date BETWEEN '2020-02-01' AND '2020-02-29'
GROUP BY prd.product_name
HAVING unit >= 100;

-- Ex 7
SELECT p1.page_id
FROM pages AS p1
LEFT JOIN page_likes AS p2
ON p1.page_id = p2.page_id
GROUP BY p1.page_id
HAVING COUNT(DISTINCT p2.user_id) = 0;
