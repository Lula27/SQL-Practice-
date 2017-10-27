USE AdventureWorks2012;
GO

-- SELECT first and last name and person type
-- from the person table to show the cryptic
-- values used to represent the person type
SELECT FirstName, LastName, PersonType 
FROM Person.Person;
GO


-- implement the CASE statement to convert the
-- cryptic values (Person Type Table -EM, IM,etc)
-- store in the DB, to more user
-- friendly values in the output
-- Keywords (CASE, WHEN, THEN, END AS [column alias])

SELECT FirstName, LastName,
CASE PersonType
		WHEN 'SC' THEN 'Store Contact'
		WHEN 'IN' THEN 'Individual Customer'
		WHEN 'SP' THEN 'Sales Person'
		WHEN 'EM' THEN 'Employee'
		WHEN 'VC' THEN 'Vendor Contact'
		WHEN 'GC' THEN 'General Contact'
		ELSE 'Unknown Person Type'
END AS [Type of Contact]
FROM Person.Person;
GO

-- Write out Case statement
SELECT AdditionalContactInfo, Demographics, 
CASE PersonType 
	WHEN 'SC' THEN 'Store Contact'
	WHEN 'IN' THEN 'Individual Customer'
	WHEN 'SP' THEN 'Sales Person'
	WHEN 'EM' THEN 'Employee'
	WHEN 'VC' THEN 'Vendor Contact'
	WHEN 'GC' THEN 'General Contact'
	ELSE 'Unknown Person Type'
END AS [Type of Contact]
FROM Person.Person;
GO 

