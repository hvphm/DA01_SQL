-- Ex 1
SELECT
SUM(CASE
    WHEN (device_type = 'laptop') THEN 1
    ELSE 0
END) AS laptop_views,

SUM(CASE
    WHEN (device_type IN ('tablet', 'phone')) THEN 1
    ELSE 0
END) AS mobile_views
FROM viewership;

-- Ex 2
SELECT *,
CASE
  WHEN (POW(x, 2) + POW(y, 2) = POW(z, 2))
    OR (POW(x, 2) + POW(z, 2) = POW(y, 2))
    OR (POW(y, 2) + POW(z, 2) = POW(x, 2))
   THEN 'Yes'
  ELSE 'No'
END AS triangle
FROM Triangle;

-- Ex 3
SELECT ((SUM(CASE
        WHEN call_category IN ('n/a', '') THEN 1
        ELSE 0
        END))/COUNT(*))*100 AS call_percentage
FROM callers;

-- Ex 4
SELECT name FROM Customer
WHERE referee_id <> 2 OR referee_id IS NULL;

-- Ex 5
SELECT
CASE WHEN pclass = 1 THEN 'first_class'
     WHEN pclass = 2 THEN 'second_class'
     ELSE 'third_class'
END AS class,

SUM(CASE WHEN survived = 1 THEN 1
     ELSE 0
END) AS survivors,

SUM(CASE WHEN survived = 0 THEN 1
     ELSE 0
END) AS non_survivors

FROM titanic
GROUP BY class;
