USE AdventureWorks2012;
GO

-- Here will generate a simple divide-by-zero error
-- to show how the TRY/CATCH blocks work
BEGIN TRY
    -- Generate a divide-by-zero error.
    SELECT 1/0;
END TRY
BEGIN CATCH
    SELECT
        ERROR_NUMBER() AS ErrorNumber
        ,ERROR_SEVERITY() AS ErrorSeverity
        ,ERROR_STATE() AS ErrorState
        ,ERROR_PROCEDURE() AS ErrorProcedure
        ,ERROR_LINE() AS ErrorLine
        ,ERROR_MESSAGE() AS ErrorMessage;
END CATCH;
GO

-- Work with TRY/CATCH
BEGIN TRY 
-- Generate a divide-by-zero error
	SELECT 1/0;
END TRY 
BEGIN CATCH 
	SELECT 
		ERROR_NUMBER() AS ErrorNumber
		,ERROR_SEVERITY() AS ErrorSeverity
		,ERROR_STATE() AS ErrorState
		,ERROR_PROCEDURE() AS ErrorState
		,ERROR_PROCEDURE() AS ErrorProcedure
		,ERROR_LINE() AS ErrorLine
		,ERROR_MESSAGE() AS ErrorMessage;
END CATCH;
GO 



-- Here we show a more concrete example of using TRY/CATCH
-- in a transaction.  We know that we want transactions to
-- either complete successfully or rollback changes if some
-- issue occurs, so error handling forms a key part of a
-- transaction.
BEGIN TRANSACTION;

BEGIN TRY
    -- Generate a constraint violation error.
    DELETE FROM Production.Product
    WHERE ProductID = 980;
END TRY
BEGIN CATCH
    SELECT 
        ERROR_NUMBER() AS ErrorNumber
        ,ERROR_SEVERITY() AS ErrorSeverity
        ,ERROR_STATE() AS ErrorState
        ,ERROR_PROCEDURE() AS ErrorProcedure
        ,ERROR_LINE() AS ErrorLine
        ,ERROR_MESSAGE() AS ErrorMessage;

    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION;
END CATCH;

IF @@TRANCOUNT > 0
    COMMIT TRANSACTION;
GO


-- Transaction for try and catch error
BEGIN TRY 
-- Generate constraint violation error
	DELETE FROM Production.Product
	WHERE ProductID = 980;
END TRY 
BEGIN CATCH 
	SELECT 
		ERROR_NUMBER() AS ErrorNumber
		,ERROR_SEVERITY() AS ErrorSeverity
		,ERROR_STATE() AS ErrorState
		,ERROR_PROCEDURE() AS ErrorProcedure
		,ERROR_LINE() AS ErrorLine
		,ERROR_MESSAGE() AS ErrorMessage; 

	IF @@TRANCOUNT > 0 
		ROLLBACK TRANSACTION;
END CATCH; 
