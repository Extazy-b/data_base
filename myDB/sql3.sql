-- Найти сборки легче 600Вт

SELECT 
    b.name AS build_name,
    COUNT(bi.component_id) AS components_count,
    SUM(c.price) AS total_price
FROM builds b
JOIN build_items bi ON b.id = bi.build_id
JOIN components c ON bi.component_id = c.id
GROUP BY b.id
HAVING b.power_usage < 600;
