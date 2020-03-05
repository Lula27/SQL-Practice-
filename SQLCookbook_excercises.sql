-- SQL Cookbook Exercises 

-- Chapter 1: Retrieving Records 
USE HRMS; 

SELECT * FROM emp;

-- Alternative to * is to list out all tables
-- Specify each column individually when writing program code 

SELECT empno, ename, job, mgr, hiredate, sal, comm, deptno
FROM emp;

-- WHERE clause used with condition (supporting operators: =, <, >, <=, >=,!, <>
-- Return all from emp table where department number not equal to 10
SELECT * 
FROM emp
WHERE deptno != 10; 


-- Return rows that satisfy multiple conditions 
-- Return all employees in dept 10, along with any employees 
-- who earn a commission, along with any employees in department 20
-- who earn at most $2000

-- Returns 9 entries 
SELECT * 
FROM emp
WHERE deptno = 10 
	OR comm is NOT NULL 
	OR sal <= 2000 AND deptno = 20; 

-- Consider change with parentasis 
-- Returns two entries 
SELECT * 
FROM emp 
WHERE (		deptno = 10
		OR comm IS NOT NULL 
		OR sal <= 2000 
		)
	AND deptno = 20; 


-- 1.4: Retrieving Subset of Columns from Table 
-- Return only the following information for employees: 
-- name, dept number, salary 

SELECT ename, deptno, sal 
FROM emp; 


-- 1.5 Aliasing Column Names 
-- Change names of columns returned for enhanced readability

SELECT ename AS [employee name], deptno AS [department name], sal AS salary
FROM emp;


SELECT ename AS [Employee Name], sal AS Salary, comm AS Commission
FROM emp;


-- 1.6: Use inline view to reference an Aliased Column in WHERE clause 
-- Inline view (aliased as x) to select salary and commission where Salary > 5000
SELECT * 
	FROM (
SELECT sal AS Salary, comm AS Commission 
	FROM emp
	) x
WHERE Salary < 5000; 


-- Inline view to select name, Salary, Commission where commission less than or equal to 500
SELECT * 
	FROM (
SELECT ename AS [Employee Name], sal AS Salary, comm AS Comission
	FROM emp
	) x 
WHERE Comission <= 500;


-- 1.7 Concatenating Column Values 

SELECT ename, job
FROM emp
WHERE deptno = 10; 

-- Concat to print out name and works as a 

-- MySQL database supports CONCAT function 
SELECT CONCAT(ename, ' WORKS AS A ', job) as [Message about title]
FROM emp 
WHERE deptno = 10;


-- SQL Server supports + operator 
SELECT ename + ' ROLE IN THIS COMPANY IS THE ' + job AS [Employee's Role in Company]
FROM emp
WHERE deptno = 10; 


-- 1.8: CASE expression: Conditional Logic in SELECT statement
-- Return message of UNDERPAID if employee is paid $2000 or less
-- Return message of OVERPAID if employee is paid $4000 or more
-- Return ADEQUATEPAY if employee makes between $2000 and $4000

SELECT ename, sal,
	CASE WHEN sal <= 2000 THEN 'UNDERPAID'
		 WHEN sal >= 4000 THEN 'OVERPAID'
		 ELSE 'ADEQUATELY PAID'
	END AS Status -- CASE expression aliased as Status 
FROM emp; 


-- Print out high/low deptno (low if deptno = 10) / high if deptno > 20; if = 20, mid level 
SELECT ename, job, deptno,
	CASE WHEN deptno = 10 THEN 'LOW LEVEL'
		WHEN deptno > 20 THEN 'HIGH LEVEL'
		ELSE 'MID LEVEL'
	END AS Status 
FROM emp; 


-- Selection and print out based on mgr id 
SELECT ename, job, mgr,
	CASE WHEN deptno < 7788 THEN 'ENTRY LEVEL MANAGER'
		 WHEN deptno = 7839 THEN 'MID LEVEL MANAGER'
		 ELSE 'HIGH LEVEL MANAGER'
	END AS Status 
FROM emp;



-- 1.9 Limit Number of Rows Returned

SELECT TOP 5 *
FROM emp; 

SELECT TOP 10 ename, hiredate, sal,
	CASE WHEN sal < 1250.00 THEN 'LOW SALARY'
		ELSE 'HIGH SALARY'
	END AS STATUS 
FROM emp;


-- 1.10 Return n Random Records from Table

SELECT TOP 5 ename, job 
FROM emp
ORDER BY newid(); 



-- 1.11 Find Null Values 
-- Can't use = or != when searching for nulls cus null isn't a value 

SELECT * 
FROM emp 
WHERE comm IS NULL; 


-- 1.12 Transform Nulls into Real Values
-- Using coalesce doesn't change new values 

SELECT COALESCE(comm, 0)
FROM emp;

SELECT ename, mgr, COALESCE(comm, 1000)
FROM emp; 


-- Replace null using case 
SELECT CASE 
	WHEN comm IS NOT NULL THEN comm 
	ELSE 0 
	END 
FROM emp; 


-- 1.13 Searching for Patterns
SELECT ename, job
FROM emp 
WHERE deptno IN (10,20); 


SELECT TOP 5 ename, job, sal
FROM emp 
WHERE deptno IN (20, 30); 


-- When searching for text, use wildcard (%) operator
SELECT ename, job 
FROM emp 
WHERE deptno in (20, 30) 
	AND (ename LIKE '%I%' OR job LIKE '%ER'); 



-- Chapter 2: Sorting Query Results 
-- Order results in set using Order By 
-- Display names, jobs and salaries (from lowest to highest) of employees in department 10 
-- In order based on their salary (lowest to highest) 
-- By default Order By: asc - ascending order; use desc for descending order
Select ename, job, sal
From emp
Where deptno = 10
Order by sal asc;  

Select ename, job, sal
From emp 
Where deptno = 10 
Order by sal desc; 


-- Select name, job, sal, dept ordering results by hiredate - most recent to earlies

Select hiredate, ename, job, sal, deptno
From emp
Order by hiredate desc; 


-- Using position of column to order by 
Select ename, job, sal
From emp
Where deptno = 10 
Order by 3 desc; 


-- Get average salary by deptno 
Select deptno, avg(sal) As [Average Salary]
From emp 
Group by deptno;


-- 2.2 Sorting by Multiple Fields 
-- Sort rows from emp first by deptno ascending
-- Then sort by salary descending 

Select empno, deptno, sal, ename, job 
From emp
Order by deptno asc, sal desc; 


-- 2.3 Sorting by Substrings
-- Return employee names and jobs from emp table 
-- Sort by last two characters in job field 
 
Select ename, job
From emp 
Order by substring(job, len(job)-1, 2)

Select ename, job
From emp 
Order by substring(job, len(job)-1, 3)

-- Try by name 
Select ename, job
from emp 
Order by substring(ename, len(ename)-1, 2) 


-- 2.4 Dealing with Nulls When Sorting
-- Sort results from emp by Comm (nullable) - specify nulls sort last or first 

-- Sort nulls first 
Select ename, sal, comm
From emp
Order by comm; 


-- Sort nulls last 
Select ename, sal, comm
From emp 
Order by comm desc; 


-- Use CASE expression to flag when value is null
-- Sort by nulls last 
Select ename, sal, comm
From (
Select ename, sal, comm, 
	Case When comm is null Then 0 Else 1 End As is_null
From emp
) x 
Order by is_null desc, comm


-- Sort by nulls first 
Select ename, sal, comm
From (
Select ename, sal, comm, 
	Case When comm is null Then 0 Else 1 End As is_null
From emp
) x 
Order by is_null asc, comm



-- Include is null binary 
Select ename, sal, comm, 
	Case When comm Is Null Then 0 Else 1 End As is_null
From emp; 


-- 2.6: Sorting on Data Dependent Key 


-- Produce column that gives 1 if salesperson, 0 otherwise
Select ename, sal, job, comm, 
	Case When job = 'SALESMAN' Then 1 Else 0 End As is_SalesPerson
From emp; 

-- Goal: Sort on comm if job is 'Salesman'
-- Otherwise: Sort by sal 
Select ename, sal, job, comm 
From emp 
Order by Case When job = 'SALESMAN' Then comm Else sal End; 


-- Use Case Expression to dynamically change how results are sorted 

Select ename, sal, job, comm, 
	Case When job = 'SALESMAN' Then comm Else sal End AS ordered 
From emp 
Order by 5;



-- Chapter 3: Working with Multiple Tables (Joins, Set Operations, etc.) 

-- 3.1: Stacking One Rowset Atop Another 
-- Union All: Return data stored in more than 1 table w/o key
-- Union All: combines rows from multiple row sources into 1 result set 

-- Not working...
Select ename as ename_and_dname, deptno
From emp
Where deptno = 10 
Union all 

-- Try again...

-- Use Union (no duplicates) to combine sets from emp & dept 
Select deptno
	From emp 
Union 
Select deptno
	From dept 

-- Union All (duplicates) 
Select deptno
	From emp 
Union All 
Select deptno 
	From dept; 


-- 3.2: Combine Related Rows 
-- Return rows from multiple tables by joining on known column 

-- Example below = equi-join (type of inner join) 
Select e.ename, d.loc 
	From emp e, dept d 
Where e.deptno = d.deptno
	And e.deptno = 10; 


-- Cartesian product (all possible combinations of rows) 
-- Don't do for large datasets (too computationally expensive) 
Select e.ename, d.loc, 
	e.deptno as emp_deptno, 
	d.deptno as dept_deptno 
From emp e, dept d 
Where e.deptno = 10; 


-- Alternative with explicit join 
Select e.ename, d.loc
	From emp e inner join dept d 
		On (e.deptno = d.deptno)
	Where e.deptno = 10; 


-- 3.3 Finding Rows in Common Between Two Tables 
-- Example view: 

Create View V 
As 
Select ename, job, sal 
	From emp 
Where job = 'CLERK'; 

Select * From V; 


-- Return empno, ename, job, sal & deptno of all employees in emp that match rows from view V

Select e.empno, e.ename, e.job, e.sal, e.deptno 
	From emp e, V
Where e.ename = v.ename
	And e.job = v.job 
	And e.sal = v.sal 

-- Performs same join with Join clause 
Select e.empno, e.ename, e.job, e.sal, e.deptno 
	From emp e join V 
	On ( e.ename = v.ename 
		And e.job = v.job 
		And e.sal = v.sal); 


-- 3.4: Retreive Values from One Table that Don't Exist in Another
Select deptno 
	From dept 
Where deptno not in (select deptno from emp); 


-- Use correlated subquery 
Select d.deptno 
	From dept d 
Where Not Exists ( 
	Select 1 
		From emp e 
		Where d.deptno = e.deptno
); 


-- 3.5: Retrieving Rows 
Select e.ename, e.deptno as emp_deptno, d.*
	From dept d Left Join emp e 
	On (d.deptno = e.deptno); 


-- Adding Joins in Query Without Interfering with Other Joins

Select e.ename, d.loc
	From emp e, dept d
Where e.deptno = d.deptno; 


-- Don't have employee bonus table so can't run 

Select e.ename, d.loc, eb.received 
	From emp e, dept d, emp_bonus eb 
Where e.deptno = d.deptno
And e.empno = eb.empno; 


-- Determine Whether 2 Tables Have Same Data 

Select Count(*)
	From emp 
Union 
Select Count(*)
	From dept; 


-- Using Union All (pg 48) 


-- 3.8 Identifying and Avoiding Cartesian Products 
-- Large set 
Select e.ename, d.loc
	From emp e, dept d 
Where e.deptno = 10; 


-- Reduce set (incorrect b/c dept 10 is in NY)
Select e.ename, d.loc
	From emp e, dept d 
Where e.deptno = 10 
	And d.deptno = e.deptno; 

Select * From dept;


-- 3.10: Performing Outer Joins When Using Aggregates
-- Don't have bonus table...

-- 3.11 Returning Missing Data from Multiple TAbles

Select d.deptno, d.dname, e.ename
	From dept d Left Outer Join emp e 
	On (d.deptno = e.deptno); 


-- Return previous result set + row for employees having no department 
Insert Into emp (empno, ename, job, mgr, hiredate, sal, comm, deptno)
Select 1111, 'YODA', 'JEDI', null, hiredate, sal, comm, null 
	From emp 
Where ename = 'KING'; 

-- This right outer join didn't return operations (see Yoda's dname)
Select d.deptno, d.dname, e.ename 
	From dept d Right Outer Join emp e 
	On (d.deptno = e.deptno); 


-- Doesn't return Yoda 
Select d.deptno, d.dname, e.ename 
	From dept d Left Outer Join emp e 
	On (d.deptno = e.deptno); 


-- Returns rows from EMP and any matching rows from dept table if any 
Select d.deptno, d.dname, e.ename
	From dept d Right Outer Join emp e 
	On (d.deptno = e.deptno); 