USE AdventureWorks2012;
GO

-- Write a SELECT statement for the Employee table
-- selecting specific attributes and using an alias for the table
SELECT hre.LoginID, hre.JobTitle, hre.HireDate
FROM HumanResources.Employee AS hre;
GO


-- Write a SELECT statement for the Employee table
-- selecting specific attributes and using an alias for the table
-- but include aliases for the attribute column names as well
SELECT hre.LoginID AS [login], hre.JobTitle AS [Title],hre.HireDate AS [Date Hired]
FROM HumanResources.Employee AS hre;
GO