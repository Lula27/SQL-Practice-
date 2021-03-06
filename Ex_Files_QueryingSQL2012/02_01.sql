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

-- My Practice
SELECT Name
FROM Person.CountryRegion; 
GO 

-- Using IntelliSense engine and arrow keys + Tab, select Name, 
-- CostRate & Availability from Production.Location table
SELECT Name, CostRate, Availability
FROM Production.Location; 
GO 

SELECT Name, ShipBase, rowguid
FROM Purchasing.ShipMethod; 
GO 

SELECT ReviewerName, EmailAddress, Rating, Comments
FROM Production.ProductReview;
GO 


-- Practice with another select statement 
SELECT AddressLine1 AS [Address], PostalCode AS Post, SpatialLocation AS Location 
FROM Person.Address;
GO 