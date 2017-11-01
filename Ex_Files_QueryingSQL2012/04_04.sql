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

