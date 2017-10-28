USE AdventureWorks2012;
GO

-- DISTINCT keyword reduces number of duplicates in 
-- Query but doesn't eliminate them all together. 

-- We want to see how many different types of people
-- are represented in the Person table.
-- Return all records and all attributes from the 
-- Person table.  This lists the PersonType attribute
-- but how many different types is difficult to see
SELECT *
FROM Person.Person;
GO


-- Ok, then let's only return the PersonType attribute
-- Still too many records to search through
SELECT PersonType
FROM Person.Person;
GO

SELECT DISTINCT PersonType
FROM Person.Person; 
GO

-- Three more examples SELECT DISTINCT
-- Without distinct keyword, yields 19972 rows 
-- Contains many duplicates - ie: Karin, Michael, etc. 
SELECT FirstName AS [First Name]
FROM Person.Person; 
GO 

-- With distinct - notice differences 
-- Retreives 1018 rows 
-- Reduced to about 900 duplicates 
SELECT DISTINCT FirstName AS [First Name]
FROM Person.Person;
GO 

-- Retreive distinct values from PersonType 
SELECT DISTINCT PersonType 
FROM Person.Person; 
GO 

-- Use Case Statement to flesh out person types 

-- Use the DISTINCT keyword to return only distinct
-- values from the PersonType field
SELECT DISTINCT PersonType
FROM Person.Person;
GO


-- What if we add more fields to the query?
-- Duplicate values will still be returned
-- Retrieves 18 rows 
SELECT DISTINCT PersonType, EmailPromotion
FROM Person.Person;
GO

SELECT DISTINCT EmailPromotion AS [Email Promotion], PersonType AS [Person Type]
FROM Person.Person;
GO 


-- This is because there are different combinations of Email Promotion for Person Type. 
-- Try alternative form.
SELECT DISTINCT EmailPromotion AS [Email Promotion], PersonType
FROM Person.Person;
GO 

-- Another example with DISTINCT
-- Both examples tried don't result in reduced rows 
-- Because these are already distinct. 
SELECT DISTINCT Name, ModifiedDate AS [Date Modified] 
FROM Person.CountryRegion;
GO 

