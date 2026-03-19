/*
-------------------------------------------------------------------
Stored Procedure : Load Silver Layer ( Bronze to Silver )
-------------------------------------------------------------------
Script purpose :
   This stored procedure performs the ETL ( Extract, Transform, Load ) process to
   populate the 'silver' schema tables from the 'bronze' schema.

   1. Truncates Silver tables
   2. Insert transformed and cleaned data from Bronze into Silver tables
   
Usage : EXEC silver.load_silver;

-------------------------------------------------------------------
Author: Yan
*/

CREATE OR ALTER PROCEDURE silver.load_silver AS
BEGIN
    
    BEGIN TRY
        
        PRINT '-------------------------------------------------';
		PRINT 'Inserting data for CRM tables';
		PRINT '-------------------------------------------------';
        PRINT '>> Truncating table : silver.crm_customers_info';
        -- Truncating and loading cleaned data into silver.crm_customers_info
        TRUNCATE TABLE silver.crm_customers_info;
        PRINT '>> Inserting data into table : silver.crm_customers_info'; 


        INSERT INTO silver.crm_customers_info(
        customer_id,
        first_name,
        last_name,
        gender,
        signup_date
        )

        SELECT 
        customer_id,
        TRIM(first_name) AS first_name,
        TRIM(last_name) AS last_name,
        CASE
	        WHEN LOWER(gender) IN ('f','female' ) THEN 'Female'
	        WHEN LOWER(gender) IN ('m','male') THEN 'Male'
	        ELSE 'n/a'
	        END AS gender,
        TRY_CAST(NULLIF(signup_date, '') AS DATE) AS signup_date -- To prevent the error if cast fail
        FROM bronze.crm_customers_info;
        PRINT '-------------------------------------------------';
        ------------------------------------------------------------------------
        PRINT '>> Truncating table : silver.crm_order_line';
        -- Truncating and loading cleaned data into silver.crm_order_line
        TRUNCATE TABLE silver.crm_order_line;
        PRINT '>> Inserting data into table : silver.crm_order_line';
        INSERT INTO silver.crm_order_line(
        purchase_id,
        customer_id,
        product_id,
        purchase_date,
        quantity,
        total_amount
        )

        SELECT 
        purchase_id,
        customer_id,
        product_id,
        TRY_CAST(NULLIF(purchase_date,'') AS DATE ) AS purchase_date, -- To prevent the error if cast fails
        quantity,
        total_amount
        FROM bronze.crm_order_line;
        PRINT '-------------------------------------------------';
        ------------------------------------------------------------------------
        PRINT '>> Truncating table : silver.crm_product_info';
        -- Truncating and loading cleaned data into silver.crm_product_info
        TRUNCATE TABLE silver.crm_product_info;
        PRINT '>> Inserting data into table : silver.crm_product_info';
        INSERT INTO silver.crm_product_info(
        product_id,
        product_name,
        price_per_unit
        )

        SELECT
        product_id,
        TRIM(product_name) AS product_name,
        price_per_unit
        FROM bronze.crm_product_info;
        PRINT '-------------------------------------------------';
        ------------------------------------------------------------------------
        PRINT '-------------------------------------------------';
		PRINT 'Inserting data for ERP tables';
		PRINT '-------------------------------------------------';
        PRINT '>> Truncating table : silver.erp_cust_contact';
        -- Truncating and loading cleaned data into silver.erp_cust_contact
        TRUNCATE TABLE silver.erp_cust_contact
        PRINT '>> Inserting data into table : silver.erp_cust_contact';
        INSERT INTO silver.erp_cust_contact(
        customer_id,
        email,
        phone_number
        )

        SELECT
        customer_id,
        CASE 
            WHEN email IS NULL OR email = '' THEN 'n/a'
            ELSE LOWER(REPLACE(TRIM(email) , ' ' , ''))
        END AS email,
        CASE 
            WHEN phone_number IS NULL OR phone_number = '' THEN 'n/a'
            WHEN phone_number LIKE '+(%)%' THEN
                '0' + REPLACE(
                SUBSTRING( phone_number,CHARINDEX(')', phone_number) + 1, -- find the ) next position and then substring it.
                            LEN(phone_number)),' ','')                    -- And add 0 infront of the phone number.
                ELSE
                    phone_number
            END AS phone_number
        FROM bronze.erp_cust_contact;
        PRINT '-------------------------------------------------';
        ------------------------------------------------------------------------
        PRINT '>> Truncating table : silver.erp_cust_loc';
        -- Truncating and loading cleaned data into silver.erp_cust_loc
        TRUNCATE TABLE silver.erp_cust_loc;
        PRINT '>> Inserting data into table : silver.erp_cust_loc';
        INSERT INTO silver.erp_cust_loc(
        customer_id,
        address,
        city,
        state,
        zip_code
        )

        SELECT
        customer_id,
        CASE
            WHEN address IS NULL OR address = '' THEN 'n/a'
            ELSE
                REPLACE(REPLACE(TRIM(address) , ',' , ' '),'.',' ')
        END AS address,
        CASE
            WHEN city IS NULL OR city = '' THEN 'n/a'
            ELSE TRIM(city)
        END AS city,
        CASE
            WHEN state IS NULL OR state = '' THEN 'n/a'
            ELSE UPPER(TRIM(state))
        END AS state,
        CASE
            WHEN zip_code IS NULL OR zip_code = '' THEN 'n/a'
            ELSE REPLACE(TRIM(zip_code), '-','')
        END AS zip_code
        FROM bronze.erp_cust_loc;
        PRINT '-------------------------------------------------';
        ------------------------------------------------------------------------
        PRINT '>> Truncating table : silver.erp_prd_details';
        -- Truncating and load cleaned data into silver.erp_prd_details
        TRUNCATE TABLE silver.erp_prd_details;
        PRINT '>> Inserting data into table : silver.erp_prd_details';
        INSERT INTO silver.erp_prd_details(
        product_id,
        category,
        brand,
        product_description
        )

        SELECT
        product_id,
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
            END AS category,
        TRIM(brand) AS brand,
        TRIM(product_description) AS product_description
        FROM bronze.erp_prd_details;
        PRINT '-------------------------------------------------';
        ------------------------------------------------------------------------
    END TRY
    BEGIN CATCH
        PRINT '-----------------------';
        PRINT 'Error occurred while loading data into silver layer :' + ERROR_MESSAGE();
        PRINT '-----------------------';
    END CATCH

END










