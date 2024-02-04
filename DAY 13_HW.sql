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


-- Ex 6


-- Ex 7


-- Ex 8


-- Ex 9


-- Ex 10


-- Ex 11


-- Ex 12
