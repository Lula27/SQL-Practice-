
SELECT 
	make, 
	MIN(price) AS minimum, 
	MAX(price) AS maximum, 
	MAX(price) - MIN(price) AS price_range, 
	AVG(price) AS average, 
	COUNT(price) AS count 
FROM 
	cars 
	INNER JOIN makes USING (make_id) 
GROUP BY 
	make;
