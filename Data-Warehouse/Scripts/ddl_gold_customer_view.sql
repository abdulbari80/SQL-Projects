/*
======================================
DDL Script: Create Gold View
======================================
Purpose: 
	This script creates views in the Gold layer.
	Whereas Gold layer represents final dimension and fact tables.

	Each view performs data transformation and combines data from silver layer
	to produce clean, enriched and user-friendly datasets. 

Usage: 
	These views can queried directly for analytics and reporting. 

*/

-- ====================================
-- Create Dimension: gold.dim_customers
-- ====================================

IF OBJECT_ID('gold.dim_customers', 'V') IS NOT NULL
	DROP VIEW gold.dim_customers;
GO

CREATE VIEW gold.dim_customers AS
SELECT 
	ROW_NUMBER() OVER(ORDER BY ci.cst_id) AS customer_key,
	ci.cst_id AS customer_id,
	ci.cst_key AS customer_number,
	ci.cst_firstname AS first_name,
	ci.cst_lastname AS last_name,
	cl.CNTRY AS country,
	ci.cst_marital_status AS marital_status,
	CASE
		WHEN ci.cst_gndr IS NULL AND ca.GEN = 'Male' THEN 'M'
		WHEN ci.cst_gndr IS NULL AND ca.GEN = 'Female' THEN 'F'
		ELSE ci.cst_gndr
	END gender,
	ca.BDATE AS birth_date,
	ci.cst_create_date AS create_date
FROM silver.crm_cust_info AS ci
LEFT JOIN silver.erp_cust_az12 AS ca
ON ci.cst_key = ca.CID
LEFT JOIN silver.erp_loc_a101 AS cl
ON ci.cst_key = cl.CID
WHERE ci.cst_id IS NOT NULL