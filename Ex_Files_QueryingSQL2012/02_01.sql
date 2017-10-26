--USE database name
-- Go keyword is batch seperator; like bookmark between pages 

USE AdventureWorks2012;
GO



-- Simple SELECT statement that returns all attributes  
-- (fields) in the Employee table.
-- No filters applied to the results
SELECT *
FROM HumanResources.Employee;
GO

-- Simple SELECT statement to return specific attributes from 
-- the Employee table.
-- No filters applied to the results
SELECT loginID, JobTitle, HireDate
FROM HumanResources.Employee;
GO

-- Demonstration of intellisense
SELECT LoginID, JobTitle, HireDate
FROM HumanResources.Employee; 
GO 
