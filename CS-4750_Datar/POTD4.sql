CREATE DATABASE P3
GO
USE P3
GO

-- Student Table
CREATE TABLE Student(
student_id INT UNIQUE NOT NULL,
CONSTRAINT Student_PK PRIMARY KEY (Student_id),
student_year INT CONSTRAINT 
student_year_CHK CHECK (student_year > 1819)
)

-- Department
CREATE TABLE Department(
department_id INT UNIQUE NOT NULL,
CONSTRAINT department_PK PRIMARY KEY (department_id),
department_name VARCHAR(100)
)

-- Professor
CREATE TABLE Professors(
professor_id INT UNIQUE NOT NULL,
CONSTRAINT professor_PK PRIMARY KEY (professor_id),
professor_name VARCHAR(100),
professor_contact VARCHAR(100) CONSTRAINT
professor_contact_CHK CHECK (professor_contact LIKE '%*@virginia.edu%'),
office_hours VARCHAR(100)
)

-- Course Table
CREATE TABLE Course(
course_id INT UNIQUE NOT NULL,
CONSTRAINT course_PK PRIMARY KEY (course_id),
department_id INT UNIQUE NOT NULL,
CONSTRAINT department_FK FOREIGN KEY (department_id)
REFERENCES [Department] (department_id),
course_name VARCHAR(100),
course_semester VARCHAR(5), 
professor_id INT UNIQUE NOT NULL,
CONSTRAINT professor_FK FOREIGN KEY (professor_id)
REFERENCES [Professors] (professor_id)
)

-- Enroll Table
CREATE TABLE Enroll(
student_id INT UNIQUE NOT NULL,
CONSTRAINT student_FK FOREIGN KEY (student_id)
REFERENCES [Student] (student_id),
course_id INT UNIQUE NOT NULL,
CONSTRAINT course_FK FOREIGN KEY (course_id)
REFERENCES [Course] (course_id),
semester VARCHAR(5)
)


CREATE TABLE Notes(
note_id INT UNIQUE NOT NULL,
CONSTRAINT note_PK PRIMARY KEY (note_id),
note_format VARCHAR(50),
course_semester VARCHAR(5),
professor_id INT UNIQUE NOT NULL,
CONSTRAINT professor_FK1 FOREIGN KEY (professor_id) 
REFERENCES [Professors] (professor_id)
)

CREATE TABLE Submits(
note_id INT UNIQUE NOT NULL,
CONSTRAINT note_FK FOREIGN KEY (note_id)
REFERENCES [Notes] (note_id),
student_id INT UNIQUE NOT NULL,
CONSTRAINT student_FK1 FOREIGN KEY (student_id)
REFERENCES [Student] (student_id),
permissions_list VARCHAR(3)
)


DROP TABLE Submits
DROP TABLE Notes
DROP TABLE Enroll
DROP TABLE Course
DROP TABLE Professors
DROP TABLE Department
DROP TABLE Student