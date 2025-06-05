-- Функции
-- Вычисляет общее энергопотребление сборки на основе TDP компонентов.
-- Проверяет совместимость двух компонентов (например, процессора и материнской платы).
-- Возвращает среднюю цену компонентов в указанной категории.
-- Форматирует информацию о компоненте в читаемый вид
-- Оценивает производительность сборки на основе характеристик компонентов (условный балл).


-- Процедуры
-- Применяет скидку ко всем компонентам указанной категории.
-- Переносит компоненты, выпущенные раньше указанного года, в архивную таблицу.
-- Создает отчет о совместимости компонентов и сохраняет его в отдельную таблицу.
-- Изменяет цены всех компонентов указанного производителя. 
-- Вывод самых новых и/или самых дешевых компонент в своей категории

CREATE FUNCTION GetMaxYear (@Category VARCHAR(20))
RETURNS numeric(3,2)
BEGIN
  DECLARE @Result numeric(3,2)
  SELECT @Result = max(SELECT release_year from components
			WHERE category_id= @Category)
  RETURN @ResultVar
END;

CREATE FUNCTION GetMinPrice (@Category VARCHAR(20))
RETURNS numeric(3,2)
BEGIN
  DECLARE @Result numeric(3,2)
  SELECT @Result = min(SELECT price from components
			WHERE category_id= @Category)
  RETURN @ResultVar
END;

CREATE PROCEDURE GetTheBest
AS
BEGIN
   SELECT name FROM components WHERE 
   com.release_year = GetMaxYear(category_id)
   OR
   com.price = GetMinPrice(category_id);
END
