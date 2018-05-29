
---------------------------------------------------------------------
-- Lesson 02 - Pivoting and Unpivoting Data
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Pivoting Data
---------------------------------------------------------------------

-- show customer IDs on rows, shipper IDs on columns, total freight in intersection
WITH PivotData AS
(
  SELECT
    custid   , -- grouping column
    shipperid, -- spreading column
    freight    -- aggregation column
  FROM Sales.Orders
)
SELECT custid, [1], [2], [3]
FROM PivotData
  PIVOT(SUM(freight) FOR shipperid IN ([1],[2],[3]) ) AS P;

-- when applying PIVOT to Orders table direclty get a result row for each order
SELECT custid, [1], [2], [3]
FROM Sales.Orders
  PIVOT(SUM(freight) FOR shipperid IN ([1],[2],[3]) ) AS P;

---------------------------------------------------------------------
-- Unpivoting Data
---------------------------------------------------------------------

-- sample data for UNPIVOT example
USE TSQL2012;
IF OBJECT_ID(N'Sales.FreightTotals', N'U') IS NOT NULL DROP TABLE Sales.FreightTotals;
GO

WITH PivotData AS
(
  SELECT
    custid   , -- grouping column
    shipperid, -- spreading column
    freight    -- aggregation column
  FROM Sales.Orders
)
SELECT *
INTO Sales.FreightTotals
FROM PivotData
  PIVOT( SUM(freight) FOR shipperid IN ([1],[2],[3]) ) AS P;

SELECT * FROM Sales.FreightTotals;

-- unpivot data
SELECT custid, shipperid, freight
FROM Sales.FreightTotals
  UNPIVOT( freight FOR shipperid IN([1],[2],[3]) ) AS U;

-- cleanup
IF OBJECT_ID(N'Sales.FreightTotals', N'U') IS NOT NULL DROP TABLE Sales.FreightTotals;

---------------------------------------------------------------------
