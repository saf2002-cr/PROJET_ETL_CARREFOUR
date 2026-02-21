# PROJET_ETL_CARREFOUR
- This project demonstrates a complete Data Engineering and Analytics pipeline. The goal is to transform raw, unorganized online sales data from Carrefour into a structured Data Warehouse to extract actionable business insights.

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
