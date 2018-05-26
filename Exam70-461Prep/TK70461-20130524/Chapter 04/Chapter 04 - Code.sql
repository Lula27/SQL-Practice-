---------------------------------------------------------------------
-- TK 70-461 - Chapter 04 - Combining Sets
-- Code
---------------------------------------------------------------------


USE TSQL2012;


---------------------------------------------------------------------
-- Lesson 02 - Using Subqueries, Table Expressions and the APPLY Operator
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Table Expressions
---------------------------------------------------------------------

-- Derived Tables

-- computes row numbers for products
-- partitioned by categoryid, ordered by unitprice, productid
SELECT
  ROW_NUMBER() OVER(PARTITION BY categoryid
                    ORDER BY unitprice, productid) AS rownum,
  categoryid, productid, productname, unitprice
FROM Production.Products;

SELECT 
	ROW_NUMBER() OVER(PARTITION BY categoryid 
						ORDER BY unitprice, productid) AS rownum,
	categoryid, productid, productname, unitprice 
FROM Production.Products; 


-- circumvent restriction of logical query processing by using table expression 
-- (not being allowed to refer to a column alias that was assigned in the SELECT list 
--in the WHERE clause b/c WHERE clause is conceptually evaluated before the SELECT clause)
-- derived table defined in the FROM caluse / derived table name = D 

-- two products with lowest prices per category 
SELECT categoryid, productid, productname, unitprice
FROM (SELECT
        ROW_NUMBER() OVER(PARTITION BY categoryid
                          ORDER BY unitprice, productid) AS rownum,
        categoryid, productid, productname, unitprice
      FROM Production.Products) AS D
WHERE rownum <= 2;


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
WHERE rownum <=2; 


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
