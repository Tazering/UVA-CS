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

DROP TABLE practice_emp

-----------------------------------------------------------------------

-- New Set up of tables
CREATE TABLE Employees(
employee_id INT NOT NULL UNIQUE,
CONSTRAINT employee_PK PRIMARY KEY (employee_id),
employee_name VARCHAR(100)
)

CREATE TABLE Projects(
project_id INT NOT NULL UNIQUE,
CONSTRAINT project_PK PRIMARY KEY (project_id),
project_name VARCHAR(100),
employee_id INT,
CONSTRAINT employee_FK FOREIGN KEY (employee_id) REFERENCES Employees(employee_id)
)

-- insert into employees
INSERT INTO Employees (employee_id, employee_name) VALUES
(1, 'John Doe'),
(2, 'Jane Smith'),
(3, 'Alice Brown'),
(4, 'Michael Johnson'),
(5, 'Emma Davis'),
(6, 'Robert Wilson'),
(7, 'Sophia Miller'),
(8, 'James Taylor'),
(9, 'Olivia Moore'),
(10, 'Liam Harris'),
(11, 'Isabella Clark'),
(12, 'Benjamin Lewis'),
(13, 'Mia Young'),
(14, 'Lucas Walker'),
(15, 'Amelia Hall'),
(16, 'Mason Lee'),
(17, 'Charlotte Allen'),
(18, 'Elijah King'),
(19, 'Harper Wright'),
(20, 'William Scott');
-- insert into projects
INSERT INTO Projects (project_id, project_name, employee_id) VALUES
(1, 'Project Alpha', 1),
(2, 'Project Beta', 1),
(3, 'Project Gamma', 2),
(4, 'Project Alpha', 3),
(5, 'Project Beta', 4),
(6, 'Project Gamma', 4),
(7, 'Project Delta', 5),
(8, 'Project Alpha', 6),
(9, 'Project Epsilon', 7),
(10, 'Project Delta', 7),
(11, 'Project Beta', 8),
(12, 'Project Gamma', 9),
(13, 'Project Alpha', 9),
(14, 'Project Delta', 10),
(15, 'Project Alpha', 11),
(16, 'Project Beta', 12),
(17, 'Project Gamma', 12),
(18, 'Project Delta', 13),
(19, 'Project Epsilon', 14),
(20, 'Project Gamma', 15);


-- Practice questions

-- 1) employees work on at least one project named 'Project Alpha'
SELECT E.employee_name
FROM Employees E
WHERE E.employee_id IN
(SELECT E1.employee_id
FROM Employees E1
INNER JOIN Projects P
ON E1.employee_id = P.employee_id
WHERE P.project_name = 'Project Alpha')

-- BETTER SOLUTION
SELECT E.employee_name
FROM Employees E
WHERE EXISTS 
(SELECT 1
FROM Projects P
WHERE E.employee_id = P.employee_id AND P.project_name = 'Project Alpha')

-- 2) employees that work on either Project Alpha or Project Beta
SELECT E.employee_name
FROM Employees E
WHERE E.employee_id IN
(SELECT P.employee_id
FROM Projects P
WHERE P.project_name = 'Project Alpha' OR P.project_name = 'Project Beta')

-- BETTER SOLUTION
/* IN checks whether a value matches any value in a list or a subquery result */
SELECT employee_name
FROM Employees
WHERE employee_id IN (
SELECT employee_id
FROM Projects
WHERE project_name IN ('Project Alpha', 'Project Beta')
);


-- 3) Which employees are working on any project with an project_id greater than 5
SELECT E.employee_name
FROM Employees E
WHERE E.employee_id = ANY
(SELECT P.employee_id
FROM Projects P
WHERE P.project_id > 5)

-- BETTER SOLUTION
/* ANY compares a value to any value in a list or subquery
and returns true if the comparison is true for at least one value */
SELECT employee_name
FROM Employees
WHERE employee_id = ANY (
SELECT employee_id
FROM Projects
WHERE project_id > 5
);

-- 4) employees not working on any project name "Project Alpha"
SELECT E.employee_name
FROM Employees E
WHERE NOT EXISTS
(SELECT 1 
FROM Projects P
WHERE E.employee_id = P.employee_id AND P.project_name = 'Project Alpha')

-- BETTER SOLUTION
/* NOT EXISTS checks if a subquery returns no rows.
It returns true if the subquery doesn't find any results. */
SELECT employee_name
FROM Employees e
WHERE NOT EXISTS (
SELECT 1
FROM Projects p
WHERE p.project_name = 'Project Alpha'
AND p.employee_id = e.employee_id
);


-- 5) Which employees are not working on either "Project Alpha" or "Project Gamma"?
SELECT E.employee_name
FROM Employees E
WHERE E.employee_id NOT IN
(SELECT P.employee_id
FROM Projects P
WHERE P.project_name IN ('Project Alpha', 'Project Gamma'))


-- BETTER SOLUTION
/* NOT IN is used to filter out rows where a
value does not match any value in a list or subquery result. */
SELECT employee_name
FROM Employees
WHERE employee_id NOT IN (
SELECT employee_id
FROM Projects
WHERE project_name IN ('Project Alpha', 'Project Gamma')
);


-- 6) Which employees are working on all projects with a project_id greater than 5?
SELECT E.employee_name
FROM Employees E
WHERE E.employee_id = ALL
(SELECT P.employee_id, P.project_id
FROM Projects P
WHERE P.project_id > 5)

/* ALL compares a value to every value in a list or subquery.
It returns true if the comparison is true for all values */
SELECT employee_name
FROM Employees e
WHERE employee_id = ALL (
SELECT p.employee_id
FROM Projects p
WHERE p.project_id > 5
);


DROP TABLE Employees
DROP TABLE projects

--------------------------------------------------------------------------------

CREATE TABLE employees(
    employee_id INT PRIMARY KEY,
    emp_name VARCHAR(50)
)

CREATE TABLE projects(
    project_id INT PRIMARY KEY,
    project_name VARCHAR(50),
    status VARCHAR(50)
)

CREATE TABLE project_assignments(
    assignment_id INT PRIMARY KEY,
    employee_id INT,
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id),
    project_id INT,
    FOREIGN KEY (project_id) REFERENCES projects(project_id)
)

INSERT INTO employees(employee_id, emp_name) VALUES
(7, 'Tyler'),
(0, 'Alex'),
(1, 'Gauss');

INSERT INTO projects(project_id, project_name, status) VALUES 
(0, 'Diffusion Models', 'active'),
(1, 'Safer Asymmetric Crypography', 'inactive'),
(2, 'Faster GPUs', 'active');


INSERT INTO project_assignments(assignment_id, employee_id, project_id) VALUES
(0, 7, 0),
(1, 7, 1),
(2, 7, 2),
(3, 0, 0),
(4, 0, 2),
(5, 1, 1),
(6, 1, 0);

-- Write a subquery to find employees who are assigned to every active project.
SELECT E.emp_name
FROM Employees E
WHERE E.employee_id = ALL
(
	SELECT A.employee_id
	FROM project_assignments A
	WHERE A.project_id = ALL
		(
		SELECT P1.project_id
		FROM projects P1
		WHERE P1.status = 'active' AND P1.project_id = A.project_id
		)
)

SELECT e.employee_id, e.emp_name
FROM employees e
WHERE NOT EXISTS (
  SELECT p.project_id
  FROM projects p
  WHERE p.status = 'active'
  AND NOT EXISTS (
    SELECT pa.assignment_id
    FROM project_assignments pa
    WHERE pa.project_id = p.project_id
    AND pa.employee_id = e.employee_id
)
);

DROP TABLE employees
DROP TABLE projects
DROP TABLE project_assignments

--------------------------------------------------------------
-- HW 4
CREATE TABLE Housing (
houseid INT IDENTITY(1,1) PRIMARY KEY,
price BIGINT,
area INT,
bedrooms INT,
bathrooms INT,
stories INT,
mainroad VARCHAR(3),
guestroom VARCHAR(3),
basement VARCHAR(3),
hotwaterheating VARCHAR(3),
airconditioning VARCHAR(3),
parking INT,
prefarea VARCHAR(3),
furnishingstatus VARCHAR(15)
);


INSERT INTO Housing (price, area, bedrooms, bathrooms, stories, mainroad,
guestroom, basement, hotwaterheating, airconditioning, parking, prefarea,
furnishingstatus) VALUES
(13300000, 7420, 4, 2, 3, 'yes', 'no', 'no', 'no', 'yes', 2, 'yes', 'furnished'),
(12250000, 8960, 4, 4, 4, 'yes', 'no', 'no', 'no', 'yes', 3, 'no', 'furnished'),
(12250000, 9960, 3, 2, 2, 'yes', 'no', 'yes', 'no', 'no', 2, 'yes', 'semi-furnished'),
(12215000, 7500, 4, 2, 2, 'yes', 'no', 'yes', 'no', 'yes', 3, 'yes', 'furnished'),
(11410000, 7420, 4, 1, 2, 'yes', 'yes', 'yes', 'no', 'yes', 2, 'no', 'furnished'),
(10850000, 7500, 3, 3, 1, 'yes', 'no', 'yes', 'no', 'yes', 2, 'yes', 'semi-furnished'),
(10150000, 8580, 4, 3, 4, 'yes', 'no', 'no', 'no', 'yes', 2, 'yes', 'semi-furnished'),
(10150000, 16200, 5, 3, 2, 'yes', 'no', 'no', 'no', 'no', 0, 'no', 'unfurnished'),
(9870000, 8100, 4, 1, 2, 'yes', 'yes', 'yes', 'no', 'yes', 2, 'yes', 'furnished'),
(9800000, 5750, 3, 2, 4, 'yes', 'yes', 'no', 'no', 'yes', 1, 'yes', 'unfurnished'),
(9800000, 13200, 3, 1, 2, 'yes', 'no', 'yes', 'no', 'yes', 2, 'yes', 'furnished'),
(9681000, 6000, 4, 3, 2, 'yes', 'yes', 'yes', 'yes', 'no', 2, 'no', 'semi-furnished'),
(9310000, 6550, 4, 2, 2, 'yes', 'no', 'no', 'no', 'yes', 1, 'yes', 'semi-furnished'),
(9240000, 3500, 4, 2, 2, 'yes', 'no', 'no', 'yes', 'no', 2, 'no', 'furnished'),
(9240000, 7800, 3, 2, 2, 'yes', 'no', 'no', 'no', 'no', 0, 'yes', 'semi-furnished'),
(9100000, 6000, 4, 1, 2, 'yes', 'no', 'yes', 'no', 'no', 2, 'no', 'semi-furnished'),
(9100000, 6600, 4, 2, 2, 'yes', 'yes', 'yes', 'no', 'yes', 1, 'yes','unfurnished'),
(8960000, 8500, 3, 2, 4, 'yes', 'no', 'no', 'no', 'yes', 2, 'no', 'furnished'),
(8890000, 4600, 3, 2, 2, 'yes', 'yes', 'no', 'no', 'yes', 2, 'no', 'furnished'),
(8855000, 6420, 3, 2, 2, 'yes', 'no', 'no', 'no', 'yes', 1, 'yes', 'semi-furnished'),
(8750000, 4320, 3, 1, 2, 'yes', 'no', 'yes', 'yes', 'no', 2, 'no', 'semi-furnished'),
(8680000, 7155, 3, 2, 1, 'yes', 'yes', 'yes', 'no', 'yes', 2, 'no', 'unfurnished'),
(8645000, 8050, 3, 1, 1, 'yes', 'yes', 'yes', 'no', 'yes', 1, 'no', 'furnished'),
(8645000, 4560, 3, 2, 2, 'yes', 'yes', 'yes', 'no', 'yes', 1, 'no', 'furnished'),
(8575000, 8800, 3, 2, 2, 'yes', 'no', 'no', 'no', 'yes', 2, 'no', 'furnished'),
(8540000, 6540, 4, 2, 2, 'yes', 'yes', 'yes', 'no', 'yes', 2, 'yes', 'furnished'),
(8463000, 6000, 3, 2, 4, 'yes', 'yes', 'yes', 'no', 'yes', 0, 'yes', 'semi-furnished'),
(8400000, 8875, 3, 1, 1, 'yes', 'no', 'no', 'no', 'no', 1, 'no', 'semi-furnished'),
(8400000, 7950, 5, 2, 2, 'yes', 'no', 'yes', 'yes', 'no', 2, 'no', 'unfurnished'),
(8400000, 5500, 4, 2, 2, 'yes', 'no', 'yes', 'no', 'yes', 1, 'yes', 'semi-furnished');


-- Q1
SELECT AVG(H.price)
FROM Housing H
WHERE H.airconditioning = 'yes'

-- Q2
SELECT COUNT(*)
FROM Housing H
WHERE H.basement = 'yes'

-- Q3
SELECT COUNT(*)
FROM Housing H
WHERE H.bedrooms > 3

-- Q4
SELECT MIN(H.price), MAX(H.price)
FROM Housing H
WHERE H.guestroom = 'yes'

-- Q5
SELECT *
FROM Housing H
WHERE H.parking > 2 AND H.mainroad = 'yes'

-- Q6
SELECT TOP 1 H.bathrooms, COUNT(H.bathrooms) AS bathroom_count
FROM Housing H
GROUP BY H.bathrooms
ORDER BY bathroom_count DESC

-- Q7
SELECT COUNT(*)
FROM Housing H
WHERE H.furnishingstatus = 'furnished' AND H.stories > 3

-- Q8
SELECT AVG(H.area)
FROM Housing H
WHERE H.furnishingstatus = 'semi-furnished'

-- Q9
SELECT * 
FROM Housing H
WHERE H.hotwaterheating = 'yes' AND H.prefarea = 'yes'

-- Q10
SELECT *
FROM Housing H
WHERE H.price > 10000000 AND H.stories > 2

-------------------------------------------------------------------------
CREATE TABLE Sales (
sale_id INT,
product_id INT,
year INT,
quantity INT,
price INT
CONSTRAINT sale_PK PRIMARY KEY (sale_id, year),
CONSTRAINT product_FK FOREIGN KEY (product_id) 
REFERENCES Product(product_id)
)

CREATE TABLE Product(
product_id INT,
product_name VARCHAR(100)
CONSTRAINT product_PK PRIMARY KEY (product_id)
)

INSERT INTO Sales(sale_id, product_id, year, quantity, price) VALUES 
(1, 100, 2008, 10, 5000),
(2, 100, 2009, 12, 5000),
(7, 200, 2011, 15, 9000);

INSERT INTO Product(product_id, product_name) VALUES
(100, 'Nokia'),
(200, 'Apple'),
(300, 'Samsung');

-- Q.4 
SELECT S.sale_id, P.product_name, S.year, S.price
FROM Product P
INNER JOIN Sales S
ON S.product_id = P.product_id

-- Q.5
SELECT S.product_id, COUNT(S.quantity)
FROM Sales S
GROUP BY S.product_id

DROP TABLE Sales
DROP TABLE Product
--------------------------------------------------------------------------
CREATE TABLE Course 
(
CourseID INT,
courseName nvarchar(100),
department nvarchar(50),
Credits INT,
Instructor nvarchar(50),
semester nvarchar(20)
CONSTRAINT course_PK PRIMARY KEY (CourseID),
CHECK (Credits >= 1 AND Credits < 5)
)

-- Q2

ALTER TABLE Course
ADD CourseDescription NVARCHAR(30);

-- Q3
ALTER TABLE Course
ALTER COLUMN CourseDescription NVARCHAR(50);

-- Q4
ALTER TABLE Course
ADD Capacity INT DEFAULT 0,
CHECK (Capacity >= 0)

-- Q5
ALTER TABLE Course
ADD Enrolled INT DEFAULT 0,
CHECK (Enrolled >= 0)

DROP TABLE Course