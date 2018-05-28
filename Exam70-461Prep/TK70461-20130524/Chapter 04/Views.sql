USE TSQL2012; 

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