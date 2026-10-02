-- ============================================================
-- RETAIL EVENTS SQL ANALYSIS
-- 20-Question SQL Assignment
-- Database: retail_events_db
-- SQL Dialect: MySQL
--
-- Author: Kshitij Chhabariya
--
-- Description:
-- Solutions to a 20-question SQL practice assignment covering
-- filtering, aggregation, JOINs, HAVING, CASE, CTEs, percentage
-- calculations, revenue analysis, and window functions.
-- ============================================================

-- ============================================================
-- Q1. Basic Filtering – High-Value Products
-- ============================================================
SELECT
    event_id,
    store_id,
    product_code,
    base_price,
    promo_type
FROM `retail_events_db`.fact_events
WHERE base_price > 1000;

-- ============================================================
-- Q2. Sorting Promotional Events
-- ============================================================
SELECT
    event_id,
    product_code,
    promo_type,
    `quantity_sold(before_promo)`,
    `quantity_sold(after_promo)`
FROM `retail_events_db`.fact_events
WHERE `quantity_sold(after_promo)` > 100
ORDER BY `quantity_sold(after_promo)` DESC;

-- ============================================================
-- Q3. DISTINCT Promotion Types
-- ============================================================
SELECT DISTINCT
    promo_type
FROM `retail_events_db`.fact_events;

-- ============================================================
-- Q4. Basic Aggregation
-- ============================================================
SELECT
    COUNT(event_id) AS `No. of Events`,
    SUM(`quantity_sold(before_promo)`) AS `Total sold before promo`,
    SUM(`quantity_sold(after_promo)`) AS `Total quantity sold after promo`,
    AVG(base_price) AS `Average base price`,
    MAX(base_price) AS `Maximum base price`,
    MIN(base_price) AS `Minimum base price`
FROM `retail_events_db`.fact_events;

-- ============================================================
-- Q5. Sales Volume by Promotion Type
-- ============================================================
SELECT
    COUNT(event_id) AS `No. of Events`,
    SUM(`quantity_sold(before_promo)`) AS `Total sold before promo`,
    SUM(`quantity_sold(after_promo)`) AS `Total quantity sold after promo`,
    promo_type
FROM `retail_events_db`.fact_events
GROUP BY promo_type
ORDER BY `Total quantity sold after promo` DESC;

-- ============================================================
-- Q6. Promotion Uplift
-- ============================================================
SELECT
    COUNT(event_id) AS `No. of Events`,
    SUM(`quantity_sold(before_promo)`) AS `Total sold before promo`,
    SUM(`quantity_sold(after_promo)`) AS `Total sold after promo`,
    SUM(`quantity_sold(after_promo)`)
        - SUM(`quantity_sold(before_promo)`) AS quantity_change,
    promo_type
FROM `retail_events_db`.fact_events
GROUP BY promo_type
ORDER BY quantity_change DESC;

-- ============================================================
-- Q7. Product Performance
-- ============================================================
SELECT
    f.product_code,
    p.product_name,
    p.category,
    SUM(f.`quantity_sold(after_promo)`) AS `total quantity after promotion`
FROM `retail_events_db`.fact_events AS f
LEFT JOIN `retail_events_db`.dim_products AS p
    ON f.product_code = p.product_code
GROUP BY
    f.product_code,
    p.product_name,
    p.category
ORDER BY `total quantity after promotion` DESC;

-- ============================================================
-- Q8. Category-Level Performance
-- ============================================================
SELECT
    COUNT(event_id) AS event_count,
    SUM(`quantity_sold(before_promo)`) AS total_quantity_before_promo,
    SUM(`quantity_sold(after_promo)`) AS total_quantity_after_promo,
    SUM(`quantity_sold(after_promo)`)
        - SUM(`quantity_sold(before_promo)`) AS quantity_change,
    p.category
FROM `retail_events_db`.fact_events AS f
LEFT JOIN `retail_events_db`.dim_products AS p
    ON f.product_code = p.product_code
GROUP BY p.category
ORDER BY total_quantity_after_promo DESC;

-- ============================================================
-- Q9. Store Performance
-- ============================================================
SELECT
    COUNT(event_id) AS total_event,
    SUM(`quantity_sold(before_promo)`) AS total_before,
    SUM(`quantity_sold(after_promo)`) AS total_after,
    s.city
FROM `retail_events_db`.fact_events AS f
LEFT JOIN `retail_events_db`.dim_stores AS s
    ON f.store_id = s.store_id
GROUP BY s.city
ORDER BY total_after DESC;

-- ============================================================
-- Q10. Campaign Performance
-- ============================================================
SELECT
    COUNT(event_id) AS number_of_events,
    SUM(`quantity_sold(before_promo)`) AS total_before,
    SUM(`quantity_sold(after_promo)`) AS total_after,
    c.campaign_name,
    c.start_date,
    c.end_date
FROM `retail_events_db`.fact_events AS f
LEFT JOIN `retail_events_db`.dim_campaigns AS c
    ON f.campaign_id = c.campaign_id
GROUP BY
    c.campaign_name,
    c.start_date,
    c.end_date
ORDER BY total_after DESC;

-- ============================================================
-- Q11. Product Category with HAVING
-- ============================================================
SELECT
    AVG(f.base_price) AS average_base_price,
    SUM(f.`quantity_sold(after_promo)`) AS total_quantity_after_promo,
    p.category
FROM `retail_events_db`.fact_events AS f
LEFT JOIN `retail_events_db`.dim_products AS p
    ON f.product_code = p.product_code
GROUP BY p.category
HAVING total_quantity_after_promo > 1000
ORDER BY total_quantity_after_promo DESC;

-- ============================================================
-- Q12. Store + Category Analysis
-- ============================================================
SELECT
    s.city,
    p.category,
    SUM(f.`quantity_sold(after_promo)`) AS total_quantity_after
FROM `retail_events_db`.dim_products AS p
LEFT JOIN `retail_events_db`.fact_events AS f
    ON p.product_code = f.product_code
LEFT JOIN `retail_events_db`.dim_stores AS s
    ON f.store_id = s.store_id
GROUP BY
    s.city,
    p.category
ORDER BY
    s.city ASC,
    total_quantity_after DESC;

-- ============================================================
-- Q13. Promotion Effectiveness by Product
-- ============================================================
SELECT
    p.product_name,
    p.category,
    SUM(f.`quantity_sold(before_promo)`) AS total_before,
    SUM(f.`quantity_sold(after_promo)`) AS total_after,
    SUM(f.`quantity_sold(after_promo)`)
        - SUM(f.`quantity_sold(before_promo)`) AS quantity_change,
    (
        SUM(f.`quantity_sold(after_promo)`)
        - SUM(f.`quantity_sold(before_promo)`)
    ) * 100 / NULLIF(SUM(f.`quantity_sold(before_promo)`), 0)
        AS percentage_change
FROM `retail_events_db`.fact_events AS f
LEFT JOIN `retail_events_db`.dim_products AS p
    ON f.product_code = p.product_code
GROUP BY
    p.product_name,
    p.category
ORDER BY percentage_change DESC;

-- ============================================================
-- Q14. Campaign and Promotion Type Analysis
-- ============================================================
SELECT
    COUNT(f.event_id) AS number_of_events,
    c.campaign_name,
    f.promo_type,
    SUM(f.`quantity_sold(before_promo)`) AS total_before,
    SUM(f.`quantity_sold(after_promo)`) AS total_after,
    SUM(f.`quantity_sold(after_promo)`)
        - SUM(f.`quantity_sold(before_promo)`) AS quantity_change
FROM `retail_events_db`.fact_events AS f
LEFT JOIN `retail_events_db`.dim_campaigns AS c
    ON f.campaign_id = c.campaign_id
GROUP BY
    c.campaign_name,
    f.promo_type
ORDER BY
    c.campaign_name ASC,
    quantity_change DESC;

-- ============================================================
-- Q15. Product Revenue Before and After Promotion
-- ============================================================
SELECT
    p.product_name,
    p.category,
    SUM(f.base_price * f.`quantity_sold(before_promo)`) AS revenue_before,
    SUM(f.base_price * f.`quantity_sold(after_promo)`) AS revenue_after,
    SUM(f.base_price * f.`quantity_sold(after_promo)`)
        - SUM(f.base_price * f.`quantity_sold(before_promo)`)
        AS revenue_difference
FROM `retail_events_db`.fact_events AS f
LEFT JOIN `retail_events_db`.dim_products AS p
    ON f.product_code = p.product_code
GROUP BY
    p.product_name,
    p.category
ORDER BY revenue_difference DESC;

-- ============================================================
-- Q16. Classify Promotion Performance
-- ============================================================
SELECT
    promo_type,
    total_before,
    total_after,
    percentage_change,
    CASE
        WHEN percentage_change >= 50 THEN 'High Impact'
        WHEN percentage_change >= 20 THEN 'Medium Impact'
        ELSE 'Low Impact'
    END AS performance_category
FROM (
    SELECT
        promo_type,
        SUM(`quantity_sold(before_promo)`) AS total_before,
        SUM(`quantity_sold(after_promo)`) AS total_after,
        (
            SUM(`quantity_sold(after_promo)`)
            - SUM(`quantity_sold(before_promo)`)
        ) * 100.0
        / NULLIF(SUM(`quantity_sold(before_promo)`), 0)
            AS percentage_change
    FROM `retail_events_db`.fact_events
    GROUP BY promo_type
) AS results
ORDER BY percentage_change DESC;

-- ============================================================
-- Q17. Top Products Within Each Category
-- ============================================================
WITH product_totals AS (
    SELECT
        dp.category,
        dp.product_name,
        SUM(fe.`quantity_sold(after_promo)`) AS total_quantity_after
    FROM `retail_events_db`.fact_events AS fe
    LEFT JOIN `retail_events_db`.dim_products AS dp
        ON fe.product_code = dp.product_code
    GROUP BY
        dp.category,
        dp.product_name
),
ranked_products AS (
    SELECT
        category,
        product_name,
        total_quantity_after,
        DENSE_RANK() OVER (
            PARTITION BY category
            ORDER BY total_quantity_after DESC
        ) AS category_rank
    FROM product_totals
)
SELECT
    category,
    product_name,
    total_quantity_after,
    category_rank
FROM ranked_products
WHERE category_rank <= 2
ORDER BY
    category,
    category_rank;

-- ============================================================
-- Q18. Best-Performing Stores Within Each City
-- ============================================================
WITH stores_total AS (
    SELECT
        s.store_id,
        s.city,
        SUM(f.`quantity_sold(after_promo)`) AS total_quantity_after
    FROM `retail_events_db`.fact_events AS f
    LEFT JOIN `retail_events_db`.dim_stores AS s
        ON f.store_id = s.store_id
    GROUP BY
        s.store_id,
        s.city
),
ranking_store AS (
    SELECT
        store_id,
        city,
        total_quantity_after,
        RANK() OVER (
            PARTITION BY city
            ORDER BY total_quantity_after DESC
        ) AS city_rank
    FROM stores_total
)
SELECT
    store_id,
    city,
    total_quantity_after,
    city_rank
FROM ranking_store
WHERE city_rank <= 2
ORDER BY
    city,
    city_rank;

-- ============================================================
-- Q19. Campaign-Level Product Performance
-- ============================================================
WITH campaign_product AS (
    SELECT
        c.campaign_name,
        p.product_name,
        SUM(f.`quantity_sold(before_promo)`) AS total_before,
        SUM(f.`quantity_sold(after_promo)`) AS total_after,
        SUM(f.`quantity_sold(after_promo)`)
            - SUM(f.`quantity_sold(before_promo)`) AS quantity_change,
        (
            SUM(f.`quantity_sold(after_promo)`)
            - SUM(f.`quantity_sold(before_promo)`)
        ) * 100
        / NULLIF(SUM(f.`quantity_sold(before_promo)`), 0)
            AS percentage_change
    FROM `retail_events_db`.dim_campaigns AS c
    LEFT JOIN `retail_events_db`.fact_events AS f
        ON c.campaign_id = f.campaign_id
    LEFT JOIN `retail_events_db`.dim_products AS p
        ON f.product_code = p.product_code
    GROUP BY
        c.campaign_name,
        p.product_name
),
ranking_campaign_product AS (
    SELECT
        campaign_name,
        product_name,
        total_before,
        total_after,
        quantity_change,
        percentage_change,
        ROW_NUMBER() OVER (
            PARTITION BY campaign_name
            ORDER BY percentage_change DESC
        ) AS campaign_rank
    FROM campaign_product
)
SELECT
    campaign_name,
    product_name,
    total_before,
    total_after,
    quantity_change,
    percentage_change,
    campaign_rank
FROM ranking_campaign_product
WHERE campaign_rank <= 3
ORDER BY
    campaign_name,
    campaign_rank;

-- ============================================================
-- Q20. Complete Promotional Performance Analysis
-- ============================================================
WITH product_performance AS (
    SELECT
        p.product_name,
        p.category,
        COUNT(f.event_id) AS number_of_promo_events,
        SUM(f.`quantity_sold(before_promo)`) AS total_quantity_before_promo,
        SUM(f.`quantity_sold(after_promo)`) AS total_quantity_after_promo,
        SUM(f.`quantity_sold(after_promo)`)
            - SUM(f.`quantity_sold(before_promo)`) AS quantity_change,
        (
            SUM(f.`quantity_sold(after_promo)`)
            - SUM(f.`quantity_sold(before_promo)`)
        ) * 100
        / NULLIF(SUM(f.`quantity_sold(before_promo)`), 0)
            AS percentage_change,
        SUM(f.base_price * f.`quantity_sold(before_promo)`)
            AS revenue_before_promotion,
        SUM(f.base_price * f.`quantity_sold(after_promo)`)
            AS revenue_after_promotion,
        SUM(f.base_price * f.`quantity_sold(after_promo)`)
            - SUM(f.base_price * f.`quantity_sold(before_promo)`)
            AS revenue_change,
        AVG(f.base_price) AS average_base_price
    FROM `retail_events_db`.fact_events AS f
    LEFT JOIN `retail_events_db`.dim_products AS p
        ON f.product_code = p.product_code
    GROUP BY
        p.product_name,
        p.category
),
final_product_performance AS (
    SELECT
        product_name,
        category,
        number_of_promo_events,
        total_quantity_before_promo,
        total_quantity_after_promo,
        quantity_change,
        percentage_change,
        revenue_before_promotion,
        revenue_after_promotion,
        revenue_change,
        average_base_price,
        DENSE_RANK() OVER (
            PARTITION BY category
            ORDER BY revenue_change DESC
        ) AS rank_product_performance
    FROM product_performance
)
SELECT
    product_name,
    category,
    number_of_promo_events,
    total_quantity_before_promo,
    total_quantity_after_promo,
    quantity_change,
    percentage_change,
    revenue_before_promotion,
    revenue_after_promotion,
    revenue_change,
    average_base_price,
    rank_product_performance
FROM final_product_performance
WHERE rank_product_performance <= 2
ORDER BY
    category,
    rank_product_performance;
