# Querying Data

### Select all data from a table
The table is not case sentitive in SQL statment
```sql
SELECT * from movies;
SELECT * from MOVIES;
```

### Selecting specific columns from a table
```sql
SELECT * from actors;
SELECT column1, column FROM tablename;
SELECT first_name FROM actors;
SELECT first_name, last_name, gender FROM actors;

SELECT 
    first_name, 
    last_name, 
    gender 
FROM actors;
```

### Adding Aliases to columns in a table
```sql
SELECT * from actors;
SELECT first_name FROM actors;
SELECT first_name AS FirstName FROM actors;
SELECT first_name AS "First Name" FROM actors;
SELECT first_name AS "First Name",last_name AS "Last Name", date_of_birth AS "Date Of Birth" FROM actors;

SELECT 
	first_name AS "First Name",
	last_name AS "Last Name", 
	date_of_birth AS "Date Of Birth" 
FROM actors;

SELECT 
	first_name "First Name",
	last_name "Last Name", 
	date_of_birth "Date Of Birth" 
FROM actors;
```

### Concatenating 2 columns
```sql
SELECT first_name || last_name FROM actors;
SELECT first_name ||' ' || last_name FROM actors;
SELECT 
	first_name ||' ' || last_name AS "Full Name"
FROM actors;
```

### Using ORDER BY to sort records

**ASC** = Ascending order

**DESC** = Descending order

```sql
SELECT
	column_lint
FROM tablename
ORDER BY
	sort_expression [ASC | DESC],
	.....
	sort_expression [ASC | DESC];
```
1. Sort base on single column
sort all movies records by their release_date in ascending order 
```sql
SELECT 
	*
FROM movieS
ORDER BY 
	release_date DESC;
	
SELECT release_date FROM movies;

OR

SELECT 
	*
FROM movieS
ORDER BY 
	release_date ASC;
	
SELECT release_date FROM movies;
```

2. Order by is ascending order by default
```sql
SELECT 
	*
FROM movies
ORDER BY 
	release_date;
```

3. Sort all the movies records by their release_date in descending order, and movies_name in ascending order
```sql
SELECT 
	*
FROM MOVIES
ORDER BY 
	release_date DESC,
	movie_name ASC;
```

```sql
SELECT 
	*
FROM MOVIES
ORDER BY 
	release_date DESC,
	movie_name ASC
;
```

```sql
SELECT 
	*
FROM MOVIES
ORDER BY 
	release_date DESC,
	movie_name ASC
;
```

```sql
SELECT * FROM MOVIES
ORDER BY 
	release_date DESC,
	movie_name ASC,
	movie_length ASC;
```

###  Using ORDER BY with alias column name

```sql
SELECT 
 	first_name,
 	last_name AS "Last Name"
 FROM actors
 ```

```sql
 SELECT 
 	first_name AS "First Name",
 	last_name AS "Last Name"
FROM actors
ORDER BY 
	first_name ASC;
```

```sql
SELECT first_name ||' ' || last_name 
FROM actors
ORDER BY 
	first_name ASC;
```

```sql
SELECT 
 	first_name AS "First Name",
 	last_name AS "Last Name"
FROM actors
ORDER BY 
	first_name ASC;
```

###  Using ORDER BY to sort rows by expressions and length
```sql
SELECT 
	first_name,
	LENGTH(first_name)
FROM ACTORS
```

```sql
SELECT 
	first_name,
	LENGTH(first_name) as len
FROM ACTORS
ORDER BY
	len ASC
```

```sql
SELECT 
	first_name,
	LENGTH(first_name) as len
FROM ACTORS
ORDER BY
	len DESC
```

### Using ORDER BY with column name
1. sort all the records by first_name in ASC, date_bith DESC from actors

```sql
SELECT * FROM actors;

SELECT
	first_name,
	date_of_birth
FROM actors
ORDER BY 
	first_name ASC,
	date_of_birth DESC
;
```

```sql
SELECT * FROM actors
ORDER BY 
	first_name ASC,
	date_of_birth DESC
```

### Using DISTINCT for selecting distinct values
DISTINCT help us to look a unique data within the table. Remove deplicate data
```sql
SELECT * FROM movies;

SELECT
	movie_lang
FROM movies;
```

```sql
SELECT
	DISTINCT movie_lang
FROM movies;
```

```sql
SELECT
	DISTINCT movie_lang
FROM movies
ORDER BY movie_lang ASC;
```

This is how you can get all the unique record in a table with any duplicate of data
```sql
SELECT
	DISTINCT *
FROM movies
ORDER BY movie_lang ASC;
```

