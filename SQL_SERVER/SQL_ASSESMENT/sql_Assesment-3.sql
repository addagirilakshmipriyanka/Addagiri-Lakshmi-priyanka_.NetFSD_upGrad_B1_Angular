use sql_Assignments

CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100) NOT NULL,
    Location VARCHAR(100)
);

CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DateOfBirth DATE,
    Gender VARCHAR(10),
    DepartmentID INT,
    AdmissionDate DATE,

    FOREIGN KEY (DepartmentID)
    REFERENCES Departments(DepartmentID)
);

CREATE TABLE Teachers (
    TeacherID INT PRIMARY KEY,
    TeacherName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    DepartmentID INT,
    HireDate DATE,

    FOREIGN KEY (DepartmentID)
    REFERENCES Departments(DepartmentID)
);
CREATE TABLE Courses (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(100),
    Credits INT,
    DepartmentID INT,
    TeacherID INT,

    FOREIGN KEY (DepartmentID)
    REFERENCES Departments(DepartmentID),

    FOREIGN KEY (TeacherID)
    REFERENCES Teachers(TeacherID)
);

CREATE TABLE Enrollments (
    EnrollmentID INT PRIMARY KEY,
    StudentID INT,
    CourseID INT,
    EnrollmentDate DATE,

    FOREIGN KEY (StudentID)
    REFERENCES Students(StudentID),

    FOREIGN KEY (CourseID)
    REFERENCES Courses(CourseID)
);

CREATE TABLE Exams (
    ExamID INT PRIMARY KEY,
    CourseID INT,
    ExamDate DATE,
    ExamType VARCHAR(50),

    FOREIGN KEY (CourseID)
    REFERENCES Courses(CourseID)
);

CREATE TABLE Marks (
    MarkID INT PRIMARY KEY,
    StudentID INT,
    ExamID INT,
    MarksObtained INT,

    FOREIGN KEY (StudentID)
    REFERENCES Students(StudentID),

    FOREIGN KEY (ExamID)
    REFERENCES Exams(ExamID)
);

--Assignment 2 – Constraints
--Objective
--Apply SQL constraints.
--Students must add the following constraints.
--Tasks
--1. Department name must be unique
--2. Student gender should only allow:
-- 'M'
-- 'F'
--3. Course credits must be between 1 and 5
--4. MarksObtained must be between 0 and 100
--5. Teacher email must be unique
--6. EnrollmentDate should have default current date
--Students should use:
--RIMARY KEY
 --FOREIGN KEY
--NIQUE
--CHECK
--DEFAULT
CREATE TABLE Departments1(
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100) UNIQUE,
    Location VARCHAR(100)
);

CREATE TABLE Teachers1(
    TeacherID INT PRIMARY KEY,
    TeacherName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    DepartmentID INT,
    HireDate DATE,

    FOREIGN KEY (DepartmentID)
    REFERENCES Departments1(DepartmentID)
    );

    CREATE TABLE Courses1( 
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(100),
    Credits INT CHECK (Credits BETWEEN 1 AND 5),
    DepartmentID INT,
    TeacherID INT,

    FOREIGN KEY (DepartmentID)
    REFERENCES Departments1(DepartmentID) ,

    FOREIGN KEY (TeacherID)
    REFERENCES Teachers1(TeacherID)
);



CREATE TABLE Enrollments1(
    EnrollmentID INT PRIMARY KEY,
    StudentID INT,
    CourseID INT,
    EnrollmentDate DATE DEFAULT GETDATE(),

    FOREIGN KEY (StudentID)
    REFERENCES Students1(StudentID),

    FOREIGN KEY (CourseID)
    REFERENCES Courses(CourseID)
);

CREATE TABLE Exams1(
    ExamID INT PRIMARY KEY,
    CourseID INT,
    ExamDate DATE,
    ExamType VARCHAR(50),

    FOREIGN KEY (CourseID)
    REFERENCES Courses1(CourseID)
);

CREATE TABLE Marks1(
    MarkID INT PRIMARY KEY,
    StudentID INT,
    ExamID INT,
    MarksObtained INT,

    FOREIGN KEY (StudentID)
    REFERENCES Students(StudentID),

    FOREIGN KEY (ExamID)
    REFERENCES Exams1(ExamID)
);
use sql_Assignments
-- Assignment 3 – ALTER TABLE
--Objective 
--Modify table structures.
--Students must perform the following operations.
--Tasks
--1. Add a column PhoneNumber to Students table.
--2. Add column Salary to Teachers table.
--3. Modify Salary datatype.
--4. Add CHECK constraint to Salary (salary > 20000).
--5. Drop PhoneNumber column.
--6. Rename a column.

-- 1. Add PhoneNumber column to Students table
ALTER TABLE Students
ADD PhoneNumber VARCHAR(15);

-- 2. Add Salary column to Teachers table
ALTER TABLE Teachers
ADD Salary INT;

-- 3. Modify Salary datatype
ALTER TABLE Teachers
ALTER COLUMN Salary DECIMAL(10,2);

-- 4. Add CHECK constraint to Salary (Salary > 20000)
ALTER TABLE Teachers
ADD CONSTRAINT CHK_TeacherSalary
CHECK (Salary > 20000);

-- 5. Drop PhoneNumber column from Students table
ALTER TABLE Students
DROP COLUMN PhoneNumber;

-- 6. Rename a column (TeacherName → FullName)
EXEC sp_rename 'Teachers.TeacherName', 'FullName', 'COLUMN';

/* Assignment 4 – Insert Sample Data
Students must insert minimum:
• 5 Departments
• 10 Teachers
• 20 Students
• 10 Courses
• 30 Enrollments
• 5 Exams
• 30 Marks */
INSERT INTO Departments (DepartmentName, Location) VALUES
('Computer Science','Block A'),
('Mathematics','Block B'),
('Physics','Block C'),
('Chemistry','Block D'),
('English','Block E');


select * from Departments;
INSERT INTO Teachers (FullName, Email, DepartmentID, HireDate, Salary) VALUES
('Ravi Kumar','ravi1@gmail.com',1,'2020-01-10',30000),
('Sita Rao','sita1@gmail.com',2,'2019-03-12',32000),
('John Paul','john1@gmail.com',3,'2021-05-15',28000),
('Anil Sharma','anil@gmail.com',1,'2018-07-20',35000),
('Meena Devi','meena@gmail.com',2,'2022-01-25',27000),
('David Raj','david@gmail.com',3,'2020-09-10',31000),
('Kiran Kumar','kiran@gmail.com',4,'2017-04-11',36000),
('Lakshmi','lakshmi@gmail.com',5,'2021-08-18',29000),
('Ramesh','ramesh@gmail.com',4,'2019-06-30',33000),
('Geetha','geetha@gmail.com',5,'2022-02-14',30000);

INSERT INTO Students (FirstName, LastName, DateOfBirth, Gender, DepartmentID, AdmissionDate) VALUES
('Asha','Reddy','2004-01-10','F',1,'2022-07-01'),
('Rahul','Kumar','2003-02-15','M',2,'2021-07-01'),
('Sneha','Patel','2004-03-12','F',1,'2022-07-01'),
('Vikram','Singh','2003-04-18','M',3,'2021-07-01'),
('Divya','Sharma','2004-05-20','F',2,'2022-07-01'),
('Arjun','Rao','2003-06-11','M',1,'2021-07-01'),
('Pooja','Nair','2004-07-09','F',3,'2022-07-01'),
('Karthik','Das','2003-08-22','M',4,'2021-07-01'),
('Neha','Verma','2004-09-30','F',5,'2022-07-01'),
('Rohit','Yadav','2003-10-05','M',1,'2021-07-01'),
('Anu','Joseph','2004-11-14','F',2,'2022-07-01'),
('Manoj','Khan','2003-12-25','M',3,'2021-07-01'),
('Keerthi','Reddy','2004-02-02','F',4,'2022-07-01'),
('Suresh','Naidu','2003-03-03','M',5,'2021-07-01'),
('Latha','Iyer','2004-04-04','F',1,'2022-07-01'),
('Ajay','Gupta','2003-05-05','M',2,'2021-07-01'),
('Swathi','Das','2004-06-06','F',3,'2022-07-01'),
('Tarun','Mehta','2003-07-07','M',4,'2021-07-01'),
('Nisha','Kaur','2004-08-08','F',5,'2022-07-01'),
('Deepak','Shah','2003-09-09','M',1,'2021-07-01');

INSERT INTO Courses (CourseName, Credits, DepartmentID, TeacherID) VALUES
('C# Programming',4,1,1),
('Data Structures',5,1,4),
('Algebra',3,2,2),
('Calculus',4,2,5),
('Physics Basics',4,3,3),
('Quantum Physics',5,3,6),
('Organic Chemistry',4,4,7),
('Inorganic Chemistry',3,4,9),
('English Literature',3,5,8),
('Communication Skills',2,5,10);

INSERT INTO Enrollments (StudentID, CourseID, EnrollmentDate) VALUES
(1,1,GETDATE()),(2,2,GETDATE()),(3,3,GETDATE()),(4,4,GETDATE()),(5,5,GETDATE()),
(6,6,GETDATE()),(7,7,GETDATE()),(8,8,GETDATE()),(9,9,GETDATE()),(10,10,GETDATE()),
(11,1,GETDATE()),(12,2,GETDATE()),(13,3,GETDATE()),(14,4,GETDATE()),(15,5,GETDATE()),
(16,6,GETDATE()),(17,7,GETDATE()),(18,8,GETDATE()),(19,9,GETDATE()),(20,10,GETDATE()),
(1,2,GETDATE()),(2,3,GETDATE()),(3,4,GETDATE()),(4,5,GETDATE()),(5,6,GETDATE()),
(6,7,GETDATE()),(7,8,GETDATE()),(8,9,GETDATE()),(9,10,GETDATE()),(10,1,GETDATE());

INSERT INTO Exams (CourseID, ExamDate, ExamType) VALUES
(1,'2023-03-01','Midterm'),
(2,'2023-03-02','Midterm'),
(3,'2023-03-03','Midterm'),
(4,'2023-03-04','Midterm'),
(5,'2023-03-05','Midterm');

INSERT INTO Marks (StudentID, ExamID, MarksObtained) VALUES
(1,1,85),(2,2,78),(3,3,90),(4,4,67),(5,5,88),
(6,1,75),(7,2,82),(8,3,91),(9,4,69),(10,5,87),
(11,1,80),(12,2,76),(13,3,89),(14,4,70),(15,5,92),
(16,1,84),(17,2,79),(18,3,88),(19,4,72),(20,5,86),
(1,1,81),(2,2,77),(3,3,93),(4,4,68),(5,5,85),
(6,1,74),(7,2,83),(8,3,90),(9,4,71),(10,5,89);

/* Assignment 5 – Filtering Data (WHERE)
Objective
Practice filtering records.
Students must write queries to:
1. Find students from Computer Science department
2. Find teachers hired after 2022
3. Find students whose name starts with 'A'
4. Find courses having credits greater than 3
5. Find students born between 2005 and 2008
6. Find students not belonging to Mechanical department
7. Find teachers whose salary between 40000 and 70000
8. Find courses not taught by TeacherID = 3
*/

-- 1. Find students from Computer Science department
SELECT s.*
FROM Students s
JOIN Departments d ON s.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'Computer Science';

-- 2. Find teachers hired after 2022

SELECT *
FROM Teachers
WHERE HireDate > '2022-12-31';

-- 3. Find students whose name starts with 'A'

SELECT *
FROM Students
WHERE FirstName LIKE 'A%';


-- 4. Find courses having credits greater than 3

SELECT *
FROM Courses
WHERE Credits > 3;

-- 5. Find students born between 2005 and 2008

SELECT *
FROM Students
WHERE DateOfBirth BETWEEN '2005-01-01' AND '2008-12-31';

-- 6. Find students not belonging to Mechanical department
SELECT s.*
FROM Students s
JOIN Departments d ON s.DepartmentID = d.DepartmentID
WHERE d.DepartmentName <> 'Mechanical';

-- 7. Find teachers whose salary between 40000 and 70000
SELECT *
FROM Teachers
WHERE Salary BETWEEN 40000 AND 70000;

-- 8. Find courses not taught by TeacherID = 3
SELECT *
FROM Courses
WHERE TeacherID <> 3;
/* Assignment 6 – Grouping Data (GROUP BY)
Objective
Use aggregate functions.
Students must write queries to:
1. Count students in each department
2. Find average marks per exam
3. Find total students enrolled per course
4. Find maximum marks scored in each exam
5. Find minimum marks per course
6. Find departments having more than 5 students
Use:
COUNT()
SUM()
AVG()
MAX()
MIN()
GROUP BY
HAVING
*/
-- 1. Count students in each department

SELECT d.DepartmentName, COUNT(s.StudentID) AS TotalStudents
FROM Students s
JOIN Departments d ON s.DepartmentID = d.DepartmentID
GROUP BY d.DepartmentName;

-- 2. Find average marks per exam

SELECT m.ExamID, AVG(m.MarksObtained) AS AverageMarks
FROM Marks m
GROUP BY m.ExamID;


-- 3. Find total students enrolled per course

SELECT c.CourseName, COUNT(e.StudentID) AS TotalStudents
FROM Enrollments e
JOIN Courses c ON e.CourseID = c.CourseID
GROUP BY c.CourseName;


-- 4. Find maximum marks scored in each exam

SELECT ExamID, MAX(MarksObtained) AS MaxMarks
FROM Marks
GROUP BY ExamID;


-- 5. Find minimum marks per course

SELECT c.CourseName, MIN(m.MarksObtained) AS MinMarks
FROM Marks m
JOIN Exams e ON m.ExamID = e.ExamID
JOIN Courses c ON e.CourseID = c.CourseID
GROUP BY c.CourseName;


-- 6. Find departments having more than 5 students
SELECT d.DepartmentName, COUNT(s.StudentID) AS TotalStudents
FROM Students s
JOIN Departments d ON s.DepartmentID = d.DepartmentID
GROUP BY d.DepartmentName
HAVING COUNT(s.StudentID) > 5;
/* Assignment 7 – Joins
Objective
Combine data from multiple tables.
Students must write queries to:
1. Show students with department names
Tables used:
Students + Departments
2. Show courses with teacher names
Tables used:
Courses + Teachers
3. Show student name and enrolled courses
Tables used:
Students + Enrollments + Courses
4. Show students with exam marks
Tables used:
Students + Marks + Exams
5. Show all courses and teachers (even if no teacher assigned)
Use:
LEFT JOIN
6. Show teachers who are not assigned to any course*/

-- 1. Show students with department names

SELECT s.FirstName, s.LastName, d.DepartmentName
FROM Students s
JOIN Departments d ON s.DepartmentID = d.DepartmentID;


-- 2. Show courses with teacher names
-- (Note: you renamed TeacherName → FullName)

SELECT c.CourseName, t.FullName
FROM Courses c
JOIN Teachers t ON c.TeacherID = t.TeacherID;

-- 3. Show student name and enrolled courses

SELECT s.FirstName, c.CourseName
FROM Enrollments e
JOIN Students s ON e.StudentID = s.StudentID
JOIN Courses c ON e.CourseID = c.CourseID;

-- 4. Show students with exam marks

SELECT s.FirstName, e.ExamType, m.MarksObtained
FROM Marks m
JOIN Students s ON m.StudentID = s.StudentID
JOIN Exams e ON m.ExamID = e.ExamID;


-- 5. Show all courses and teachers (even if no teacher assigned)
-- (LEFT JOIN)

SELECT c.CourseName, t.FullName
FROM Courses c
LEFT JOIN Teachers t ON c.TeacherID = t.TeacherID;


-- 6. Show teachers not assigned to any course

SELECT t.FullName
FROM Teachers t
LEFT JOIN Courses c ON t.TeacherID = c.TeacherID
WHERE c.TeacherID IS NULL;
/*Assignment 8 – Subqueries
Objective
Practice nested queries.
Students must write queries to:
1. Find students whose marks are greater than average marks
2. Find courses with maximum credits
3. Find students enrolled in more than 2 courses
4. Find teachers working in the same department as teacher 'John'
5. Find students who scored highest marks in an exam
6. Find departments having maximum number of students
Students should use:
IN
EXISTS
= ANY
= ALL
Scalar Subquery
Correlated Subquery
*/
-- 1. Students whose marks are greater than average marks
-- (Scalar Subquery)

SELECT *
FROM Marks
WHERE MarksObtained > (
    SELECT AVG(MarksObtained) FROM Marks
);


-- 2. Courses with maximum credits
-- (= ALL)

SELECT *
FROM Courses
WHERE Credits >= ALL (
    SELECT Credits FROM Courses
);

-- 3. Students enrolled in more than 2 courses
-- (Correlated Subquery)

SELECT *
FROM Students s
WHERE (
    SELECT COUNT(*)
    FROM Enrollments e
    WHERE e.StudentID = s.StudentID
) > 2;


-- 4. Teachers in same department as 'John'
-- (IN)

SELECT *
FROM Teachers
WHERE DepartmentID IN (
    SELECT DepartmentID
    FROM Teachers
    WHERE FullName LIKE 'John%'
);


-- 5. Students who scored highest marks in an exam
-- (= ANY)

SELECT *
FROM Marks
WHERE MarksObtained = ANY (
    SELECT MAX(MarksObtained)
    FROM Marks
    GROUP BY ExamID
);


-- 6. Departments having maximum number of students
-- (Correlated + ALL)

SELECT d.*
FROM Departments d
WHERE (
    SELECT COUNT(*)
    FROM Students s
    WHERE s.DepartmentID = d.DepartmentID
) >= ALL (
    SELECT COUNT(*)
    FROM Students
    GROUP BY DepartmentID
);

-- EXTRA (EXISTS example - for exam usage)

SELECT *
FROM Students s
WHERE EXISTS (
    SELECT 1
    FROM Enrollments e
    WHERE e.StudentID = s.StudentID
);

/*Assignment 9 – Views
Objective
Create reusable virtual tables.
Students must create the following views.
View 1
Student basic information with department name
StudentID
StudentName
DepartmentName
View 2
Student course enrollment view
StudentName
CourseName
EnrollmentDate
View 3
Exam result view
StudentName
CourseName
ExamType
MarksObtained
Tasks
1. Create views
2. Query views
3. Update data through view (where possible)
4. Drop views
*/

-- VIEW 1: Student basic info with Department

CREATE VIEW vw_StudentDepartment AS
SELECT 
    s.StudentID,
    s.FirstName + ' ' + s.LastName AS StudentName,
    d.DepartmentName
FROM Students s
JOIN Departments d ON s.DepartmentID = d.DepartmentID;


-- VIEW 2: Student Course Enrollment

CREATE VIEW vw_StudentCourses AS
SELECT 
    s.FirstName + ' ' + s.LastName AS StudentName,
    c.CourseName,
    e.EnrollmentDate
FROM Enrollments e
JOIN Students s ON e.StudentID = s.StudentID
JOIN Courses c ON e.CourseID = c.CourseID;


-- VIEW 3: Exam Result View

CREATE VIEW vw_ExamResults AS
SELECT 
    s.FirstName + ' ' + s.LastName AS StudentName,
    c.CourseName,
    ex.ExamType,
    m.MarksObtained
FROM Marks m
JOIN Students s ON m.StudentID = s.StudentID
JOIN Exams ex ON m.ExamID = ex.ExamID
JOIN Courses c ON ex.CourseID = c.CourseID;


-- QUERY VIEWS

SELECT * FROM vw_StudentDepartment;
SELECT * FROM vw_StudentCourses;
SELECT * FROM vw_ExamResults;


-- UPDATE THROUGH VIEW (only simple view works)

UPDATE Students
SET FirstName = 'Asha',
    LastName = 'Reddy'
WHERE StudentID = 1;
-- (Note: May fail if view is complex)


-- DROP VIEWS

DROP VIEW vw_StudentDepartment;
DROP VIEW vw_StudentCourses;
DROP VIEW vw_ExamResults;


/*
Assignment 10 – Indexes
Objective
Improve query performance.
Students must create indexes.
Tasks
1. Create index on Student LastName
2. Create index on Teacher Email
3. Create composite index on
StudentID + CourseID
in Enrollments table.
4. Create unique index on DepartmentName
5. Drop an index*/

-- 1. Index on Student LastName

CREATE INDEX idx_Student_LastName
ON Students (LastName);

-- 2. Index on Teacher Email

CREATE INDEX idx_Teacher_Email
ON Teachers (Email);

-- 3. Composite Index (StudentID + CourseID)

CREATE INDEX idx_Enrollment_Student_Course
ON Enrollments (StudentID, CourseID);

-- 4. Unique Index on DepartmentName

CREATE UNIQUE INDEX idx_Department_Name
ON Departments (DepartmentName);
-- 5. Drop Index

DROP INDEX idx_Student_LastName ON Students;
