/*
=====================================================================
SILVER LAYER – RAW SOURCE TABLE CREATION
=====================================================================

Script Purpose:
---------------
This script creates raw ingestion tables in the silver schema.
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
Running this script will DROP existing tables in the silver schema
(if they exist) and recreate them.
Ensure no critical downstream processes depend on these tables
before execution.

=====================================================================
*/

/*-------------------------------------------------------------------
 CRM CUSTOMER INFORMATION – RAW DATA
-------------------------------------------------------------------*/
IF OBJECT_ID('silver.crm_cust_info', 'U') IS NOT NULL
	DROP TABLE silver.crm_cust_info;
GO

CREATE TABLE silver.crm_cust_info (
	cst_id INT,                         -- Customer identifier
	cst_key NVARCHAR(50),               -- Business/customer key from source system
	cst_firstname NVARCHAR(50),         -- Customer first name
	cst_lastname NVARCHAR(50),          -- Customer last name
	cst_marital_status NVARCHAR(50),    -- Marital status
	cst_gndr NVARCHAR(50),              -- Gender
	cst_create_date DATE,               -- Customer creation date
	dw_create_date DATETIME2 DEFAULT GETDATE()
);
GO

/*-------------------------------------------------------------------
 CRM PRODUCT INFORMATION – RAW DATA
-------------------------------------------------------------------*/

IF OBJECT_ID('silver.crm_prd_info', 'U') IS NOT NULL
	DROP TABLE silver.crm_prd_info;
GO
	
CREATE TABLE silver.crm_prd_info (
	prd_id INT,                        -- Product identifier
	cat_id NVARCHAR(50),               -- Category identifier
	prd_key NVARCHAR(50),              -- Product business key
	prd_nm NVARCHAR(50),               -- Product name
	prd_cost INT,                      -- Product cost
	prd_line NVARCHAR(50),             -- Product line/category
	prd_start_dt DATE,             -- Product effective start date
	prd_end_dt DATE,               -- Product effective end date
	dw_create_date DATETIME2 DEFAULT GETDATE()
);
GO

/*-------------------------------------------------------------------
 CRM SALES TRANSACTION DETAILS – RAW DATA
-------------------------------------------------------------------*/
IF OBJECT_ID('silver.crm_sales_details', 'U') IS NOT NULL
	DROP TABLE silver.crm_sales_details;
GO
	
CREATE TABLE silver.crm_sales_details (
	sls_ord_num NVARCHAR(50),           -- Sales order number
	sls_prd_key NVARCHAR(50),           -- Product key
	sls_cust_id INT,                    -- Customer ID
	sls_order_dt DATE,                   -- Order date (YYYYMMDD format)
	sls_ship_dt DATE,                    -- Shipping date (YYYYMMDD format)
	sls_due_dt DATE,                     -- Due date (YYYYMMDD format)
	sls_sales INT,                      -- Total sales amount
	sls_quantity INT,                   -- Quantity sold
	sls_price INT,                      -- Price per unit
	dw_create_date DATETIME2 DEFAULT GETDATE()
);
GO

/*-------------------------------------------------------------------
 ERP LOCATION MASTER – RAW DATA
-------------------------------------------------------------------*/
IF OBJECT_ID('silver.erp_loc_a101', 'U') IS NOT NULL
	DROP TABLE silver.erp_loc_a101;
GO
	
CREATE TABLE silver.erp_loc_a101 (
	cid NVARCHAR(50),                   -- Customer identifier
	cntry NVARCHAR(50),                 -- Country
	dw_create_date DATETIME2 DEFAULT GETDATE()
);
GO

/*-------------------------------------------------------------------
 ERP CUSTOMER MASTER – RAW DATA
-------------------------------------------------------------------*/
IF OBJECT_ID('silver.erp_cust_az12', 'U') IS NOT NULL
	DROP TABLE silver.erp_cust_az12;
GO
	
CREATE TABLE silver.erp_cust_az12 (
	cid NVARCHAR(50),                   -- Customer identifier
	bdate DATE,                         -- Birth date
	gen NVARCHAR(50),                   -- Gender
	dw_create_date DATETIME2 DEFAULT GETDATE()
);
GO

/*-------------------------------------------------------------------
 ERP PRODUCT CATEGORY MASTER – RAW DATA
-------------------------------------------------------------------*/
IF OBJECT_ID('silver.erp_px_cat_g1v2', 'U') IS NOT NULL
	DROP TABLE silver.erp_px_cat_g1v2;
GO
	
CREATE TABLE silver.erp_px_cat_g1v2 (
	id NVARCHAR(50),                    -- Product identifier
	cat NVARCHAR(50),                   -- Product category
	subcat NVARCHAR(50),                -- Product sub-category
	maintenance NVARCHAR(50),           -- Maintenance indicator
	dw_create_date DATETIME2 DEFAULT GETDATE()
);
GO
