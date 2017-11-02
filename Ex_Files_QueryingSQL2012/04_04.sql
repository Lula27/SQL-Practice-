--*****************************************
-- 04_04_Using_JOINS_in_a_Query.sql
--*****************************************

USE AdventureWorks2012;
GO

-- Select the product name from the 
-- Production.Prouct table
-- combine that with the comments and product 
-- review ID from the ProductReview table
-- using the ProductID to establish the 
-- relationship
SELECT p.Name, pr.ProductReviewID, 
		pr.Comments
FROM Production.Product p
INNER JOIN Production.ProductReview pr
ON p.ProductID = pr.ProductID;
GO


-- In the above, joining two separate tables
-- Use Select and provided aliases to observe 
-- Table contents: Production.Product 

SELECT p.Name
-- Indicate table alias w/o "AS" 
FROM Production.Product p; 
GO 

-- Table contents: Production.ProductReview 

SELECT ProductReviewID, Comments
FROM Production.ProductReview pr; 
GO 

-- Inner Join
-- Select the product name from the 
-- Production.Prouct table
-- combine that with the comments and product 
-- review ID from the ProductReview table
-- using the ProductID to establish the 
-- relationship

SELECT p.Name, pr.Comments, pr.ProductReviewID
FROM Production.Product p 
INNER JOIN Production.ProductReview pr 
ON p.ProductID = pr.ProductReviewID; 
GO 


-- Retreive data from Sales. Customer & Sales.PersonCreditCard 
SELECT sc.CustomerID, sc.AccountNumber As [Account Number]
FROM Sales.Customer sc;  
GO 

SELECT pc.CreditCardID
FROM Sales.PersonCreditCard pc;
GO 

-- Combine data using inner join

SELECT sc.CustomerID, sc.AccountNumber, pc.CreditCardID
FROM Sales.Customer sc
INNER JOIN Sales.PersonCreditCard pc
ON sc.CustomerID = pc.CreditCardID; 
GO 

-- Practice with Inner Joins
SELECT P.Name, P.ProductID
FROM Production.Product P; 
GO 

SELECT PS.Name, PS.ProductSubcategoryID
FROM Production.ProductSubcategory PS; 
GO 

-- Inner Join to produce intersection 
-- using the joining key of subcategory Id
SELECT P.Name AS [Product Name], PS.Name AS [Product Subcategory]
FROM Production.Product P
INNER JOIN Production.ProductSubcategory PS
ON P.ProductSubcategoryID = PS.ProductSubcategoryID; 
GO 

-- Inner join columns from HR.Employee & Person Tables
SELECT emp.JobTitle AS [Job Title]
FROM HumanResources.Employee emp; 
GO 

SELECT p.FirstName + ' ' + p.LastName As [Full Name]
FROM Person.Person p; 
GO

-- Inner join tables using business entity Id
SELECT p.FirstName + ' ' + p.LastName As [Full Name], emp.JobTitle AS [Job Title]
FROM Person.Person p
INNER JOIN HumanResources.Employee emp 
ON emp.BusinessEntityID = p.BusinessEntityID; 
GO 

-- Practice problems with inner joins
-- # 1 - Both Person.Person & HR.Employee share BusinessEntityID as join key 
SELECT p.FirstName + ' ' +  p.LastName AS Name
FROM Person.Person p;
GO 

SELECT e.JobTitle AS [Job Title], e.NationalIDNumber AS [National ID Number]
FROM HumanResources.Employee e; 
GO 

-- Use Inner Join
SELECT p.FirstName + ' ' +  p.LastName AS Name, e.JobTitle AS [Job Title],
 e.NationalIDNumber AS [National ID Number] 
FROM Person.Person p
INNER JOIN HumanResources.Employee e
ON p.BusinessEntityID = e.BusinessEntityID;
GO	

-- problem #2 : key = ProductCategoryID 
SELECT PS.Name AS [Product Subcategory Name]
FROM Production.ProductSubcategory PS; 
GO 

SELECT Name AS [Product Category Name]
FROM Production.ProductCategory PC;
GO 

-- Inner Join
SELECT PC.Name AS [Product Category Name], PS.Name AS [Product Subcategory Name]
FROM Production.ProductCategory PC
INNER JOIN Production.ProductSubcategory PS
ON PC.ProductCategoryID = PS.ProductCategoryID; 
GO 


-- problem #3 : inner join 3 tables - return name colum from 3 tables
-- Hint: do two at a time since it isn't possible 
-- to inner join all three at once
-- keys = ProductID (P & PS); ProductCategoryID (PC & PS)
-- (order based on general to specifics) PC -> PS -> P
SELECT *
FROM Production.Product P;
GO 
-- key = ProductSubcategoryID

SELECT *
FROM Production.ProductSubcategory PS;
GO 
-- Key = ProudctCategoryID

SELECT *
FROM Production.ProductCategory PC;
GO 
-- Key = ProductCategoryID

-- Complete inner join #1
SELECT PC.Name AS [Product Category Name], PS.Name AS [Product Subcategory Name]
FROM Production.ProductCategory PC 
INNER JOIN Production.ProductSubcategory PS
ON PC.ProductCategoryID = PS.ProductCategoryID; 
GO 

-- Complete inner join #2 
SELECT PS.Name AS [Product Subcategory Name], P.Name AS [Product Name]
FROM Production.ProductSubcategory PS
INNER JOIN Production.Product P
ON P.ProductSubcategoryID = PS.ProductSubcategoryID;
GO 




-- Using a left outer join, we will return all the 
-- rows in one table regardless of whether there 
-- is a match in the other table.
-- NOTE the placement of the table names in the 
-- FROM and JOIN clauses determine which table 
-- is the LEFT.  In this case, Product is the 
-- left table
SELECT  p.Name, pr.ProductReviewID, pr.Comments
FROM Production.Product p
LEFT OUTER JOIN Production.ProductReview pr
ON p.ProductID = pr.ProductID;
GO

SELECT pr.ProductReviewID, pr.Comments
FROM Production.ProductReview pr; 
GO

-- Inner Join one more example
SELECT E.JobTitle AS [Job Title], E.HireDate AS [Hire Date]
FROM HumanResources.Employee E;
GO

SELECT EDH.StartDate AS [Start Date]
FROM HumanResources.EmployeeDepartmentHistory EDH; 
GO 

-- Join key = BusinessEntityID  
-- Based on this table, hire date = start date 
SELECT E.JobTitle AS [Job Title], E.HireDate AS [Hire Date], EDH.StartDate AS [Start Date]
FROM HumanResources.Employee E
INNER JOIN HumanResources.EmployeeDepartmentHistory EDH
ON E.BusinessEntityID = EDH.BusinessEntityID
GO 



-- Using a left outer join, we will return all the 
-- rows in one table regardless of whether there 
-- is a match in the other table.
-- NOTE the placement of the table names in the 
-- FROM and JOIN clauses determine which table 
-- is the LEFT.  In this case, ProductReview is 
-- the left table
SELECT  p.Name, pr.ProductReviewID, pr.Comments
FROM Production.ProductReview pr
LEFT OUTER JOIN Production.Product p
ON p.ProductID = pr.ProductID;
GO



-- Using a right outer join, we will return all 
-- the rows in one table
-- regardless of whether there is a match in the 
-- other table.
-- In this case, the ProductReview table is the 
-- RIGHT table according to placement in JOIN 
-- clause.  Also, the ProductReview table only 
-- has four entries total
SELECT p.Name, pr.ProductReviewID, pr.Comments
FROM Production.Product p
RIGHT OUTER JOIN Production.ProductReview pr
ON p.ProductID = pr.ProductID;
GO


-- Using a full outer join, we will retain the 
-- nonmatching rows regardless of whether there 
-- is a match in the other table the results look 
-- similar to the LEFT OUTER JOIN in this instance 
-- because of the way the data exists in 
-- these tables.
SELECT p.Name, pr.ProductReviewID, pr.Comments
FROM Production.Product p
FULL OUTER JOIN Production.ProductReview pr
ON p.ProductID = pr.ProductID;
GO

