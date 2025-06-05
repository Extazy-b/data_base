-- список всех возможных сборок (по совместимости) из представленных копонентов
-- таблица компонентов совместимых с каждой материнской платой, упорядоченная в порядке года выпуска
-- возможные составы корзины не дороже заданной стоимости
-- список компонент и их основных характеристик

CREATE VIEW components_summary AS
SELECT 
    c.name AS component,
    cat.name AS category,
    c.price,
    c.release_year
FROM components c
JOIN categories cat ON c.category_id = cat.id;