CREATE TABLE movies_revenues (
	revenue_id SERIAL PRIMARY KEY,
	movie_id INT REFERENCES movies (movie_id),
	revenues_domestic NUMERIC (10,2),
	revenues_international NUMERIC (10,2)
);

SELECT * FROM movies_revenues; 

-- (10,2): 2 is the decimal places 
