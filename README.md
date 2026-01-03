# sql-data-warehouse-analytics
# SQL Data Warehouse & Advanced Analytics Project

## 📌 Project Overview

This project demonstrates the **end-to-end design and implementation of a modern SQL-based Data Warehouse**, following **Bronze → Silver → Gold** layered architecture. It covers raw data ingestion, data cleansing, transformation, modeling (Star Schema), and advanced analytical querying for business insights.

The project is built using **SQL Server** and focuses on **real-world analytics use cases**, making it suitable for **Data Analyst / Analytics Engineer / Data Engineer portfolios**.

---

**Project Goal:**  
To build a structured, scalable data warehouse and generate meaningful business insights using SQL.

---


## 🏗️ Architecture Overview

```
Source Files (CSV)
        ↓
Bronze Layer (Raw Ingestion)
        ↓
Silver Layer (Cleaned & Standardized)
        ↓
Gold Layer (Star Schema & Analytics)


- **Bronze Layer:** Loads raw ERP & CRM data without transformations.
- **Silver Layer:** Standardizes, cleans, deduplicates, and validates.
- **Gold Layer:** Business-ready schema with dimension & fact structures.

---

## 📁 Repository Structure


```

### 🔹 Bronze Layer

* Raw ingestion of CRM and ERP CSV files
* No transformations
* Full refresh using `TRUNCATE + BULK INSERT`

### 🔹 Silver Layer

* Data cleansing and standardization
* Deduplication and data validation
* Handling invalid dates, NULLs, and inconsistencies

### 🔹 Gold Layer

* Business-ready **Dimensions & Fact tables (Star Schema)**
* Optimized for analytics and reporting

---

## 📂 Project Structure

```
├── datasets/ # Source ERP & CRM CSV files
├── docs/ # Supporting documentation
├── scripts/ # Stored procedures and ETL logic
│ ├── bronze/ # Bronze layer code
│ ├── silver/ # Silver layer code
│ └── gold/ # Gold layer code
├── tests/ # Data quality & validation scripts
├── 01_database_exploration.sql # Metadata & structure queries
├── 02_dimensions_exploration.sql # Dimension analytics
├── 03_date_range_exploration.sql # Time span queries
├── 04_measures_exploration.sql # Numeric measure analysis
├── 05_magnitude_analysis.sql # Volume & total magnitude
├── 06_ranking_analysis.sql # Ranked insights
├── 07_change_over_time_analysis.sql # Trend analysis
├── 08_cumulative_analysis.sql # Cumulative metrics
├── 09_performance_analysis.sql # Performance comparisons
├── 10_data_segmentation.sql # Segmentation analytics
├── 11_part_to_whole_analysis.sql # Contribution analysis
├── 12_report_customers.sql # Customer reports
├── 13_report_products.sql # Product reports
├── README.md # Project overview (this file)
└── LICENSE # MIT License
```

---

## 🧱 Data Model (Gold Layer)

### ⭐ Dimensions

* `gold.dim_customers`
* `gold.dim_products`

### ⭐ Fact Table

* `gold.fact_sales`

**Model Type:** Star Schema
**Grain:** One row per product per order

---

## 📊 Analytics & SQL Use Cases

### 🔍 Exploration

* Database & schema exploration
* Column-level metadata analysis
* Dimension exploration

### 📈 Time-Based Analysis

* Date range validation
* Change-over-time analysis
* Cumulative metrics

### 📐 Business Analysis

* Magnitude analysis (counts, totals, averages)
* Ranking analysis (Top / Bottom N)
* Performance analysis
* Part-to-whole contribution
* Customer & product segmentation

### 🧠 Advanced SQL Concepts Used

* Window functions (`RANK`, `DENSE_RANK`, `ROW_NUMBER`, `SUM OVER`)
* CTEs and subqueries
* Data validation logic
* NULL handling (`COALESCE`, `NULLIF`)
* Date transformations

---

## ⚙️ Execution Order

1. Run **DDL scripts**

   * `ddl_bronze.sql`
   * `ddl_silver.sql`
   * `ddl_gold.sql`

2. Load data

   * `EXEC bronze.load_bronze`
   * `EXEC silver.load_silver`

3. Run analytics scripts

   * `01_database_exploration.sql` → `13_report_products.sql`

---

## 🧪 Data Quality & Validation

* Primary key uniqueness checks
* Referential integrity checks
* Invalid date and numeric validations
* Standardization of categorical values

---

## 🛠️ Tools & Technologies

* **SQL Server / SSMS**
* T-SQL
* CSV-based source systems
* Git & GitHub

---

## 🎯 Key Learnings

* Designing layered data warehouse architecture
* Implementing ETL using pure SQL
* Building analytics-ready star schemas
* Writing complex analytical SQL queries
* Applying real-world data quality rules

---

## 👤 Author

**Tanuj**
Aspiring Data Analyst / Data Scientist

---

⭐ *If you find this project helpful, feel free to star the repository!*

