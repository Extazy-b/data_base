--1. Все оценки по выполненным заказам, исполнителями которых являлись студенты.
SELECT Mark FROM Order1 WHERE Is_Done = 1 AND Employee_ID IN (SELECT Employee_ID FROM Employee WHERE Spec = 'student');

-- 2. Фамилии исполнителей, не получивших еще ни одного заказа.
SELECT Last_Name FROM Person JOIN Employee ON Person.Person_ID = Employee.Person_ID WHERE Employee_ID NOT IN (SELECT Employee_ID FROM Order1);

-- 3. Список заказов (вид услуги, время, фамилия исполнителя, кличка питомца, фамилия владельца).

SELECT S.Name AS Service, Time_Order AS DAteTime, 
P.Last_Name AS Employer, Nick, Own.Last_Name AS Owner

FROM Order1 AS O JOIN
Service AS S ON O.Service_ID = S.Service_ID JOIN
Employee AS E ON O.Employee_ID = E.Employee_ID JOIN
Person AS P ON E.Person_ID = P.Person_ID JOIN
Pet ON O.Pet_ID = Pet.Pet_ID JOIN
Person AS Own ON Pet.Owner_ID = Own.Person_ID;

-- 4. Общий список комментариев, имеющихся в базе.

SELECT Comments AS Комментарий FROM Order1 WHERE Comments <> ''
UNION
SELECT Description AS Комментарий FROM Pet WHERE Description <> ''
UNION
SELECT Description AS Комментарий FROM Owner WHERE Description <> '';


-- 5. Имена и фамилии сотрудников, хотя бы раз получивших пятерку за выполнение заказа.
SELECT p.Last_Name, p.First_Name
FROM Person AS p
WHERE EXISTS (
    SELECT 1
    FROM Employee AS e
    JOIN Order1 AS o ON e.Employee_ID = o.Employee_ID
    WHERE e.Person_ID = p.Person_ID
    AND o.Mark = 5
);

SELECT DISTINCT p.Last_Name, p.First_Name
FROM Person p
JOIN Employee e ON p.Person_ID = e.Person_ID
JOIN Order1 o ON e.Employee_ID = o.Employee_ID
WHERE o.Mark = 5;
