# PROJET_ETL_CARREFOUR
- This project builds a complete Business Intelligence solution for analyzing Carrefour's e-commerce performance. It extracts raw transaction data from CSV files, transforms and cleans it through Pentaho ETL pipelines, loads structured data into a MySQL Star Schema Data Warehouse, and enables interactive analytics through Python dashboards.


# Architecture & Tools
- Source: Raw CSV datasets containing transaction history.

- ETL Tool: Pentaho Data Integration (PDI) used for data cleaning, handling missing values, and business logic implementation.

- Data Warehouse: MySQL used to host a structured Star Schema (Fact and Dimension tables).

- Analysis & Visualization: Python (Pandas, Matplotlib, Seaborn) for deep dive analysis and KPI tracking.

# Key Features
- Automated Cleaning: Removal of duplicates and normalization of dates/currencies via Pentaho.

- Star Schema Design: Optimized database structure for fast analytical queries.

- Business Intelligence:

     Sales trend analysis (Daily/Monthly).

     Top-performing product categories.

     Customer behavior patterns.

## ETL Pipelines

### 1️⃣ load_dim_product.ktr
*Product Dimension Loading Pipeline*

![ETL Flow](docs/etl_dim_product_flow.png)
*Figure 1: Pentaho ETL Transformation Flow for Product Dimension*

| Metric | Value |
|--------|-------|
| **Source** | Carrefour CSV (64,006 rows) |
| **Target** | `dim_product` (MySQL) |
| **Key Fields** | `sku`, `item_id`, `category`, `unit_price` |
| **Transformations** | Field filtering, type conversion (Integer→String), price→unit_price mapping |
| **Data Quality** | Duplicate SKU removal via Sort Rows + Unique Rows |
| **Performance** | Batch inserts (1000 rows/commit) |
| **Status** | ✅ PRODUCTION READY |

**ETL Flow**:
