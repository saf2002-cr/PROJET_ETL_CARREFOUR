-- ============================================
-- Populate dim_date Table because fact_sales will have a FK to dim_date
-- ============================================
USE carrefour_bi;

-- Insérer les dates de 2020 et 2021 (période du dataset)
INSERT INTO dim_date (date_key, day, month, year, quarter, month_name, day_name, is_weekend, is_month_start, is_month_end)
SELECT 
    d AS date_key,
    DAY(d) AS day,
    MONTH(d) AS month,
    YEAR(d) AS year,
    CONCAT('Q', QUARTER(d)) AS quarter,
    MONTHNAME(d) AS month_name,
    DAYNAME(d) AS day_name,
    (WEEKDAY(d) >= 5) AS is_weekend,
    (DAY(d) = 1) AS is_month_start,
    (LAST_DAY(d) = d) AS is_month_end
FROM (
    SELECT DATE('2020-01-01') + INTERVAL n DAY AS d
    FROM (
        SELECT a.N + b.N * 10 + c.N * 100 AS n
        FROM 
            (SELECT 0 AS N UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) a,
            (SELECT 0 AS N UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) b,
            (SELECT 0 AS N UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) c
    ) numbers
    WHERE DATE('2020-01-01') + INTERVAL n DAY <= DATE('2021-12-31')
) dates;

-- Vérification
SELECT COUNT(*) AS total_dates FROM dim_date;
SELECT * FROM dim_date LIMIT 10;
