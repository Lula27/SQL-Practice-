--********************************************
-- 05_03_Grouping_with_GROUP_BY.sql
--********************************************
-- Group By is useful for consolidating records 
-- Group By is executed before Select 
-- This is why errors may occure if the query for group by has a mistake


USE AdventureWorks2012;
GO


--9. Use COUNT(*)
-- Return the city name and the number of 
-- addresses in the table that are in each city.  
-- Rename the number of cities column to Totals
-- Use Person.Address table
SELECT City, COUNT(*) AS Totals
FROM Person.Address
GROUP BY City;
GO 



--10. Return all the records in the Address table 
-- just to show the difference in the row count
-- that takes place when using GROUP BY.  
-- Use ORDER BY to show the number of times a city
-- name repeats in the table as well.

-- This query will generate an error because the 
-- AddressLine1 field is not part of an aggregate 
-- function, like COUNT in the first query, 
-- nor is it part of the GROUP BY clause

SELECT AddressLine1, City
FROM Person.Address
GROUP BY City; 
GO 




--12. This query fixes the error because the 
-- AddressLine1 field is now part of the 
-- GROUP BY clause.  It doesn't make much sense 
-- because the grouping isn't logical on the 
-- AddressLine1 field, but we can see how 
-- the inclusion in the GROUP BY clause, allows 
-- us to return multiple fields.
-- Also notice that the city names are now 
-- expanded rather than just one entry per city

-- THE FIX 
SELECT AddressLine1, City
FROM Person.Address
GROUP BY City, AddressLine1; 
GO 