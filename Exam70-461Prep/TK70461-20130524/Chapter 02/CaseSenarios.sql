-- Case Senarios 

-- 1. write rates: 
-- read performance: 



-- DATETIME: storage size = 8 bytes 
-- contains day, month, year, hours, minutes and seconds: 1900-01-01 00:00:00 (default value)
-- cast string as date and time data types:







-- Alternatives to DATETIME data type for storing order date & invoice date: 
-- use least bytes as possible

-- A. date: storage structure = 1,3-byte integer store: 1900-01-01 (default value) 
DECLARE @date date = '1912-10-25'; 
DECLARE @smalldatetime smalldatetime = @date; 

SELECT @date AS '@date', @smalldatetime AS '@smalldatetime'; 

SELECT 
	CAST('2007-05-08 12:35:29. 1234567 +12:15' AS time(7)) AS 'time'
	,CAST('2007-05-08 12:35:29. 1234567 +12:15' AS date) AS 'date'
	,CAST('2007-05-08 12:35:29.123' AS smalldatetime) AS 
		'smalldatetime'
	,CAST('2007-05-08 12:35:29.123' AS datetime) AS 'datetime'
	,CAST('2007-05-08 12:35:29. 1234567 +12:15' AS datetime2(7)) AS 
		'datetime2'
	,CAST('2007-05-08 12:35:29.1234567 +12:15' AS datetimeoffset(7)) AS 
		'datetimeoffset'; 