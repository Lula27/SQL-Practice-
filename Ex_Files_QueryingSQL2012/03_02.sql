USE AdventureWorks2012;
GO

-- Use WHERE predicate to specify query 
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

-- Use where clause to retreive only the records where employees are single.
SELECT LoginId AS [Login Id], JobTitle AS [Job Title], MaritalStatus AS [Marital Status]
FROM HumanResources.Employee 
WHERE MaritalStatus = 'S'; 
GO 

-- Use the WHERE clause to return only the records in 
-- the Employee table where the employees are male
SELECT LoginID, JobTitle
FROM HumanResources.Employee
WHERE Gender  ='F';
GO

-- Select from Employee table where employees are female 
SELECT LoginID AS [Login Id], JobTitle [Job Title], Gender
FROM HumanResources.Employee
WHERE Gender = 'M'; 
GO 

-- Same query but with distinct Job Title 
SELECT DISTINCT JobTitle, LoginID 
FROM HumanResources.Employee
WHERE Gender = 'M';
GO 

-- Select employees who only have the job title Database Admin
-- This won't work. 
SELECT LoginID, JobTitle, Gender
FROM HumanResources.Employee
WHERE JobTitle ='Database'
GO 

-- Correction: Use LIKE with modulous 
SELECT LoginID, JobTitle, Gender
FROM HumanResources.Employee
WHERE JobTitle LIKE '%atabase%';
GO 

-- Use the WHERE clause to return only the records in 
-- the Employee table where employees have 99 hours 
-- of vacation time
SELECT *
FROM HumanResources.Employee
WHERE VacationHours = 99;
GO

-- Where employees have 37 hrs of vacay time 
SELECT *
FROM HumanResources.Employee
WHERE VacationHours = 37; 
GO 

SELECT * 
FROM HumanResources.Employee; 
GO

-- Employees with Sick leave hours less than 50
SELECT *
FROM HumanResources.Employee
WHERE SickLeaveHours < 50; 
GO 

-- Employees with no salaries? SalariedFlag = 0 
SELECT *
FROM HumanResources.Employee
WHERE SalariedFlag = 0; 
GO 

-- Where Business Entity ID = 17
SELECT * 
FROM HumanResources.Employee
WHERE BusinessEntityID = 17;
GO 