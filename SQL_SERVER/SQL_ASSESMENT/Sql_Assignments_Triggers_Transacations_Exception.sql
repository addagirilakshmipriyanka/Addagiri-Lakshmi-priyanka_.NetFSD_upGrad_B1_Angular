/*1. Triggers Assignments
Objective
Learn how to automatically execute logic when INSERT, UPDATE, DELETE operations occur.
Assignment 1 – Audit Trigger for Students
Scenario
Whenever a new student is inserted, record the action in an audit table.
Step 1 – Create Audit Table
Students must create a table:
StudentAudit
Columns
Column
AuditID
StudentID
ActionType
ActionDate
Step 2 – Create Trigger
Create trigger:
trg_StudentInsertAudit
Trigger behavior
When a new student is inserted:
• Capture StudentID
• Record action as "INSERT"
• Record current date
Tasks
1. Insert a student.
2. Check audit table.
3. Insert multiple students and verify trigger execution*/
-- STEP 1: Create Audit Table
CREATE TABLE StudentAudit (
    AuditID INT IDENTITY(1,1) PRIMARY KEY,
    StudentID INT,
    ActionType VARCHAR(20),
    ActionDate DATETIME
);
-- STEP 2: Create Trigger
CREATE TRIGGER trg_StudentInsertAudit
ON Students
AFTER INSERT
AS
BEGIN
    INSERT INTO StudentAudit (StudentID, ActionType, ActionDate)
    SELECT 
        i.StudentID,
        'INSERT',
        GETDATE()
    FROM inserted i;
END;
-- TASK 1: Insert a student
INSERT INTO Students (FirstName, LastName, Gender, DepartmentID, AdmissionDate)
VALUES ( 'Test', 'User', 'M', 1, '2024-07-01');
-- TASK 2: Check audit table
SELECT * FROM StudentAudit;
-- TASK 3: Insert multiple students
INSERT INTO Students ( FirstName, LastName, Gender, DepartmentID, AdmissionDate)
VALUES 
( 'Asha', 'Reddy', 'F', 1, '2024-07-01'),
('Rahul', 'Kumar', 'M', 2, '2024-07-01');
-- Verify again
SELECT * FROM StudentAudit;
/*Assignment 2 – Prevent Deleting Students
Scenario
Students should not be deleted if they have enrollments.
Create trigger:
trg_PreventStudentDelete
Logic
If student exists in:
Enrollments
Then:
RAISERROR('Student has course enrollments and cannot be deleted')
Rollback the transaction.
Tasks
1. Try deleting a student with enrollments.
2. Try deleting a student without enrollments.*/
-- 1. Create Trigger
CREATE TRIGGER trg_PreventStudentDelete
ON Students
INSTEAD OF DELETE
AS
BEGIN
    -- Check if student has enrollments
    IF EXISTS (
        SELECT 1
        FROM Enrollments e
        JOIN deleted d ON e.StudentID = d.StudentID
    )
    BEGIN
        RAISERROR('Student has course enrollments and cannot be deleted', 16, 1);
        ROLLBACK TRANSACTION;
    END
    ELSE
    BEGIN
        -- Allow delete if no enrollments
        DELETE FROM Students
        WHERE StudentID IN (SELECT StudentID FROM deleted);
    END
END;
-- 2. Try deleting student WITH enrollments
select * from Students;
DELETE FROM Students
WHERE StudentID = 1;
-- 3. Try deleting student WITHOUT enrollments
DELETE FROM Students
WHERE StudentID = 28;
/*Assignment 3 – Update Marks Trigger
Scenario
Whenever marks are updated, record old and new marks.
Create table
MarksAudit
Columns
AuditID
StudentID
ExamID
OldMarks
NewMarks
UpdatedDate
Create trigger
trg_UpdateMarksAudit
Tasks
1. Update marks.
2. Verify audit table.*/
-- STEP 1: Create Audit Table
CREATE TABLE MarksAudit (
    AuditID INT IDENTITY(1,1) PRIMARY KEY,
    StudentID INT,
    ExamID INT,
    OldMarks INT,
    NewMarks INT,
    UpdatedDate DATETIME
);
-- STEP 2: Create Trigger
CREATE TRIGGER trg_UpdateMarksAudit
ON Marks
AFTER UPDATE
AS
BEGIN
    INSERT INTO MarksAudit (StudentID, ExamID, OldMarks, NewMarks, UpdatedDate)
    SELECT 
        d.StudentID,
        d.ExamID,
        d.MarksObtained AS OldMarks,
        i.MarksObtained AS NewMarks,
        GETDATE()
    FROM deleted d
    JOIN inserted i 
    ON d.MarkID = i.MarkID;
END;
-- TASK 1: Update marks
UPDATE Marks
SET MarksObtained = 95
WHERE MarkID = 1;
-- TASK 2: Verify audit table
SELECT * FROM MarksAudit;
/*2. Exception Handling Assignments
Objective
Learn how to use:
TRY
CATCH
RAISERROR
Assignment 1 – Insert Student Procedure with Exception Handling
Create stored procedure:
sp_AddStudent
Parameters
FirstName
LastName
DepartmentID
Gender
AdmissionDate
Logic
BEGIN TRY
Insert student
END TRY
BEGIN CATCH
Display error message
END CATCH
Tasks
1. Insert valid student.
2. Try inserting student with invalid DepartmentID.
Observe error handling.*/
-- 1. Create Stored Procedure with Exception Handling
CREATE PROCEDURE sp_AddStudent
    @FirstName VARCHAR(50),
    @LastName VARCHAR(50),
    @DepartmentID INT,
    @Gender VARCHAR(10),
    @AdmissionDate DATE
AS
BEGIN
    BEGIN TRY
        INSERT INTO Students (FirstName, LastName, DepartmentID, Gender, AdmissionDate)
        VALUES (@FirstName, @LastName, @DepartmentID, @Gender, @AdmissionDate);

        PRINT 'Student inserted successfully';
    END TRY

    BEGIN CATCH
        PRINT 'Error occurred: ' + ERROR_MESSAGE();
    END CATCH
END;
-- 2. Insert valid student
EXEC sp_AddStudent 
    @FirstName = 'Anu',
    @LastName = 'Priya',
    @DepartmentID = 1,
    @Gender = 'F',
    @AdmissionDate = '2024-07-01';
-- 3. Insert invalid student (wrong DepartmentID)
EXEC sp_AddStudent 
    @FirstName = 'Test',
    @LastName = 'User',
    @DepartmentID = 999,  -- ❌ invalid
    @Gender = 'M',
    @AdmissionDate = '2024-07-01';
-- 4. Verify data
SELECT * FROM Students;
/*Assignment 2 – Marks Validation Procedure
Create stored procedure:
sp_InsertMarks
Parameters
StudentID
ExamID
MarksObtained
Rules
Marks must be between 0 and 100
If not:
RAISERROR('Invalid Marks')
Tasks
1. Insert valid marks.
2. Insert marks greater than 100. */
-- 1. Create Stored Procedure with Validation
CREATE PROCEDURE sp_InsertMarks
    @StudentID INT,
    @ExamID INT,
    @MarksObtained INT
AS
BEGIN
    BEGIN TRY
        IF (@MarksObtained < 0 OR @MarksObtained > 100)
        BEGIN
            RAISERROR('Invalid Marks', 16, 1);
            RETURN;
        END

        -- Insert Marks
        INSERT INTO Marks (StudentID, ExamID, MarksObtained)
        VALUES (@StudentID, @ExamID, @MarksObtained);

        PRINT 'Marks inserted successfully';

    END TRY

    BEGIN CATCH
        PRINT 'Error: ' + ERROR_MESSAGE();
    END CATCH
END;
-- 2. Insert valid marks
EXEC sp_InsertMarks 
    @StudentID = 1,
    @ExamID = 1,
    @MarksObtained = 85;
-- 3. Insert invalid marks (>100)
EXEC sp_InsertMarks 
    @StudentID = 1,
    @ExamID = 1,
    @MarksObtained = 150;
-- 4. Verify data
SELECT * FROM Marks;
/*Assignment 3 – Safe Delete Procedure
Create stored procedure
sp_DeleteStudent
Logic
BEGIN TRY
Delete student
END TRY
BEGIN CATCH
Return error message
END CATCH
Test with:
• student having enrollments
• student without enrollments*/
-- 1. Create Stored Procedure
CREATE PROCEDURE sp_DeleteStudent
    @StudentID INT
AS
BEGIN
    BEGIN TRY
        DELETE FROM Students
        WHERE StudentID = @StudentID;

        PRINT 'Student deleted successfully';
    END TRY

    BEGIN CATCH
        PRINT 'Error: ' + ERROR_MESSAGE();
    END CATCH
END;
-- 2. Test: Student WITH enrollments
EXEC sp_DeleteStudent @StudentID = 1;
-- 3. Test: Student WITHOUT enrollments
EXEC sp_DeleteStudent @StudentID = 200;
-- 4. Verify
SELECT * FROM Students;

/*3. Cursors Assignments (Basic)
Objective
Understand row-by-row processing.
Assignment 1 – Display Student Names
Create stored procedure:
sp_DisplayStudentsCursor
Cursor should loop through
Students table
Display:
StudentID
StudentName
Tasks
1. Execute procedure.
2. Observe cursor output*/
-- Create Procedure
CREATE PROCEDURE sp_DisplayStudentsCursor
AS
BEGIN
    DECLARE @StudentID INT;
    DECLARE @StudentName VARCHAR(100);
    DECLARE student_cursor CURSOR FOR
    SELECT StudentID, FirstName + ' ' + LastName
    FROM Students;
    OPEN student_cursor;
    FETCH NEXT FROM student_cursor INTO @StudentID, @StudentName;
    WHILE @@FETCH_STATUS = 0
    BEGIN
        PRINT 'ID: ' + CAST(@StudentID AS VARCHAR(10)) + ' Name: ' + @StudentName;
        FETCH NEXT FROM student_cursor INTO @StudentID, @StudentName;
    END
    CLOSE student_cursor;
    DEALLOCATE student_cursor;
END;
    CLOSE student_cursor;
    DEALLOCATE student_cursor;
END;
-- Execute
EXEC sp_DisplayStudentsCursor;
/*
Assignment 2 – Calculate Total Marks Per Student
Create procedure
sp_CalculateStudentTotalMarks
Cursor should iterate through:
Students
For each student:
Calculate SUM(MarksObtained)
Display
StudentName
TotalMarks */
-- Create Procedure
CREATE PROCEDURE sp_CalculateStudentTotalMarks
AS
BEGIN
    DECLARE @StudentID INT;
    DECLARE @StudentName VARCHAR(100);
    DECLARE @TotalMarks INT;
    DECLARE student_cursor CURSOR FOR
    SELECT StudentID, FirstName + ' ' + LastName
    FROM Students;
    OPEN student_cursor;
    FETCH NEXT FROM student_cursor INTO @StudentID, @StudentName;
    WHILE @@FETCH_STATUS = 0
    BEGIN
        SELECT @TotalMarks = ISNULL(SUM(MarksObtained), 0)
        FROM Marks
        WHERE StudentID = @StudentID;
        PRINT 'Name: ' + @StudentName + ' Total Marks: ' + CAST(@TotalMarks AS VARCHAR);
        FETCH NEXT FROM student_cursor INTO @StudentID, @StudentName;
    END;
    CLOSE student_cursor;
    DEALLOCATE student_cursor;
END;
-- Execute
EXEC sp_CalculateStudentTotalMarks;
/*
Assignment 3 – Update Course Credits
Scenario:
Increase credits by 1 for all courses having credits less than 3.
Use cursor.
Create procedure
sp_UpdateCourseCredits */
-- Create Procedure
CREATE PROCEDURE sp_UpdateCourseCredits
AS
BEGIN
    DECLARE @CourseID INT;
    DECLARE @Credits INT;
    DECLARE course_cursor CURSOR FOR
    SELECT CourseID, Credits
    FROM Courses
    WHERE Credits < 3;
    OPEN course_cursor;
    FETCH NEXT FROM course_cursor INTO @CourseID, @Credits;
    WHILE @@FETCH_STATUS = 0
    BEGIN
        UPDATE Courses
        SET Credits = @Credits + 1
        WHERE CourseID = @CourseID;

        FETCH NEXT FROM course_cursor INTO @CourseID, @Credits;
    END;

    CLOSE course_cursor;
    DEALLOCATE course_cursor;
END;
-- Execute
EXEC sp_UpdateCourseCredits;
-- Verify
SELECT * FROM Courses;
/*
4. Transactions Assignments
Objective
Understand data consistency using transactions.
Assignment 1 – Student Enrollment Transaction
Create stored procedure
sp_EnrollStudentTransaction
Parameters
StudentID
CourseID
Logic
BEGIN TRANSACTION
Insert into Enrollments
COMMIT
If error occurs
ROLLBACK
Tasks
1. Enroll student in course.
2. Test failure scenario.*/
-- Create Procedure
CREATE PROCEDURE sp_EnrollStudentTransaction
    @StudentID INT,
    @CourseID INT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;
        INSERT INTO Enrollments (StudentID, CourseID, EnrollmentDate)
        VALUES (@StudentID, @CourseID, GETDATE());
        COMMIT TRANSACTION;
        PRINT 'Enrollment successful';
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        PRINT 'Error: ' + ERROR_MESSAGE();
    END CATCH
END;
-- Execute
EXEC sp_EnrollStudentTransaction 1, 1;
/*
Assignment 2 – Exam Marks Transaction
Create procedure
sp_RecordExamMarks
Operations
Insert marks
Update exam record
Both operations must succeed.
If one fails:
ROLLBACK*/
-- Create Procedure
CREATE PROCEDURE sp_RecordExamMarks
    @StudentID INT,
    @ExamID INT,
    @MarksObtained INT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;
        INSERT INTO Marks (StudentID, ExamID, MarksObtained)
        VALUES (@StudentID, @ExamID, @MarksObtained);
        UPDATE Exams
        SET ExamType = ExamType  -- dummy update
        WHERE ExamID = @ExamID;
        COMMIT TRANSACTION;
        PRINT 'Marks recorded successfully';
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        PRINT 'Error: ' + ERROR_MESSAGE();
    END CATCH
END;
-- Execute
EXEC sp_RecordExamMarks 1, 1, 85;
/*
Assignment 3 – Department Transfer Transaction
Scenario
Move student from one department to another.
Create procedure
sp_TransferStudentDepartment
Logic
BEGIN TRANSACTION
Update student department
Verify department exists
COMMIT
ROLLBACK if failure*/
-- Create Procedure
CREATE PROCEDURE sp_TransferStudentDepartment
    @StudentID INT,
    @NewDepartmentID INT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;
        IF NOT EXISTS (
            SELECT 1 FROM Departments WHERE DepartmentID = @NewDepartmentID
        )
        BEGIN
            RAISERROR('Department does not exist',16,1);
            ROLLBACK TRANSACTION;
            RETURN;
        END
        UPDATE Students
        SET DepartmentID = @NewDepartmentID
        WHERE StudentID = @StudentID;
        COMMIT TRANSACTION;
        PRINT 'Department updated successfully';
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        PRINT 'Error: ' + ERROR_MESSAGE();
    END CATCH
END;
-- Execute
EXEC sp_TransferStudentDepartment 1, 2;
