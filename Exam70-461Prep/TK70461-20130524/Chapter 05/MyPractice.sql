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
SELECT C.custid, C.city, 
COUNT(*) AS numorders 
FROM Sales.Customers AS C 
	INNER JOIN Sales.Orders AS O
		ON C.custid = O.custid 
	WHERE C.country = N'Spain'
	GROUP BY C.custid, C.city; 


--  Define Multiple Grouping Sets 
--1. Start w/ query written in step previous question. 
-- Include in the same output the grand count (along with the counts by customer previously returned) 
-- Does this mean, I just want another row that adds up the numorders column (3 + 5 + 10 + 5 = 23)? 
-- My try = INCORRECT, I guess...
SELECT C.custid, C.city,
COUNT(*) AS numorders 
FROM Sales.Customers AS C 
	INNER JOIN Sales.Orders AS O
		ON C.custid = O.custid
	WHERE C.country = N'Spain'
	GROUP BY CUBE(C.custid, C.city); 


	
-- CORRECT Query: gave grand total of 23 (with 2 place holder NULLs) 
SELECT C.custid, C.city,
COUNT(*) AS numorders 
FROM Sales.Customers AS C 
	INNER JOIN Sales.Orders AS O 
		ON C.custid = O.custid 
	WHERE C.country = N'Spain'
	GROUP BY GROUPING SETS( (C.custid, C.city), () ) 
	ORDER BY GROUPING(C.custid); 

-- Exercise 2: Pivot Data & Compute Counts 
--1. Write a PIVOT query that returns a row for each distinct customer ID (grouping column), 
-- a column for each distinct shipper ID (spreading column), and the count of orders in the customer-shipper intersections. 
-- Prepare a table expression that returns only the custid and shipperid columns from the Sales.Orders table 
-- and provide this table expression as input to the PIVOT operator. 

-- INCORRECT: pivot doesn't support COUNT(*) Aggregate function 
-- error: Msg 102, Level 15, State 1, Line 10
--Incorrect syntax near '*'.

WITH PivotData AS 
(
SELECT 
 custid , -- grouping column
 shipperid  -- spreading column 
FROM Sales.Orders
) 
SELECT custid, [1], [2], [3] 
FROM PivotData 
	PIVOT( COUNT(*) FOR shipperid IN ([1], [2], [3]) ) AS P; 

-- Solution #1: Use spreading column as aggregation column: COUNT(shipperid)
-- Solution #2: create dummy column from constant expression in table expression 
-- use that column as input to COUNT function (shown below)

WITH PivotData AS 
(
SELECT 
	custid, -- grouping column
	shipperid, -- spreading column 
	1 AS aggcol  -- aggregation column 
FROM Sales.Orders
) 
SELECT custid, [1], [2], [3] 
FROM PivotData
	PIVOT( COUNT(aggcol) FOR shipperid IN ([1], [2], [3])) AS P; 


-- Using Window Functions (p. 180) 
-- Exercise 1 : Use Window Aggregate Functions 
--1. Write query against Sales.OrderValues (FROM Sales.OrderValues) view that returns per each customer 
-- and order (SELECT custid, orderid) the moving average value of the customer's last three orders. 
SELECT custid, orderid, orderdate, val,
	AVG(val) OVER(PARTITION BY custid 
				  ORDER BY orderdate, orderid 
				  ROWS BETWEEN 2 PRECEDING 
						  AND CURRENT ROW) AS movingavg
FROM Sales.OrderValues;



-- Exercise 2: Use Window Ranking & Offset Functions 
-- 1. Write query against Sales.Orders table and filter three orders with 
-- highest freight values per each shipper using orderid as the tiebreaker.

-- Solution: define table expression based on query that invokes ROW_NUMBER function & assigns expression with a column alias 
WITH C AS 
(
	SELECT shipperid, orderid, freight, 
	ROW_NUMBER() OVER(PARTITION BY shipperid
					  ORDER BY freight DESC, orderid) AS rownum 
	FROM Sales.Orders
) 
SELECT shipperid, orderid, freight 
FROM C 
WHERE rownum <= 3
ORDER BY shipperid, rownum; 


-- 2. Query Sales.OrderValues view. 
-- Compute difference between current order value and value of customer's previous order,
-- in addition to the difference btw. the current order value and value of customer's next order. 

SELECT custid, orderid, orderdate, val, 
	val - LAG(val)	OVER(PARTITION BY custid 
						 ORDER BY orderdate, orderid) AS diffprev, 
	val - LEAD(val) OVER(PARTITION BY custid 
						 ORDER BY orderdate, orderid) AS diffnext
FROM Sales.OrderValues; 