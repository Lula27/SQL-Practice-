---------------------------------------------------------------------
-- TK 70-461 - Chapter 01 - Querying Foundations
-- Exercises
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Lesson 01 - Using T-SQL in a Relational Way
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Practice - Using T-SQL in a Relational Way
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Exercise 1: Identify Nonrelational Elements in a Query
---------------------------------------------------------------------

-- 2.

USE TSQL2012;

SELECT custid, YEAR(orderdate)
FROM Sales.Orders
ORDER BY 1, 2;


SELECT custid, YEAR(orderdate) AS [Year]
FROM Sales.Orders
ORDER BY 1, 2; 
---------------------------------------------------------------------
-- Exercise 2: Make the Nonrelational Query Relational
---------------------------------------------------------------------

-- 1.

SELECT DISTINCT custid, YEAR(orderdate) AS orderyear
FROM Sales.Orders;

SELECT DISTINCT custid, YEAR(orderdate) AS orderyear 
FROM Sales.Orders; 

---------------------------------------------------------------------
-- Lesson 02 - Logical Query Processing
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Practice - Logical Query Processing
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Exercise 1: Fix Problem with Grouping
---------------------------------------------------------------------

-- 2.

-- fails
SELECT custid, orderid
FROM Sales.Orders
GROUP BY custid;

-- 3.

SELECT custid, MAX(orderid) AS maxorderid
FROM Sales.Orders
GROUP BY custid;

SELECT custid, MAX(orderid) AS maxorderid
FROM Sales.Orders
GROUP BY custid; 
---------------------------------------------------------------------
-- Exercise 2: Fix Problem with Aliasing
---------------------------------------------------------------------

-- 1.

SELECT shipperid, SUM(freight) AS totalfreight
FROM Sales.Orders
WHERE freight > 20000.00
GROUP BY shipperid;

SELECT shipperid, SUM(freight) AS totalfreight 
FROM Sales.Orders
WHERE freight > 20000.00
GROUP BY shipperid; 

-- 2.

-- fails
SELECT shipperid, SUM(freight) AS totalfreight
FROM Sales.Orders
GROUP BY shipperid
HAVING totalfreight > 20000.00;

-- 3.

SELECT shipperid, SUM(freight) AS totalfreight
FROM Sales.Orders
GROUP BY shipperid
HAVING SUM(freight) > 20000.00;

SELECT shipperid, SUM(freight) AS totalfrieght 
FROM Sales.Orders
GROUP BY shipperid
HAVING SUM(freight) > 20000.00; 

SELECT empid, lastname
FROM HR.Employees 
ORDER BY 1; 

SELECT empid, lastname 
FROM HR.Employees
ORDER BY 1; 

SELECT custid AS [Customer Id], YEAR(orderdate) AS Year 
FROM Sales.Orders
ORDER BY 1, 2; 



-- Using T-SQL in a Relational Way
-- WRONG!!!! - EXPLAIN WHY THE FOLLOWING IS INCORRECT 
SELECT custid, YEAR (orderdate)
FROM Sales.Orders
ORDER BY 1, 2; 

-- Relational = predicate logic, set theory (no order, no duplicates)
-- duplicates in years; use distinct 

-- What's wrong: no alias for YEAR, returns duplicates
-- Query forces certain presentation ordering to result and uses ordinal positions in ORDER BY clause 

-- CORRECTION
SELECT DISTINCT custid AS [Customer Id], YEAR (orderdate) AS [Order Date]
FROM Sales.Orders
ORDER BY 1; 

SELECT DISTINCT custid AS [Customer Id], YEAR(orderdate) AS [Order Date]
FROM Sales.Orders
ORDER BY 1; 