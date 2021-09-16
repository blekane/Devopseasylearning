### Create a new table call customers in movies DB
```sql
CREATE TABLE customers (
	customer_id SERIAL PRIMARY KEY,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	email VARCHAR(150),
	age INT
);

SELECT * FROM customers;
```
### Insert a single record into customers table
```sql 
INSERT INTO customers (first_name, last_name, email, age)
VALUES ('Adnan','Waheed','a@b.com',40);

SELECT * FROM customers;
```

### Insert multiple records into customers table
```sql
INSERT INTO customers (first_name, last_name)
VALUES 
('ADNAN','WAHEED'),
('JOHN','ADAMS'),
('LINDA','ABE');

SELECT * FROM customers;
```

### Use RETURNING to get info on added rows
1. The system will not give you the same data that you added back. This will not return anything
```sql 
INSERT INTO customers (first_name)
VALUES ('ADAM');
```
2. This will return the entire role that was added
```sql
INSERT INTO customers (first_name)
VALUES ('JOSEPH') RETURNING *;
```
3. This will return the customer id
```sql
INSERT INTO customers (first_name)
VALUES ('JOSEPH1') RETURNING customer_id;
```

### Update data in a table

1. Update the email on the first record from `a@b.com` to `a2@b.com`
```sql
UPDATE customers
SET email = 'a2@b.com'
WHERE customer_id = 1;

SELECT * FROM customers;
```

2. Update multiple record at the same time
```sql
UPDATE customers
SET 
email = 'tom@gmail.com',
age = 30
WHERE customer_id = 1;

SELECT * FROM customers;
```

3. Update multiple record at the same time and return just the role

```sql
UPDATE customers
SET email = 'a2@b.com'
WHERE customer_id = 1
RETURNING *;
```

```sql
UPDATE customers
SET 
email = 'jhon@gmail.com',
first_name = 'John',
last_name = 'Smith',
age = 55
WHERE customer_id = 1
RETURNING *;
```

```sql
UPDATE customers
SET 
email = 'jhon@.com',
first_name = 'Hans',
last_name = 'Paul',
age = 10
WHERE customer_id = 3
RETURNING *;
```

### Updating all records in a table
1. Create a new column in customers tabe
```sql
ALTER TABLE public.customers
    ADD COLUMN gender character varying(15);
```

2. Update just one record
```sql
select * from customers;

UPDATE customers
SET gender = 'Male'
WHERE customer_id = 2
```

2. Update all the records
```sql
select * from customers;

UPDATE customers
SET gender = 'Male'
```

### Delete data from a table
```sql
select * from customers;

DELETE FROM customers 
WHERE customer_id = 1;
```

### Delete data from a table
```sql
select * from customers;

DELETE FROM customers 
```

