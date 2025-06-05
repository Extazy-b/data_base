-- Удалить все компоненты, которые не входят ни в одну сборку или были выпущены до 2020 года

DELETE FROM components
WHERE id IN (
    SELECT c.id
    FROM components c
    LEFT JOIN build_items bi ON c.id = bi.component_id
    WHERE (bi.build_id IS NULL
      OR c.release_year < 2020)
);