/*
=====================================
Create database and schema
=====================================
Script Purpose: 
This script is developed to create a data warehouse.

Warnings: Running this scripts will drop the entire data warehouse immediately. 
Hence, please check if you need this or if there is a working backup 
before running this script. 
*/

USE master;
GO

--
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
	ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE DataWarehouse
END;

CREATE DATABASE DataWarehouse;
GO

USE DataWarehouse;
GO

-- Create schemas
CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO