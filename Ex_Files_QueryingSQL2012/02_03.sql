USE AdventureWorks2012;
GO

-- Write a simple SELECT statement that uses string 
-- concatenation this query will create an output 
-- column called Name, and concatenates the last name 
-- and first name along with a comma
SELECT LastName + ', ' + FirstName AS Name
FROM Person.Person;
GO

-- Write a SELECT statement that returns a person's 
-- full name in a single column
SELECT FirstName + ' ' + MiddleName + ' ' + LastName AS [Full Name]
FROM Person.Person;
GO


-- Write a SELECT statement that returns a the first, 
-- middle, and last names of the entries in the 
-- Person table
SELECT FirstName, MiddleName, LastName
FROM Person.Person;
GO

-- Write a SELECT statement that returns a person's 
-- full name in a single column.
-- This code contains logic errors due to the use of 
-- the commas
SELECT FirstName, + ' ' + MiddleName, + ' ' + LastName AS [Full Name]
FROM Person.Person;
GO