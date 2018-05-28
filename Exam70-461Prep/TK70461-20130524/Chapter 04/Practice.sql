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
