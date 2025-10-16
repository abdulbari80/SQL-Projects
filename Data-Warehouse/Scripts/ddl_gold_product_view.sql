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
-- Create Dimension: gold.dim_products
-- ====================================

IF OBJECT_ID('gold.dim_products', 'V') IS NOT NULL
	DROP VIEW gold.dim_products;
GO

CREATE VIEW gold.dim_products AS
SELECT 
	ROW_NUMBER() OVER(ORDER BY p.prd_start_dt, p.prd_key) AS product_key,
	p.prd_id AS product_id,
	p.prd_key AS product_number,
	p.prd_nm AS product_name,
	p.prd_line AS product_line,
	p.cat_id AS category_id,
	c.CAT AS category,
	c.SUBCAT AS sub_category,
	c.MAINTENANCE AS maintenance,
	p.prd_cost AS cost,
	p.prd_start_dt AS start_dt
FROM silver.crm_prd_info AS p
LEFT JOIN silver.erp_px_cat_g1v2 AS c
ON p.cat_id = c.ID
WHERE p.prd_end_dt IS NULL  --to drop obsolete product