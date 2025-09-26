/*
======================================
DDL Script: Create Gold View
======================================
Purpose: 
	This script creates views in the Gold layer.
	Whereas Gold layer represents final dimension and fact tables.

Usage: 
	These views can queried directly for analytics and reporting. 

*/

-- ====================================
-- Create Fact: gold.fact_sales
-- ====================================

IF OBJECT_ID('gold.fact_sales', 'V') IS NOT NULL
	DROP VIEW gold.fact_sales;
GO

CREATE VIEW gold.fact_sales AS
SELECT 
	ss.sls_ord_num AS order_number,
	gp.product_key AS product_key,
	gc.customer_key,
	ss.sls_order_dt AS order_date,
	ss.sls_ship_dt AS ship_date,
	ss.sls_due_dt AS due_date,
	ss.sls_sales AS sales_amount,
	ss.sls_quantity AS quantity,
	ss.sls_price AS price
FROM silver.crm_sales_details AS ss
LEFT JOIN gold.dim_products AS gp
ON ss.sls_prd_key = gp.product_number
LEFT JOIN gold.dim_customers AS gc
ON ss.sls_cust_id = gc.customer_id