-- Sorting Data
---------------------------------------------------------------------
USE TSQL2012; 

-- query with no ORDER BY doesn't guarantee presentation ordering
-- might look like it b/c of SQL's internal optimization but that can change 
SELECT empid, firstname, lastname, city, MONTH(birthdate) AS birthmonth
FROM HR.Employees
WHERE country = N'USA' AND region = N'WA';

-- Simple ORDER BY example
-- default is ASC but if a column doesn't have unique values, order might not be deterministic 
SELECT empid, firstname, lastname, city, MONTH(birthdate) AS birthmonth
FROM HR.Employees
WHERE country = N'USA' AND region = N'WA'
ORDER BY city;

SELECT empid, firstname, lastname, city, MONTH(birthdate) AS birthmonth 
FROM HR.Employees
WHERE country = N'USA' AND region = N'WA'
ORDER BY city; 

-- add additional columns to get something more concrete 
SELECT empid, firstname, lastname, city, MONTH(birthdate) AS birthmonth 
FROM HR.Employees
WHERE country = N'USA' AND region = N'WA'
ORDER BY empid, city; 

-- use descending order
SELECT empid, firstname, lastname, city, MONTH(birthdate) AS birthmonth
FROM HR.Employees
WHERE country = N'USA' AND region = N'WA'
ORDER BY city DESC;

-- order by multiple columns
SELECT empid, firstname, lastname, city, MONTH(birthdate) AS birthmonth
FROM HR.Employees
WHERE country = N'USA' AND region = N'WA'
ORDER BY city, empid;

-- order by ordinals (bad practice)
-- don't bother - just a bad idea since tables are sets that don't have order, why use ordinal notation? 
SELECT empid, firstname, lastname, city, MONTH(birthdate) AS birthmonth
FROM HR.Employees
WHERE country = N'USA' AND region = N'WA'
ORDER BY 4, 1;

-- change SELECT list but forget to change ordinals in ORDER BY
SELECT empid, city, firstname, lastname, MONTH(birthdate) AS birthmonth
FROM HR.Employees
WHERE country = N'USA' AND region = N'WA'
ORDER BY 4, 1;

-- order by elements not in SELECT
SELECT empid, city
FROM HR.Employees
WHERE country = N'USA' AND region = N'WA'
ORDER BY birthdate;

-- when DISTINCT specified, can only order by elements in SELECT

-- following fails
SELECT DISTINCT city
FROM HR.Employees
WHERE country = N'USA' AND region = N'WA'
ORDER BY birthdate;

-- following succeeds
SELECT DISTINCT city
FROM HR.Employees
WHERE country = N'USA' AND region = N'WA'
ORDER BY city;

SELECT DISTINCT city 
FROM HR.Employees
WHERE country = N'USA' AND region = N'WA'
ORDER BY city; 

-- can refer to column aliases asigned in SELECT
-- this is because order by is evaluated after select 
SELECT empid, firstname, lastname, city, MONTH(birthdate) AS birthmonth
FROM HR.Employees
WHERE country = N'USA' AND region = N'WA'
ORDER BY birthmonth;

SELECT empid, firstname, lastname, city, MONTH(birthdate) AS birthmonth 
FROM HR.Employees
WHERE country = N'USA' AND region = N'WA'
ORDER BY birthmonth; 

-- NULLs sort first
SELECT orderid, shippeddate
FROM Sales.Orders
WHERE custid = 20
ORDER BY shippeddate;

-- try to change sort order of nulls using CASE statement: nope - didn't work
SELECT orderid, shippeddate 
FROM Sales.Orders  
ORDER BY 
(CASE 
	WHEN shippeddate IS NULL THEN orderid
	ELSE shippeddate 
END); 


-- Excercises pg 81 
-- #1. Write a query that 