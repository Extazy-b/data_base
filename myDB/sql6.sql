-- Найти пары совместимых процессоров и материнских плат

SELECT 
    cpu.name AS processor,
    mb.name AS motherboard
FROM compatibilities comp
JOIN components cpu ON comp.source_id = cpu.id
JOIN components mb ON comp.target_id = mb.id
JOIN categories cat_cpu ON cpu.category_id = cat_cpu.id
JOIN categories cat_mb ON mb.category_id = cat_mb.id
WHERE cat_cpu.name = 'Процессоры'
    AND cat_mb.name = 'Материнские платы'