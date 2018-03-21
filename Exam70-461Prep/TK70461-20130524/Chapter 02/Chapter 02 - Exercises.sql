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
-- Using Select clause, project the following attributes from the Sales.Shippers table
-- attributes: shipperid, companyname, phone 
SELECT S.shipperid, S.companyname, S.phone
FROM Sales.Shippers AS S; 

-- Use Column Aliases and Delimited Identifiers 
SELECT S.shipperid, S.companyname, S.phone AS [Phone Number] 
FROM Sales.Shippers AS S; 



--Generating surrogate keys 
-- Nonsequential GUIDs: nonsequential global unique identifiers stored in an attribute of a UNIQUEIDENTIFIER type 
-- GUIDS can be generated anywhere and not conflict across time & space 


-- Date & Time Functions: https://msdn.microsoft.com/en-us/library/ms186724(v=SQL.110).aspx
 
-- Remember, to retrieve the attribute, always begin statements with SELECT!
-- Return system date & time 
SELECT SYSDATETIME(); 

-- include time zone offset
SELECT SYSDATETIMEOFFSET(); 

-- Lower-precision system date and time functions 
SELECT CURRENT_TIMESTAMP; 

SELECT GETDATE(); 

-- Get Date and Time Parts 
SELECT DATEPART(month, '20180310'); -- returns month as integer 3
SELECT DATENAME(month, '20180310'); -- returns month attribute as character 

-- Add and Diff 
-- use DATEADD to add # of units to date 
SELECT DATEADD(year,1,'20180310'); 
SELECT DATEADD(month, 5,'20180310'); 
SELECT DATEADD(day, 7, '20180310');

-- use DATEDIFF
-- returns difference in terms of requested part vtw 2 date and time values 
SELECT DATEDIFF(day, '20110212', '20120212'); -- difference btw Feb 12 2012 & Feb 12 2011
SELECT DATEDIFF(month,'20110212', '20110512'); 
SELECT DATEDIFF(year, '20170310', '18700310');

-- Offset : **kind of confused as to what this does...
-- Use SWITCHOFFSET to return an input DATETIMEOFFSET value in a requested offset term 
SELECT SWITCHOFFSET(SYSDATETIMEOFFSET(), '-08:00'); 

SELECT 
	SWITCHOFFSET('20130212 14:00:00.0000000 -08:00', '-05:00') AS [SWITCHOFFSET],
	TODATETIMEOFFSET('20130212 14:00:00.0000000', '-08:00') AS [TODATETIMEOFFSET]; 

-- Character Functions 
-- returns nulls
SELECT empid, country, region , city, 
	country + N',' + region + N',' + city AS location 
FROM HR.Employees;

-- In location section, nulls replaced with empty strings 
-- use COALESE to replace Null with empty string
SELECT empid, country, region, city,
	country + COALESCE(N',' + region, N'') + N',' + city AS location 
FROM HR.Employees; 

-- Use CHARINDEX to combine or nest functions in the same expression 
SELECT LEFT(fullname, CHARINDEX('', fullname)-1);  

-- String Length 
SELECT LEN(N'xyz'); 

-- Remove first character from input string
--SELECT STUFF(',x,y,z', 1,1,"); NOT WORKING...


-- CASE epxressions and Related Functions 
-- simple form of CASE expression: compares expressions 
SELECT productid, productname, unitprice, discontinued,   
	CASE discontinued  
		WHEN 0 THEN 'No'
		WHEN 1 THEN 'Yes'
		ELSE 'Unknown'
	END AS discounted_desc
FROM Production.Products; 

-- searched form (more flexible than simple form)
SELECT productid, productname, unitprice,
	CASE 
		WHEN unitprice < 20.00 THEN 'Low'
		when unitprice < 40.00 THEN 'Medium'
		WHEN unitprice >= 40.00 THEN 'High'
		ELSE 'Unknown'
	END AS pricerange 
FROM Production.Products; 

SELECT empid, country, region, city, 
	country + COALESCE( N',' + region, N'') + N',' + city AS location 
FROM HR.Employees;

SELECT SUBSTRING('abcde', 1, 3);  

-- Example with Coalesce 
DECLARE 
	@x AS VARCHAR(3) = NULL, 
	@y AS VARCHAR(10) = '123456789'; 

SELECT COALESCE(@x, @y) AS [COALESCE], ISNULL(@x, @y) AS [ISNULL]; 

SELECT CHOOSE(2, 'x', 'y', 'z'); 
SELECT CHOOSE(3, 'A', 'B', 'C', 'D');


-- pp. 54 - Excersise 1 : Apply String Concatenation and Use a Date and Time Function 
SELECT empid, 
	firstname + N' ' + lastname AS fullname, 
	YEAR(birthdate) AS birthyear 
FROM HR.Employees; 

-- write query to return the following attributes: employee ID, full name (concatenate attributes firstname, space, & lastname) & birth year 
SELECT * 
FROM HR.Employees; 

SELECT E.empid,
	firstname + N' ' + lastname AS [Full Name], 
	E.birthdate
FROM HR.Employees AS E; 











