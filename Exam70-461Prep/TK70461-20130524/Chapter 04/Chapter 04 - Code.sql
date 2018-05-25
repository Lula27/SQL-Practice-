---------------------------------------------------------------------
-- TK 70-461 - Chapter 04 - Combining Sets
-- Code
---------------------------------------------------------------------

-- add row to Production.Suppliers
USE TSQL2012;


---------------------------------------------------------------------
-- Lesson 02 - Using Subqueries, Table Expressions and the APPLY Operator
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Using Subqueries
---------------------------------------------------------------------


-- Self-Contained Subqueries

-- scalar subqueries
-- products with minimum price
SELECT productid, productname, unitprice
FROM Production.Products
WHERE unitprice =
  (SELECT MIN(unitprice)
   FROM Production.Products);

SELECT productid, productname, unitprice
FROM Production.Products
WHERE unitprice = 
	(SELECT MIN(unitprice)
	FROM Production.Products); 
   
-- multi-valued subqieries
-- products supplied by suppliers from Japan
SELECT productid, productname, unitprice
FROM Production.Products
WHERE supplierid IN
  (SELECT supplierid
   FROM Production.Suppliers
   WHERE country = N'Japan');

SELECT productid, productname, unitprice 
FROM Production.Products
WHERE supplierid IN 
	(SELECT supplierid 
	FROM Production.Suppliers
	WHERE country = N'Japan'); 

-- negate query
SELECT productid, productname, unitprice 
FROM Production.Products
WHERE supplierid NOT IN 
	(SELECT supplierid 
	FROM Production.Suppliers
	WHERE country = N'Japan'); 

-- Correlated Subqueries

-- products with minimum unitprice per category
SELECT categoryid, productid, productname, unitprice
FROM Production.Products AS P1
WHERE unitprice =
  (SELECT MIN(unitprice)
   FROM Production.Products AS P2
   WHERE P2.categoryid = P1.categoryid);



-- customers who placed an order on February 12, 2007
SELECT custid, companyname
FROM Sales.Customers AS C
WHERE EXISTS
  (SELECT *
   FROM Sales.Orders AS O
   WHERE O.custid = C.custid
     AND O.orderdate = '20070212');

-- customers who did not place an order on February 12, 2007
SELECT custid, companyname
FROM Sales.Customers AS C
WHERE NOT EXISTS
  (SELECT *
   FROM Sales.Orders AS O
   WHERE O.custid = C.custid
     AND O.orderdate = '20070212');

---------------------------------------------------------------------
-- Table Expressions
---------------------------------------------------------------------

-- Derived Tables

-- row numbers for products
-- partitioned by categoryid, ordered by unitprice, productid
SELECT
  ROW_NUMBER() OVER(PARTITION BY categoryid
                    ORDER BY unitprice, productid) AS rownum,
  categoryid, productid, productname, unitprice
FROM Production.Products;

-- two products with lowest prices per category
SELECT categoryid, productid, productname, unitprice
FROM (SELECT
        ROW_NUMBER() OVER(PARTITION BY categoryid
                          ORDER BY unitprice, productid) AS rownum,
        categoryid, productid, productname, unitprice
      FROM Production.Products) AS D
WHERE rownum <= 2;

-- CTEs

-- two products with lowest prices per category
WITH C AS
(
  SELECT
    ROW_NUMBER() OVER(PARTITION BY categoryid
                      ORDER BY unitprice, productid) AS rownum,
    categoryid, productid, productname, unitprice
  FROM Production.Products
)
SELECT categoryid, productid, productname, unitprice
FROM C
WHERE rownum <= 2;

-- Recursive CTE
-- management chain leading to given employee
WITH EmpsCTE AS
(
  SELECT empid, mgrid, firstname, lastname, 0 AS distance
  FROM HR.Employees
  WHERE empid = 9

  UNION ALL

  SELECT M.empid, M.mgrid, M.firstname, M.lastname, S.distance + 1 AS distance
  FROM EmpsCTE AS S
    JOIN HR.Employees AS M
      ON S.mgrid = M.empid
)
SELECT empid, mgrid, firstname, lastname, distance
FROM EmpsCTE;
GO

-- Views

-- view representing ranked products per category by unitprice
IF OBJECT_ID(N'Sales.RankedProducts', N'V') IS NOT NULL DROP VIEW Sales.RankedProducts;
GO
CREATE VIEW Sales.RankedProducts
AS

SELECT
  ROW_NUMBER() OVER(PARTITION BY categoryid
                    ORDER BY unitprice, productid) AS rownum,
  categoryid, productid, productname, unitprice
FROM Production.Products;
GO

SELECT categoryid, productid, productname, unitprice
FROM Sales.RankedProducts
WHERE rownum <= 2;

-- Inline Table-Valued Functions

-- management chain leading to given employee
IF OBJECT_ID(N'HR.GetManagers', N'IF') IS NOT NULL DROP FUNCTION HR.GetManagers;
GO
CREATE FUNCTION HR.GetManagers(@empid AS INT) RETURNS TABLE
AS

RETURN
  WITH EmpsCTE AS
  (
    SELECT empid, mgrid, firstname, lastname, 0 AS distance
    FROM HR.Employees
    WHERE empid = @empid

    UNION ALL

    SELECT M.empid, M.mgrid, M.firstname, M.lastname, S.distance + 1 AS distance
    FROM EmpsCTE AS S
      JOIN HR.Employees AS M
        ON S.mgrid = M.empid
  )
  SELECT empid, mgrid, firstname, lastname, distance
  FROM EmpsCTE;
GO

SELECT *
FROM HR.GetManagers(9) AS M;

---------------------------------------------------------------------
-- APPLY
---------------------------------------------------------------------

-- two products with lowest unit prices for given supplier
SELECT productid, productname, unitprice
FROM Production.Products
WHERE supplierid = 1
ORDER BY unitprice, productid
OFFSET 0 ROWS FETCH FIRST 2 ROWS ONLY;

-- CROSS APPLY
-- two products with lowest unit prices for each supplier from Japan
-- exclude suppliers without products
SELECT S.supplierid, S.companyname AS supplier, A.*
FROM Production.Suppliers AS S
  CROSS APPLY (SELECT productid, productname, unitprice
               FROM Production.Products AS P
               WHERE P.supplierid = S.supplierid
               ORDER BY unitprice, productid
               OFFSET 0 ROWS FETCH FIRST 2 ROWS ONLY) AS A
WHERE S.country = N'Japan';

-- OUTER APPLY
-- two products with lowest unit prices for each supplier from Japan
-- include suppliers without products
SELECT S.supplierid, S.companyname AS supplier, A.*
FROM Production.Suppliers AS S
  OUTER APPLY (SELECT productid, productname, unitprice
               FROM Production.Products AS P
               WHERE P.supplierid = S.supplierid
               ORDER BY unitprice, productid
               OFFSET 0 ROWS FETCH FIRST 2 ROWS ONLY) AS A
WHERE S.country = N'Japan';

---------------------------------------------------------------------
-- Lesson 03 - Using Set Operators
---------------------------------------------------------------------

---------------------------------------------------------------------
-- UNION and UNION ALL
---------------------------------------------------------------------

-- locations that are employee locations or customer locations or both
SELECT country, region, city
FROM HR.Employees

UNION

SELECT country, region, city
FROM Sales.Customers;

-- with UNION ALL duplicates are not discarded
SELECT country, region, city
FROM HR.Employees

UNION ALL

SELECT country, region, city
FROM Sales.Customers;

---------------------------------------------------------------------
-- INTERSECT
---------------------------------------------------------------------

-- locations that are both employee and customer locations
SELECT country, region, city
FROM HR.Employees

INTERSECT

SELECT country, region, city
FROM Sales.Customers;

---------------------------------------------------------------------
-- EXCEPT
---------------------------------------------------------------------

-- locations that are employee locations but not customer locations
SELECT country, region, city
FROM HR.Employees

EXCEPT

SELECT country, region, city
FROM Sales.Customers;

-- cleanup
DELETE FROM Production.Suppliers WHERE supplierid > 29;
IF OBJECT_ID(N'Sales.RankedProducts', N'V') IS NOT NULL DROP VIEW Sales.RankedProducts;
IF OBJECT_ID(N'HR.GetManagers', N'IF') IS NOT NULL DROP FUNCTION HR.GetManagers;
