# ***CS-4750 Quiz 2 Study Guide***


## **RA**

### **Operations**

- two types of query languages: procedural vs declarative
- Unary Operations
  - Selection $\sigma$
    - conditions such as $=, <, <=, >, >=, <>$ and AND, OR, NOT
    - Notation: $\sigma P(r)$
    - Example: $\sigma$TA = 'Minnie' AND Course = 'Database Systems' (Student_lecture)
  - Project $\pi$
    - returns specified attributes of a relation
    - removes duplicates
    - $\pi$A1, A2, ..., Ak (r)
  - Rename $\rho$
    - changes schema
    - Example: $\rho$ friend_contact(ID, primary_email, alternative_email)(contact)
  - Assignment $(<-)$
- Binary Operations
  - Cartesian Product $(\times)$
  - Union $(\cup)$
  - Intersection $(\cap)$
  - Difference $(-)$
  - Conditional/Natural Join $\bowtie$
    - merge under condition
  - Division $(\div)$
    - used to find "for all" queries
- Other Operations
  - Group By (G) and Aggregate $(\gamma)$
    - group by for summarization
    - aggregate for five standard operators

## **SQL Basics**

Queries divided into three types
- **Data Driven Language (DDL)**: effects schema
  - commands that define a database
  - examples: `CREATE DATABASE/TABLE`, `ALTER TABLE`, `DROP TABLE`, `TRUNCATE`, etc
- **Data Manipulation Language (DML)**: effects instance
  - commands that query a database
  - examples: `SELECT`, `INSERT`, `UPDATE`, `DELETE`
- **Data Control Language (DCL)**: control database
  - administering privileges
  - committing data

### **Datatypes**
- int, float, decimal(p, s)
- Strings
  - CHAR(n): fixed length n
  - VARCHAR(n): variable length, max length n 
  - TEXT: large values, NOT NULL
- Boolean
- Date, Time, Timestamp
  - Date: year, month, and day values
  - Time: hour, minute, and second
  - Timestamp: year, month, day, hour, minute, and second
- Blob: varying-length binary string for file, image, video, large object

### **Data Integrity Controls**
- **Referential Integrity**: constraint that ensures that foreign key values of a table must match primary key of related table
- Options
  - *Restricting*: cannot delete record where parent table has primary key that child table uses as the foreign key
  - *Cascading*: remove data from oparent and child table (foreign key) automatically
  - *Set to null/default*: when record from parent table is removed, foreign key with child table with be `NULL`

### **Commands**
- `TRUNCATE`: remove all records
- `ORDER BY`: sorts results in ascending or descending order
- `GROUP BY`: combine and categorize data results from aggregate functions
- `BULK Insert`: import data
- `UPDATE`: modifies data in existing rows
```sql
UPDATE table_name
SET column1 = value1, column2 = value2, ...
WHERE condition
```
- `DELETE`: for removing rows from table
```sql
DELETE FROM table_name
WHERE condition
```
- `SELECT` statement
  - Clauses
    - `SELECT`: list columns that should be viewed
    - `FROM`: indicate table/view from which data will be obtained
    - `WHERE`: conditions where row we be added
    - `GROUP BY`: categorization of results
    - `HAVING`: conditions where category (group) will be included
    - `ORDER BY`: sorts results according to criteria

- Aggregate functions
  - `COUNT()`, `SUM()`, `AVG()`, `MAX()`, `MIN()`
  - use `HAVING` clause to filter out output from `GROUP BY` clause
- Joins
  - combine related tables or sets of data on key values
  - `INNER JOIN`: returns matching records between two tables
  - `LEFT JOIN/LEFT OUTER JOIN`: returns all recorods from left table and the matching records from the right table
  - `RIGHT JOIN/RIGHT OUTER JOIN`: returns all records from right table and matching records from the left table
  - `FULL JOIN/FULL OUTER JOIN`: returns all recrods when there is a match in either left or right table
  - `SELF JOIN`: table is joined with itself

## **SQL Subqueries**

Core Idea:
- split problem into subproblems
- solve separately
- compose them

**subquery**: query that is part of another query
- subqueries can have subqueries

**correlate subquery**: subquery that depends on outer query
- subquery executed repeatedly
- inner query references outer query

**uncorrelated subquery**: inner query is independent of outer query
- independence: subquery does not depend on outer query for execution
- executed once
- more efficient than correlated subqueries

### *SELECT* clause

Example (correlated subquery)
```sql
SELECT E1.job,
(SELECT AVG(E2.sal)
FROM practice_emp AS E2
WHERE E1.job = E2.job) AS AvgSal
FROM practice_emp E1
GROUP BY E1.job
```

Steps:
1. fetches all the jobs from E1 (outer query)
2. execute subquery for each job retrieved by outer query

### *FROM* clause
- Example (uncorrelated)
```sql
SELECT E1.job, AvgSal
FROM practice_emp E1,
(SELECT job, Avg(sal) AS AvgSal
FROM practice_emp
GROUP BY job) AS E2
WHERE E1.job = E2.job
GROUP BY E1.job, AvgSal
```

Steps
1. run inner query
2. join queries
3. select columns
4. group E1.job and AvgSal

### *WHERE* clause

```sql
SELECT E1.ename
FROM practice_emp E1
WHERE E1.sal = 
(SELECT MAX(E2.sal)
FROM practice_emp AS E2
WHERE E1.job = E2.job
GROUP BY E2.job)
```

#### **Existential Quantifier**
**existential quantifiers**: exists at least one element
- `EXISTS`: true if there exists at least one element that satisfies the condition
  - Syntax: `SELECT ____ WHERE EXISTS (subquery)`
- `IN`: check whether something is in list
  - Syntax: `SELECT ____ WHERE attribute IN (subquery)`
- `ANY`: if there any value that satisfies the condition
  - Syntax: `SELECT ____ WHERE constant >/</= ANY (subquery)`
  - similar to exists except with operators

#### **Universal Quantifiers**
**universal quantifiers**: for all elements
- every element satisfies a given property

- `NOT IN`: elements that are NOT in the list
  - Syntax: `SELECT ____ WHERE attribute NOT IN (subquery)`
- `NOT EXISTS`: true if there does NOT exist an element that satisfies the condition
  - Syntax: `SELECT ____ WHERE NOT EXISTS (subquery)`
- `ALL`: true if ALL the values satisfy the condition
  - Syntax: `SELECT ____ WHERE constant >/</= ALL (subquery)`

#### *WITH* clause 

The `WITH` clause return a temporary relation that can be used by an associated query

Same example as above but with an uncorrelated approach
```sql
WITH temp AS 
(SELECT job, MAX(sal) AS maxSAL
FROM practice_emp
GROUP BY job)
SELECT E1.ename
FROM practice_emp AS E1, temp as T
WHERE E1.sal = T.maxSAL AND E1.job = T.job
```

## **Resources**

`ANY` vs `EXISTS`: https://www.reddit.com/r/SQL/comments/js0dic/whats_the_difference_between_any_and_exists_in_sql/

`ALL`: https://www.sqltutorial.org/sql-all/

