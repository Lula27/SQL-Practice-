USE AdventureWorks2012;
GO

-- Using specific fields in the SELECT clause to 
-- filter the attributes to be returned
-- normal query that doesn't use any predicates yet
SELECT LoginID, JobTitle, MaritalStatus 
FROM HumanResources.Employee;
GO


-- Use the WHERE clause to return only the records 
-- in the Employee table where the employees are 
-- married.  This is where we introduce predicates using
-- the WHERE clause to filter rows, not columns
SELECT LoginID, JobTitle, MaritalStatus
FROM HumanResources.Employee
WHERE MaritalStatus  ='M';
GO


-- Use the WHERE clause to return only the records in 
-- the Employee table where the employees are male
SELECT LoginID, JobTitle
FROM HumanResources.Employee
WHERE Gender  ='F';
GO


-- Use the WHERE clause to return only the records in 
-- the Employee table where employees have 99 hours 
-- of vacation time
SELECT *
FROM HumanResources.Employee
WHERE VacationHours = 99;
GO