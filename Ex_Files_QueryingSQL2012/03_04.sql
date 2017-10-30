--********************************************
-- 03_04_Filtering_Text.sql
--********************************************

USE AdventureWorks2012;
GO

-- Use the WHERE clause to return only the records 
-- in the Employee table where the employees are 
-- a manager of some type this example uses 
-- the % character for any number of characters
SELECT JobTitle, Gender
FROM HumanResources.Employee
WHERE JobTitle LIKE '%Manager%'; 



-- Use the LIKE keyword to return records from the 
-- Person table where users' first names end in 
-- "ary". This example uses the _ character to 
-- represent a single character
SELECT FirstName + ' ' + LastName As [Full Name], EmailPromotion As [Email Promotion], ModifiedDate As [Date Modified] 
FROM Person.Person
WHERE FirstName LIKE '_ary'; 



-- Use the LIKE keyword to return records from the 
-- Person table where users' first names end in 
-- "ary". This example uses the [] characters to 
-- represent a single character found within the 
-- list of characters in the []
SELECT FirstName + ' ' + LastName As [Full Name], EmailPromotion As [Email Promotion], ModifiedDate As [Date Modified] 
FROM Person.Person
WHERE FirstName LIKE [^ary]; 






-- Use the LIKE keyword to return records from the 
-- Person table where users' first names end in 
-- "ary". This example uses the [^] characters to 
-- represent a single character to exclude 
-- characters in the name searched
SELECT FirstName + ' ' + LastName As [Full Name], EmailPromotion As [Email Promotion], ModifiedDate As [Date Modified] 
FROM Person.Person
WHERE FirstName LIKE [%arry]; 



-- Use the NOT LIKE keywords to return records 
-- from the Person table where users' first names 
-- do NOT end in "ary".
SELECT
FROM 
WHERE 
