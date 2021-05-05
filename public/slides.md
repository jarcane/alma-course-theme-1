# An Introduction to SQL

Table Flipping for Fun and Profit

![Table Flipping for Fun and Profit](https://media.giphy.com/media/6lScd4x2D5Oko/giphy.gif)

Annaia Danvers

![](https://cdn.glitch.com/41388b2e-033a-4169-85ef-909f1dcb3ad5%2FsiiliSmalleer.png?v=1617865780201)

^^^^

# Tables

SQL is a structured language for querying and modifying databases.

Data is represented as tables, like this:

| id  | name           | job                | alive | employer |
| --- | -------------- | ------------------ | ----- | -------- |
| 1   | Annaia Danvers | Programmer         | true  | Siili    |
| 2   | Lisa Randall   | Physicist          | true  | null     |
| 3   | Grace Hopper   | Computer Scientist | false | US Navy  |
| 4   | Steve Klabnik  | Programmer         | true  | Oxide    |

^^^^

# Types

Each column in a table is typed, and _must_ contain that type of value. Some common types are:

- BOOLEAN
- INTEGER
- FLOAT
- TIMESTAMP (optionally WITH TIME ZONE)
- TEXT: A more flexible data type for strings and text
- SERIAL: an autoincrementing integer column useful for IDs (PostgreSQL only)

^^^^

# CRUD

As with any database, the main operations are CRUD: create, read, update, delete.

They map to the following SQL statements (with equivalent HTTP request for comparison):

| CRUD   | SQL    | HTTP   |
| ------ | ------ | ------ |
| create | INSERT | PUT    |
| read   | SELECT | GET    |
| update | UPDATE | PUT    |
| delete | DELETE | DELETE |

^^^^

# SELECT

SELECT is the basic query statement, the 'read' in CRUD

A basic SELECT generally has two clauses:

- the SELECT itself, followed by the list of columns from the table you want (or \* for all columns)
- the FROM clause, which expects the name of a table

^^^^

# SELECT (cont.)

For example:

```
SELECT name, job
FROM people;
```

Returns:

| name           | job                |
| -------------- | ------------------ |
| Annaia Danvers | Programmer         |
| Lisa Randall   | Physicist          |
| Grace Hopper   | Computer Scientist |
| Steve Klabnik  | Programmer         |

^^^^

# WHERE

WHERE is the filter clause, and allows you to filter for rows that match a boolean test

For example:

```
SELECT id, name
FROM people
WHERE job = 'physicist';
```

Returns:

| id  | name         |
| --- | ------------ |
| 2   | Lisa Randall |

^^^^

# Operators

Common basic comparison operators are as in many languages:

- = (equals)
- <> (not equals)
- < (less than)
- <= (less than or equal)
- \> (greater than)
- \>= (greater than or equal)
- AND/OR/NOT

^^^^

# IS and NULL

NULL is the SQL value that indicates that a given column is empty for that row.

You can check for NULL with IS, in the form like:

```
SELECT id, name FROM people
WHERE employer IS NULL;
```

Result:

| id  | name         |
| --- | ------------ |
| 2   | Lisa Randall |

^^^^

# IS and NOT

IS can also be used with NOT:

```
SELECT name, employer FROM people
WHERE employer IS NOT NULL;
```

Result:

| name           | employer |
| -------------- | -------- |
| Annaia Danvers | Siili    |
| Grace Hopper   | US Navy  |
| Steve Klabnik  | Oxide    |

^^^^

# IS and Booleans

IS can also be used to check for TRUE and FALSE with BOOLEAN columns:

```
SELECT id, name FROM people
WHERE alive IS FALSE;
```

Results in:

| id  | name         |
| --- | ------------ |
| 3   | Grace Hopper |

^^^^

# IN

IN let's you check for the presence of a value within an array:

```
SELECT id, name FROM people
WHERE job IN ('Programmer', 'Computer Scientist');
```

Result:

| id  | name           |
| --- | -------------- |
| 1   | Annaia Danvers |
| 3   | Grace Hopper   |
| 4   | Steve Klabnik  |

^^^^

# BETWEEN

BETWEEN lets you check if a value is within a given range of values, either numbers, text, or even dates.

The begin and end values are inclusive.

```
SELECT * FROM people
WHERE id BETWEEN 2 AND 3;
```

Result:

| id  | name         | job                | alive | employer |
| --- | ------------ | ------------------ | ----- | -------- |
| 2   | Lisa Randall | Physicist          | true  | null     |
| 3   | Grace Hopper | Computer Scientist | false | US Navy  |

^^^^

# LIKE

LIKE is a string-matching operator. It lets you compare a string to a _pattern_, and matches on strings that fit the pattern.

The pattern is itself a string, with special behavior for two special characters:

- `%`: matches any number of characters
- `_`: matches a single character

You can use this to match fragments of strings to the data, for instance in our data set:

- `WHERE job LIKE '%ist'` will match Cox's 'Physicist' and McCarthy's 'Computer Scientist'
- `WHERE job LIKE 'P%'` will match my 'Programmer' and Cox's 'Physicist'

^^^^

# Exercise Time!

We'll now do section 2: SELECT from World on SQLZOO

<https://sqlzoo.net/wiki/SELECT_from_WORLD_Tutorial>

^^^^

# ORDER BY

ORDER BY is an additional clausethat tells the database to sort the result in order according to the columns
specified, optionally specifying ASC or DESC after the columns list to indicate in which direction to sort.

For example:

```
SELECT name, job FROM people
ORDER BY job ASC;
```

Result:

| name           | job                |
| -------------- | ------------------ |
| Grace Hopper   | Computer Scientist |
| Lisa Randall   | Physicist          |
| Annaia Danvers | Programmer         |
| Steve Klabnik  | Programmer         |

^^^^

# COUNT

COUNT() is an _aggregate function_ that when applied to a column, counts the number of rows in that column.
It can also be used as COUNT(\*) to simply count the number of rows in the whole query.

Example:

```
SELECT COUNT(*) FROM people WHERE job = 'Programmer';
```

Result:

| COUNT(\*) |
| --------- |
| 2         |

^^^^

# COUNT and NULL

COUNT ignores NULL results from a column. So for example if we want to find how many people in our table have an employer:

```
SELECT COUNT(employer) FROM people;
```

Result:

| COUNT(employer) |
| --------------- |
| 3               |

^^^^

# GROUP BY

The GROUP BY clause can be added to a query to "group" the results of an aggregate function like COUNT with a related column.
This lets us do things like count results for specific values.

For example:

```
SELECT job, COUNT(*) FROM people
GROUP BY job;
```

Result:

| job                | COUNT(\*) |
| ------------------ | --------- |
| Computer Scientist | 1         |
| Physicist          | 1         |
| Programmer         | 2         |

^^^^

# More Aggregate Functions

Other aggregate functions exist and can be used in a similar fashion with GROUP BY to collect results.
Many of these are most useful with columns of numeric values.

- SUM(): totals the values for all rows selected in the column
- MIN(): Finds the smallest value of all rows
- MAX(): Finds the largest value of all rows
- AVG(): Finds the average value of the rows (ie. SUM()/COUNT())

^^^^

# DISTINCT

The DISTINCT keyword can be appended to SELECT to only return unique examples of the value of the column selected.

Example:

```
SELECT DISTINCT job FROM people;
```

Result:

| job                |
| ------------------ |
| Programmer         |
| Physicist          |
| Computer Scientist |

^^^^

# Exercise time!

We will now do section 5: SUM and COUNT

<https://sqlzoo.net/wiki/SUM_and_COUNT>

^^^^

# Relations

Of course the most powerful part of databases is they are _relational_. Through the use of several different methods
we can cross reference data between tables in a single query. To demonstrate we're gonna add a new table we'll call _publications_:

| id  | title                         | year | author_id |
| --- | ----------------------------- | ---- | --------- |
| 1   | The Rust Programming Language | 2018 | 4         |
| 2   | Understanding Computers       | 1987 | 3         |
| 3   | Higgs Discovery               | 2013 | 2         |
| 4   | Warped Passages               | 2005 | 2         |

^^^^

# Nesting SELECT

The result of a SELECT can be used as a value within another SELECT query.

Example:

```
SELECT name, job FROM people
WHERE id=(SELECT author_id FROM publications
          WHERE title='The Rust Programming Language');
```

Result:

| name          | job        |
| ------------- | ---------- |
| Steve Klabnik | Programmer |

^^^^

# Exercise Time!

Section 4: SELECT within SELECT

<https://sqlzoo.net/wiki/SELECT_within_SELECT_Tutorial>

^^^^

# JOIN

There's a much easier way to do many things you might do with nested SELECT: JOINs.

Example:

```
SELECT people.name, people.job FROM people
JOIN publications ON people.id = publications.author_id
WHERE publications.title = 'The Rust Programming Language';
```

Result:

| name          | job        |
| ------------- | ---------- |
| Steve Klabnik | Programmer |

^^^^

# JOIN (cont.)

Besides cross-referencing, JOIN can also be used to combine data, as the resulting table can have any column from either:

Example:

```
SELECT publications.title, publications.year, people.name
FROM publications
JOIN people ON publications.author_id = people.id;
```

Result:

| title                         | year | name          |
| ----------------------------- | ---- | ------------- |
| The Rust Programming Language | 2018 | Steve Klabnik |
| Understanding Computers       | 1987 | Grace Hopper  |
| Higgs Discovery               | 2013 | Lisa Randall  |
| Warped Passages               | 2005 | Lisa Randall  |

^^^^

# JOIN and Aggregates

We can combine a JOIN with an aggregate function to generate interesting reports.

Example:

```
SELECT people.name, COUNT(publications.id)
FROM people
JOIN publications ON people.id = publications.author_id
GROUP by people.name;
```

Result:

| name          | count |
| ------------- | ----- |
| Steve Klabnik | 1     |
| Grace Hopper  | 1     |
| Lisa Randall  | 2     |

^^^^

# OUTER JOIN

You may notice a problem in our last example: I'm missing! I wasn't included in the table because I have no publications,
so I don't appear in the publications table.

Default join is an _INNER JOIN_: it only includes data that matches both sides of the join.

There are three other kinds of _OUTER JOIN_ that include missing data:

- LEFT JOIN: Includes all of the left table + matching data from both
- RIGHT JOIN: Includes all of the right table + matching data
- FULL JOIN: Includes all data from _both_ sides of the table

^^^^

# OUTER JOIN (cont.)

So we can fix our previous query by instead using a LEFT JOIN to make sure I don't get left out:

Example:

```
SELECT people.name, COUNT(publications.id)
FROM people
LEFT JOIN publications
ON people.id = publications.author_id
GROUP BY people.name;
```

Returns:

| name           | count |
| -------------- | ----- |
| Annaia Danvers | 0     |
| Steve Klabnik  | 1     |
| Grace Hopper   | 1     |
| Lisa Randall   | 2     |

^^^^

# Exercise time!

Section 6: JOIN

<https://sqlzoo.net/wiki/The_JOIN_operation>

^^^^

# AS and Short Names

Table names and columns can be a bit cumbersome or cryptic to read. The AS keyword lets us give things names.

Example:

```
SELECT p.name, COUNT(pub.id) AS books
FROM people AS p
LEFT JOIN publications pub
ON p.id = pub.author_id
GROUP BY p.name;
```

Result:

| name           | books |
| -------------- | ----- |
| Annaia Danvers | 0     |
| Steve Klabnik  | 1     |
| Grace Hopper   | 1     |
| Lisa Randall   | 2     |

^^^^

# Common Table Expression (CTE)

Another handy concept for simplifying code is a "common table expression". CTEs allow you to make an intermediate query
and assign the result to a name, to be treated as a table in an additional query:

Example:
```
With rust_books as (
  SELECT author_id FROM publications
  WHERE title LIKE '%Rust%'
)
SELECT name, job 
FROM people, rust_books
WHERE people.id=rust_books.author_id;
```

Result:

| name          | job        |
| ------------- | ---------- |
| Steve Klabnik | Programmer |

^^^^

# INSERT

INSERT is the _create_ part of our CRUD operations. It lets you insert new row into the table.

INSERT expects an INTO clause indicating the table (and optionally which columns in the table) we're inserting our data,
and a VALUES clause that contains an array of the values to insert in those columns.

Example:

```
INSERT INTO people (name, job, alive)
VALUES ('Bozo','Clown',TRUE);
```

^^^^

# UPDATE

UPDATE is the next part of our CRUD, letting us set specific columns for a row in our table.

UPDATE has a SET clause, which contains a number of assignment statements, and a WHERE clause, which matches the row
to be updated in much the same way WHERE does in a SELECT

Example:

```
UPDATE people
SET alive = FALSE
WHERE name = 'Bozo';
```

^^^^

# DELETE

And finally, DELETE forms the last part of the CRUD operations, and allows us to delete a row from our table.

DELETE contains a FROM clause indicating which table we're targeting, and a WHERE clause, which again functions much
like the WHERE clause in a SELECT.

```
DELETE FROM people
WHERE name = 'Bozo';
```

^^^^

# Transactions

An important concept when making changes to the database is 'transactions'. A transaction is a group of operations that 
the database is instructed *must* all successfully run, or else any changes will be safely rolled back.

Many SQL libraries automatically wrap all queries in transactions for safety, but you can also set one manually by the 
BEGIN and COMMIT commands:

```
BEGIN;
INSERT INTO people (name, job, alive)
VALUES ('Bozo','Clown',TRUE);
UPDATE people
SET alive = FALSE
WHERE name = 'Bozo';
COMMIT;
```

^^^^

# CREATE TABLE

CREATE TABLE is how we can create new tables for new data sets in our database.

A CREATE TABLE statement consists of the name of the table, followed by a list of the columns of that table and their types.

The statement for the _publications_ table looks like this:

```
CREATE TABLE publications (
  id SERIAL PRIMARY KEY,
  title TEXT not NULL,
  year INTEGER not NULL,
  author_id INTEGER not NULL,
  foreign KEY (author_id) references people(id)
);
```

^^^^

# ALTER TABLE

The ALTER TABLE statment contains a number of subclauses that allow us to modify the columns contained in our table.

It starts with `ALTER TABLE <name of table>` followed by one of these common clauses (and many more):

- ADD _name_ _datatype_: adds a column to the table, specifying its name and data type much as in CREATE
- DROP COLUMN _name_: removes the column and all data in it from the table
- ALTER COLUMN _name_ TYPE _datatype_: changes the type of the column and tries to convert any data present.
- RENAME COLUMN _name_ TO _new_name_: renames a column to a new name
- RENAME _name_ TO _new_name_: Renames the entire table

^^^^

# DROP TABLE

The DROP TABLE statement simply deletes a table and all its data entirely from the database.

It expects only the name of the table to be removed.

This often CANNOT be reversed without restoring from backups so be _very_ careful when handling it.

We could remove the _publications_ table like this:

```
DROP TABLE publications;
```

^^^^

# Credits

Slides & Presentation by Annaia Danvers

![](https://media.giphy.com/media/Xj1GHC7mXPquY/giphy.gif)

Site powered by [Glitch.com](https://glitch.com)
