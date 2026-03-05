
CREATE TABLE Worker (
	WORKER_ID INT PRIMARY KEY IDENTITY(1,1),
	FIRST_NAME VARCHAR(25),
	LAST_NAME VARCHAR(25),
	SALARY INT,
	JOINING_DATE DATETIME,
	DEPARTMENT CHAR(25)
);


CREATE TABLE Bonus (
	WORKER_REF_ID INT,
	BONUS_AMOUNT INT,
	BONUS_DATE DATETIME,
	FOREIGN KEY (WORKER_REF_ID)
		REFERENCES Worker(WORKER_ID)
        ON DELETE CASCADE
);
CREATE TABLE Title (
	WORKER_REF_ID INT,
	WORKER_TITLE CHAR(25),
	AFFECTED_FROM DATETIME,
	FOREIGN KEY (WORKER_REF_ID)
		REFERENCES Worker(WORKER_ID)
        ON DELETE CASCADE
);

INSERT INTO Worker (WORKER_ID, FIRST_NAME, LAST_NAME, SALARY, JOINING_DATE, DEPARTMENT) VALUES
(1,'Monika','Arora',100000,'2014-02-20 09:00:00','HR'),
(2,'Niharika','Verma',80000,'2014-06-11 09:00:00','Admin'),
(3,'Vishal','Singhal',300000,'2014-02-20 09:00:00','HR'),
(4,'Amitabh','Singh',500000,'2014-02-20 09:00:00','Admin'),
(5,'Vivek','Bhati',500000,'2014-06-11 09:00:00','Admin'),
(6,'Vipul','Diwan',200000,'2014-06-11 09:00:00','Account'),
(7,'Satish','Kumar',75000,'2014-01-20 09:00:00','Account'),
(8,'Geetika','Chauhan',90000,'2014-04-11 09:00:00','Admin');

INSERT INTO Bonus (WORKER_REF_ID, BONUS_DATE, BONUS_AMOUNT) VALUES
(1,'2016-02-20 00:00:00',5000),
(2,'2016-06-11 00:00:00',3000),
(3,'2016-02-20 00:00:00',4000),
(1,'2016-02-20 00:00:00',4500),
(2,'2016-06-11 00:00:00',3500);

INSERT INTO Title (WORKER_REF_ID, WORKER_TITLE, AFFECTED_FROM) VALUES
(1,'Manager','2016-02-20 00:00:00'),
(2,'Executive','2016-06-11 00:00:00'),
(8,'Executive','2016-06-11 00:00:00'),
(5,'Manager','2016-06-11 00:00:00'),
(4,'Asst. Manager','2016-06-11 00:00:00'),
(7,'Executive','2016-06-11 00:00:00'),
(6,'Lead','2016-06-11 00:00:00'),
(3,'Lead','2016-06-11 00:00:00');

-- 1. Write an SQL query to fetch “FIRST_NAME” from Worker table using the alias name as <WORKER_NAME>.
select FIRST_NAME AS WORKER_NAME from Worker;
--  Write an SQL query to fetch “FIRST_NAME” from Worker table in upper case.
 select UPPER(FIRST_NAME) from Worker;
-- 3. Write an SQL query to fetch unique values of DEPARTMENT from Worker table.
 select Distinct  DEPARTMENT from Worker;	
-- 4. Write an SQL query to print the first three characters of  FIRST_NAME from Worker table.
select SUBSTRING(FIRST_NAME,1,3) FROM Worker;
-- 5. Write an SQL query to find the position of the alphabet (‘a’) in the first name column ‘Amitabh’ from Worker table.
 select CHARINDEX('a',FIRST_NAME) from Worker where FIRST_NAME='Amitabh'
-- 6. Write an SQL query to print the FIRST_NAME from Worker table after removing white spaces from the right side.
select RTRIM(FIRST_NAME) from Worker;
--7. Write an SQL query to print the DEPARTMENT from Worker table after removing white spaces from the left side.
select LTRIM(FIRST_NAME) from Worker;
--8. Write an SQL query that fetches the unique values of DEPARTMENT from Worker table and prints its length.
  select DISTINCT(DEPARTMENT),LEN(DEPARTMENT) from Worker 
--9. Write an SQL query to print the FIRST_NAME from Worker table after replacing ‘a’ with ‘A’.
SELECT REPLACE(FIRST_NAME,'a','A')From Worker;
--10. Write an SQL query to print the FIRST_NAME and LAST_NAME from Worker table into a single column COMPLETE_NAME. A space char should separate them.
select concat(FIRST_NAME,' ',LAST_NAME) AS COMPLETE_NAME from Worker;
--11. Write an SQL query to print all Worker details from the Worker table order by FIRST_NAME Ascending.
select * from Worker order by FIRST_NAME ASC;
--12. Write an SQL query to print all Worker details from the Worker table order by FIRST_NAME Ascending and DEPARTMENT Descending.
select * from Worker order by FIRST_NAME DESC,DEPARTMENT ASC;
--13. Write an SQL query to print details for Workers with the first name as “Vipul” and “Satish” from Worker table.
SELECT * FROM Worker where FIRST_NAME IN('Vipul','Satish');
--14. Write an SQL query to print details of workers excluding first names, “Vipul” and “Satish” from Worker table.
SELECT * FROM Worker where FIRST_NAME not IN('Vipul','Satish');
--15. Write an SQL query to print details of Workers with DEPARTMENT name as “Admin”.
select * from Worker where DEPARTMENT='Admin';
--16. Write an SQL query to print details of the Workers whose FIRST_NAME contains ‘a’.
select * from Worker where FIRST_NAME like '%a%';
--17. Write an SQL query to print details of the Workers whose FIRST_NAME ends with ‘a’.
select * from Worker where FIRST_NAME like '%a';
--18. Write an SQL query to print details of the Workers whose FIRST_NAME ends with ‘h’ and contains six alphabets.
select * from Worker where FIRST_NAME like '_____h';
--19. Write an SQL query to print details of the Workers whose SALARY lies between 100000 and 500000.
select * from Worker WHERE SALARY BETWEEN 100000 AND 500000;
--20. Write an SQL query to print details of the Workers who have joined in Feb’2014.
select * from Worker where JOINING_DATE>='2014-02-01' and JOINING_DATE< '2014-03-01';
--21. Write an SQL query to fetch worker names with salaries >= 50000 and <= 100000.
select FIRST_NAME,LAST_NAME,SALARY  from Worker where SALARY>=50000 AND SALARY<=100000;
--22. Write an SQL query to fetch the no. of workers for each department in the descending order.
  SELECT DEPARTMENT,COUNT(*) as TotalWorkers FROM Worker group by DEPARTMENT order by TotalWorkers DESC;
--23. Write an SQL query to print details of the Workers who are also Managers
SELECT W.* FROM Worker W INNER JOIN Title T
    ON W.WORKER_ID = T.WORKER_REF_ID
WHERE T.WORKER_TITLE = 'Manager';
--24.Write an SQL query to show the current date and time.
select GetDate() as currentDate;
--25.Write an SQL query to show the top n (say 10) records of a table.select
select top 5 * from Worker order by salary DESC;

