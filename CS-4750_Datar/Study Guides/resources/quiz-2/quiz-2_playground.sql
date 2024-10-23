CREATE DATABASE Q2_PLAYGROUND
GO
USE Q2_PLAYGROUND
GO

-- Create practice_emp table
CREATE TABLE practice_emp(
empno INT UNIQUE NOT NULL,
CONSTRAINT empno_PK PRIMARY KEY (empno),
ename VARCHAR(50),
job VARCHAR(50),
sal DECIMAL(10, 2)
)


-- Insert values into the table
-- inserting values in the table
INSERT INTO practice_emp (empno, ename, job, sal) VALUES
(7369, 'Smith', 'Clerk', 1200),
(7499, 'Allen', 'Salesman', 2000),
(7521, 'Ward', 'Salesman', 1650),
(7566, 'Jones', 'Manager', 3375),
(7654, 'Martin', 'Salesman', 1650),
(7698, 'Blake', 'Manager', 3250),
(7782, 'Clark', 'Manager', 2850),
(7788, 'Scott', 'Analyst', 3500),
(7839, 'King', 'President', 6500),
(7844, 'Turner', 'Salesman', 1900),
(7876, 'Adams', 'Clerk', 1500),
(7900, 'James', 'Clerk', 1350),
(7902, 'Ford', 'Analyst', 3500),
(7934, 'Miller', 'Clerk', 1700);

-- quick version
SELECT E1.job, AVG(E2.sal) AS AvgSal
FROM practice_emp E1, practice_emp E2
WHERE E1.job = E2.job
GROUP BY E1.job

-- subquery approach
SELECT E1.job,
(SELECT AVG(E2.sal)
FROM practice_emp AS E2
WHERE E1.job = E2.job) AS AvgSal
FROM practice_emp E1
GROUP BY E1.job

-- FROM clause example
SELECT E1.job, AvgSal
FROM practice_emp E1, 
(SELECT job, AVG(sal) AS AvgSal
FROM practice_emp
GROUP BY job) AS E2
WHERE E1.job = E2.job
GROUP BY E1.job, AvgSal

-- WHERE clause example
SELECT E1.ename
FROM practice_emp E1
WHERE E1.sal = 
(SELECT MAX(E2.sal)
FROM practice_emp AS E2
WHERE E1.job = E2.job
GROUP BY E2.job)

-- uncorrelated example
WITH temp AS 
(SELECT job, MAX(sal) AS maxSAL
FROM practice_emp
GROUP BY job)
SELECT E1.ename
FROM practice_emp AS E1, temp as T
WHERE E1.sal = T.maxSAL AND E1.job = T.job

SELECT * FROM practice_emp


