---------------------------------------------------------------------
-- TK 70-461 - Chapter 05 - Grouping and Windowing 
-- Code
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Lesson 01 - Writing Grouped Queries
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Working With a Single Grouping Set
---------------------------------------------------------------------

-- grouped query without GROUP BY clause
USE TSQL2012;

-- no grouping: all rows in 1 group 
SELECT COUNT(*) AS numorders
FROM Sales.Orders;

-- grouped query with GROUP BY clause
-- group rows based on specified grouping set of expressions 
SELECT shipperid, COUNT(*) AS numorders
FROM Sales.Orders
GROUP BY shipperid;

SELECT shipperid, COUNT(*) AS numorders 
FROM Sales.Orders
GROUP BY shipperid; 

-- grouping set with multiple elements
SELECT shipperid, YEAR(shippeddate) AS shippedyear,
   COUNT(*) AS numorders
FROM Sales.Orders
GROUP BY shipperid, YEAR(shippeddate);

SELECT shipperid, YEAR(shippeddate) AS shippedyear,
	COUNT(*) AS numorders 
FROM Sales.Orders
GROUP BY shipperid, YEAR(shippeddate); 

-- filtering groups
SELECT shipperid, YEAR(shippeddate) AS shippedyear,
   COUNT(*) AS numorders
FROM Sales.Orders
WHERE shippeddate IS NOT NULL
GROUP BY shipperid, YEAR(shippeddate)
HAVING COUNT(*) < 100;

SELECT shipperid, YEAR(shippeddate) AS shippedyear, 
	COUNT(*) AS numorders 
FROM Sales.Orders
WHERE shippeddate IS NOT NULL 
GROUP BY shipperid, YEAR(shippeddate) 
HAVING COUNT(*) < 100; 

-- general aggregate functions ignore NULLs
SELECT shipperid,
  COUNT(*) AS numorders,
  COUNT(shippeddate) AS shippedorders,
  MIN(shippeddate) AS firstshipdate,
  MAX(shippeddate) AS lastshipdate,
  SUM(val) AS totalvalue
FROM Sales.OrderValues
GROUP BY shipperid;

SELECT shipperid, 
	COUNT(*) AS numorders,
	COUNT(shippeddate) AS shippedorders, 
	MIN(shippeddate) AS firstshipdate,
	MAX(shippeddate) AS lastshipdate,
	SUM(val) AS totalvalue 
FROM Sales.OrderValues
GROUP BY shipperid; 

-- aggregating distinct cases
SELECT shipperid, COUNT(DISTINCT shippeddate) AS numshippingdates
FROM Sales.Orders
GROUP BY shipperid;
GO

SELECT shipperid, COUNT(DISTINCT shippeddate) AS numshippingdates 
FROM Sales.Orders
GROUP BY shipperid; 
GO 

-- grouped query cannot refer to detail elements after grouping
SELECT S.shipperid, S.companyname, COUNT(*) AS numorders
FROM Sales.Shippers AS S
  JOIN Sales.Orders AS O
    ON S.shipperid = O.shipperid
GROUP BY S.shipperid;
GO

-- solution 1: add column to grouping set
SELECT S.shipperid, S.companyname,
  COUNT(*) AS numorders
FROM Sales.Shippers AS S
  INNER JOIN Sales.Orders AS O
    ON S.shipperid = O.shipperid
GROUP BY S.shipperid, S.companyname;

SELECT S.shipperid, S.companyname, 
	COUNT(*) AS numorders 
FROM Sales.Shippers AS S 
	INNER JOIN Sales.Orders AS O 
		ON S.shipperid = O.shipperid
GROUP BY S.shipperid, S.companyname; 

-- solution 2: apply an aggregate to the column
SELECT S.shipperid,
  MAX(S.companyname) AS companyname,
  COUNT(*) AS numorders
FROM Sales.Shippers AS S
  INNER JOIN Sales.Orders AS O
    ON S.shipperid = O.shipperid
GROUP BY S.shipperid;

SELECT S.shipperid, 
	MAX(S.companyname) AS companyname,
	COUNT(*) AS numorders 
FROM Sales.Shippers AS S 
	INNER JOIN Sales.Orders AS O 
		ON S.shipperid = O.shipperid
GROUP BY S.shipperid; 

-- solution 3: join after aggregating
-- performs just as well as solution 1 in terms of optimization 
-- but this is longer code so stick to the simplier option 
WITH C AS
(
  SELECT shipperid, COUNT(*) AS numorders
  FROM Sales.Orders
  GROUP BY shipperid
)
SELECT S.shipperid, S.companyname, numorders
FROM Sales.Shippers AS S
  INNER JOIN C
    ON S.shipperid = C.shipperid;

WITH C AS 
(
	SELECT shipperid, COUNT(*) AS numorders 
	FROM Sales.Orders
	GROUP BY shipperid
) 
SELECT S.shipperid, S.companyname, numorders 
FROM Sales.Shippers AS S 
	INNER JOIN C 
		ON S.shipperid = C.shipperid; 
---------------------------------------------------------------------
-- Working With Multiple Grouping Sets
---------------------------------------------------------------------

-- using the GROUPING SETS clause
SELECT shipperid, YEAR(shippeddate) AS shipyear, COUNT(*) AS numorders
FROM Sales.Orders
WHERE shippeddate IS NOT NULL -- exclude unshipped orders
GROUP BY GROUPING SETS
(
  ( shipperid, YEAR(shippeddate) ),
  ( shipperid                    ),
  ( YEAR(shippeddate)            ),
  (                              )
);

SELECT shipperid, YEAR(shippeddate) AS shipyear, COUNT(*) AS numorders 
FROM Sales.Orders
WHERE shippeddate IS NOT NULL -- exclude unshipped orders 
GROUP BY GROUPING SETS 
(
	(shipperid, YEAR(shippeddate)), 
	(shipperid					),
	(YEAR(shippeddate)			),
	(							)
); 

-- using the CUBE clause
SELECT shipperid, YEAR(shippeddate) AS shipyear, COUNT(*) AS numorders
FROM Sales.Orders
GROUP BY CUBE( shipperid, YEAR(shippeddate) );

-- using the ROLLUP clause
SELECT shipcountry, shipregion, shipcity, COUNT(*) AS numorders
FROM Sales.Orders
GROUP BY ROLLUP( shipcountry, shipregion, shipcity );

SELECT shipcountry, shipregion, shipcity, COUNT(*) AS numorders 
FROM Sales.Orders
GROUP BY ROLLUP( shipcountry, shipregion, shipcity ); 

-- GROUPING and GROUPING_ID

-- GROUPING
SELECT
  shipcountry, GROUPING(shipcountry) AS grpcountry,
  shipregion , GROUPING(shipregion) AS grpregion,
  shipcity   , GROUPING(shipcity) AS grpcity,
  COUNT(*) AS numorders
FROM Sales.Orders
GROUP BY ROLLUP( shipcountry, shipregion, shipcity );

-- GROUPING_ID
SELECT GROUPING_ID( shipcountry, shipregion, shipcity ) AS grp_id,
  shipcountry, shipregion, shipcity,
  COUNT(*) AS numorders
FROM Sales.Orders
GROUP BY ROLLUP( shipcountry, shipregion, shipcity );
