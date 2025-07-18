/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;
===============================================================================
*/


CREATE OR ALTER PROCEDURE bronze.load_bronze AS
EXEC bronze.load_bronze

BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME
	BEGIN TRY
		print'===========================================';
		print 'Loading bronze layer';
		print '==========================================';

		print '------------------'
		print 'loading CRM Tables'
		print '------------------'

		set @start_time = GETDATE()
		PRINT '>> Truncating table:bronze.crm_cust_info '
		TRUNCATE TABLE bronze.crm_cust_info;
		BULK INSERT bronze.crm_cust_info
		FROM 'E:\courses\data-engineer\sql-data-warehouse-project\datasets\\source_crm\cust_info.csv'

		WITH(
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK

		);
		set @end_time = GETDATE();
		print '>> load Duration ' + CAST( DATEDIFF(Second, @start_time, @end_time) AS NVARCHAR) + 'Seconds'
		print '>>--------------'

		set @start_time = GETDATE()
		PRINT '>> Truncating table:bronze.crm_prd_info '
		TRUNCATE TABLE bronze.crm_prd_info;
		BULK INSERT bronze.crm_prd_info
		FROM 'E:\courses\data-engineer\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'

		WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);
		set @end_time = GETDATE();
		print '>> load Duration ' + CAST( DATEDIFF(Second, @start_time, @end_time) AS NVARCHAR) + 'Seconds'
		print '>> --------------'

		set @start_time = GETDATE()
		PRINT '>> Truncating table:bronze.crm_sales_details '

		TRUNCATE TABLE bronze.crm_sales_details;
		BULK INSERT bronze.crm_sales_details
		FROM 'E:\courses\data-engineer\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'

		WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);
		set @end_time = GETDATE();
		print '>> load Duration ' + CAST( DATEDIFF(Second, @start_time, @end_time) AS NVARCHAR) + 'Seconds'
		print '>> --------------'

		print '------------------'
		print 'loading ERP Tables'
		print '------------------'

		set @start_time = GETDATE()
		PRINT '>> Truncating table:bronze.erp_cust_az12 '

		TRUNCATE TABLE bronze.erp_cust_az12;
		BULK INSERT bronze.erp_cust_az12
		FROM 'E:\courses\data-engineer\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'

		WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);
		set @end_time = GETDATE();
		print '>> load Duration ' + CAST( DATEDIFF(Second, @start_time, @end_time) AS NVARCHAR) + 'Seconds'
		print '>> --------------'

		set @start_time = GETDATE()
		PRINT '>> Truncating table:bronze.erp_loc_a101 '
		TRUNCATE TABLE bronze.erp_loc_a101;
		BULK INSERT bronze.erp_loc_a101
		FROM 'E:\courses\data-engineer\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'

		WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);
		set @end_time = GETDATE();
		print '>> load Duration ' + CAST( DATEDIFF(Second, @start_time, @end_time) AS NVARCHAR) + 'Seconds'
		print '>> --------------'

		set @start_time = GETDATE()
		PRINT '>> Truncating table:bronze.erp_px_cat_g1v2 '
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'E:\courses\data-engineer\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'

		WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);

		set @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -------------';
	END TRY
	BEGIN CATCH
	PRINT'====================================================';
	PRINT'ERROR OCURING DURING LOADING BRONZE LYER';
	PRINT'Error message '+ ERROR_MESSAGE(); 
	PRINT'Error message '+ CAST(ERROR_NUMBER () AS NVARCHAR);
	PRINT'Error message '+ CAST(ERROR_STATE () AS NVARCHAR);
	PRINT'===================================================='
	END CATCH
END
