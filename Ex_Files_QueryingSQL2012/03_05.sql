--********************************************
-- 04_05_Working_with_NULL.sql
--********************************************

USE AdventureWorks2012;
GO


-- Use the WHERE clause to return only the records 
-- in the Employee table where the employees are 
-- a manager of some type this example uses the 
-- % character for any number of characters
SELECT LoginID, JobTitle
FROM HumanResources.Employee
WHERE JobTitle LIKE '%manager%';
GO

-- No NULL values are returned, even though the
-- table contains entries where NULL exist in
-- the middle name field
-- Execute this query to see result without NULL
SELECT FirstName, MiddleName, LastName
FROM Person.Person
WHERE MiddleName <> 'A';
GO

-- Execute the same query, only this time, allow
-- a check for NULL values in an OR portion of
-- the WHERE clause.
SELECT FirstName, MiddleName, LastName
FROM Person.Person
WHERE MiddleName <> 'A'
OR MiddleName IS NULL;
GO

-- Execute this query to see only the records
-- returned where the middle name is NULL
-- NOTE: we use IS NULL and not = NULL
-- You cannot compare NULL to something because
-- NULL is undefined
SELECT FirstName, MiddleName, LastName
FROM Person.Person
WHERE MiddleName IS NULL;
GO

-- We use NOT NULL to return all values that
-- are not NULL values.
SELECT FirstName, MiddleName, LastName
FROM Person.Person
WHERE MiddleName IS NOT NULL;
GO