--******************************************
-- 06_02_ Queries_Using_Character_Data_Types.sql
--******************************************
-- Looking at queries with character (strings) data types

USE AdventureWorks2012;
GO


-- Use the N prefix designator to reflect using 
-- Unicode data types to prevent the use of 
-- casting (conversion of data types) in your 
-- query to help increase performance of queries
SELECT FirstName, LastName
FROM Person.Person
WHERE LastName = N'Adams'; -- N reps unicode values; helps avoid casting (conversion of data types in queries); makes query run faster
GO

SELECT FirstName, LastName
FROM Person.Person
WHERE LastName = N'Brown'; 
GO 


-- Try withou N : maybe went slower...not sure...Yes! Considerably slower without N.
SELECT LastName
FROM Person.Person
WHERE LastName = 'Adams';
GO 

-- Whenever you use wildcard (%), use LIKE 
-- Use the % symbol to apply filters with any 
-- string as a wildcard in this case, we search 
-- for people with last names that start with A
SELECT FirstName, LastName
FROM Person.Person
WHERE LastName LIKE N'A%'; -- last name starts with A
GO

SELECT FirstName, LastName
FROM Person.Person
WHERE FirstName	LIKE N'H%'; 
GO 

SELECT FirstName, LastName 
FROM Person.Person
WHERE LastName LIKE N'%A'; 
GO 

-- Use the % symbol to apply filters with any 
-- string as a wildcard in this case we expand 
-- our filter by looking for last names that start 
-- with 'Ab'.  The % simply means any number of 
-- characters after the supplied characters
SELECT FirstName, LastName
FROM Person.Person
WHERE LastName LIKE N'Ab%';
GO

-- Select names where first name starts with Ki
SELECT FirstName, LastName
FROM Person.Person
WHERE FirstName	LIKE N'Ki%'; 
GO 

-- Select names where last name ends with ez
SELECT FirstName, LastName
FROM Person.Person
WHERE LastName LIKE '%ez';
GO 

-- Use the % symbol to apply filters with any 
-- string as a wildcard in this case, we search 
-- for people with first names that end in 'im'
-- or where the letters 'im' appear somewhere in 
-- the first name.
-- This demonstrates how the wild card can be 
-- used in different locations
SELECT FirstName, LastName
FROM Person.Person
WHERE FirstName LIKE N'%im' OR FirstName LIKE N'%im%'; -- im somewhere in first name
GO

-- Wasn't expecting this to retrieve the exact same thing - thought Kim would disappear
-- but 204 rows retrieved just like last time 
SELECT FirstName, LastName
FROM Person.Person
WHERE FirstName LIKE N'%im%'; -- im somewhere in first name
GO




-- Use the _ symbol to apply filters with any 
-- string as a wildcard in this case, we search 
-- for people with last names that have a
-- letter 'd' in the second place in the name
SELECT FirstName, LastName
FROM Person.Person
WHERE LastName LIKE N'_D%';
GO

-- Use a list of characters within [] brackets to 
-- search for multiple possible character values. 
-- Here we search for last names that contain 
-- either A, B, or C as the first characters 
-- in the last name.
SELECT FirstName, LastName
FROM Person.Person
WHERE LastName LIKE N'[ABC]%';
GO

-- Use a list of characters within [] brackets to 
-- search for multiple possible character values.  
-- Here we search for last names that start with 
-- characters within a range.
SELECT FirstName, LastName
FROM Person.Person
WHERE LastName LIKE N'[A-F]%';
GO

-- Use a list of characters within [] brackets to 
-- search for multiple possible character values. 
-- Here we search for last names that don't start 
-- with characters specified in the range supplied
SELECT FirstName, LastName
FROM Person.Person
WHERE LastName LIKE N'[^A-F]%';
GO