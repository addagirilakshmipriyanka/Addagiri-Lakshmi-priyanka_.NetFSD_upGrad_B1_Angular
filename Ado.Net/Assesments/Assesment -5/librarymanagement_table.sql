use EmployeeDb;
CREATE TABLE Books (
    BookId INT PRIMARY KEY IDENTITY(1,1),
    Title NVARCHAR(200),
    Author NVARCHAR(100),
    Price DECIMAL(10,2)
);