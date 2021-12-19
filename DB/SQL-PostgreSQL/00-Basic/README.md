### What is a Database?
A database is a place where you can store, manipulate and retrieve data

### Types of database
- Flat file (like excel sheet)
- documents model databases (NOSQL)
    - These databases content documents instead of tables
- Relational Databases - This is when 2 or more tables have a relationship between them
    - Oracle Database (we need a license)
    - MYSQL (own by oracle)
    - SQL Server (own by Microsoft)
    - PostgreSQL (free and open source)

### structure query Language (SQL)
It is a the language for talking to relational databases. It is used to create tables, insert data, retrieve data and much more. 

### Downlaod PostgreSQL
[PostgreSQL Downloads](https://www.postgresql.org/download/)


### Installing PostgreSQL
[PostgreSQL: The World's Most Advanced Open Source Relational Database ---> Download](https://www.postgresql.org/)

[PostgreSQL Database Download](https://www.enterprisedb.com/downloads/postgres-postgresql-downloads)

- Default user: postgre
- Default port: 5432

### Add psql to path in windows
[Open postgreSQL through command prompt in windows PC](https://www.youtube.com/watch?v=1Za_EzTIXVY)

Search for env and edit it
```
C:\Program Files\PostgreSQL\13\bin
```

### Connect to Postgres
```
psql -U [username] -h [hostname]
psql -U postgres -h localhost
```
postgres pasword = 12345
master= Vanessa50======

### Pgadmin zoom in and out
```
ctrl +
ctrl -
```

### List databases
```
\l
```
### Quit
```
\q
```

### List table
```
\dt
```

### List users
```
\du
```

### Clear screen
```
\! cls
```

### Switching Databases
```
\c [database name]
\c sales
```

### Create a database
```sql
CREATE DATABASE [database name];
CREATE DATABASE sales;
```

### PostgreSQL DROP DATABASE
**NB:** only the supper user and the owner can drop the database
```sql
DROP DATABASE IF EXISTS  [database name];
DROP DATABASE IF EXISTS sales;
```

### How to delete users?
```sql
DROP USER  [user name];
DROP USER  tia;
```

### Drop a table
```sql
DROP TABLE  [table name];
DROP TABLE accounts;
```

### Drop a COLUMN (ALTER TABLE DROP COLUMN)
```sql
ALTER TABLE table_name
DROP COLUMN column_name;

ALTER TABLE accounts
DROP COLUMN user_email;
```

### Create a database and connect
```sql
CREATE DATABASE yourdbname;
CREATE USER youruser WITH ENCRYPTED PASSWORD 'yourpass';
GRANT ALL PRIVILEGES ON DATABASE yourdbname TO youruser;

CREATE DATABASE hr;
CREATE USER john WITH ENCRYPTED PASSWORD '12345';
GRANT ALL PRIVILEGES ON DATABASE hr TO john;

CREATE ROLE paul WITH LOGIN PASSWORD '12345';
CREATE DATABASE master WITH OWNER paul;
\c master;

psql -U postgres -h localhost

psql -h localhost -p 5432 -U paul master
psql -h localhost -p 5432 -U john hr
psql -h localhost -p 5432 -U adam learning
```

```
psql -U postgres -h localhost
psql -h localhost -p 5432 -U adam learning
psql -h localhost -p 5432 -U tia learning
```

### Search in the table
```
SELECT * FROM [table name];
SELECT * FROM locations;
```

### Comment in SQL
```
--- Using pgAdmin - View table structure, and create column
```

OR 

```
/*
Using pgAdmin - Rename, delete and change the data type of a column
Using pgAdmin - View table structure, and create column
*/
```
