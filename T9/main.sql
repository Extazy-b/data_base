DROP VIEW IF EXISTS Dogs;
DROP VIEW IF EXISTS EmployeeRating;
DROP VIEW IF EXISTS Customers;


-- 1. Создание представления "Собаки"
CREATE VIEW Dogs AS
SELECT 
    p.Nick AS Кличка, 
    p.Breed AS Порода, 
    p.Age AS Возраст, 
    per.Last_Name AS Фамилия, 
    per.First_Name AS Имя
FROM 
    Pet p
JOIN 
    Owner o ON p.Owner_ID = o.Owner_ID
JOIN 
    Person per ON o.Person_ID = per.Person_ID
JOIN 
    Pet_Type pt ON p.Pet_Type_ID = pt.Pet_Type_ID
WHERE 
    pt.Name = 'DOG';

-- Получение списка пуделей: кличка, фамилия хозяина
SELECT Кличка, Фамилия 
FROM Dogs 
WHERE Порода = 'poodle';

-------------------------------------------------------------

-- 2. Создание представления "Рейтинг сотрудников"
CREATE VIEW EmployeeRating AS
SELECT 
    p.Last_Name AS Фамилия, 
    p.First_Name AS Имя, 
    COUNT(o.Order_ID) AS Количество_выполненных_заказов, 
    AVG(o.Mark) AS Средний_балл
FROM 
    Employee e
JOIN 
    Person p ON e.Person_ID = p.Person_ID
JOIN 
    Order1 o ON e.Employee_ID = o.Employee_ID AND o.Is_Done = 1
GROUP BY 
    p.Last_Name, p.First_Name;

-- Рейтинг с сортировкой по убыванию балла
SELECT * 
FROM EmployeeRating
ORDER BY Средний_балл DESC;

-------------------------------------------------------------

-- "Заказчики"
CREATE VIEW Customers AS
SELECT 
    p.Last_Name AS Фамилия, 
    p.First_Name AS Имя, 
    p.Phone AS Телефон, 
    p.Address AS Адрес
FROM 
    Person p
JOIN 
    Owner o ON p.Person_ID = o.Person_ID;

/* -- Обновление
UPDATE Customers
SET Адрес = '?'
WHERE Адрес IS NULL OR Адрес = ''; */

SELECT 
    Фамилия, 
    Имя, 
    Телефон, 
    CASE WHEN Адрес IS NULL OR Адрес = '' THEN '?' ELSE Адрес END AS Адрес
FROM 
    Customers;


