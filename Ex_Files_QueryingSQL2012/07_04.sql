--******************************************
-- 07_04_ Introducing_CTE.sql
--******************************************

USE AdventureWorks2012;
GO

-- Define the CTE (Common Table Expression) expression name and column 
-- list.
-- Here we are naming our CTE as Sales_CTE 
-- and we are defining the column names it 
-- will use when referenced in a query later.

WITH Sales_CTE (SalesPersonID, SalesOrderID, 
	SalesYear)
AS
-- This is the query that generates the 
-- structure of the CTE and returns the data 
--values that will be contained in the CTE.
(
    SELECT SalesPersonID, SalesOrderID, 
		YEAR(OrderDate) AS SalesYear
    FROM Sales.SalesOrderHeader
    WHERE SalesPersonID IS NOT NULL
)


-- Now that the inner query has been created, 
-- we can define the CTE outer query that 
-- will use the result set from the previous 
-- query.
-- Note that the previous query can execute 
-- by itself, but this query will generate an 
-- error if you execute it alone, 
-- demonstrating that the CTE
-- only exists in the scope of the entire 
-- query operation
SELECT SalesPersonID, COUNT(SalesOrderID) 
	AS TotalSales, SalesYear
FROM Sales_CTE
GROUP BY SalesYear, SalesPersonID
ORDER BY SalesPersonID, SalesYear;
GO


-- Practice with CTEs
-- Part 1: inner query 
WITH Sales_CTE (SalesPersonID, SalesOrderID, 
		SalesYear)
AS 
(
	SELECT SalesPersonID, SalesOrderID,
		YEAR(OrderDate) AS SalesYear
	FROM Sales.SalesOrderHeader
	WHERE SalesPersonID IS NOT NULL
) 

-- outer query 
SELECT SalesPersonID, COUNT(SalesOrderID)
	AS TotalSales, SalesYear
FROM Sales_CTE
GROUP BY SalesYear, SalesPersonID
ORDER BY SalesPersonID, SalesYear; 
GO 


WITH Sales_CTE (SalesPersonID, SalesOrderID, SalesYear)
AS 
(	SELECT SalesPersonID, SalesOrderID, 
		YEAR(OrderDate) AS SalesYear
	FROM Sales.SalesOrderHeader
	WHERE SalesPersonID IS NOT NULL
) 
SELECT SalesPersonID, COUNT(SalesOrderID) 
	AS TotalSales, SalesYear 
FROM Sales_CTE
GROUP BY SalesYear, SalesPersonID
ORDER BY SalesPersonID, SalesYear; 
GO 




-- Using a CTE to retreive multiple types of data 
WITH Sales_CTE(SalesPersonID, SalesOrderID, SalesYear)
	AS 
	( 
		SELECT SalesPersonID, SalesOrderID, 
			YEAR(OrderDate) AS SalesYear 
			FROM Sales.SalesOrderHeader
			WHERE SalesPersonID IS NOT NULL 
	) 

-- hmmmm...above doesn't seem to be working

-- Try my own CTE example
-- source: https://docs.microsoft.com/en-us/sql/t-sql/queries/with-common-table-expression-transact-sql

-- step 1: Define the CTE expression name & colum list
WITH Sales_CTE (SalesPersonID, SalesOrderID, SalesYear)
AS 
-- Define the CTE query.
(
	SELECT SalesPersonID, SalesOrderID, YEAR(OrderDate) AS SalesYEar
	FROM Sales.SalesOrderHeader
	WHERE SalesPersonID IS NOT NULL 
) 
-- Define the outer query referencing the CTE name. 
SELECT SalesPersonID, COUNT(SalesOrderID) AS TotalSales, SalesYear
FROM Sales_CTE 
GROUP BY SalesYear, SalesPersonID
ORDER BY SalesPersonID, SalesYear; 
GO 