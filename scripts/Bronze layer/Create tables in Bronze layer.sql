/*
-------------------------------------------------------------------
Create Tables in the bronze Schema from CRM and ERP data sources
-------------------------------------------------------------------
Script purpose :
- Create tables in the bronze schema from CRM and ERP data sources.
1. Layered drop table which enable re-run the script without error.
2. Then created the tables columns with same data type as source system
   to avoid data type conversion issue during data ingestion.

-------------------------------------------------------------------
Author: Yan
*/


-- Create tables for crm in the bronze layer , drop tables if they exist - for automation

IF OBJECT_ID('bronze.crm_customers_info' , 'U' ) IS NOT NULL
DROP TABLE bronze.crm_customers_info;
CREATE TABLE bronze.crm_customers_info(
customer_id INT,
first_name VARCHAR(50),
last_name VARCHAR(50),
gender VARCHAR(10),
signup_date VARCHAR(50)

);

IF OBJECT_ID('bronze.crm_order_line' , 'U' ) IS NOT NULL
DROP TABLE bronze.crm_order_line;
CREATE TABLE bronze.crm_order_line(
purchase_id INT,
customer_id INT,
product_id INT,
purchase_date VARCHAR(50),
quantity INT,
total_amount DECIMAL(10,2)

);

IF OBJECT_ID('bronze.crm_product_info', 'U' ) IS NOT NULL
DROP TABLE bronze.crm_product_info;
CREATE TABLE bronze.crm_product_info(
product_id INT,
product_name VARCHAR(50),
price_per_unit DECIMAL(10,2)

);

-- Create tables for erp in the bronze layer , drop tables if they exist - for automation

IF OBJECT_ID('bronze.erp_cust_contact','U' ) IS NOT NULL
DROP TABLE bronze.erp_cust_contact;
CREATE TABLE bronze.erp_cust_contact(
customer_id INT,
email VARCHAR(255),
phone_number VARCHAR(50)

);

IF OBJECT_ID('bronze.erp_cust_loc','U') IS NOT NULL
DROP TABLE bronze.erp_cust_loc;
CREATE TABLE bronze.erp_cust_loc(
customer_id INT,
[address] VARCHAR(255),
city VARCHAR(50),
[state] VARCHAR(50),
zip_code VARCHAR(50)

);

IF OBJECT_ID('bronze.erp_prd_details','U') IS NOT NULL
DROP TABLE bronze.erp_prd_details;
CREATE TABLE bronze.erp_prd_details(
product_id INT,
category VARCHAR(50),
brand VARCHAR(50),
product_description VARCHAR(255)

);