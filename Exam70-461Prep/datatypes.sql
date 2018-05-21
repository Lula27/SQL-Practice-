-- Practice with data types 
DECLARE @MyBitVariable bit = 0 
SELECT @MyBitVariable AS MyBitVariable 
	, DATALENGTH(@MyBitVariable) AS StorageSpace;  -- DATALENGTH is a function that tells how much space being taken

-- could also use SET instead of SELECT 

DECLARE @MyIntVariable int = 500
SELECT @MyIntVariable AS MyIntVariable 
	, DATALENGTH(@MyIntVariable) AS StorageSpace; 