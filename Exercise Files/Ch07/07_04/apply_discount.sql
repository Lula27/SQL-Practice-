
SELECT 
	car_id, 
	make, 
	yearmade, 
	mileage, 
	transmission, 
	price, 
	apply_discount(price) AS discounted, 
	description 
FROM 
	cars 
	INNER JOIN makes USING (make_id) 
ORDER BY 
	price ASC