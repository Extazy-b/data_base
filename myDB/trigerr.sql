-- Если удаляется компонента, задействованная в сборке, то ей находится наиболее близкая по стоимости замена
-- Проверка совместимости при добавлении компонента в сборку
-- Перерасчет энергопотребления сборки при изменениях
-- Запрет удаления компонента, который используется в сборках

-- Триггер для автоматического расчета стоимости сборки
CREATE TRIGGER update_build_price
AFTER INSERT ON build_items
BEGIN
    UPDATE builds
    SET total_price = (
        SELECT SUM(c.price * bi.quantity)
        FROM build_items bi
        JOIN components c ON bi.component_id = c.id
        WHERE bi.build_id = NEW.build_id
    )
    WHERE id = NEW.build_id;
END;

-- Тригер для перерасчета стоимости сборки при изменении стоимость компоненты
CREATE TRIGGER update_build_price_on_component_change
AFTER UPDATE OF price ON components
FOR EACH ROW
WHEN OLD.price <> NEW.price
BEGIN
    UPDATE builds
    SET total_price = (
        SELECT SUM(c.price * bi.quantity)
        FROM build_items bi
        JOIN components c ON bi.component_id = c.id
        WHERE bi.build_id = builds.id
    )
    WHERE id IN (
        SELECT build_id
        FROM build_items
        WHERE component_id = NEW.id
    );
END;