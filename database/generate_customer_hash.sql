-- ============================================
-- Generate MD5 Hash for Customer Dimension
-- ============================================
-- Purpose: Create unique customer_hash from 
--          gender, age, and city combination
-- Usage: Run AFTER load_dim_customer.ktr execution
-- ============================================

USE carrefour_bi;

-- Disable safe update mode for bulk update
SET SQL_SAFE_UPDATES = 0;

-- Generate MD5 hash for all customers without hash
UPDATE dim_customer 
SET customer_hash = MD5(CONCAT(gender, '_', age, '_', city))
WHERE customer_hash IS NULL;

-- Re-enable safe update mode
SET SQL_SAFE_UPDATES = 1;

-- ============================================
-- Verification Queries
-- ============================================

-- View sample data with generated hashes
SELECT 
    customer_sk, 
    customer_hash, 
    gender, 
    age, 
    city 
FROM dim_customer 
LIMIT 10;

-- Check for duplicate hashes (0 rows)
SELECT customer_hash, COUNT(*) as count
FROM dim_customer
GROUP BY customer_hash
HAVING count > 1;

-- Verify no NULL hashes remain
SELECT COUNT(*) AS null_hashes 
FROM dim_customer 
WHERE customer_hash IS NULL;
