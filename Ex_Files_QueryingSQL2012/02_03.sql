j

-- Tip: use [] to contain spaces 
-- Also in the case of reserved SQL keyword names *use not advised
-- Concatenation doesn't change table values
-- Only output appearance is affected 
-- Write a simple SELECT statement that uses string 
-- concatenation this query will create an output 
-- column called Name, and concatenates the last name 
-- and first name along with a comma
SELECT LastName + ', ' + FirstName AS Name
FROM Person.Person;
GO

-- Write a SELECT statement that returns a person's 
-- full name in a single column
-- NULL is unknown value 
-- Concatenation with NULL values always returns NULL 
SELECT FirstName + ' ' + MiddleName + ' ' + LastName AS [Full Name]
FROM Person.Person;
GO


-- Write a SELECT statement that returns a the first, 
-- middle, and last names of the entries in the 
-- Person table
-- Commas used as field separators 
SELECT FirstName, MiddleName, LastName
FROM Person.Person;
GO

-- Write a SELECT statement that returns a person's 
-- full name in a single column.
-- This code contains logic errors due to the use of 
-- the commas : notice comma right after MiddleName 
-- Will execute but messes up labels in output 
SELECT FirstName, + ' ' + MiddleName, + ' ' + LastName AS [Full Name]
FROM Person.Person;
GO


SELECT FirstName + ' ' + LastName AS [Full Name]
FROM Person.Person AS P; 
GO 


-- Practice with concat 
SELECT Name + ': ' + GroupName AS [Name & Details], ModifiedDate AS [Modified Date]
FROM HumanResources.Department AS HR;
GO 

