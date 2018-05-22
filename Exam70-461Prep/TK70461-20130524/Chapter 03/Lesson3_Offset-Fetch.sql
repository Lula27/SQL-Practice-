-- Filtering Data with TOP and OFFSET-FETCH
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Filtering Data with TOP
---------------------------------------------------------------------
USE TSQL2012; 

-- return the three most recent orders
SELECT TOP (3) orderid, orderdate, custid, empid
FROM Sales.Orders
ORDER BY orderdate DESC;

SELECT TOP (3) orderid, orderdate, custid, empid 
FROM Sales.Orders 
ORDER BY orderdate DESC; 

-- can use percent
SELECT TOP (1) PERCENT orderid, orderdate, custid, empid
FROM Sales.Orders
ORDER BY orderdate DESC;
GO

SELECT TOP (1) PERCENT orderid, orderdate, custid, empid 
FROM Sales.Orders
ORDER BY orderdate DESC; 
GO 

-- can use expression, like parameter or variable, as input
DECLARE @n AS BIGINT = 5;

SELECT TOP (@n) orderid, orderdate, custid, empid
FROM Sales.Orders
ORDER BY orderdate DESC;
GO

DECLARE @n AS BIGINT = 5; 

SELECT TOP (@n) orderid, orderdate, custid, empid 
FROM Sales.Orders 
ORDER BY orderdate DESC; 
GO  

-- no ORDER BY, ordering is arbitrary
SELECT TOP (3) orderid, orderdate, custid, empid
FROM Sales.Orders;

-- be explicit about arbitrary ordering
SELECT TOP (3) orderid, orderdate, custid, empid
FROM Sales.Orders
ORDER BY (SELECT NULL);

SELECT TOP (3) orderid, orderdate, custid, empid
FROM Sales.Orders 
ORDER BY (SELECT NULL); 

-- non-deterministic ordering even with ORDER BY since ordering isn't unique
SELECT TOP (3) orderid, orderdate, custid, empid
FROM Sales.Orders
ORDER BY orderdate DESC;

-- how to make deterministic: 
-- 1. return all ties
SELECT TOP (3) WITH TIES orderid, orderdate, custid, empid
FROM Sales.Orders
ORDER BY orderdate DESC;

SELECT TOP (3) WITH TIES orderid, orderdate, custid, empid
FROM Sales.Orders
ORDER BY orderdate DESC; 

-- 2. break ties
SELECT TOP (3) orderid, orderdate, custid, empid
FROM Sales.Orders
ORDER BY orderdate DESC, orderid DESC;

SELECT TOP (3) orderid, orderdate, custid, empid 
FROM Sales.Orders
ORDER BY orderdate DESC, orderid DESC; 

---------------------------------------------------------------------
-- Filtering Data with OFFSET-FETCH
---------------------------------------------------------------------

-- skip 50 rows, fetch next 25 rows
SELECT orderid, orderdate, custid, empid
FROM Sales.Orders
ORDER BY orderdate DESC, orderid DESC
OFFSET 50 ROWS FETCH NEXT 25 ROWS ONLY;

SELECT orderid, orderdate, custid, empid 
FROM Sales.Orders 
ORDER BY orderdate DESC, orderid DESC 
OFFSET 50 ROWS FETCH NEXT 25 ROWS ONLY; 



-- fetch first 25 rows
SELECT orderid, orderdate, custid, empid
FROM Sales.Orders
ORDER BY orderdate DESC, orderid DESC
OFFSET 0 ROWS FETCH FIRST 25 ROWS ONLY;

SELECT orderid, orderdate, custid, empid 
FROM Sales.Orders
ORDER BY orderdate DESC, orderid DESC 
OFFSET 0 ROWS FETCH FIRST 25 ROWS ONLY; 

-- skip 50 rows, return all the rest
SELECT orderid, orderdate, custid, empid
FROM Sales.Orders
ORDER BY orderdate DESC, orderid DESC
OFFSET 50 ROWS;

SELECT orderid, orderdate, custid, empid
FROM Sales.Orders 
ORDER BY orderdate DESC, orderid DESC 
OFFSET 50 ROWS; 

-- ORDER BY is mandatory; return some 3 rows
SELECT orderid, orderdate, custid, empid
FROM Sales.Orders
ORDER BY (SELECT NULL)
OFFSET 0 ROWS FETCH FIRST 3 ROWS ONLY;
GO

SELECT orderid, orderdate, custid, empid
FROM Sales.Orders
ORDER BY (SELECT NULL) 
OFFSET 0 ROWS FETCH FIRST 3 ROWS ONLY; 
GO 

-- can use expressions as input
DECLARE @pagesize AS BIGINT = 25, @pagenum AS BIGINT = 3;

SELECT orderid, orderdate, custid, empid
FROM Sales.Orders
ORDER BY orderdate DESC, orderid DESC
OFFSET (@pagenum - 1) * @pagesize ROWS FETCH NEXT @pagesize ROWS ONLY;
GO


DECLARE @pagesize AS BIGINT = 50, @pagenum AS BIGINT = 10; 

SELECT orderid, orderdate, custid, empid 
FROM Sales.Orders 
ORDER BY orderdate DESC, orderid DESC 
OFFSET (@pagenum - 1) * @pagesize ROWS FETCH NEXT @pagesize ROWS ONLY; 
GO 

-- Exerises 
-- 1. Write query against Production.Products table; return 5 most expensive products from category 1 
-- retreives 5 rows 
SELECT TOP (5) productid, unitprice
FROM Production.Products
WHERE categoryid = 1 
ORDER BY unitprice DESC; 

-- make deterministic with ties 
-- retreives 7 rows 
SELECT TOP (5) WITH TIES productid, unitprice 
FROM Production.Products
WHERE categoryid = 1 
ORDER BY unitprice DESC; 

-- break tie 
-- retreives 5 rows 
SELECT TOP (5) productid, unitprice 
FROM Production.Products
WHERE categoryid = 1
ORDER BY unitprice DESC, productid DESC; 


 -- OFFSET-FETCH exercises 
 -- 1. Write a set of queries that page through products, five at a time,
-- in unit price ordering, using the product ID as the tie breaker. 

SELECT productid, categoryid, unitprice
FROM Production.Products
ORDER BY unitprice DESC, productid DESC
OFFSET 0 ROWS FETCH FIRST 5 ROWS ONLY; 

-- 2. Write query that returns the next five rows (rows 6 through 10)
SELECT productid, categoryid, unitprice 
FROM Production.Products
ORDER BY unitprice, productid 
OFFSET 5 ROWS FETCH NEXT 5 ROWS ONLY; 

-- 3. Write the following query to return rows 11 through 15
SELECT productid, categoryid, unitprice
FROM Production.Products
ORDER BY unitprice, productid 
OFFSET 10 ROWS FETCH NEXT 5 ROWS ONLY; 