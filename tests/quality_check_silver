/*Quality Checks

Script Purpose:
This script performs various quality checks for data consistency, accuracy,
and standardization across the 'silver' schemas. It includes checks for:
- Null or duplicate primary keys.
- Unwanted spaces in string fields.
- Data standardization and consistency.
- Invalid date ranges and orders.
- Data consistency between related fields.

Usage Notes:
- Run these checks after data loading Silver Layer.
- Investigate and resolve any discrepancies found during the checks.

*/

-- Check For Nulls or Duplicates in Primary Key
-- Expectation: No Result

SELECT
	prd_id,
	COUNT(*)
FROM silver.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1 OR prd_id IS NULL

-- Check for unwanted spaces
-- Expectation: No Results
SELECT 
	prd_nm
FROM silver.crm_prd_info
WHERE prd_nm != TRIM(prd_nm)

-- Check for NULL or negative numbers
-- Expectation: No Results
SELECT 
	prd_cost
FROM silver.crm_prd_info
WHERE prd_cost IS NULL OR prd_cost < 0

-- Data Standardization & Consitency
SELECT DISTINCT prd_line
FROM silver.crm_prd_info

-- Check for Invalid Date Orders
SELECT 
*
FROM silver.crm_sales_details
WHERE sls_order_dt <= 0 OR LEN(sls_order_dt) != 8 OR sls_order_dt > 20500101

-- Check Data Consitency: Between Sales, Quantity and Price
-- >> Sales = Quantity * Price
-- >> Values must not be NULL, zero or negative
SELECT DISTINCT
    sls_sales,
	sls_quantity, 
	sls_price
FROM silver.crm_sales_details
WHERE sls_sales != sls_quantity * sls_price 
OR sls_sales IS NULL OR sls_quantity IS NULL OR sls_price IS NULL
OR sls_sales <= 0 OR sls_quantity <= 0 OR sls_price <= 0
ORDER BY sls_sales, sls_price

-- Identify Out-of-Range Dates
SELECT
	bdate
FROM silver.erp_cust_az12
WHERE bdate < '1924-01-01' OR bdate > GETDATE()

SELECT DISTINCT
cntry
FROM silver.erp_loc_a101


SELECT 
cid
FROM silver.erp_loc_a101
WHERE cid NOT IN (SELECT DISTINCT cst_key FROM silver.crm_cust_info)

