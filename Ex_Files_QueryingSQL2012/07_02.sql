--******************************************
-- 07_02_ Using_EXISTS.sql
--******************************************

USE AdventureWorks2012;
GO


-- Using EXISTS predicate to check for existence 
-- of records in a subquery.

-- In this instance, we are looking for customer 
-- account numbers who place orders online.
-- We do this by using EXISTS to check which 
-- records in the subquery, in this case the 
-- SalesOrderHeader table, match the customer IDs 
-- and that also have the online order flag set to
 
-- 1. We might run such a query to determine which 
-- customers place online orders so that we can 
-- send them specials or other notification types.
SELECT AccountNumber
FROM Sales.Customer AS c
WHERE EXISTS
	(SELECT *
	FROM Sales.SalesOrderHeader AS soh
	WHERE c.CustomerID = soh.CustomerID
	AND OnlineOrderFlag = 1);  -- Why not == ? : b/c that is assignment 
GO

SELECT AccountNumber
FROM Sales.Customer AS sc 
WHERE EXISTS 
	(SELECT *
	FROM Sales.SalesOrderHeader AS soh 
	WHERE sc.CustomerID = soh.CustomerID
	AND OnlineOrderFlag = 1); 
GO   

SELECT AccountNumber 
FROM Sales.Customer AS sc 
WHERE EXISTS 
	(SELECT * 
	FROM Sales.SalesOrderHeader AS soh 
	WHERE sc.CustomerID = soh.CustomerID
	AND OnlineOrderFlag = 1); 
GO 

SELECT AccountNumber
FROM Sales.Customer AS sc 
WHERE EXISTS 
	(SELECT *
	FROM Sales.SalesOrderHeader AS soh 
	WHERE sc.CustomerID = soh.CustomerID
	AND OnlineOrderFlag = 1); 
GO 

-- Select AccountNumber where exists (territory ID = 4)
-- Key: TerritoryID 

SELECT StoreID, TerritoryID, AccountNumber
FROM Sales.Customer; 


-- where SubTotal > 2000 ; key is AccountNumber 
SELECT AccountNumber, SalesOrderID, TerritoryID, SubTotal
FROM Sales.SalesOrderHeader;
GO 

SELECT AccountNumber AS [Account Number]
FROM Sales.Customer AS sc
WHERE EXISTS 
	(SELECT * 
	FROM Sales.SalesOrderHeader AS soh 
	WHERE sc.TerritoryID = soh.TerritoryID
	AND SubTotal > 2000); 
GO 


-- key: BusinessEntityID
-- retreive DepartmentID, StartDate 

-- where rate > 13 
SELECT *
FROM HumanResources.EmployeePayHistory; 

SELECT DepartmentID AS [Department ID], StartDate AS [Start Date] 
FROM HumanResources.EmployeeDepartmentHistory AS hredh 
WHERE EXISTS 
	(SELECT *
	FROM HumanResources.EmployeePayHistory AS hreph
	WHERE Rate > 13); 


-- ket: BusinessEntityID 

SELECT *
FROM Sales.SalesPerson; 

SELECT *
FROM Sales.SalesPersonQuotaHistory; 

-- key: BusinessEntityID

SELECT BusinessEntityID, FirstName + ' ' + LastName AS [Full Name]
FROM Person.Person; 

SELECT * 
FROM Person.PersonPhone;

-- rows: 736
SELECT FirstName + ' ' + LastName AS [Full Name] 
FROM Person.Person AS p
WHERE EXISTS 
	(SELECT pp.PhoneNumber 
	FROM Person.PersonPhone AS pp
	WHERE p.BusinessEntityID = pp.BusinessEntityID
	AND PhoneNumberTypeID = 3); 


-- rows: 736
SELECT pp.PhoneNumber, pp.PhoneNumberTypeID
FROM Person.PersonPhone AS pp 
WHERE pp.PhoneNumberTypeID = 3; 

-- Do the opposite! 
-- We can also negate the results if we are 
-- looking for records that are NOT in the 
-- subquery. 

-- In this instance, we are looking 
-- for customer account numbers who do NOT place 
-- orders online.

-- We do this by using NOT EXISTS to check which 
-- records in the subquery.

SELECT AccountNumber
FROM Sales.Customer AS c
WHERE NOT EXISTS
	(SELECT *
	FROM Sales.SalesOrderHeader AS soh
	WHERE c.CustomerID = soh.CustomerID
	AND OnlineOrderFlag = 1);
GO

SELECT AccountNumber AS [Account Number]
FROM Sales.Customer AS sc
WHERE NOT EXISTS 
	(SELECT *
	FROM Sales.SalesOrderHeader AS soh
	WHERE sc.CustomerID = soh.CustomerID
	AND OnlineOrderFlag = 1); 
GO 

SELECT AccountNumber AS [Account Number]
FROM Sales.Customer AS sc 
WHERE NOT EXISTS 
	(SELECT * 
	FROM Sales.SalesOrderHeader AS soh
	WHERE sc.CustomerID = soh.CustomerID
	AND OnlineOrderFlag = 1);
GO 

-- rows: 19236 
SELECT p.FirstName + ' ' + p.LastName AS [Full Name]
FROM Person.Person AS p
WHERE NOT EXISTS 
	 (SELECT * 
	 FROM Person.PersonPhone AS pp
	 WHERE pp.BusinessEntityID = p.BusinessEntityID
	 AND pp.PhoneNumberTypeID = 3);


-- key: BusinessEntityID
SELECT pp.PhoneNumber, PhoneNumberTypeID
FROM Person.PersonPhone AS pp; 



