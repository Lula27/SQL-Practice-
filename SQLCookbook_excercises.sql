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


SELECT ename AS [Employee Name], comm AS Commission, sal AS Salary
FROM emp;


