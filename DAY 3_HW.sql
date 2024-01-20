-- Ex1
SELECT NAME FROM CITY
WHERE POPULATION > 120000
    AND COUNTRYCODE = 'USA'

-- Ex 2
SELECT * FROM CITY
WHERE COUNTRYCODE = 'JPN'

-- Ex 3
SELECT CITY, STATE FROM STATION

-- Ex 4
SELECT DISTINCT CITY FROM STATION
WHERE CITY LIKE 'a%'
    OR CITY LIKE 'i%'
    OR CITY LIKE 'e%'
    OR CITY LIKE 'o%'
    OR CITY LIKE 'u%'

-- Ex 5
SELECT DISTINCT CITY FROM STATION
WHERE CITY LIKE '%a'
    OR CITY LIKE '%i'
    OR CITY LIKE '%e'
    OR CITY LIKE '%o'
    OR CITY LIKE '%u'

-- Ex 6
SELECT DISTINCT CITY FROM STATION
WHERE CITY NOT LIKE 'a%'
    AND CITY NOT LIKE 'i%'
    AND CITY NOT LIKE 'e%'
    AND CITY NOT LIKE 'o%'
    AND CITY NOT LIKE 'u%'

-- Ex 7
SELECT name FROM Employee
ORDER BY name

-- Ex 8
SELECT name FROM Employee
WHERE salary > 2000
    AND months < 10
ORDER BY employee_id

-- Ex 9
SELECT product_id FROM Products
WHERE low_fats = 'Y'
    AND recyclable = 'Y'

-- Ex 10
SELECT name FROM Customer
WHERE referee_id <> 2
    OR referee_id IS NULL

-- Ex 11
SELECT name, population, area FROM World
WHERE area > 300000
    AND population > 25000000

-- Ex 12
SELECT DISTINCT author_id AS id FROM Views
WHERE  author_id = viewer_id
ORDER BY author_id

-- Ex 13
SELECT part, assembly_step FROM parts_assembly
WHERE finish_date IS NULL

-- Ex 14
SELECT * FROM lyft_drivers
WHERE yearly_salary NOT BETWEEN 30000 AND 70000

-- Ex 15
SELECT * FROM uber_advertising
WHERE year = 2019
    AND money_spent > 100000
