-- TK 70-461 - Chapter 05 - Grouping and Windowing
-- Exercises
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Lesson 01 - Writing Grouped Queries
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Practice - Writing Grouped Queries
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Exercise 1 - Aggregate Information About Customer Orders
--------------------------------------------------------------------
USE TSQL2012; 

--1. return count for customers in Spain from sales.orders & sales.customers tables 
-- Customers in Spain who placed an order? 
SELECT C.custid, 
COUNT(*) AS numorders 
FROM Sales.Customers AS C 
	INNER JOIN Sales.Orders AS O 
		ON C.custid = O.custid
	WHERE C.country = N'Spain'
	GROUP BY C.custid;
	
-- 2. Add the city information in the output of the query. 
-- results in error: Msg 102, Level 15, State 1, Line 2
-- Incorrect syntax near '*'.
SELECT C.custid, C.city 
COUNT(*) AS numorders 
FROM Sales.Customers AS C
	INNER JOIN Sale.Orders AS O 
		ON C.custid = O.custid 
	WHERE C.country = N'Spain'
	GROUP BY C.custid;  

-- Find a solution to allow returning the city as well. 


SELECT C.city
FROM Sales.Customers AS C; 
	