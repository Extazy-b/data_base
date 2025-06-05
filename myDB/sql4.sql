-- Вывести процессоры, совместимые с материнской платой ASUS ROG

SELECT *
FROM components
WHERE category_id = (SELECT id FROM categories WHERE name = 'Процессоры')
    AND id IN (
        SELECT source_id
        FROM compatibilities
        WHERE target_id = (SELECT id FROM components WHERE name LIKE 'ASUS ROG%')
    );