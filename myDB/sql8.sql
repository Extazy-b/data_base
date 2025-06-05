-- Увеличить цену на 10% для комплектующих в сборках дороже $1500

UPDATE components
SET price = price * 1.1
WHERE id IN (
    SELECT bi.component_id
    FROM build_items bi
    JOIN builds b ON bi.build_id = b.id
    WHERE b.total_price > 1500
);