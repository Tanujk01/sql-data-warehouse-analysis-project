/*
===============================================================================
Gold Layer – Quality & Integrity Checks
===============================================================================
Purpose:
    This script validates data quality and model integrity in the GOLD layer.
    The checks ensure that the analytical star schema is reliable and consistent.

Checks Covered:
    - Uniqueness of surrogate keys in dimension tables
    - Data standardization in dimensional attributes
    - Referential integrity between fact and dimension tables

Usage Notes:
    - Any returned rows indicate data quality issues.
    - Issues should be resolved before using GOLD layer for reporting.
===============================================================================
*/

-- ====================================================================
-- Dimension Validation: gold.dim_customers
-- ====================================================================

-- Check 1: Ensure surrogate customer_key is unique
-- Expectation: No rows returned
SELECT 
    customer_key,
    COUNT(*) AS duplicate_count
FROM gold.dim_customers
GROUP BY customer_key
HAVING COUNT(*) > 1;

-- Check 2: Validate standardized gender values
-- Purpose: Identify unexpected or inconsistent gender values
SELECT DISTINCT gender
FROM gold.dim_customers;

-- ====================================================================
-- Dimension Validation: gold.dim_products
-- ====================================================================

-- Check 3: Ensure surrogate product_key is unique
-- Expectation: No rows returned
SELECT 
    product_key,
    COUNT(*) AS duplicate_count
FROM gold.dim_products
GROUP BY product_key
HAVING COUNT(*) > 1;

-- ====================================================================
-- Fact-to-Dimension Integrity Check: gold.fact_sales
-- ====================================================================

-- Check 4: Validate referential integrity between fact and dimensions
-- Purpose:
--     Ensures every fact record maps to a valid customer and product.
-- Expectation: No rows returned
SELECT * 
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
    ON c.customer_key = f.customer_key
LEFT JOIN gold.dim_products p
    ON p.product_key = f.product_key
WHERE p.product_key IS NULL 
   OR c.customer_key IS NULL;
