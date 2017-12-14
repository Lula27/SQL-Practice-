--******************************************
-- 05_04_Using_TOP.sql
--******************************************
-- Aggregate functions allow you to perform calculations on 
-- the values in the query. 
-- Result = single value for use in result set (scalar functions)
-- Ex: SUM, AVG, MIN, MAX 
USE AdventureWorks2012;
GO

-- Use COUNT to determine the number of records 
-- that match a criteria in this case, we want to 
-- know how many employees we have in the table
-- so we use the COUNT(*) clause
SELECT COUNT(*) 
FROM HumanResources.Employee; 
GO 




-- Use COUNT with DISTINCT to determine the number 
-- of records that match a criteria in this case, 
-- we want to know how many titles we have for 
-- employees so we use the 
-- COUNT(DISTINCT JobTitle) clause
SELECT COUNT(DISTINCT JobTitle)
	AS [Number of Titles] 
FROM HumanResources.Employee; 
GO 



-- Use the average (AVG) function to calculate the 
-- average number of sick days that employees 
-- have accumulated
SELECT AVG(VacationHours) AS [Average Vacation Hours]
FROM HumanResources.Employee;
GO 



-- Use MAX to return the maximum value in an 
-- expression. In this case we check to see what 
-- the maximum number of vacation hours an 
-- employee has accumulated. 
-- MAX ignores NULL values but will work on 
-- character values and uses the configured 
-- collating sequence of the SQL instance
SELECT MAX(VacationHours) AS [Maximum vacay hours] 
FROM HumanResources.Employee; 
GO




-- Use MIN to return the minimum value in an 
-- expression. In this case we check to see what 
-- the lowest number of vacation hours an employee 
-- has accumulated.
-- MIN ignores NULL values but will work on 
-- character values and uses the configured 
-- collating sequence of the SQL instance
SELECT MIN(VacationHours) AS [Minimum Vacation Hours] 
FROM HumanResources.Employee;
GO 


-- Use SUM to return the cumulative value in an 
-- expression. In this case we check to see what 
-- the total number of vacation hours all 
-- employees have accumulated
SELECT SUM(VacationHours) AS [Total Vacation Hours]
FROM HumanResources.Employee;
GO 

-- Use VAR (spread from mean) to return the statistical variance of 
-- all values in an expression.
-- In this case we check to see what the variance 
-- is in vacation hours all employees 
-- have accumulated
SELECT VAR(VacationHours) AS [Vacation Hours Variance]
FROM HumanResources.Employee; 
GO 

-- You can also mix aggregates in the same query 
-- by specifying the function and including the 
-- appropriate field name in the parentheses.
-- Here we will check the MIN, MAX, and SUM of 
-- vacation hours along with the SUM of sick 
-- days and the date of the last employee hire
SELECT MIN(VacationHours) AS [Minimum Vacation Hours],
	MAX(VacationHours) AS [Maximum Vacation Hours], 
	SUM(VacationHours) AS [Maximum Vacation Hours], 
	SUM(SickLeaveHours) AS [Total Sick Leave Hours], 
	MAX (HireDate) AS [Last Hire Date]
FROM HumanResources.Employee;
GO 


