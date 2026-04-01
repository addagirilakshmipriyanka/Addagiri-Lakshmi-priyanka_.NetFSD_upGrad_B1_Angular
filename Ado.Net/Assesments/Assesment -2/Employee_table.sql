create database EmployeeDb
use EmployeeDb;
CREATE TABLE Employees (
    EmpId INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100),
    Salary DECIMAL(10,2),
    Department NVARCHAR(50)
);
insert into  Employees values('Priyanka',33000,'IT');
insert into  Employees values('Priya',40000,'Backend');
insert into  Employees values('Latha',30000,'Frontend');


CREATE PROCEDURE InsertEmployee
    @Name NVARCHAR(100),
    @Salary DECIMAL(10,2),
    @Department NVARCHAR(50)
AS
BEGIN
    INSERT INTO Employees VALUES (@Name, @Salary, @Department)
END
CREATE PROCEDURE UpdateEmployeeSalary
    @EmpId INT,
    @Salary DECIMAL(10,2)
AS
BEGIN
    UPDATE Employees SET Salary = @Salary WHERE EmpId = @EmpId
END
CREATE PROCEDURE GetEmployeesByDepartment
    @Department NVARCHAR(50)
AS
BEGIN
    SELECT * FROM Employees WHERE Department = @Department
END