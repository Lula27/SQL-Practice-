---------------------------------------------------------------------
-- TK 70-461 - Chapter 04 - Combining Sets
-- Code
---------------------------------------------------------------------
---------------------------------------------------------------------
-- APPLY
---------------------------------------------------------------------
USE TSQL2012; 

-- two products with lowest unit prices for given supplier
SELECT productid, productname, unitprice
FROM Production.Products
WHERE supplierid = 1
ORDER BY unitprice, productid
OFFSET 0 ROWS FETCH FIRST 2 ROWS ONLY;

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
