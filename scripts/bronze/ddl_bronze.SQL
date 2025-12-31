/*
=====================================================================
BRONZE LAYER – RAW SOURCE TABLE CREATION
=====================================================================

Script Purpose:
---------------
This script creates raw ingestion tables in the BRONZE schema.
These tables represent data extracted directly from source systems
(CRM and ERP) with minimal to no transformations applied.

Design Principles:
------------------
- Tables store raw, source-aligned data
- No business logic or aggregations applied
- Used as the foundation for SILVER layer transformations
- Supports traceability and data lineage

WARNING:
--------
Running this script will DROP existing tables in the BRONZE schema
(if they exist) and recreate them.
Ensure no critical downstream processes depend on these tables
before execution.

=====================================================================
*/

/*-------------------------------------------------------------------
 CRM CUSTOMER INFORMATION – RAW DATA
-------------------------------------------------------------------*/
IF OBJECT_ID('bronze.crm_cust_info', 'U') IS NOT NULL
	DROP TABLE bronze.crm_cust_info;
GO

CREATE TABLE bronze.crm_cust_info (
	cst_id INT,                          -- Customer identifier
	cst_key NVARCHAR(50),               -- Business/customer key from source system
	cst_firstname NVARCHAR(50),         -- Customer first name
	cst_lastname NVARCHAR(50),          -- Customer last name
	cst_marital_status NVARCHAR(50),    -- Marital status
	cst_gndr NVARCHAR(50),              -- Gender
	cst_create_date DATE                -- Customer creation date
);
GO

/*-------------------------------------------------------------------
 CRM PRODUCT INFORMATION – RAW DATA
-------------------------------------------------------------------*/
IF OBJECT_ID('bronze.crm_prd_info', 'U') IS NOT NULL
	DROP TABLE bronze.crm_prd_info;
GO

CREATE TABLE bronze.crm_prd_info (
	prd_id INT,                         -- Product identifier
	prd_key NVARCHAR(50),              -- Product business key
	prd_nm NVARCHAR(50),               -- Product name
	prd_cost INT,                      -- Product cost
	prd_line NVARCHAR(50),             -- Product line/category
	prd_start_dt DATETIME,             -- Product effective start date
	prd_end_dt DATETIME                -- Product effective end date
);
GO

/*-------------------------------------------------------------------
 CRM SALES TRANSACTION DETAILS – RAW DATA
-------------------------------------------------------------------*/
IF OBJECT_ID('bronze.crm_sales_details', 'U') IS NOT NULL
	DROP TABLE bronze.crm_sales_details;
GO

CREATE TABLE bronze.crm_sales_details (
	sls_ord_num NVARCHAR(50),           -- Sales order number
	sls_prd_key NVARCHAR(50),           -- Product key
	sls_cust_id INT,                    -- Customer ID
	sls_order_dt INT,                   -- Order date (YYYYMMDD format)
	sls_ship_dt INT,                    -- Shipping date (YYYYMMDD format)
	sls_due_dt INT,                     -- Due date (YYYYMMDD format)
	sls_sales INT,                      -- Total sales amount
	sls_quantity INT,                   -- Quantity sold
	sls_price INT                       -- Price per unit
);
GO

/*-------------------------------------------------------------------
 ERP LOCATION MASTER – RAW DATA
-------------------------------------------------------------------*/
IF OBJECT_ID('bronze.erp_loc_a101', 'U') IS NOT NULL
	DROP TABLE bronze.erp_loc_a101;
GO

CREATE TABLE bronze.erp_loc_a101 (
	cid NVARCHAR(50),                   -- Customer identifier
	cntry NVARCHAR(50)                  -- Country
);
GO

/*-------------------------------------------------------------------
 ERP CUSTOMER MASTER – RAW DATA
-------------------------------------------------------------------*/
IF OBJECT_ID('bronze.erp_cust_az12', 'U') IS NOT NULL
	DROP TABLE bronze.erp_cust_az12;
GO

CREATE TABLE bronze.erp_cust_az12 (
	cid NVARCHAR(50),                   -- Customer identifier
	bdate DATE,                         -- Birth date
	gen NVARCHAR(50)                    -- Gender
);
GO

/*-------------------------------------------------------------------
 ERP PRODUCT CATEGORY MASTER – RAW DATA
-------------------------------------------------------------------*/
IF OBJECT_ID('bronze.erp_px_cat_g1v2', 'U') IS NOT NULL
	DROP TABLE bronze.erp_px_cat_g1v2;
GO

CREATE TABLE bronze.erp_px_cat_g1v2 (
	id NVARCHAR(50),                    -- Product identifier
	cat NVARCHAR(50),                   -- Product category
	subcat NVARCHAR(50),                -- Product sub-category
	maintenance NVARCHAR(50)            -- Maintenance indicator
);
GO
