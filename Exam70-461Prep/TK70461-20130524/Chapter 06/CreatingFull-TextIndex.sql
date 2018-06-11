-- Exercise 1: Create a Table and Full-Text Components 
-- Check to see if Full-Text Search is installed 


SELECT SERVERPROPERTY('IsFullTextInstalled'); -- assuming 1 means yes! 

-- Create table to use for full-text search: 
CREATE TABLE dbo.Documents 
( 
id INT IDENTITY(1,1) NOT NULL, 
title NVARCHAR(100) NOT NULL, 
doctype NCHAR(4) NOT NULL, 
docexcerpt NVARCHAR(1000) NOT NULL,
doccontent VARBINARY(MAX) NOT NULL, 
CONSTRAINT PK_Documents 
	PRIMARY KEY CLUSTERED(id) 
); 

-- Import four documents included in the folder for this book 
