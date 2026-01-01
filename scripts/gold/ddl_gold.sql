/*
===============================================================================
DDL Script: Create Gold Layer Views
===============================================================================
Purpose:
    This script creates business-ready views in the GOLD layer of the
    data warehouse. The GOLD layer represents the final dimensional
    and fact structures following a Star Schema design.

Gold Layer Responsibilities:
    - Provide clean, enriched, analytics-ready data
    - Combine and conform data from multiple Silver layer sources
    - Apply final business logic and calculations
    - Serve as the source for BI tools, dashboards, and reporting

Objects Created:
    - gold.dim_customers  : Customer dimension
    - gold.dim_products   : Product dimension
    - gold.fact_sales     : Sales fact table

Usage:
    - Query these views directly for reporting and analytics
    - No transformations should be applied downstream of Gold layer

===============================================================================
*/

-- =============================================================================
-- Dimension View: gold.dim_customers
-- Description:
--     Creates a customer dimension by combining CRM and ERP customer data.
--     - Generates a surrogate key
--     - Uses CRM as the primary source
--     - Falls back to ERP data when CRM values are missing
-- =============================================================================
IF OBJECT_ID('gold.dim_customers', 'V') IS NOT NULL
    DROP VIEW gold.dim_customers;
GO

CREATE VIEW gold.dim_customers AS
SELECT
    ROW_NUMBER() OVER (ORDER BY cst_id) AS customer_key,   -- Surrogate key
    ci.cst_id                          AS customer_id,
    ci.cst_key                         AS customer_number,
    ci.cst_firstname                   AS first_name,
    ci.cst_lastname                    AS last_name,
    la.cntry                           AS country,
    ci.cst_marital_status              AS marital_status,
    CASE 
        WHEN ci.cst_gndr != 'n/a' THEN ci.cst_gndr         -- CRM is primary source
        ELSE COALESCE(ca.gen, 'n/a')                       -- ERP fallback
    END                                AS gender,
    ca.bdate                           AS birthdate,
    ci.cst_create_date                 AS create_date
FROM silver.crm_cust_info ci
LEFT JOIN silver.erp_cust_az12 ca
    ON ci.cst_key = ca.cid
LEFT JOIN silver.erp_loc_a101 la
    ON ci.cst_key = la.cid;
GO

-- =============================================================================
-- Dimension View: gold.dim_products
-- Description:
--     Creates a product dimension with category enrichment.
--     - Generates a surrogate key
--     - Joins CRM product data with ERP category master
--     - Filters out historical (inactive) products
-- =============================================================================
IF OBJECT_ID('gold.dim_products', 'V') IS NOT NULL
    DROP VIEW gold.dim_products;
GO

CREATE VIEW gold.dim_products AS
SELECT
    ROW_NUMBER() OVER (ORDER BY pn.prd_start_dt, pn.prd_key) AS product_key,
    pn.prd_id       AS product_id,
    pn.prd_key      AS product_number,
    pn.prd_nm       AS product_name,
    pn.cat_id       AS category_id,
    pc.cat          AS category,
    pc.subcat       AS subcategory,
    pc.maintenance  AS maintenance,
    pn.prd_cost     AS cost,
    pn.prd_line     AS product_line,
    pn.prd_start_dt AS start_date
FROM silver.crm_prd_info pn
LEFT JOIN silver.erp_px_cat_g1v2 pc
    ON pn.cat_id = pc.id
WHERE pn.prd_end_dt IS NULL;  -- Keep only active products
GO

-- =============================================================================
-- Fact View: gold.fact_sales
-- Description:
--     Creates the sales fact table.
--     - Links sales transactions to customer and product dimensions
--     - Supports time-based and dimensional analytics
-- =============================================================================
IF OBJECT_ID('gold.fact_sales', 'V') IS NOT NULL
    DROP VIEW gold.fact_sales;
GO

CREATE VIEW gold.fact_sales AS
SELECT
    sd.sls_ord_num  AS order_number,
    pr.product_key  AS product_key,
    cu.customer_key AS customer_key,
    sd.sls_order_dt AS order_date,
    sd.sls_ship_dt  AS shipping_date,
    sd.sls_due_dt   AS due_date,
    sd.sls_sales    AS sales_amount,
    sd.sls_quantity AS quantity,
    sd.sls_price    AS price
FROM silver.crm_sales_details sd
LEFT JOIN gold.dim_products pr
    ON sd.sls_prd_key = pr.product_number
LEFT JOIN gold.dim_customers cu
    ON sd.sls_cust_id = cu.customer_id;
GO
