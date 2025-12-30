/*
=====================================================================
 Create Database and Schemas
=====================================================================

 Script Purpose:
 --------------------------------------------------------------------
 This script initializes a new Data Warehouse environment by:
   1. Checking whether a database named 'DataWarehouse' already exists
   2. Dropping the database if it exists (after forcing single-user mode)
   3. Recreating the 'DataWarehouse' database
   4. Creating three logical schemas to support a medallion architecture:
        - bronze : Raw / source-level data
        - silver : Cleaned and transformed data
        - gold   : Business-ready, aggregated data

 WARNING:
 --------------------------------------------------------------------
 Running this script will DROP the entire 'DataWarehouse' database
 if it already exists.

 All existing data will be permanently deleted.
 Ensure you have proper backups before executing this script.

 Intended Use:
 --------------------------------------------------------------------
 - Initial environment setup
 - Development / learning environments
 - Re-initializing the data warehouse from scratch

=====================================================================
*/

USE master;
GO

/*---------------------------------------------------------------
 Drop and recreate the 'DataWarehouse' database if it exists
---------------------------------------------------------------*/
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN 
    -- Force single-user mode to terminate existing connections
    ALTER DATABASE DataWarehouse 
    SET SINGLE_USER WITH ROLLBACK IMMEDIATE;

    -- Drop the existing database
    DROP DATABASE DataWarehouse;
END;
GO

/*---------------------------------------------------------------
 Create Database: DataWarehouse
---------------------------------------------------------------*/
CREATE DATABASE DataWarehouse;
GO

/*---------------------------------------------------------------
 Switch context to the newly created database
---------------------------------------------------------------*/
USE DataWarehouse;
GO

/*---------------------------------------------------------------
 Create Schemas (Medallion Architecture)
---------------------------------------------------------------*/

-- Bronze schema: raw ingestion layer
CREATE SCHEMA bronze;
GO

-- Silver schema: cleaned and transformed data layer
CREATE SCHEMA silver;
GO

-- Gold schema: business-level aggregates and analytics layer
CREATE SCHEMA gold;
GO
