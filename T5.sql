SELECT * from Pet WHERE Nick='Partizan';

SELECT Nick, Breed, Age from Pet ORDER BY Age;

SELECT * from Pet WHERE NOT (Description = 'NULL' OR Description="");

SELECT AVG(Age) from Pet WHERE Breed = 'poodle';

SELECT COUNT(DISTINCT Owner_ID) from Pet;

SELECT Breed, COUNT(*) FROM Pet GROUP BY Breed;

SELECT Breed, COUNT(*) FROM Pet GROUP BY Breed HAVING NOT COUNT(*) = 1;