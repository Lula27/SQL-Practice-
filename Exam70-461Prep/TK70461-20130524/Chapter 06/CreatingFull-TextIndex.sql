-- Exercise 1: Create a Table and Full-Text Components 
USE TSQL2012; 
GO 
-- Check to see if Full-Text Search is installed 

--1. Check to see if Full Text is installed 
SELECT SERVERPROPERTY('IsFullTextInstalled'); -- assuming 1 means yes! 
GO 
-- 2. Create table to use for full-text search: 
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
GO 

-- 3. Import four documents included in the folder for this book (Insert data) 
INSERT INTO dbo.Documents
(title, doctype, docexcerpt, doccontent)
SELECT N'Columnstore Indices and Batch Processing', 
 N'docx',
 N'You should use a columnstore index on your fact tables,
   putting all columns of a fact table in a columnstore index. 
   In addition to fact tables, very large dimensions could benefit 
   from columnstore indices as well. 
   Do not use columnstore indices for small dimensions. ',
 bulkcolumn
FROM OPENROWSET(BULK 'C:\Users\loret\Desktop\DataSciencePrep\SQL\SQL-Practice-\Exam70-461Prep\TK70461-20130524\Chapter 06\ColumnstoreIndicesAndBatchProcessing.docx', 
                SINGLE_BLOB) AS doc;
INSERT INTO dbo.Documents
(title, doctype, docexcerpt, doccontent)
SELECT N'Introduction to Data Mining', 
 N'docx',
 N'Using Data Mining is becoming more a necessity for every company 
   and not an advantage of some rare companies anymore. ',
 bulkcolumn
FROM OPENROWSET(BULK 'C:\Users\loret\Desktop\DataSciencePrep\SQL\SQL-Practice-\Exam70-461Prep\TK70461-20130524\Chapter 06\IntroductionToDataMining.docx', 
                SINGLE_BLOB) AS doc;
INSERT INTO dbo.Documents
(title, doctype, docexcerpt, doccontent)
SELECT N'Why Is Bleeding Edge a Different Conference', 
 N'docx',
 N'During high level presentations attendees encounter many questions. 
   For the third year, we are continuing with the breakfast Q&A session. 
   It is very popular, and for two years now, 
   we could not accommodate enough time for all questions and discussions! ',
 bulkcolumn
FROM OPENROWSET(BULK 'C:\Users\loret\Desktop\DataSciencePrep\SQL\SQL-Practice-\Exam70-461Prep\TK70461-20130524\Chapter 06\WhyIsBleedingEdgeADifferentConference.docx', 
                SINGLE_BLOB) AS doc;
INSERT INTO dbo.Documents
(title, doctype, docexcerpt, doccontent)
SELECT N'Additivity of Measures', 
 N'docx',
 N'Additivity of measures is not exactly a data warehouse design problem. 
   However, you have to realize which aggregate functions you will use 
   in reports for which measure, and which aggregate functions 
   you will use when aggregating over which dimension.',
 bulkcolumn
FROM OPENROWSET(BULK 'C:\Users\loret\Desktop\DataSciencePrep\SQL\SQL-Practice-\Exam70-461Prep\TK70461-20130524\Chapter 06\AdditivityOfMeasures.docx', 
                SINGLE_BLOB) AS doc;

-- 4. Create a search property list called WordSearchPropertyList 