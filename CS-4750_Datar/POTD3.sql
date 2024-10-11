CREATE DATABASE POTD3;
GO
USE POTD3
GO

-- Q.1 Create table
CREATE TABLE Course
(
CourseID int not null,
courseName nvarchar(100),
department nvarchar(50),
Credits int CONSTRAINT
Credits_CHK CHECK (Credits >= 1 AND Credits < 5),
Instructor nvarchar(50),
semester nvarchar(20)
CONSTRAINT Course_PK primary key (CourseID)
)

-- Q.2 alter table
ALTER TABLE Course ADD CourseDescription nvarchar(30);

-- Q.3 change size of courseDescription
ALTER TABLE Course ALTER COLUMN CourseDescription nvarchar(50)

-- Q.4 Add new column called capacity
ALTER TABLE Course ADD Capacity int CONSTRAINT
Capacity_CHK CHECK (Capacity > 0)

-- Q.5 Add enrolled column
ALTER TABLE Course ADD Enrolled int CHECK (Enrolled >= 0) DEFAULT 0;

DROP TABLE Course;

