USE AdventureWorks2012;
GO 
SELECT *
FROM Production.Product
ORDER BY Name ASC;
USE AdventureWorks2012; 
GO
SELECT p.*
FROM Production.Product AS p
ORDER BY Name ASC;
GO 

---Create View
SELECT * FROM Person.Address;

CREATE VIEW clientinfo
AS SELECT AddressLine1, City, StateProvinceID 
FROM Person.Address; 

---Observe View 
SELECT*FROM clientinfo;  

---Edit View 
SELECT AddressLine1, City, StateProvinceID 
AVG(StateProvinceID); 


CREATE VIEW HumanResources.EmployeeHireDate
AS 
SELECT p.FirstName, p.LastName, e.HireDate
FROM HumanResources.Employee AS e JOIN Person.Person AS p 
ON e.BusinessEntityID = p.BusinessEntityID;

SELECT*FROM HumanResources.EmployeeHireDate; 

DROP VIEW HumanResources.EmployeeHireDate; 

---Change view to include only employees hired before 2002 
ALTER VIEW HumanResources.EmployeeHireDate
AS 
SELECT p.FirstName, p.LastName, e.HireDate
FROM HumanResources.Employee AS e JOIN Person.Person AS p
ON e.BusinessEntityID = p.BusinessEntityID
WHERE HireDate < CONVERT(DATETIME, '20020101',101); 
GO 

SELECT*FROM HumanResources.EmployeeHireDate; 

DROP VIEW HumanResources.EmployeeHireDate; 


---Create Stored Procedure: mechanism to store statements & call on them later
SELECT FirstName, LastName, Department
FROM HumanResources.vEmployeeDepartmentHistory 
WHERE FirstName = @FirstName AND LastName = @LastName	
	AND EndDate IS NULL; 


---1. Variable vs Parameter 
#Variable = an --object in Transact-SQL batches and scripts that hold a data value
USE AdventureWorks2012; 
GO 
DECLARE @EmpIDVar int; 
SET @EmpIDVar = 1234;
SELECT *
FROM HumanResources.Employee
WHERE BusinessEntityID = @EmpIDVar; 


#2. Parameter -- object used to pass data btw stored procedure & batch/
Script that executes sp
--2 types: input/output parameters 

CREATE PROCEDURE ParmSample @EmpIDParm int AS
SELECT BusinessEntityID, JobTitle
FROM HumanResources.Employee
WHERE BusinessEntityID = @EmpIDParm;
GO 

-- Execute sp & call upon parameter @EmpIDParm
EXEC ParmSample @EmpIDParm = 109; 
GO 

--Create my own stored procedure 
CREATE VIEW peekperson
AS 
SELECT BusinessEntityID,FirstName,LastName FROM Person.Person; 

DROP VIEW peekperson; 

SELECT * FROM peekperson; 

CREATE PROCEDURE fullname AS 
SELECT CONCAT(FirstName, ' ', LastName)
FROM peekperson; 

EXEC fullname; 



---Derived Table - 


---Subquery: SQL query nested inside a larger query 


