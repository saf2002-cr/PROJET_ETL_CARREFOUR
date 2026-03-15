-- ============================================
-- Carrefour E-commerce Data Warehouse Schema
-- ============================================
-- Purpose: Star Schema design for BI analytics
-- Author: Safaa Oussalem
-- Date: 2026-02-22
-- Version: 1.0
-- ============================================

-- Create Database
DROP DATABASE IF EXISTS carrefour_bi;
CREATE DATABASE carrefour_bi;
USE carrefour_bi;

-- ============================================
-- DIMENSION TABLES
-- ============================================

-- Dimension: Product
CREATE TABLE IF NOT EXISTS dim_product (
    product_sk INT AUTO_INCREMENT PRIMARY KEY,
    sku VARCHAR(150) NOT NULL,              -- Business Key (unique product identifier)
    item_id VARCHAR(50),                     -- Technical ID from source dataset
    brand VARCHAR(100),                      -- Extracted from SKU (oasis, Fantastic, mdeal...)
    category VARCHAR(100),                   -- Product category
    unit_price DECIMAL(10,2),                -- Unit price in currency
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY uk_sku (sku),
    INDEX idx_category (category),
    INDEX idx_brand (brand)
);

-- Dimension: Customer
CREATE TABLE IF NOT EXISTS dim_customer (
    customer_sk INT AUTO_INCREMENT PRIMARY KEY,
    customer_hash VARCHAR(100),              -- MD5 hash (gender_age_city) for unique identification
    gender VARCHAR(20),                      -- Customer gender
    age INT,                                 -- Customer age
    city VARCHAR(100),                       -- Customer city
    region VARCHAR(100),                     -- Region derived from city (e.g., Cairo → Greater Cairo)
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY uk_customer_hash (customer_hash),
    INDEX idx_city (city),
    INDEX idx_gender (gender)
);

-- Dimension: Date
CREATE TABLE IF NOT EXISTS dim_date (
    date_key DATE PRIMARY KEY,
    day INT,
    month INT,
    year INT,
    quarter VARCHAR(2),
    month_name VARCHAR(20),
    day_name VARCHAR(20),
    is_weekend BOOLEAN,
    is_month_start BOOLEAN,
    is_month_end BOOLEAN
);

-- Dimension: Payment Method
CREATE TABLE IF NOT EXISTS dim_payment (
    payment_sk INT AUTO_INCREMENT PRIMARY KEY,
    payment_method VARCHAR(50) UNIQUE,       -- Payment method (cod, credit_card, wallet...)
    description VARCHAR(255)                 -- Payment method description
);

-- Dimension: Order Status
CREATE TABLE IF NOT EXISTS dim_order_status (
    status_sk INT AUTO_INCREMENT PRIMARY KEY,
    status_code VARCHAR(50) UNIQUE,          -- Status from source (received, complete, cancelled...)
    status_group VARCHAR(50),                -- Aggregated status (completed, pending, cancelled)
    description VARCHAR(255)                 -- Status description
);

-- ============================================
-- FACT TABLE
-- ============================================

-- Fact: Sales Transactions
CREATE TABLE IF NOT EXISTS fact_sales (
    sale_sk BIGINT AUTO_INCREMENT PRIMARY KEY,
    order_id VARCHAR(100) NOT NULL,          -- Business Key from source
    product_sk INT,                          -- FK to dim_product
    customer_sk INT,                         -- FK to dim_customer
    date_key DATE,                           -- FK to dim_date
    payment_sk INT,                          -- FK to dim_payment
    status_sk INT,                           -- FK to dim_order_status
    
    -- Metrics (calculated in ETL)
    line_total DECIMAL(12,2),                -- qty_ordered * unit_price
    net_sales DECIMAL(12,2),                 -- line_total - discount_amount
    
    -- Metadata
    cancellation_reason VARCHAR(255),        -- Reason for cancellation/refund
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Foreign Key Constraints
    FOREIGN KEY (product_sk) REFERENCES dim_product(product_sk),
    FOREIGN KEY (customer_sk) REFERENCES dim_customer(customer_sk),
    FOREIGN KEY (date_key) REFERENCES dim_date(date_key),
    FOREIGN KEY (payment_sk) REFERENCES dim_payment(payment_sk),
    FOREIGN KEY (status_sk) REFERENCES dim_order_status(status_sk),
    
    -- Performance Indexes
    INDEX idx_order (order_id),
    INDEX idx_date (date_key),
    INDEX idx_product (product_sk),
    INDEX idx_customer (customer_sk)
);

-- ============================================
-- END OF SCHEMA
-- ============================================
