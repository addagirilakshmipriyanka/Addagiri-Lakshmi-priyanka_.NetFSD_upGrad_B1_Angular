use EmployeeDb

CREATE TABLE Products (
    ProductId INT PRIMARY KEY IDENTITY(1,1),
    ProductName NVARCHAR(100),
    Price DECIMAL(10,2),
    Stock INT
);
select * from Products;
insert into Products values('priyanka',50000,4);