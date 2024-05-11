-- Chuyển đổi dữ liệu
ALTER TABLE sales_dataset_rfm_prj
    ALTER COLUMN quantityordered TYPE numeric USING (quantityordered::numeric);

ALTER TABLE sales_dataset_rfm_prj
    ALTER COLUMN priceeach TYPE numeric USING (priceeach::numeric);

ALTER TABLE sales_dataset_rfm_prj
    ALTER COLUMN sales TYPE numeric USING (sales::numeric);

ALTER TABLE sales_dataset_rfm_prj
    ALTER COLUMN orderdate TYPE TIMESTAMP USING to_timestamp(orderdate, 'MM/DD/YYYY HH24:MI');

-- Check NULL/BLANK
SELECT * FROM sales_dataset_rfm_prj
WHERE (ordernumber = '' OR ordernumber IS NULL)
	OR (quantityordered IS NULL)
	OR (priceeach IS NULL)
	OR (orderlinenumber = '' OR orderlinenumber IS NULL)
	OR (sales IS NULL)
	OR (orderdate IS NULL);

-- Thêm cột
ALTER TABLE sales_dataset_rfm_prj
    ADD COLUMN contactlastname VARCHAR(255),
    ADD COLUMN contactfirstname VARCHAR(255);

UPDATE sales_dataset_rfm_prj
	SET
		contactlastname = UPPER(LEFT(SPLIT_PART(contactfullname, '-', 2), 1))
							||
						  LOWER(SUBSTRING(SPLIT_PART(contactfullname, '-', 2), 2, LENGTH(SPLIT_PART(contactfullname, '-', 2)))),
		contactfirstname = UPPER(LEFT(SPLIT_PART(contactfullname, '-', 1), 1))
							||
						  LOWER(SUBSTRING(SPLIT_PART(contactfullname, '-', 1), 2, LENGTH(SPLIT_PART(contactfullname, '-', 1))));

-- Thêm cột
ALTER TABLE sales_dataset_rfm_prj
    ADD COLUMN qtr_id VARCHAR,
    ADD COLUMN month_id VARCHAR,
	ADD COLUMN year_id VARCHAR;

UPDATE sales_dataset_rfm_prj
	SET
		qtr_id = EXTRACT(QUARTER FROM orderdate),
		month_id = EXTRACT(MONTH FROM orderdate),
		year_id = EXTRACT(YEAR FROM orderdate);

-- Tìm và xử lý outlier
WITH z_score AS (
    SELECT
        *,
        (SELECT AVG(quantityordered) FROM sales_dataset_rfm_prj) AS avg,
        (SELECT STDDEV(quantityordered) FROM sales_dataset_rfm_prj) AS stddev
    FROM sales_dataset_rfm_prj
),
outlier AS (
    SELECT
        *,
        (quantityordered - avg)/stddev AS z_score
    FROM z_score
    WHERE ABS((quantityordered - avg)/stddev) > 3
)

--- Cách 1
UPDATE sales_dataset_rfm_prj
SET QUANTITYORDERED = (
    SELECT AVG(quantityordered)
    FROM sales_dataset_rfm_prj
)
WHERE QUANTITYORDERED IN (SELECT quantityordered FROM outlier);

--- Cách 2
DELETE FROM sales_dataset_rfm_prj
WHERE QUANTITYORDERED IN (SELECT quantityordered FROM outlier);

-- Lưu dữ liệu vào bảng mới
CREATE TABLE sales_dataset_rfm_prj_clean AS
SELECT * FROM sales_dataset_rfm_prj;
