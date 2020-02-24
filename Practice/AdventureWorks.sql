-- From following site: https://sqlzoo.net/wiki/AdventureWorks_easy_questions 

-- Show the first name and the email address of customer with CompanyName 'Bike World'.
USE AdventureWorks2012;

-- Person table has FirstName 
SELECT * FROM Person.Person;

-- BusinessEntityID, EmailAddress, eaID 
SELECT BusinessEntityID, EmailAddress FROM Person.EmailAddress; 


SELECT FirstName, EmailAddress
FROM Person.EmailAddress AS P
	INNER JOIN 