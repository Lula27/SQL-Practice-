USE AdventureWorks2012;
GO

-- Aliases (shorter representations of table names make it easier 
-- to query tables) 

-- Write a SELECT statement for the Employee table
-- selecting specific attributes and using an alias for the table
SELECT e.LoginID, e.JobTitle, e.HireDate, e.Gender
FROM HumanResources.Employee AS e;
GO


-- Write a SELECT statement for the Employee table
-- selecting specific attributes and using an alias for the table
-- but include aliases for the attribute column names as well
-- use aliases to change column names in output to 
-- make them a bit easier to read 
SELECT hre.LoginID AS [login], hre.JobTitle AS [Title],hre.HireDate AS [Date Hired]
FROM HumanResources.Employee AS hre;
GO

-- Column Alias My Example 1 
SELECT emp.JobTitle, emp.LoginID, emp.SickLeaveHours
FROM HumanResources.Employee AS emp; 
GO 

-- CA example 2 
SELECT Name, GroupName
FROM HumanResources.Department AS d; 
GO 

SELECT Ad.AddressLine1, Ad.City, Ad.PostalCode
FROM Person.Address AS Ad;
GO 