-- Задание 1: Добавление пометки "(s)" в начало комментария для заказов, исполнитель которых – студент
UPDATE Order1
SET Comments = '(s) ' || COALESCE(Comments, '')
WHERE Employee_ID IN (
    SELECT Employee_ID 
    FROM Employee 
    WHERE Spec = 'student'
);

----------------------------------------------------------------------------------

-- Задание 2: Удаление всех невыполненных заказов по combing-у
DELETE FROM Order1
WHERE Service_ID IN (
    SELECT Service_ID
    FROM Service 
    WHERE Name = 'Combing'
) AND Is_Done = 0;

----------------------------------------------------------------------------------

-- Задание 3: Добавление нового физического лица с сохранением последовательной нумерации
INSERT INTO Person (Person_ID, Last_Name, First_Name, Phone, Address)
VALUES (
    (SELECT MAX(Person_ID) + 1 FROM Person),
    'Иванов',
    'Иван',
    '+7(800) 555-35-35',
    'г. Санкт-Петербург, ул. Пушкина, д. Колотушкинаен'
);

-----------------------------------------------------------------------------------

-- Создание новой таблицы для хранения данных о документах физ.лиц
CREATE TABLE Person_Documents (
    Document_ID INTEGER PRIMARY KEY,
    Person_ID INTEGER NOT NULL,
    Document_Type VARCHAR(20) NOT NULL,
    Document_Number VARCHAR(20) NOT NULL,
    CONSTRAINT FK_Person_Documents_Person 
    FOREIGN KEY (Person_ID) REFERENCES Person(Person_ID)
);

----------------------------------------------------------------------------------

-- Триггер для каскадного обновления документов при обновлении персоны
CREATE TRIGGER update_person_id
AFTER UPDATE OF Person_ID ON Person
FOR EACH ROW
BEGIN
    UPDATE Person_Documents
    SET Person_ID = NEW.Person_ID
    WHERE Person_ID = OLD.Person_ID;
END;

----------------------------------------------------------------------------------

-- Триггер для каскадного удаления документов при удалении персоны
CREATE TRIGGER delete_person_documents
BEFORE DELETE ON Person
FOR EACH ROW
BEGIN
    DELETE FROM Person_Documents
    WHERE Person_ID = OLD.Person_ID;
END;

----------------------------------------------------------------------------------

-- Добавление документов для нового физ.лица
INSERT INTO Person_Documents (Document_ID, Person_ID, Document_Type, Document_Number)
VALUES 
    (1, (SELECT MAX(Person_ID) FROM Person), 'Паспорт', '1234 567890'),
    (2, (SELECT MAX(Person_ID) FROM Person), 'Водительское удостоверение', '12AB 345678');

----------------------------------------------------------------------------------

-- Проверка каскадного обновления
UPDATE Person
SET Person_ID = Person_ID + 1000
WHERE Person_ID = (SELECT MAX(Person_ID) FROM Person WHERE Person_ID < 1000);

----------------------------------------------------------------------------------

-- Проверка, что документы остались за обновленным физ.лицом
SELECT * FROM Person_Documents 
WHERE Person_ID = (SELECT MAX(Person_ID) FROM Person);

----------------------------------------------------------------------------------

-- Проверка каскадного удаления
DELETE FROM Person
WHERE Person_ID = (SELECT MAX(Person_ID) FROM Person);

----------------------------------------------------------------------------------

-- Проверка, что документы удалились
SELECT * FROM Person_Documents 
WHERE Person_ID = (SELECT MAX(Person_ID) FROM Person) + 1000;

----------------------------------------------------------------------------------

-- Замечание: Для полной работоспособности модели следовало бы добавить каскадные свойства

-- Триггеры для каскадного обновления и удаления в таблице Owner
CREATE TRIGGER update_owner_person_id
AFTER UPDATE OF Person_ID ON Person
FOR EACH ROW
BEGIN
    UPDATE Owner
    SET Person_ID = NEW.Person_ID
    WHERE Person_ID = OLD.Person_ID;
END;

----------------------------------------------------------------------------------

CREATE TRIGGER delete_owner_records
BEFORE DELETE ON Person
FOR EACH ROW
BEGIN
    DELETE FROM Owner
    WHERE Person_ID = OLD.Person_ID;
END;

----------------------------------------------------------------------------------

-- Триггеры для каскадного обновления и удаления в таблице Employee
CREATE TRIGGER update_employee_person_id
AFTER UPDATE OF Person_ID ON Person
FOR EACH ROW
BEGIN
    UPDATE Employee
    SET Person_ID = NEW.Person_ID
    WHERE Person_ID = OLD.Person_ID;
END;

----------------------------------------------------------------------------------

CREATE TRIGGER delete_employee_records
BEFORE DELETE ON Person
FOR EACH ROW
BEGIN
    DELETE FROM Employee
    WHERE Person_ID = OLD.Person_ID;
END;