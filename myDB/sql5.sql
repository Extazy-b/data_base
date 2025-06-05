-- Найти компоненты 2019 года, которые есть хотя бы в одной сборке

SELECT *
FROM components c
WHERE c.release_year = 2019
    AND EXISTS (
        SELECT 1
        FROM build_items bi
        WHERE bi.component_id = c.id
    );