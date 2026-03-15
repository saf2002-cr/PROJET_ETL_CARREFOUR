-- ============================================
-- Reset Database for Development
-- ============================================
-- Purpose: Truncate all tables for clean ETL reload
-- ============================================

USE carrefour_bi;

-- Disable foreign key checks
SET FOREIGN_KEY_CHECKS = 0;

-- Truncate all tables (order doesn't matter with FK checks disabled)
TRUNCATE TABLE fact_sales;
TRUNCATE TABLE dim_customer;
TRUNCATE TABLE dim_product;
TRUNCATE TABLE dim_date;
TRUNCATE TABLE dim_payment;
TRUNCATE TABLE dim_order_status;

-- Re-enable foreign key checks
SET FOREIGN_KEY_CHECKS = 1;

-- ============================================
-- Verification
-- ============================================

SELECT 'dim_product' AS table_name, COUNT(*) AS row_count FROM dim_product
UNION ALL
SELECT 'dim_customer', COUNT(*) FROM dim_customer
UNION ALL
SELECT 'dim_date', COUNT(*) FROM dim_date
UNION ALL
SELECT 'dim_payment', COUNT(*) FROM dim_payment
UNION ALL
SELECT 'dim_order_status', COUNT(*) FROM dim_order_status
UNION ALL
SELECT 'fact_sales', COUNT(*) FROM fact_sales;
