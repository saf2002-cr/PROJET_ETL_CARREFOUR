CREATE DATABASE carrefour_bi;
USE carrefour_bi;
--- DIMENSION PRODUIT
CREATE TABLE IF NOT EXISTS dim_product(
	 product_sk INT AUTO_INCREMENT PRIMARY KEY,
    sku VARCHAR(150) NOT NULL,              -- Business Key (ex: oasis_Oasis-064-36)
    item_id VARCHAR(50),                     -- ID technique du dataset
    brand VARCHAR(100),                      -- Extrait du SKU : oasis, Fantastic, mdeal...
    category VARCHAR(100),
    unit_price DECIMAL(10,2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY uk_sku (sku),
    INDEX idx_category (category),
    INDEX idx_brand (brand)
);

--- DIMENSION CLIENTS
CREATE TABLE IF NOT EXISTS dim_customer (
    customer_sk INT AUTO_INCREMENT PRIMARY KEY,
    customer_hash VARCHAR(100),              -- Hash anonymisé (âge+ville+genre) car pas d'ID client
    gender VARCHAR(20),
    age INT,
    city VARCHAR(100),
    region VARCHAR(100),                     -- À déduire de la ville (ex: Cairo → Greater Cairo)
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_city (city),
    INDEX idx_gender (gender)
);
--- DIMENSION TEMPS
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

--- Dimension Paiement
 CREATE TABLE IF NOT EXISTS dim_payment (
    payment_sk INT AUTO_INCREMENT PRIMARY KEY,
    payment_method VARCHAR(50) UNIQUE,       -- cod, credit_card, wallet...
    description VARCHAR(255)
);

--- Dimension Statut Commande 
CREATE TABLE IF NOT EXISTS dim_order_status (
    status_sk INT AUTO_INCREMENT PRIMARY KEY,
    status_code VARCHAR(50) UNIQUE,          -- received, complete, cancelled...
    status_group VARCHAR(50),                -- completed, pending, cancelled (pour agrégation)
    description VARCHAR(255)
);

--- tablede FAITS
CREATE TABLE IF NOT EXISTS fact_sales (
    sale_sk BIGINT AUTO_INCREMENT PRIMARY KEY,
    order_id VARCHAR(100) NOT NULL,          -- Business Key
    product_sk INT,
    customer_sk INT,
    date_key DATE,
    payment_sk INT,
    status_sk INT,
    
    line_total DECIMAL(12,2),      -- métriques à gérer dans pentaho (qty * unit_price)
    net_sales DECIMAL(12,2),                 --  et (line_total - discount_amount)
    
    cancellation_reason VARCHAR(255), -- metadonnées
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (product_sk) REFERENCES dim_product(product_sk), 
    FOREIGN KEY (customer_sk) REFERENCES dim_customer(customer_sk),
    FOREIGN KEY (date_key) REFERENCES dim_date(date_key),
    FOREIGN KEY (payment_sk) REFERENCES dim_payment(payment_sk),
    FOREIGN KEY (status_sk) REFERENCES dim_order_status(status_sk),
    
    -- Index pour performance
    INDEX idx_order (order_id),
    INDEX idx_date (date_key),
    INDEX idx_product (product_sk),
    INDEX idx_customer (customer_sk)
);
