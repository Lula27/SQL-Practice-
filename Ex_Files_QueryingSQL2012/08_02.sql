--******************************************
-- 08_02_TSQL_Programming.sql
--******************************************

USE AdventureWorks2012;
GO


-- You can use IF...ELSE to control flow based on Boolean 
-- conditions.
-- Boolean conditions are either true or false
-- This sample is taken directly from the SQL Server Books 
-- Online samples and demonstrates the use of IF...ELSE.
-- Here we are checking to see if the number of products, 
-- with the text "Touring-3000" in the name, is greater than 5. 
-- If the result is true, then we print out a statement to 
-- the results window based on the result returned.  
-- The ELSE clause prints a different message for a false result
USE AdventureWorks2012;
GO

IF 
(SELECT COUNT(*) FROM Production.Product 
	WHERE Name LIKE 'Touring-3000%' ) > 5
PRINT 'There are more than 5 Touring-3000 bicycles.'
ELSE PRINT 'There are 5 or less Touring-3000 bicycles.' ;
GO


-- Using BEGIN and END can help us control groups of statements. 
-- This is similar to batching
USE AdventureWorks2012;
GO

-- declare some variables for use in the script
DECLARE @AvgWeight decimal(8,2), @BikeCount int

-- set up and IF statement like above, checking the number of Touring-3000 products
-- and then setup a statement block using BEGIN.
IF 
(SELECT COUNT(*) FROM Production.Product 
	WHERE Name LIKE 'Touring-3000%' ) > 5
BEGIN
	-- Set a value for the @BikeCount variable based on a query for the count of those products
   SET @BikeCount = 
        (SELECT COUNT(*) 
         FROM Production.Product 
         WHERE Name LIKE 'Touring-3000%');

    -- Set a value for the @AvgWeight variable using the AVG math function
   SET @AvgWeight = 
        (SELECT AVG(Weight) 
         FROM Production.Product 
         WHERE Name LIKE 'Touring-3000%');

    -- print out messages based on the results
   PRINT 'There are ' + CAST(@BikeCount AS varchar(3)) 
	+ ' Touring-3000 bikes.'
   PRINT 'The average weight of the top 5 Touring-3000 bikes 
	is ' + CAST(@AvgWeight AS varchar(8)) + '.';


-- This END keyword marks the end of the statement block that was started with BEGIN
END

-- Setup the messages for the case of a false return from IF
ELSE 
BEGIN
SET @AvgWeight = 
        (SELECT AVG(Weight)
         FROM Production.Product 
         WHERE Name LIKE 'Touring-3000%' );
   PRINT 'Average weight of the Touring-3000 bikes is ' 
	+ CAST(@AvgWeight AS varchar(8)) + '.' ;
END ;
GO