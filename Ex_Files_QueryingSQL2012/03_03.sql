--*********************************************
-- 04_03_WHERE_Clause_Relational_Operators.sql
--*********************************************

USE AdventureWorks2012;
GO

-- Use the WHERE clause to return only the records in the Employee table
-- where the employees are married
SELECT LoginID, JobTitle, MaritalStatus
FROM HumanResources.Employee
WHERE MaritalStatus  ='M';
GO
-- Practiced already with S 


-- Use the WHERE clause to return only the records in the Employee table
-- where the employees' level in the organization is above 2
SELECT * 
FROM HumanResources.Employee 
WHERE OrganizationLevel > 2; 
GO 

-- Use the WHERE clause to return only the records in the Employee table
-- where the employees' level in the organization is less than or equal to 2
SELECT * 
FROM HumanResources.Employee
WHERE OrganizationLevel <= 2; 
GO 

-- Use the OR operator to return records from the Person table
-- where the contact type is either single contact (SC) or vendor contact (VC)
SELECT *
FROM Person.Person
WHERE PersonType = 'VC' OR PersonType = 'SC';
GO


-- Use the AND operator to return records from the Person table
-- where the contact type is single contact (SC)
-- and they are in category 2 for email promotions



-- Use the IN operator to return records from the Person table
-- where the persons' first name is in a range of names supplied



-- Use the BETWEEN operator to return records from the Employee table
-- where the employees' have sick leave time between 40 and 99 hours
