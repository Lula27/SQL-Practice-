
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

SELECT custid, companyname 
FROM Sales.Customers AS C
WHERE EXISTS 
	(SELECT * 
	FROM Sales.Orders AS O
	WHERE O.custid = C.custid
		AND O.orderdate = '20070212'); 

-- negate it!
-- customers who did not place an order on February 12, 2007
SELECT custid, companyname
FROM Sales.Customers AS C
WHERE NOT EXISTS
  (SELECT *
   FROM Sales.Orders AS O
   WHERE O.custid = C.custid
     AND O.orderdate = '20070212');

SELECT custid, companyname 
FROM Sales.Customers AS C
WHERE NOT EXISTS 
	(SELECT * 
	FROM Sales.Orders AS O 
	WHERE O.custid = C.custid 
		AND O.orderdate = '20070212'); 