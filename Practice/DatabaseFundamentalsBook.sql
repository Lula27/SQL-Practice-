--Part 1: Create Table using GUI 
-- Write DDL - SQL statements that modify (change) structure  of 
-- database schema (ie: CREATE, DROP, ALTER, etc.) 
USE Test; 
GO

DROP TABLE PersonInfo; 

CREATE TABLE PersonInfo (
	FirstName varchar(100),
	LastName varchar(100),
	Country varchar(100),
	Birthdate date
);


SELECT FirstName
FROM PersonInfo; 

INSERT INTO PersonInfo
VALUES ('Loretta', 'Agyemang', 'Ghana', '1991-09-17');

