/*
============================================================================
Quality Checks
============================================================================

Script Purpose:
This script performs quality checks to validate the integrity, consistency,
and accuracy of the Gold Layer. These checks ensure:
- Unitiphess of surrogate keys in dimension tables.
Referential integrity between fact and dimension tables.
- Validation of relationships in the data model for analytical purposes.

Usage Notes:
- Run these checks after loading the Gold Layer.
- Investigate and resolve any discrepancies found during the checks.
============================================================================

*/
-- Check for Uniqueness of Customer Key in gold.dim_customers
-- Expectation: No results
SELECT
customer_key,
COUNT(*) AS duplicate_count
FROM gold.dim_customers
GROUP BY customer_key
HAVING COUNT(*) > 1;

-- Foreign Key Integrity (Dimensions)
SELECT * FROM gold.fact_sales s
LEFT JOIN gold.dim_customers c
ON s.customer_key = c.customer_key
LEFT JOIN gold.dim_products p
ON s.product_key = p.product_key
WHERE c.customer_key IS NULL OR p.product_key IS NULL
