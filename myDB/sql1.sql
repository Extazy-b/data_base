-- Найти среднюю цену видеокарт NVIDIA в сборках мощностью более 400 Вт

SELECT 
    c.name AS component_name,
    ROUND(AVG(c.price), 2) AS avg_price,
    COUNT(bi.build_id) AS build_count
FROM components c
JOIN build_items bi ON c.id = bi.component_id
JOIN builds b ON bi.build_id = b.id
JOIN categories cat ON c.category_id = cat.id
WHERE cat.name = 'Видеокарты'
    AND c.manufacturer = 'NVIDIA'
    AND b.power_usage > 400

