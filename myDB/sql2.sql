-- Показать все категории и количество компонентов, включая пустые

SELECT 
    cat.name AS category_name,
    COUNT(c.id) AS component_count
FROM categories cat
LEFT JOIN components c ON cat.id = c.category_id
GROUP BY cat.id;