/*
-------------------------------------------------------------------
Create Views for gold layer
-------------------------------------------------------------------
Script purpose :
1. This script create views for the gold layer in the data warehouse.
2. This gold layer represents the final dimension tables and fact tables ( Star Schema )
3. Each view perform transformaions and combine data from silver layer
   to produce a clean, enriched and business-ready datasets.

Usage : These views can be directly queried in -> Datawarehouse2 > Views
-------------------------------------------------------------------
Author: Yan
*/

-- Create view : gold.fact_sales
IF OBJECT_ID('gold.fact_sales','V') IS NOT NULL
	DROP VIEW gold.fact_sales;
GO
CREATE VIEW gold.fact_sales AS

SELECT
o.purchase_id AS purchase_key,
o.customer_id AS customer_key,
o.product_id AS product_key,
o.purchase_date,
o.quantity,
CASE
	WHEN
	(p.price_per_unit * o.quantity ) > o.total_amount 
	THEN (p.price_per_unit * o.quantity ) - o.total_amount -- There are both discounted and marked up sales.
	ELSE 0
END AS discount_amount,
CASE
	WHEN
	(p.price_per_unit * o.quantity ) < o.total_amount
	THEN o.total_amount - (p.price_per_unit * o.quantity )
	ELSE 0
END AS markup_amount,
o.total_amount AS total_sale_amount
FROM silver.crm_order_line o
LEFT JOIN silver.crm_product_info p
ON o.product_id = p.product_id;

GO
--------------------------------------------------------------
-- Create view : gold.dim_customers
IF OBJECT_ID('gold.dim_customers','V') IS NOT NULL
	DROP VIEW gold.dim_customers;
GO
CREATE VIEW gold.dim_customers AS 

SELECT
ci.customer_id AS customer_key,
ci.first_name,
ci.last_name,
ci.gender,
cc.email,
cc.phone_number,
ci.signup_date,
cl.address,
cl.city,
cl.state,
cl.zip_code
FROM silver.crm_customers_info ci
LEFT JOIN silver.erp_cust_loc cl
ON ci.customer_id = cl.customer_id
LEFT JOIN silver.erp_cust_contact cc
ON ci.customer_id = cc.customer_id;

GO
--------------------------------------------------------------
-- Create view : gold.dim_products
IF OBJECT_ID('gold.dim_products','V') IS NOT NULL
	DROP VIEW gold.dim_products;
GO
CREATE VIEW gold.dim_products AS

SELECT
p.product_id AS product_key,
p.product_name,
d.category,
d.brand,
d.product_description,
p.price_per_unit
FROM silver.crm_product_info p
LEFT JOIN silver.erp_prd_details d
ON p.product_id = d.product_id;

GO
--------------------------------------------------------------







