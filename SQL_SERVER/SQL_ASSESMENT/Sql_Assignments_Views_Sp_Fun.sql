/*Assignment 1 – Student Department View
Create a view named:
vw_StudentDepartment
The view should show:
Column
StudentID
StudentName
DepartmentName
AdmissionDate
Tables used:
Students
Departments
Tasks
1.Create the view.
2.Retrieve all records from the view.
3.Filter students from Computer Science department using the view.
4.Drop the view.*/

-- 1. Create the view
CREATE VIEW vw_StudentDepartment AS
SELECT 
    s.StudentID,
    s.FirstName + ' ' + s.LastName AS StudentName,
    d.DepartmentName,
    s.AdmissionDate
FROM Students s
JOIN Departments d 
ON s.DepartmentID = d.DepartmentID;
-- 2. Retrieve all records from the view
SELECT * FROM vw_StudentDepartment;
-- 3. Filter students from Computer Science department
SELECT *
FROM vw_StudentDepartment
WHERE DepartmentName = 'Computer Science';
-- 4. Drop the view
DROP VIEW vw_StudentDepartment;

/*Assignment 2 – Student Course Enrollment View
Create a view named:
vw_StudentCourses
The view should show:
Column
StudentName
CourseName
EnrollmentDate
Tables required:
Students
Enrollments
Courses
Tasks
Write queries using this view to:
1.Show courses taken by StudentID = 5
2.Count courses taken by each student
3.List students enrolled after 2024*/
-- 1. Create the View
CREATE VIEW vw_StudentCourses AS
SELECT 
    s.StudentID,
    s.FirstName + ' ' + s.LastName AS StudentName,
    c.CourseName,
    e.EnrollmentDate
FROM Enrollments e
JOIN Students s ON e.StudentID = s.StudentID
JOIN Courses c ON e.CourseID = c.CourseID;
-- 2. Show courses taken by StudentID = 5
SELECT *
FROM vw_StudentCourses
WHERE StudentID = 5;
-- 3. Count courses taken by each student
SELECT StudentName, COUNT(CourseName) AS TotalCourses
FROM vw_StudentCourses
GROUP BY StudentName;
-- 4. List students enrolled after 2024
SELECT *
FROM vw_StudentCourses
WHERE EnrollmentDate > '2024-12-31';
-- (Optional) Drop the View
DROP VIEW vw_StudentCourses;
/*Assignment 3 – Exam Result View
Create a view:
vw_ExamResults
Columns:
StudentName
CourseName
ExamType
MarksObtained
Tables used:
Students
Marks
Exams
Courses
Tasks
1.Retrieve students scoring more than 80
2.Retrieve top scorers in each exam
3.Find students who failed*/
-- 1. Create the View
CREATE VIEW vw_ExamResults AS
SELECT 
    s.FirstName + ' ' + s.LastName AS StudentName,
    c.CourseName,
    e.ExamType,
    m.MarksObtained
FROM Marks m
JOIN Students s ON m.StudentID = s.StudentID
JOIN Exams e ON m.ExamID = e.ExamID
JOIN Courses c ON e.CourseID = c.CourseID;
-- 2. Retrieve students scoring more than 80
SELECT *
FROM vw_ExamResults
WHERE MarksObtained > 80;
-- 3. Retrieve top scorers in each exam
SELECT *
FROM vw_ExamResults v
WHERE MarksObtained = (
    SELECT MAX(m.MarksObtained)
    FROM Marks m
    JOIN Exams e ON m.ExamID = e.ExamID
    WHERE e.ExamType = v.ExamType
);
-- 4. Find students who failed
-- (Assuming pass mark = 35)
SELECT *
FROM vw_ExamResults
WHERE MarksObtained < 35;
/*Assignment 4 – Aggregate View
Create a view:
vw_DepartmentStudentCount
Columns:
DepartmentName
TotalStudents
Tables used:
Students
Departments
Tasks
1.Retrieve departments with more than 10 students
2.Sort departments by highest student count.*/
-- 1. Create the View
CREATE VIEW vw_DepartmentStudentCount AS
SELECT 
    d.DepartmentName,
    COUNT(s.StudentID) AS TotalStudents
FROM Departments d
LEFT JOIN Students s 
ON d.DepartmentID = s.DepartmentID
GROUP BY d.DepartmentName;
-- 2. Retrieve departments with more than 10 students
SELECT *
FROM vw_DepartmentStudentCount
WHERE TotalStudents > 10;
-- 3. Sort departments by highest student count
SELECT *
FROM vw_DepartmentStudentCount
ORDER BY TotalStudents DESC;
/*2. Stored Procedures Assignments
Objective
Learn how to encapsulate business logic inside stored procedures.

Assignment 1 – Insert Student Procedure
Create a stored procedure:
sp_InsertStudent
Parameters:
FirstName
LastName
Gender
DepartmentID
AdmissionDate
Tasks
1.Insert a new student.
2.Execute the procedure.
3.Verify inserted data.*/

-- 1. Create Stored Procedure
CREATE PROCEDURE sp_InsertStudent
    @FirstName VARCHAR(50),
    @LastName VARCHAR(50),
    @Gender VARCHAR(10),
    @DepartmentID INT,
    @AdmissionDate DATE
AS
BEGIN
    INSERT INTO Students (FirstName, LastName, Gender, DepartmentID, AdmissionDate)
    VALUES (@FirstName, @LastName, @Gender, @DepartmentID, @AdmissionDate);
END;
-- 2. Execute the Procedure
EXEC sp_InsertStudent 
    @FirstName = 'Ravi',
    @LastName = 'Kumar',
    @Gender = 'M',
    @DepartmentID = 1,
    @AdmissionDate = '2024-07-01';
-- 3. Verify Inserted Data
SELECT * FROM Students
WHERE FirstName = 'Ravi' AND LastName = 'Kumar';
/*Assignment 2 – Get Students By Department
Create procedure:
sp_GetStudentsByDepartment
Parameter:
@DepartmentID
Output:
StudentID
StudentName
AdmissionDate
Tasks
1.Execute procedure for DepartmentID = 2
2.Execute for DepartmentID = 3*/
-- 1. Create Stored Procedure
CREATE PROCEDURE sp_GetStudentsByDepartment
    @DepartmentID INT
AS
BEGIN
    SELECT 
        StudentID,
        FirstName + ' ' + LastName AS StudentName,
        AdmissionDate
    FROM Students
    WHERE DepartmentID = @DepartmentID;
END;
-- 2. Execute for DepartmentID = 2
EXEC sp_GetStudentsByDepartment @DepartmentID = 2;
-- 3. Execute for DepartmentID = 3
EXEC sp_GetStudentsByDepartment @DepartmentID = 3;
/*Assignment 2 – Get Students By Department
Create procedure:
sp_GetStudentsByDepartment
Parameter:
@DepartmentID
Output:
StudentID
StudentName
AdmissionDate
Tasks
1.Execute procedure for DepartmentID = 2
2.Execute for DepartmentID = 3*/

-- 1. Create Stored Procedure
CREATE PROCEDURE sp_GetStudentsByDepartment
    @DepartmentID INT
AS
BEGIN
    SELECT 
        StudentID,
        FirstName + ' ' + LastName AS StudentName,
        AdmissionDate
    FROM Students
    WHERE DepartmentID = @DepartmentID;
END;
-- 2. Execute for DepartmentID = 2
EXEC sp_GetStudentsByDepartment @DepartmentID = 2;
-- 3. Execute for DepartmentID = 3
EXEC sp_GetStudentsByDepartment @DepartmentID = 3;
/*Assignment 3 – Course Enrollment Procedure
Create procedure:
sp_EnrollStudent
Parameters:
@StudentID
@CourseID
The procedure should:
1.Insert data into Enrollments table
2.Automatically use current date*/

