/*
---------------------------------------------------------
Load data into Bronze layer
---------------------------------------------------------
Script purpose :
- Load data into Bronze layer from CRM and ERP data sources.
1. Layered truncate table which enable re-run the script without error.
2. Then used bulk insert to load data from csv files into the bronze tables.
   The file path is hard coded in the script, so please make sure to update the file path before running the script.
3. Created the stored procedure named 'load_bronze' which can be easily executed to load data into the bronze tables.
4. Use BEGIN TRY to handle errors and print error message.
----------------------------------------------------------
Author: Yan
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	
	BEGIN TRY
		PRINT '-------------------------------------------------';
		PRINT 'Inserting data for CRM tables';
		PRINT '-------------------------------------------------';
		PRINT '>> Truncating table : bronze.crm_customers_info';
		TRUNCATE TABLE bronze.crm_customers_info;
		PRINT '>> Inserting data into table : bronze.crm_customers_info';
		BULK INSERT bronze.crm_customers_info
		FROM 'E:\Projects\DWH project 2\datasets\crm source\customers_info.csv'
		WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);
		PRINT '-------------------------------------------------';

		PRINT '>> Truncating table : bronze.crm_order_line';
		TRUNCATE TABLE bronze.crm_order_line;
		PRINT '>> Inserting data into table : bronze.crm_order_line';
		BULK INSERT bronze.crm_order_line
		FROM 'E:\Projects\DWH project 2\datasets\crm source\order_line.csv'
		WITH(
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);
		PRINT '-------------------------------------------------';

		PRINT '>> Truncating table : bronze.crm_product_info';
		TRUNCATE TABLE bronze.crm_product_info;
		PRINT '>> Inserting data into table : bronze.crm_product_info';
		BULK INSERT bronze.crm_product_info
		FROM 'E:\Projects\DWH project 2\datasets\crm source\product_info.csv'
		WITH(
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);
		PRINT '-------------------------------------------------';

		PRINT '-------------------------------------------------';
		PRINT 'Inserting data for ERP tables';
		PRINT '-------------------------------------------------';
		PRINT '>> Truncating table : bronze.erp_cust_contact';
		TRUNCATE TABLE bronze.erp_cust_contact;
		PRINT '>> Inserting data into table : bronze.erp_cust_contact';
		BULK INSERT bronze.erp_cust_contact
		FROM 'E:\Projects\DWH project 2\datasets\erp source\cust_contact.csv'
		WITH(
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);
		PRINT '-------------------------------------------------';

		PRINT '>> Truncating table : bronze.erp_cust_loc';
		TRUNCATE TABLE bronze.erp_cust_loc;
		PRINT '>> Inserting data into table : bronze.erp_cust_loc';
		BULK INSERT bronze.erp_cust_loc
		FROM 'E:\Projects\DWH project 2\datasets\erp source\cust_loc.csv'
		WITH(
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);
		PRINT '-------------------------------------------------';

		PRINT '>> Truncating table : bronze.erp_prd_details';
		TRUNCATE TABLE bronze.erp_prd_details;
		PRINT '>> Inserting data into table : bronze.erp_prd_details';
		BULK INSERT bronze.erp_prd_details
		FROM 'E:\Projects\DWH project 2\datasets\erp source\prd_details.csv'
		WITH(
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);
		PRINT '-------------------------------------------------';
	END TRY
	BEGIN CATCH
		PRINT '--------------------------------------';
		PRINT 'Error occurred while loading data into bronze layer : ' + ERROR_MESSAGE();
		PRINT '--------------------------------------';
	END CATCH;
END



EXEC bronze.load_bronze;






