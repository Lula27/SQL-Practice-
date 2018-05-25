-- JOINS 

---------------------------------------------------------------------
-- TK 70-461 - Chapter 04 - Combining Sets
-- Code
---------------------------------------------------------------------

-- add row to Production.Suppliers
USE TSQL2012;

INSERT INTO Production.Suppliers(companyname, contactname, contacttitle, address, city, postalcode, country, phone)
  VALUES(N'Supplier XYZ', N'Jiru', N'Head of Security', N'42 Sekimai Musashino-shi', N'Tokyo', N'01759', N'Japan', N'(02) 4311-2609');

INSERT INTO Production.Suppliers(companyname, contactname, contacttitle, address, city, postalcode, country, phone)
	VALUES(N'Supplier XYZ', N'Jiru', N'Head of Security', N'42 Sekimai Musashino-shi', N'Tokyo', N'01759', N'Japan', N'(02) 4311-2609'); 

---------------------------------------------------------------------
-- Lesson 01 - Using Joins
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Cross Joins
---------------------------------------------------------------------

-- a cross join returning a row for each day of the week
-- and shift number out of three
SELECT D.n AS theday, S.n AS shiftno  
FROM dbo.Nums AS D
  CROSS JOIN dbo.Nums AS S
WHERE D.n <= 7
  AND S.N <= 3
ORDER BY theday, shiftno;

SELECT D.n AS theday, S.n AS shiftno
FROM dbo.Nums AS D
	CROSS JOIN dbo.Nums AS S
WHERE D.n <= 7
	AND S.N <= 3
ORDER BY theday, shiftno; 
---------------------------------------------------------------------
-- Inner Joins
---------------------------------------------------------------------

-- suppliers from Japan and products they supply
-- suppliers without products not included
SELECT
  S.companyname AS supplier, S.country,
  P.productid, P.productname, P.unitprice
FROM Production.Suppliers AS S
  INNER JOIN Production.Products AS P
    ON S.supplierid = P.supplierid
WHERE S.country = N'Japan';

SELECT 
	S.companyname AS supplier, S.country,
	P.productid, P.productname, P.unitprice
FROM Production.Suppliers AS S 
	INNER JOIN Production.Products AS P
		ON S.supplierid = P.supplierid
WHERE S.country = N'Japan'; 

-- same meaning
SELECT
  S.companyname AS supplier, S.country,
  P.productid, P.productname, P.unitprice
FROM Production.Suppliers AS S
  INNER JOIN Production.Products AS P
    ON S.supplierid = P.supplierid
    AND S.country = N'Japan';

SELECT 
	S.companyname AS supplier, S.country, 
	P.productid, P.productname, P.unitprice
FROM Production.Suppliers AS S
	INNER JOIN Production.Products AS P
		ON S.supplierid = P.supplierid
		AND S.country = N'Japan'; 

-- employees and their managers
-- employee without manager (CEO) not included
SELECT E.empid,
  E.firstname + N' ' + E.lastname AS emp,
  M.firstname + N' ' + M.lastname AS mgr
FROM HR.Employees AS E
  INNER JOIN HR.Employees AS M
    ON E.mgrid = M.empid;

SELECT E.empid,
	E.firstname + N' ' + E.lastname AS emp,
	M.firstname + N' ' + M.lastname AS mgr
FROM HR.Employees AS E 
	INNER JOIN HR.Employees AS M 
	ON E.mgrid = M.empid; 

---------------------------------------------------------------------
-- Outer Joins
---------------------------------------------------------------------

-- suppliers from Japan and products they supply
-- suppliers without products included
SELECT
  S.companyname AS supplier, S.country,
  P.productid, P.productname, P.unitprice
FROM Production.Suppliers AS S
  LEFT OUTER JOIN Production.Products AS P
    ON S.supplierid = P.supplierid
WHERE S.country = N'Japan';

SELECT
	S.companyname AS supplier, S.country,
	P.productid, P.productname, P.unitprice
FROM Production.Suppliers AS S
	LEFT OUTER JOIN Production.Products AS P
		ON S.supplierid = P.supplierid
WHERE S.country = N'Japan'; 


-- return all suppliers
-- show products for only suppliers from Japan
SELECT
  S.companyname AS supplier, S.country,
  P.productid, P.productname, P.unitprice
FROM Production.Suppliers AS S
  LEFT OUTER JOIN Production.Products AS P
    ON S.supplierid = P.supplierid
   AND S.country = N'Japan';

SELECT 
	S.companyname AS supplier, S.country,
	P.productid, P.productname, P.unitprice
FROM Production.Suppliers AS S
	LEFT OUTER JOIN Production.Products AS P
		ON S.supplierid = P.supplierid
		AND S.country = N'Japan'; 

-- employees and their managers
-- employee without manager (CEO) included
SELECT E.empid,
  E.firstname + N' ' + E.lastname AS emp,
  M.firstname + N' ' + M.lastname AS mgr
FROM HR.Employees AS E
  LEFT OUTER JOIN HR.Employees AS M
    ON E.mgrid = M.empid;

SELECT E.empid,
	E.firstname + N' ' + E.lastname AS emp,
	M.firstname + N' ' + M.lastname AS mrg
FROM HR.Employees AS E
	LEFT OUTER JOIN HR.Employees AS M 
	ON E.mgrid = M.empid; 

-- attempt to include product category from Production.Categories table
-- inner join nullifies outer part of outer join
SELECT
  S.companyname AS supplier, S.country,
  P.productid, P.productname, P.unitprice,
  C.categoryname
FROM Production.Suppliers AS S
  LEFT OUTER JOIN Production.Products AS P
    ON S.supplierid = P.supplierid
  INNER JOIN Production.Categories AS C
    ON C.categoryid = P.categoryid
WHERE S.country = N'Japan';

SELECT
	S.companyname AS supplier, S.country, 
	P.productid, P.productname, P.unitprice,
	C.categoryname 
FROM Production.Suppliers AS S
	LEFT OUTER JOIN Production.Products AS P 
	ON S.supplierid = P.supplierid
INNER JOIN Production.Categories AS C
	ON C.categoryid = P.categoryid
WHERE S.country = N'Japan'; 

-- fix using parentheses
SELECT
  S.companyname AS supplier, S.country,
  P.productid, P.productname, P.unitprice,
  C.categoryname
FROM Production.Suppliers AS S
  LEFT OUTER JOIN 
    (Production.Products AS P
       INNER JOIN Production.Categories AS C
         ON C.categoryid = P.categoryid)
    ON S.supplierid = P.supplierid
WHERE S.country = N'Japan';

SELECT 
	S.companyname AS supplier, S.country,
	P.productid, P.productname, P.unitprice,
	C.categoryname 
FROM Production.Suppliers AS S 
	LEFT OUTER JOIN 
		(Production.Products AS P 
			INNER JOIN Production.Categories AS C
				ON C.categoryid = P.categoryid) 
		ON S.supplierid = P.supplierid
WHERE S.country = N'Japan'; 