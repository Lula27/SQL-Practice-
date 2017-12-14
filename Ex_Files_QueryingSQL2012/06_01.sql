--********************************************
-- 06_01_Queries_using_Date_Time.sql
--********************************************
-- Take away: best to use language neutral settings when working with SQL server 

USE AdventureWorks2012;
GO

-- Query the Employee table to see the format 
-- that the HireDate field uses.
SELECT LoginID, HireDate
FROM HumanResources.Employee;
GO

-- Query the hire date for a value of 
-- February 15, 2003 using language neutral format
SELECT LoginID, HireDate
FROM HumanResources.Employee
WHERE HireDate = '20030215'; -- Language neutral format 
GO

-- Query the hire date for a value of February 15, 
-- 2003 using US-based format
SELECT LoginID, HireDate
FROM HumanResources.Employee
WHERE HireDate = '02-15-2003'; -- US based format
GO

-- Query the hire date for a value of February 15, 
-- 2003 using Canadian format
SELECT LoginID, HireDate
FROM HumanResources.Employee
WHERE HireDate = '15-02-2003';   -- International format (Canadian/British): failed translation b/c SQL format doesn't recognize format: sql version set for US based install
GO

-- Query the hire date for a value between 
-- Jan. 1, 2000 and Dec. 31, 2002
SELECT LoginID, HireDate
FROM HumanResources.Employee
WHERE HireDate BETWEEN '20000101' AND '20021231'; -- range: Jan 1st, 2000 to Dec 31, 2002
GO

-- Query the hire date for a value between 
-- Jan. 1, 2000 and Dec. 31, 2002 using 
-- comparison operators
-- Range between the two + inclusive 
SELECT LoginID, HireDate
FROM HumanResources.Employee
WHERE HireDate >= '20000101' 
	AND HireDate <= '20021231';
GO


-- Query the hire date field returning only the 
-- year portion of the date
-- using the DATEPART function.  Replace YEAR 
-- with MONTH or DAY to get those parts
SELECT DATEPART(YEAR, HireDate) AS [Hire Date]
FROM HumanResources.Employee;
GO

-- Try for day 
SELECT DATEPART(DAY, HireDate) AS [Hire Day]
FROM HumanResources.Employee;
GO

-- Query the hire date field returning only the 
-- month portion of the date using the 
-- DATENAME function
SELECT DATENAME(MONTH, HireDate) AS [Hire Month]
FROM HumanResources.Employee;
GO

-- Query the hire date field returning only the 
-- day portion of the date using the DATENAME 
-- function, but ask for the name of the week day
SELECT DATENAME(WEEKDAY, HireDate) AS [Week Day Hired]
FROM HumanResources.Employee;
GO

-- Use the DATEDIFF function to determine the 
-- elasped time between two dates
-- in this case, we are asking for the number of 
-- years between the first hire date and the last 
-- hire date.
-- This query adds some complexity in that we are 
-- using MIN and MAX in the parameters for the 
-- DATEDIFF function.  
-- Play around with replacing the YEAR parameter 
-- with DAY or MONTH to see the results.
SELECT DATEDIFF(YEAR, MIN(HireDate), MAX(HireDate) ) AS [Years between first and last hire]-- range: btw min & max hire date year
FROM HumanResources.Employee;
GO

-- Use the DATEADD function to show how you can 
-- change the value of date parts this is a 
-- contrived example where we are simply adding 
-- 2 to the month value in the returned results.  
-- In the real-world, you might do this to change 
-- the values in the database if you wanted to 
-- modify a membership date extension as an 
-- example.
SELECT HireDate, DATEADD(MONTH, 2, HireDate) 
	AS [Modified Date]
FROM HumanResources.Employee;
GO

-- Use the SYSDATETIME() function to return the 
-- current system date and time
SELECT SYSDATETIME();
GO

-- Use the SYSDATETIME() function to return the 
-- current system date and time
-- including the offset from UTC time (-05 = five hours behind UTC - Grenish?)
SELECT SYSDATETIMEOFFSET();
GO

-- Use the TIMEFROMPARTS() function to output 
-- integer values into a time format
SELECT TIMEFROMPARTS(22,45,0,0,0);  --hours, minutes, seconds, millisecs
GO