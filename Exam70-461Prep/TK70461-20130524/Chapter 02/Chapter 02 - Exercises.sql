---------------------------------------------------------------------
-- TK 70-461 - Chapter 02 - Getting Started with the SELECT Statement
-- Exercises
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Lesson 01 - Using the FROM and SELECT Clauses
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Practice - Using the FROM and SELECT Clauses
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Exercise 1: Writing a Simple Query and Using Table Aliases
---------------------------------------------------------------------

-- 2.


USE TSQL2012;

SELECT shipperid, companyname, phone
FROM Sales.Shippers;

-- Get it faster
SELECT S.shipperid, S.companyname, S.phone
FROM Sales.Shippers AS S; 

-- 3.

SELECT S.shipperid, companyname, phone
FROM Sales.Shippers AS S;

SELECT SS.shipperid, SS.phone, SS.companyname
FROM Sales.Shippers AS SS; 

---------------------------------------------------------------------
-- Exercise 2: Using Column Aliases and Delimited Identifiers
---------------------------------------------------------------------


-- 1.

SELECT S.shipperid, companyname, phone AS phone number
FROM Sales.Shippers AS S;

-- 2.

SELECT S.shipperid, companyname, phone AS [phone number]
FROM Sales.Shippers AS S;

SELECT SS.shipperid, SS.companyname, SS.phone AS [phone number]
FROM Sales.Shippers AS SS; 

---------------------------------------------------------------------
-- Lesson 02 - Working with Data Types and Built-In Functions
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Practice - Working with Data Types and Built-in Functions
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Exercise 1: Apply String Concatenation and Use a Date and Time Function
---------------------------------------------------------------------

-- 2.
-- N' ' gets info to load faster 
SELECT empid, 
  firstname + N' ' + lastname AS fullname, 
  YEAR(birthdate) AS birthyear
FROM HR.Employees;

SELECT empid, 
	firstname + N' ' + lastname AS [Full Name], 
	YEAR(birthdate) AS [Birth Year] 
FROM HR.Employees; 

---------------------------------------------------------------------
-- Exercise 2: Use Additional Date and Time Functions
---------------------------------------------------------------------

-- 1.

-- end of current month
SELECT EOMONTH(SYSDATETIME()) AS end_of_current_month;
SELECT DATEFROMPARTS(YEAR(SYSDATETIME()), 12, 31) AS end_of_current_year;

SELECT EOMONTH(SYSDATETIME()) AS end_of_current_month; 
SELECT DATEFROMPARTS(YEAR(SYSDATETIME()), 12, 31) AS end_of_current_year; 
---------------------------------------------------------------------
-- Exercise 3: Use String and Conversion Functions
---------------------------------------------------------------------

-- 1.

-- using string functions
SELECT productid, 
  RIGHT(REPLICATE('0', 10) + CAST(productid AS VARCHAR(10)), 10) AS str_productid
FROM Production.Products;


SELECT productid, 
	RIGHT(REPLICATE('0', 10) + CAST(productid AS VARCHAR(10)), 10) AS str_productid 
FROM Production.Products; 



-- 2.

-- using FORMAT
SELECT productid, 
  FORMAT(productid, 'd10') AS str_productid
FROM Production.Products;

SELECT productid,
	FORMAT(productid, 'd10') AS str_productid
FROM Production.Products; 

-- Book practice 
