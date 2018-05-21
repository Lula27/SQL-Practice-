-- TK 70-461 - Chapter 03 - Filtering and Sorting Data
-- Code
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Lesson 01 - Filtering Data with Predicates
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Predicates, Three-Valued-Logic and Search Arguments
---------------------------------------------------------------------

USE TSQL2012;

-- content of Employees table
SELECT empid, firstname, lastname, country, region, city
FROM HR.Employees

-- employees from the United States
SELECT empid, firstname, lastname, country, region, city
FROM HR.Employees
WHERE country = N'USA';

SELECT empid, firstname, lastname, country, region, city 
FROM HR.Employees
WHERE country = N'USA'; 

-- employees from Washington State
SELECT empid, firstname, lastname, country, region, city
FROM HR.Employees
WHERE region = N'WA';

SELECT empid, firstname, lastname, country, region, city
FROM HR.Employees
WHERE region=N'WA'; 

-- employees that are not from Washington State
-- This example is incorrect 
SELECT empid, firstname, lastname, country, region, city
FROM HR.Employees
WHERE region <> N'WA';

-- employees that are not from Washington State, resolving the NULL problem: corrected above 
SELECT empid, firstname, lastname, country, region, city
FROM HR.Employees
WHERE region <> N'WA'
   OR region IS NULL;

SELECT empid, firstname, lastname, country, region, city
FROM HR.Employees
WHERE region IS NULL; 

-- orders shipped on a given date
DECLARE @dt DATETIME = '20070212';
SELECT @dt AS Mydate 
	, DATALENGTH(@Mydate) AS StorageSpace;

DECLARE @dt AS DATETIME = '20070212'; 

-- incorrect treatment of NULLs
SELECT orderid, orderdate, empid
FROM Sales.Orders
WHERE shippeddate = @dt;

-- correct treatment but not SARG
SELECT orderid, orderdate, empid
FROM Sales.Orders
WHERE COALESCE(shippeddate, '19000101') = COALESCE(@dt, '19000101');

-- correct treatment and also a SARG
SELECT orderid, orderdate, empid
FROM Sales.Orders
WHERE shippeddate = @dt
   OR (shippeddate IS NULL AND @dt IS NULL);

SELECT orderid, orderdate, empid 
FROM Sales.Orders
WHERE shippeddate IS NULL AND @dt IS NULL; 

-- why does code above result in this error? Msg 137, Level 15, State 2, Line 3
-- Must declare the scalar variable "@dt".

---------------------------------------------------------------------
-- Combining Predicates
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Filtering Character Data
---------------------------------------------------------------------

-- regular character string
SELECT empid, firstname, lastname
FROM HR.Employees
WHERE lastname = 'Davis';

-- Unicode character string
SELECT empid, firstname, lastname
FROM HR.Employees
WHERE lastname = N'Davis';

SELECT empid, firstname, lastname 
FROM HR.Employees
WHERE lastname = N'Davis'; 

-- employees whose last name starts with the letter D.
SELECT empid, firstname, lastname
FROM HR.Employees
WHERE lastname LIKE N'D%';

SELECT empid, firstname, lastname 
FROM HR.Employees
WHERE lastname LIKE N'D%'; 

---------------------------------------------------------------------
-- Filtering Date and Time Data
---------------------------------------------------------------------

-- language-dependent literal
SELECT orderid, orderdate, empid, custid
FROM Sales.Orders
WHERE orderdate = '02/12/07';

-- language-neutral literal
SELECT orderid, orderdate, empid, custid
FROM Sales.Orders
WHERE orderdate = '20070212';

SELECT orderid, orderdate, empid, custid 
FROM Sales.Orders
WHERE orderdate = '20070212'; 

-- not SARG
SELECT orderid, orderdate, empid, custid
FROM Sales.Orders
WHERE YEAR(orderdate) = 2007 AND MONTH(orderdate) = 2;

-- SARG
SELECT orderid, orderdate, empid, custid
FROM Sales.Orders
WHERE orderdate >= '20070201' AND orderdate < '20070301';

SELECT orderid, orderdate, empid, custid 
FROM Sales.Orders 
WHERE orderdate >= '20070201' AND orderdate < '20070301'; 
