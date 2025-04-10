SELECT Nick, Name FROM Pet JOIN Pet_type ON Pet.Pet_Type_ID = Pet_Type.Pet_Type_ID WHERE Nick = 'Partizan';

SELECT Nick, Name FROM Pet, Pet_type WHERE Pet.Pet_Type_ID = Pet_Type.Pet_Type_ID AND Nick = 'Partizan';

SELECT Nick, Breed, Age FROM Pet JOIN Pet_type ON Pet.Pet_Type_ID = Pet_Type.Pet_Type_ID AND Name = 'DOG';

SELECT AVG(Age) AVERAGE_AGE FROM Pet JOIN Pet_type ON Pet.Pet_Type_ID = Pet_Type.Pet_Type_ID AND Name = 'CAT';

SELECT Time_Order, First_Name, Last_Name FROM Order1 JOIN Employee ON Order1.Employee_ID = Employee.Employee_ID JOIN Person ON Employee.Person_ID = Person.Person_ID WHERE Is_Done = 0;

SELECT First_Name, Last_Name, Phone FROM Owner JOIN Person ON Owner.Person_ID = Person.Person_ID;

SELECT Name, Nick FROM Pet_Type LEFT JOIN Pet ON Pet_Type.Pet_Type_ID = Pet.Pet_Type_ID;

SELECT Name, Nick FROM Pet_Type JOIN Pet ON Pet_Type.Pet_Type_ID = Pet.Pet_Type_ID;

SELECT Age, Name, COUNT() AS COUNT FROM Pet INNER JOIN Pet_Type On Pet.Pet_Type_ID = Pet_Type.Pet_Type_ID GROUP BY Age, Name;

SELECT Last_Name, COUNT(Order_ID) AS ORDERS_COUNT FROM Order1 INNER JOIN Employee ON Order1.Employee_ID = Employee.Employee_ID AND Is_Done = 1 INNER JOIN Person ON Employee.Person_ID = Person.Person_ID GROUP BY Last_Name HAVING COUNT(Order_ID) > 3;

-- Данные владельцев, не предоствавших информацию о прививках для своих питомцев
SELECT First_Name, Last_Name, Phone FROM Person LEFT JOIN Owner ON Person.Person_ID = Owner.Person_ID LEFT JOIN Pet ON Owner.Owner_ID = Pet.Owner_ID LEFT JOIN Vaccine ON Pet.Pet_ID = Vaccine.Pet_ID WHERE Vaccine.Type is NULL;