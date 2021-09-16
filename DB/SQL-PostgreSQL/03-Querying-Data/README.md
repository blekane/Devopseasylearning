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