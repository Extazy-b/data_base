SELECT * from Pet WHERE Nick='Partizan';

SELECT Nick, Breed, Age from Pet ORDER BY Age;

SELECT * from Pet WHERE NOT (Description = 'NULL' OR Description="");

SELECT AVG(Age) from Pet WHERE Breed = 'poodle';

SELECT COUNT(DISTINCT Owner_ID) from Pet;

SELECT Breed, COUNT(*) FROM Pet GROUP BY Breed;

SELECT Breed, COUNT(*) FROM Pet GROUP BY Breed HAVING NOT COUNT(*) = 1;

SELECT Nick, Age, Description from Pet WHERE Age BETWEEN 2 AND 5;
/* выбираем питомцев активного возраста (не щенки и не пожилые) */

SELECT First_Name, Phone, Address from Person WHERE Phone NOT LIKE '+7%';
/* выбираем неформатные номера для их проверки */

SELECT Owner_ID, Nick, Age, Breed from Pet WHERE Breed IN ('poodle', 'Siamese');
/* выбираем питомцев конкретной породы */