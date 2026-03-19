
-- # Cleaning bronze.crm_customers_info

SELECT *
FROM bronze.crm_customers_info;

-- Checking the null values

SELECT 
customer_id,
COUNT(*)
FROM bronze.crm_customers_info
GROUP BY customer_id
HAVING COUNT(*) > 1;

-- Removing white spaces in name columns

SELECT 
TRIM(first_name) AS first_name,
TRIM(last_name) AS last_name
FROM bronze.crm_customers_info;

-- Checking unique values in gender column

SELECT DISTINCT gender
FROM bronze.crm_customers_info;

SELECT DISTINCT gender
FROM
(
SELECT 
CASE
	WHEN LOWER(gender) IN ('f','female' ) THEN 'Female'
	WHEN LOWER(gender) IN ('m','male') THEN 'Male'
	ELSE 'n/a'
	END AS gender
FROM bronze.crm_customers_info
)t ;

-- Decting outliers in signup_date column

SELECT 
signup_date
FROM bronze.crm_customers_info
WHERE signup_date IS NULL OR signup_date = '';

SELECT MAX(signup_date), MIN(signup_date)
FROM
(
SELECT 
	TRY_CAST(NULLIF(signup_date, '') AS DATE) AS signup_date
FROM bronze.crm_customers_info
)t ;


---------------------------------------------------------------

-- # Cleaning bronze.crm_order_line

SELECT *
FROM bronze.crm_order_line;


-- Checking duplicate id

SELECT purchase_id,
COUNT(*)
FROM bronze.crm_order_line
GROUP BY purchase_id
HAVING COUNT(*) > 1;

-- Checking total_amount 

SELECT *
FROM bronze.crm_order_line
WHERE product_id = 42; 

-- # it includes discounted prices in total.

-- Detecting outliners in quantity column

SELECT MAX(quantity) , MIN(quantity)
FROM bronze.crm_order_line;

-- Detecting outliers in total_amount column

SELECT MAX(total_amount) , MIN(total_amount)
FROM bronze.crm_order_line;

-----------------------------------------------------------------

-- # Cleaning bronze.crm_product_info

SELECT *
FROM bronze.crm_product_info;

-- Checking duplicate id

SELECT product_id,
COUNT(*)
FROM bronze.crm_product_info
GROUP BY product_id
HAVING COUNT(*) > 1;

-- Checking and cleaning white spaces in product_name column

SELECT DISTINCT product_name
FROM bronze.crm_product_info
ORDER BY product_name;

-- Detecting outliers in price_per_unit column

SELECT MAX(price_per_unit), MIN(price_per_unit)
FROM bronze.crm_product_info;

-----------------------------------------------------------------
-- # Cleaning bronze.erp_cust_contact

SELECT *
FROM bronze.erp_cust_contact;

-- checking duplicate id

SELECT customer_id,
COUNT(*)
FROM bronze.erp_cust_contact
GROUP BY customer_id
HAVING COUNT(*) > 1;

-- checking and cleaning email

SELECT email
FROM bronze.erp_cust_contact
WHERE email NOT LIKE '%_@gmail.com'; -- checking other mail

SELECT email
FROM bronze.erp_cust_contact
WHERE email = '' OR email IS NULL; -- checking null email

SELECT 
LOWER(REPLACE(TRIM(email) , ' ' , '')) AS email
FROM bronze.erp_cust_contact
WHERE email LIKE ' %_%' OR email LIKE '%_% ';

SELECT
phone_number
FROM bronze.erp_cust_contact
WHERE phone_number NOT LIKE '___-___-____'
OR phone_number IS NULL
OR phone_number LIKE '+%';

SELECT
 CASE 
     WHEN phone_number LIKE '+(%)%' THEN
        '0' + REPLACE(
        SUBSTRING( phone_number,CHARINDEX(')', phone_number) + 1, -- find the ) next position and then substring it.
                    LEN(phone_number)),' ','')                    -- And add 0 infront of the phone number.
        ELSE
            phone_number
    END AS phone_number

FROM bronze.erp_cust_contact;

-----------------------------------------------------------------

-- # Cleaning bronze.erp_cust_loc

SELECT *
FROM bronze.erp_cust_loc;

-- checking duplicate id

SELECT customer_id,
COUNT(*)
FROM bronze.erp_cust_loc
GROUP BY customer_id
HAVING COUNT(*) > 1;

-- cleaning address

SELECT DISTINCT address
FROM bronze.erp_cust_loc;

SELECT address
FROM bronze.erp_cust_loc 
WHERE address IS NULL OR address = '';

SELECT address
FROM bronze.erp_cust_loc
WHERE address LIKE '%,%' OR address LIKE '%.%';

SELECT 
REPLACE(REPLACE(TRIM(address) , ',' , ' '),'.',' ') AS address
FROM bronze.erp_cust_loc
WHERE address LIKE '%,%' OR address LIKE '%.%';

-- cleaning city

SELECT DISTINCT city
FROM bronze.erp_cust_loc;

SELECT 
TRIM(city) AS city
FROM bronze.erp_cust_loc;

-- cleaning state

SELECT DISTINCT state
FROM bronze.erp_cust_loc;

SELECT 
UPPER(TRIM(state)) AS state
FROM bronze.erp_cust_loc;

-- cleaning zip code

SELECT zip_code 
FROM bronze.erp_cust_loc
WHERE LEN(zip_code) > 5 OR 
zip_code IS NULL OR zip_code = '';

SELECT
REPLACE(TRIM(zip_code), '-','') AS zip_code
FROM bronze.erp_cust_loc;

-----------------------------------------------------------------

-- # Cleaning bronze.erp_prd_details

SELECT *
FROM bronze.erp_prd_details;

-- checking duplicate id

SELECT product_id,
COUNT(*) 
FROM bronze.erp_prd_details
GROUP BY product_id
HAVING COUNT(*) > 1;

-- cleaning category column

SELECT DISTINCT category
FROM bronze.erp_prd_details
ORDER BY category;

SELECT TRIM(category)
FROM bronze.erp_prd_details;

SELECT category
FROM
(
SELECT
    CASE 
        WHEN LOWER(product_description) LIKE '%apple%' 
          OR LOWER(product_description) LIKE '%banana%' THEN 'Fruits'

        WHEN LOWER(product_description) LIKE '%butter%' 
          OR LOWER(product_description) LIKE '%cheese%' 
          OR LOWER(product_description) LIKE '%milk%' THEN 'Dairy'

        WHEN LOWER(product_description) LIKE '%chicken%' 
          OR LOWER(product_description) LIKE '%egg%' THEN 'Meat'

        WHEN LOWER(product_description) LIKE '%bread%' 
          OR LOWER(product_description) LIKE '%pasta%' 
          OR LOWER(product_description) LIKE '%rice%' THEN 'Grains'

        ELSE 'Others'
    END AS category
FROM bronze.erp_prd_details
) t
WHERE category = 'Others';

-- cleaning brand column

SELECT DISTINCT brand
FROM bronze.erp_prd_details;

SELECT *
FROM bronze.erp_prd_details
WHERE brand = 'BrandE';

-- cleaning product_description

SELECT DISTINCT product_description
FROM bronze.erp_prd_details;

-----------------------------------------------------------------