-- ============================================
-- Seed Reference Data for Dimensions
-- ============================================
-- Purpose: Populate dim_payment and dim_order_status
-- ============================================

USE carrefour_bi;

-- ============================================
-- Payment Methods
-- ============================================
INSERT INTO dim_payment (payment_method, description) VALUES
('cod', 'Cash on Delivery'),
('credit_card', 'Credit Card Payment'),
('debit_card', 'Debit Card Payment'),
('wallet', 'Digital Wallet (e.g., Vodafone Cash, Orange Cash)'),
('payaxis', 'PayAxis Payment Gateway'),
('easypay', 'EasyPay Payment Service'),
('fawry', 'Fawry Payment Service');

-- ============================================
-- Order Statuses
-- ============================================
INSERT INTO dim_order_status (status_code, status_group, description) VALUES
('received', 'pending', 'Order received but not yet processed'),
('complete', 'completed', 'Order successfully completed and delivered'),
('cancelled', 'cancelled', 'Order cancelled by customer or system'),
('order_refunded', 'cancelled', 'Order refunded after completion'),
('return', 'cancelled', 'Order returned by customer');

-- ============================================
-- Verification
-- ============================================
SELECT 'dim_payment' AS table_name, COUNT(*) AS row_count FROM dim_payment
UNION ALL
SELECT 'dim_order_status', COUNT(*) FROM dim_order_status;
