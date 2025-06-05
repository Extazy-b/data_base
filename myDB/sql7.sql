-- Объединенный список названий компонентов и сборок

SELECT name AS item_name, 'component' AS type 
FROM components
UNION ALL
SELECT name, 'build' 
FROM builds
ORDER BY type, item_name;