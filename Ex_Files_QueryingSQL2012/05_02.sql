--**********************************************
-- 05_02_Sorting_with_ORDER_BY.sql
--**********************************************


USE AdventureWorks2012;
GO

-- Straightforward query with no order specified.
-- Records are returned in the order the 
-- database engine determines
-- 1. Select BE_ID, FN, MN, LN from Person.Person tbl
SELECT P.BusinessEntityID, P.FirstName,P.MiddleName, P.LastName 
FROM Person.Person P; 
GO 


-- Change the order of the records by ordering 
-- the results on BusinessEntityID
-- 2. Same as one but order using BE_ID from lowest to highest
SELECT P.BusinessEntityID, P.FirstName, P.MiddleName, P.LastName 
FROM Person.Person P
ORDER BY P.BusinessEntityID ASC; 
GO 


-- 3. Change the order of the records by ordering the 
-- results in reverse order based on the last 
-- name field.
SELECT P.BusinessEntityID, P.FirstName, P.MiddleName, P.LastName 
FROM Person.Person P
ORDER BY P.LastName DESC; 
GO 


-- 4. Change the order of the records by ordering 
-- the results alphabetically based on the first 
-- name and the last name with the first name 
-- taking precedence.
SELECT P.BusinessEntityID, P.FirstName, P.MiddleName, P.LastName 
FROM Person.Person P
ORDER BY P.FirstName, P.LastName ASC; 
GO 



-- 5. Change the order of the records by ordering the 
-- results alphabetically based on the first name 
-- to show the difference between an ORDER BY
-- used on the first name only as opposed to first 
-- then last.
-- Note the order, or lack of order, for the 
-- last names in this version
SELECT P.BusinessEntityID, P.FirstName, P.MiddleName, P.LastName 
FROM Person.Person P
ORDER BY P.FirstName ASC; 
GO 



-- 6. Avoid using this method - gets messy! 
-- Change the order of the records by ordering the 
-- results alphabetically based on the first name 
-- and then last name but in this instance, do not 
-- use the field name but rather use the ordinal 
-- positions to show how the results sort.
-- NOTE, this is not a good practice and is only 
-- demonstrated for awareness
-- FN(1), MN(2), LN(3)
SELECT P.FirstName, P.MiddleName, P.LastName 
FROM Person.Person P
ORDER BY 1, 2, 3; 
GO 



-- 7. Change the order of the records by ordering the 
-- results based on the BusinessEntityID that 
-- isn't included in the output to show that the 
-- order is still applied even though the field
-- is not included in the result list.  
-- It's also hard to tell how the order was 
-- factored so this could cause confusion in the 
-- results.
SELECT P.FirstName, P.MiddleName, P.LastName 
FROM Person.Person P
ORDER BY P.BusinessEntityID; 
GO 


-- 8. Change the order of the records by ordering the 
-- results alphabetically based on the middle name 
-- to show how the NULL impacts the results.
-- NULL affects the results because it is unknown 
-- and will show up in the results ahead of any 
-- other value.
SELECT P.FirstName, P.MiddleName, P.LastName 
FROM Person.Person P
ORDER BY P.MiddleName ASC; 
GO 