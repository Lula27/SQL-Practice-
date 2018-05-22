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


DECLARE @pagesize AS BIGINT = 25, @pagenum AS BIGINT = 3; 

SELECT orderid, orderdate, custid, empid 
FROM Sales.Orders 
ORDER BY orderdate DESC, orderid DESC 
OFFSET (@pagenum - 1) * @pagesize ROWS FETCH NEXT @pagesize ROWS ONLY; 
GO 