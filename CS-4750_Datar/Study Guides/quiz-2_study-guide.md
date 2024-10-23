# ***CS-4750 Quiz 2 Study Guide***


## **RA**

## **SQL Basics**

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

