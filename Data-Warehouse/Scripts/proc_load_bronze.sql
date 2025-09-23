/*
=====================================================================
Stored Procedure: Load raw data into Bronze layer (source --> Bronze)
=====================================================================
Purpose: 
	This procedure inserts data into Bronze schema from external .csv files.
	List of actions:
	- Truncates Bronze tables before insertion
	- Uses 'BULK INSERT' command to load data

Parameter: 
	None

Return:
	None
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME, @session_start DATETIME,
	@end_time DATETIME, @session_end DATETIME
	BEGIN TRY 
		PRINT('===========================================')
		PRINT('Data load started')
		SET @session_start = GETDATE();

		-- Empty table and insert data to Table 1
		TRUNCATE TABLE bronze.crm_cust_info;

		SET @start_time = GETDATE();
		PRINT('>>> inserting data into: crm_cust_info');
		BULK INSERT bronze.crm_cust_info
		FROM 'C:\datasets\sql\source_crm\cust_info.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT('Insert completed in ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds');
		PRINT('.....................................');

		-- Empty table and insert data to Table 2
		TRUNCATE TABLE bronze.crm_prd_info;

		SET @start_time = GETDATE();
		PRINT('>>> inserting data into: crm_prd_info');
		BULK INSERT bronze.crm_prd_info
		FROM 'C:\datasets\sql\source_crm\prd_info.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT('Insert completed in ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds');
		PRINT('.....................................');
		
		-- Empty table and insert data to Table 3
		TRUNCATE TABLE bronze.crm_sales_details;
	
		SET @start_time = GETDATE();
		PRINT('>>> inserting data into: crm_sales_details');
		BULK INSERT bronze.crm_sales_details
		FROM 'C:\datasets\sql\source_crm\sales_details.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT('Insert completed in ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds');
		PRINT('.....................................');

		-- Empty table and insert data to Table 4
		TRUNCATE TABLE bronze.erp_cust_az12

		SET @start_time = GETDATE();
		PRINT('>>> inserting data into: erp_cust_az12');
		BULK INSERT bronze.erp_cust_az12
		FROM 'C:\datasets\sql\source_erp\cust_az12.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT('Insert completed in ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds');
		PRINT('.....................................');

		-- Empty table and insert data to Table 5
		TRUNCATE TABLE bronze.erp_loc_a101;

		SET @start_time = GETDATE();
		PRINT('>>> inserting data into: erp_loc_a101');
		BULK INSERT bronze.erp_loc_a101
		FROM 'C:\datasets\sql\source_erp\loc_a101.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT('Insert completed in ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds');
		PRINT('.....................................');

		-- Empty table and insert data to Table 6
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;

		SET @start_time = GETDATE();
		PRINT('>>> inserting data into: erp_px_cat_g1v2');
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'C:\datasets\sql\source_erp\px_cat_g1v2.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);

		SET @end_time = GETDATE();
		PRINT('Insert completed in ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds');
		PRINT('.....................................');

		SET @session_end = GETDATE();
		PRINT('Data load completed!');
		PRINT('Total load time: ' + CAST(DATEDIFF(second, @session_start, @session_end) AS NVARCHAR) + ' seconds');
		PRINT('==================================================');
	END TRY
BEGIN CATCH
	-- Error handling
	PRINT('An error occured');
	PRINT('Error message: ' + ERROR_MESSAGE())
	PRINT('Error line: ' + CAST(ERROR_LINE() AS VARCHAR))
	PRINT('Error number: ' + CAST(ERROR_NUMBER() AS VARCHAR))
	PRINT('Error procedure: ' + ERROR_PROCEDURE());
END CATCH
END;