---------------------------------------------------------------------
-- TK 70-461 - Chapter 02 - Getting Started with the SELECT Statement
-- Code
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Lesson 01 - Using the FROM and SELECT Clauses
---------------------------------------------------------------------

---------------------------------------------------------------------
-- The FROM Clause
---------------------------------------------------------------------

USE TSQL2012;

-- basic example
SELECT empid, firstname, lastname
FROM HR.Employees;

SELECT empid, firstname, lastname
FROM HR.Employees; 

-- assigning a table alias
SELECT E.empid, firstname, lastname
FROM HR.Employees AS E;


SELECT E.empid, firstname, lastname 
FROM HR.Employees AS E; 
---------------------------------------------------------------------
-- The SELECT Clause
---------------------------------------------------------------------

-- projection of a subset of the source attributes
SELECT empid, firstname, lastname
FROM HR.Employees;

SELECT empid, firstname, lastname
FROM HR.Employees; 

-- bug due to missing comma
SELECT empid, firstname lastname
FROM HR.Employees;

SELECT empid, firstname + ' ' + lastname AS [Full Name] 
FROM HR.Employees;

-- aliasing for renaming
SELECT empid AS employeeid, firstname, lastname
FROM HR.Employees;

SELECT empid AS employeeid, firstname, lastname
FROM HR.Employees; 

-- expression without an alias
-- Recall, N' allows you to retrieve things much faster
SELECT empid, firstname + N' ' + lastname
FROM HR.Employees;

SELECT empid, firstname + N' ' + lastname 
FROM HR.Employees; 

-- aliasing expressions
SELECT empid, firstname + N' ' + lastname AS fullname
FROM HR.Employees;

-- removing duplicates with DISTINCT
SELECT DISTINCT country, region, city
FROM HR.Employees;

SELECT DISTINCT country, region, city 
FROM HR.Employees; 

-- SELECT without FROM
SELECT 10 AS col1, 'ABC' AS col2;

SELECT 10 AS col1, 'ABC' AS col2; 
---------------------------------------------------------------------
-- Lesson 02 - Working with Data Types and Built-In Functions
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Choosing the Appropriate Data Type
---------------------------------------------------------------------

-- approximate types
DECLARE @f AS FLOAT = '29545428.022495';
SELECT CAST(@f AS NUMERIC(28, 14)) AS value;

DECLARE @f AS FLOAT = '70330989393338.303830488'; 
SELECT CAST (@f AS NUMERIC(30, 12)) AS value; 

-- attempt to convert fails
SELECT CAST('abc' AS INT);

-- attempt to convert returns a NULL
SELECT TRY_CAST('abc' AS INT);

---------------------------------------------------------------------
-- Date and Time Functions
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Current Date and Time
---------------------------------------------------------------------

SELECT
  GETDATE()           AS [GETDATE],
  CURRENT_TIMESTAMP   AS [CURRENT_TIMESTAMP],
  GETUTCDATE()        AS [GETUTCDATE],
  SYSDATETIME()       AS [SYSDATETIME],
  SYSUTCDATETIME()    AS [SYSUTCDATETIME],
  SYSDATETIMEOFFSET() AS [SYSDATETIMEOFFSET];

SELECT 
	GETDATE()			AS [GETDATE], 
	CURRENT_TIMESTAMP	AS [CURRENT_TIMESTAMP], 
	GETUTCDATE()        AS [GETUTCDATE], 
	SYSDATETIME()		AS [SYSDATETIME], 
	SYSUTCDATETIME()	AS [SYSUTCDATETIME],
	SYSDATETIMEOFFSET() AS [SYSDATETIMEOFFSET]; 


SELECT
  CAST(SYSDATETIME() AS DATE) AS [current_date],
  CAST(SYSDATETIME() AS TIME) AS [current_time];


SELECT 
	CAST(SYSDATETIME() AS DATE) AS [Current_Date], 
	CAST(SYSDATETIME() AS TIME) AS [Current_Time];


---------------------------------------------------------------------
-- Date and Time Parts
---------------------------------------------------------------------

-- DATEPART
SELECT DATEPART(month, '20120212');

-- DAY, MONTH, YEAR
SELECT
  DAY('20120212') AS theday,
  MONTH('20120212') AS themonth,
  YEAR('20120212') AS theyear;

-- Date Part 
SELECT DATEPART(month, '20170222');

-- Day, month, year 
SELECT 
	DAY('20170222') AS theday,
	MONTH('20170222') AS themonth, 
	YEAR('20170222') AS theyear; 

-- DATENAME
SELECT DATENAME(month, '20090212');
SELECT DATENAME(month, '20090212');

-- fromparts
SELECT
  DATEFROMPARTS(2012, 02, 12),
  DATETIME2FROMPARTS(2012, 02, 12, 13, 30, 5, 1, 7),
  DATETIMEFROMPARTS(2012, 02, 12, 13, 30, 5, 997),
  DATETIMEOFFSETFROMPARTS(2012, 02, 12, 13, 30, 5, 1, -8, 0, 7),
  SMALLDATETIMEFROMPARTS(2012, 02, 12, 13, 30),
  TIMEFROMPARTS(13, 30, 5, 1, 7);

SELECT
	DATEFROMPARTS(2012, 02, 12),
	DATETIME2FROMPARTS(2012, 02, 12, 13, 30, 5, 1, 7),
	DATETIMEFROMPARTS(2012, 02, 12, 13, 30, 5, 997), 
	DATETIMEOFFSETFROMPARTS(2012, 02, 12, 13, 30, 5, 1, -8, 0, 7), 
	SMALLDATETIMEFROMPARTS(2012, 02, 12, 13, 30),
	TIMEFROMPARTS(13, 30, 5, 1, 7); 

-- EOMONTH
SELECT EOMONTH(SYSDATETIME());
SELECT EOMONTH(SYSDATETIME()); 

---------------------------------------------------------------------
-- Add and Diff Functions
---------------------------------------------------------------------

-- DATEADD
SELECT DATEADD(year, 1, '20120212');

SELECT DATEADD(year, 1, '20120212'); 

-- DATEDIFF
SELECT DATEDIFF(day, '20110212', '20120212');

SELECT DATEDIFF(day, '20110212', '20120212'); 
---------------------------------------------------------------------
-- Offset Related Functions
---------------------------------------------------------------------

-- SWITCHOFFSET
SELECT SWITCHOFFSET(SYSDATETIMEOFFSET(), '-05:00');
SELECT SWITCHOFFSET(SYSDATETIMEOFFSET(), '-08:00');

-- SWITCHOFFSET 
SELECT SWITCHOFFSET(SYSDATETIMEOFFSET(), '-05:00');
SELECT SWITCHOFFSET(SYSDATETIMEOFFSET(), '-08:00'); 

-- TODATETIMEOFFSET
/*
UPDATE dbo.T1
  SET dto = TODATETIMEOFFSET(dt, theoffset);
*/
-- example with both functions
SELECT 
  SWITCHOFFSET('20130212 14:00:00.0000000 -08:00', '-05:00') AS [SWITCHOFFSET],
  TODATETIMEOFFSET('20130212 14:00:00.0000000', '-08:00') AS [TODATETIMEOFFSET];

---------------------------------------------------------------------
-- Character Functions
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Concatenation
---------------------------------------------------------------------

-- Concatenation
SELECT empid, country, region, city,
  country + N',' + region + N',' + city AS location
FROM HR.Employees;

-- convert NULL to empty string
SELECT empid, country, region, city,
  country + COALESCE( N',' + region, N'') + N',' + city AS location
FROM HR.Employees;

-- using CONCAT
SELECT empid, country, region, city,
  CONCAT(country, N',' + region, N',' + city) AS location
FROM HR.Employees;

---------------------------------------------------------------------
-- Substring Extraction and Position
---------------------------------------------------------------------

SELECT SUBSTRING('abcde', 1, 3); -- 'abc'

SELECT LEFT('abcde', 3); -- 'abc'

SELECT RIGHT('abcde', 3); -- 'cde'

SELECT CHARINDEX(' ','Itzik Ben-Gan'); -- 6

SELECT PATINDEX('%[0-9]%', 'abcd123efgh'); -- 5

-- Substring Extraction and Position
SELECT SUBSTRING('abcde', 1, 3); -- selects 1 - 3 (abc) 
SELECT LEFT('abcde', 3);  -- selects left 3 (abc)
SELECT RIGHT('abcde', 3) -- selects cde
SELECT CHARINDEX(' ', 'Itzik Ben-Gan');   -- tells you the index of the space 
SELECT PATINDEX('%[0-9]%', 'abcd123efgh'); 

---------------------------------------------------------------------
-- String Length
---------------------------------------------------------------------

SELECT LEN(N'xyz'); -- 3

SELECT LEN(N'xyz'); -- character length - returns 3

SELECT DATALENGTH(N'xyz'); -- 6
SELECT DATALENGTH(N'xyz'); -- data length - returns 6 

---------------------------------------------------------------------
-- String Alteration
---------------------------------------------------------------------

SELECT REPLACE('.1.2.3.', '.', '/'); -- '/1/2/3/'

SELECT REPLACE('.1.2.3.', '.', '/'); 

SELECT REPLACE('.1.2.3', '.', '|'); 

SELECT REPLICATE('0', 10); -- '0000000000'

SELECT REPLICATE('0', 10); 

SELECT REPLICATE('7', 3); 

SELECT STUFF(',x,y,z', 1, 1, ''); -- 'x,y,z'

SELECT STUFF(',x,y,z', 1, 1, ''); 



---------------------------------------------------------------------
-- String Formating
---------------------------------------------------------------------

SELECT UPPER('aBcD'); -- 'ABCD'
SELECT UPPER('LOretta'); -- makes all upper case 

SELECT LOWER('aBcD'); -- 'abcd'
SELECT LOWER('xyZABC'); 

SELECT RTRIM(LTRIM('   xyz   ')); -- 'xyz'
SELECT RTRIM(LTRIM(' 23445 ')); 

SELECT FORMAT(1759, '000000000'); -- '0000001759'
SELECT FORMAT(1759, '0000000000'); 
---------------------------------------------------------------------
-- CASE Expression and Related Functions
---------------------------------------------------------------------

-- simple CASE expression
SELECT productid, productname, unitprice, discontinued,
  CASE discontinued
    WHEN 0 THEN 'No'
    WHEN 1 THEN 'Yes'
    ELSE 'Unknown'
  END AS discontinued_desc
FROM Production.Products;

-- kind of like if/else statement 
-- steps: first goes to production schema in products table 
-- selects productid, productname, unitprice, discontinued 
-- specifies in case of discontinued column - when 0, type no; when 1, type yes 
SELECT productid, productname, unitprice, discontinued, 
	CASE discontinued
		WHEN 0 THEN 'No'
		WHEN 1 THEN 'Yes'
		ELSE 'Unknown'
	END AS discontinued_desc
FROM Production.Products; 


-- searched CASE expression
SELECT productid, productname, unitprice,
  CASE
    WHEN unitprice < 20.00 THEN 'Low'
    WHEN unitprice < 40.00 THEN 'Medium'
    WHEN unitprice >= 40.00 THEN 'High'
    ELSE 'Unknown'
  END AS pricerange
FROM Production.Products;

SELECT productid, productname, unitprice,
	CASE
		WHEN unitprice < 20.00 THEN 'Low'
		WHEN unitprice < 40.00 THEN 'Medium'
		WHEN unitprice >= 40.00 THEN 'High'
		ELSE 'Unknown'
	END AS pricerange 
FROM Production.Products; 

-- COALESCE vs. ISNULL
DECLARE
  @x AS VARCHAR(3) = NULL,
  @y AS VARCHAR(10) = '1234567890';

SELECT COALESCE(@x, @y) AS [COALESCE], ISNULL(@x, @y) AS [ISNULL];


DECLARE 
	@x AS VARCHAR(3) = NULL,
	@y AS VARCHAR(10) = '1234567890'; 
SELECT COALESCE(@x, @y) AS [COALESCE], ISNULL(@x, @y) AS [ISNULL]; 
