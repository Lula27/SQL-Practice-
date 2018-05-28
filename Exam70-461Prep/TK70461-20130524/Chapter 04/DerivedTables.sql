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