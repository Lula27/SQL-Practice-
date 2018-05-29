-- Practice: p. 132 
-- Using Subqueries, Table Expressions, and APPLY Operator 

-- 2. Write query against Product.Products table that groups the products by categoryid
-- and returns for each category the minimum unit price. 


SELECT categoryid, MIN(unitprice) AS mn 
FROM Production.Products
GROUP BY categoryid; 


-- 3. Define CTE based on previous query and then join the CTE 
-- to the Production.Products table to return per each category the products 
-- with the minimum unit price. 


WITH CatMin AS 
( 
SELECT categoryid, MIN(unitprice) AS mn
FROM Production.Products
GROUP BY categoryid
) 
SELECT P.categoryid, P.productid, P.productname, P.unitprice 
FROM Production.Products AS P 
	INNER JOIN CatMin AS M -- give alias to cte 
	ON P.categoryid = M.categoryid
	AND P.unitprice = M.mn; 


-- Exercise 2.
-- 1. Define inline table-valued function that accepts a supplier ID as input (@supplierid) in addition to a number @n
-- and returns @n products with the lowest prices for the input supplier.
-- In the case of ties in the unit price, use the product ID as the tiebreaker.

IF OBJECT_ID('Production.GetTopProducts', 'IF') IS NOT NULL DROP FUNCTION 
Production.GetTopProducts; 
GO 
CREATE FUNCTION Production.GetTopProducts(@supplierid AS INT, @n AS BIGINT) 
RETURNS TABLE 
AS 

RETURN 
	SELECT productid, productname, unitprice 
	FROM Production.Products 
	WHERE supplierid = @supplierid
	ORDER BY unitprice, productid 
	OFFSET 0 ROWS FETCH FIRST @n ROWS ONLY; 
GO 

-- Query function to test it:
-- Providing the supplier ID 1 and number 2 to return the two products with the lowest prices for the input supplier 
SELECT * FROM Production.GetTopProducts(1,2) AS P; 

-- 3. Return per each supplier from Japan the two products with the lowest prices 
-- use CROSS APPLY operator w/ Production.Suppliers as the left side and Production.GetTopProducts function as the right side 
-- no NULLs retreived 

SELECT S.supplierid, S.companyname AS supplier, A.* 
FROM Production.Suppliers AS S 
	CROSS APPLY Production.GetTopProducts(S.supplierid, 2) AS A 
WHERE S.country = N'Japan'; 

-- 4. Use OUTER APPLY operator to return NULLs
-- return suppliers from Japn with no related products (previously discarded)
SELECT S.supplierid, S.companyname AS supplier, A.* 
FROM Production.Suppliers AS S 
	OUTER APPLY Production.GetTopProducts(S.supplierid, 2) AS A 
WHERE S.country = N'Japan'; 

-- clean up code
IF OBJECT_ID('Production.GetTopProducts', 'IF') IS NOT NULL DROP FUNCTION
Production.GetTopProducts; 

-- Exercise 1: Use Set Operators 

--1. Write query that returns employees who handled orders for customers 1 but not customer 2. 
SELECT empid
FROM Sales.Orders
WHERE custid = 1

EXCEPT 

SELECT empid 
FROM Sales.Orders
WHERE custid = 2;

-- 2. Return employees who handeled orders for both customer 1 & customer 2
SELECT empid 
FROM Sales.Orders
WHERE custid = 1 

INTERSECT 

SELECT empid 
FROM Sales.Orders
WHERE custid = 2;  