# An Introduction to SQL

Table Flipping for Fun and Profit

![Table Flipping for Fun and Profit](https://media.giphy.com/media/6lScd4x2D5Oko/giphy.gif)

Annaia Danvers

![](https://cdn.glitch.com/41388b2e-033a-4169-85ef-909f1dcb3ad5%2FsiiliSmalleer.png?v=1617865780201)

^^^^

# Tables

SQL is a structured language for querying and modifying databases.

Data is represented as tables, like this:

| id  | name           | job                | alive | employer  |
| --- | -------------- | ------------------ | ----- | --------- |
| 1   | Annaia Danvers | Programmer         | true  | Siili     |
| 2   | Brian Cox      | Physicist          | true  | null      |
| 3   | John McCarthy  | Computer Scientist | false | MIT       |
| 4   | Sy Brand       | Programmer         | true  | Microsoft |

^^^^

# Types

Each column in a table is typed, and _must_ contain that type of value. Some common types are:

- BOOLEAN
- INTEGER
- FLOAT
- TIMESTAMP (optionally WITH TIME ZONE)
- CHAR(n): String of fixed length n
- VARCHAR(n): Variable length string of max size n

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
FROM people
```

Returns:

| name           | job                |
| -------------- | ------------------ |
| Annaia Danvers | Programmer         |
| Brian Cox      | Physicist          |
| John McCarthy  | Computer Scientist |
| Sy Brand       | Programmer         |

^^^^

# WHERE

WHERE is the filter clause, and allows you to filter for rows that match a boolean test

For example:

```
SELECT id, name
FROM people
WHERE job = 'physicist'
```

Returns:

| id  | name      |
| --- | --------- |
| 2   | Brian Cox |

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
WHERE employer IS NULL
```

Result:

| id  | name      |
| --- | --------- |
| 2   | Brian Cox |

^^^^

# IS and NOT

IS can also be used with NOT:

```
SELECT name, employer FROM people
WHERE employer IS NOT NULL
```

Result:

| name           | employer  |
| -------------- | --------- |
| Annaia Danvers | Siili     |
| John McCarthy  | MIT       |
| Sy Brand       | Microsoft |

^^^^

# IS and Booleans

IS can also be used to check for TRUE and FALSE with BOOLEAN columns:

```
SELECT id, name FROM people
WHERE alive IS FALSE
```

Results in:

| id  | name          |
| --- | ------------- |
| 3   | John McCarthy |

^^^^

# IN

IN let's you check for the presence of a value within an array:

```
SELECT id, name FROM people
WHERE job IN ('Programmer', 'Computer Scientist')
```

Result:

| id  | name           |
| --- | -------------- |
| 1   | Annaia Danvers |
| 3   | John McCarthy  |
| 4   | Sy Brand       |

^^^^

# BETWEEN

BETWEEN lets you check if a value is within a given range of values, either numbers, text, or even dates.

The begin and end values are inclusive.

```
SELECT * FROM people
WHERE id BETWEEN 2 AND 3
```

Result:

| id  | name          | job                | alive | employer |
| --- | ------------- | ------------------ | ----- | -------- |
| 2   | Brian Cox     | Physicist          | true  | null     |
| 3   | John McCarthy | Computer Scientist | false | MIT      |

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

# ORDER BY

ORDER BY is an additional clausethat tells the database to sort the result in order according to the columns
specified, optionally specifying ASC or DESC after the columns list to indicate in which direction to sort.

For example:

```
SELECT name, job FROM people
ORDER BY job ASC
```

Result:

| name           | job                |
| -------------- | ------------------ |
| John McCarthy  | Computer Scientist |
| Brian Cox      | Physicist          |
| Annaia Danvers | Programmer         |
| Sy Brand       | Programmer         |

^^^^

# COUNT

COUNT() is an _aggregate function_ that when applied to a column, counts the number of rows in that column.
It can also be used as COUNT(\*) to simply count the number of rows in the whole query.

Example:

```
SELECT COUNT(*) FROM people WHERE job = 'Programmer'
```

Result:

| COUNT(\*) |
| --------- |
| 2         |

^^^^

# COUNT and NULL

COUNT ignores NULL results from a column. So for example if we want to find how many people in our table have an employer:

```
SELECT COUNT(employer) FROM people
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
GROUP BY job
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
SELECT DISTINCT job FROM people
```

Result:

| job                |
| ------------------ |
| Programmer         |
| Physicist          |
| Computer Scientist |

^^^^

# Relations



^^^^

# Nesting SELECT

^^^^

# JOIN

^^^^

# UNION(?)

^^^^

# INSERT

^^^^

# UPDATE

^^^^

# DELETE/TRUNCATE(?)

^^^^

# CREATE/DROP

(primary key/foreign key/referential integrity)

^^^^

# Transactions (?)

^^^^

# CTE (?)

^^^^

# Credits

Slides & Presentation by Annaia Danvers

![](https://media.giphy.com/media/Xj1GHC7mXPquY/giphy.gif)

Site powered by [Glitch.com](https://glitch.com)

