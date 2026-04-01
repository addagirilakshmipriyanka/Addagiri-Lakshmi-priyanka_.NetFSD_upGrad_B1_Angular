use EmployeeDb;
CREATE TABLE Orders (
    OrderId INT PRIMARY KEY IDENTITY(1,1),
    CustomerName NVARCHAR(100),
    TotalAmount DECIMAL(10,2)
);
CREATE TABLE OrderItems (
    ItemId INT PRIMARY KEY IDENTITY(1,1),
    OrderId INT,
    ProductName NVARCHAR(100),
    Quantity INT
);

