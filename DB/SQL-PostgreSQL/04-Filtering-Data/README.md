# Filtering Data

### Comparison, Logical and Arithmetic operators
1. Comparison operator
- =
- >
- <
- >=
- <=
- !=

2. Logical operator
- AND
- OR 
- LIKE
- BETWEEN

### AND operator
**NB:** to use a condition, put the record in a single quote ' '
```sql
SELECT * FROM movies;

SELECT * FROM movies
WHERE 
	movie_lang = 'English' 
```

```sql
SELECT * FROM movies
WHERE 
	movie_lang = 'Japanese' 
```	
	
```sql
SELECT * FROM movies
WHERE 
	movie_lang = 'English' AND age_certificate = '18'
	
SELECT * FROM movies
WHERE 
	movie_lang = 'English' 
	AND age_certificate = '18'
```	

### OR operator
```sql
SELECT * FROM movies
WHERE 
	movie_lang = 'English' 
	OR movie_lang = 'Chinese'
ORDER BY movie_lang ASC

SELECT * FROM movies
WHERE 
	movie_lang = 'English' OR movie_lang = 'Chinese'
ORDER BY movie_lang ASC
```

```sql	
SELECT * FROM movies
WHERE 
	movie_lang = 'Japanese' 
	OR movie_lang = 'English'
	
SELECT * FROM movies
WHERE 
	movie_lang = 'Japanese' OR movie_lang = 'English'
```

```sql	
SELECT * FROM movies
WHERE 
	movie_lang = 'English' 
	AND director_id = '8'
	
SELECT * FROM movies
WHERE 
	movie_lang = 'English' AND director_id = '8'
```

### Combining AND, OR operators
```sql
SELECT * FROM movies
WHERE 
	(movie_lang = 'English' 
	OR movie_lang = 'Chinese')
	AND age_certificate = '12'
ORDER BY movie_lang ASC;

SELECT * FROM movies
WHERE 
	(movie_lang = 'English' OR movie_lang = 'Chinese') AND age_certificate = '12'
ORDER BY movie_lang ASC;
```
