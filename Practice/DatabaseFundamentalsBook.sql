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


SELECT FirstName + ' ' + LastName AS FullName, Birthdate
FROM PersonInfo; 

INSERT INTO PersonInfo (FirstName, LastName, Country, Birthdate) 
VALUES ('Loretta', 'Agyemang', 'Ghana', '1991-09-17'), 
	   ('Stephan', 'Agyemang', 'United States', '1999-06-03'),
	   ('Nikki', 'Romanov', 'Russia', '1993-07-17'),
	   ('Chen', 'Gong', 'China', '1872-04-19');  

INSERT INTO PersonInfo (FirstName, LastName, Country, Birthdate) 
VALUES ('Loretta', 'Agyemang', 'Ghana', '1991-09-17'); 





