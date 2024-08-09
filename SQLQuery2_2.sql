
Drop Table Employees

--Constraints are used to Restrict the user
NOT NULL
DEFAULT
CHECK
UNIQUE
PRIMARY KEY
FOREIGN KEY

-- NOT NULL

Create Table Employees
(
	Empid int,
	Ename varchar(25),
	Salary money,
	City varchar(20) NOT NULL,
	Dept int
)

Select * From Employees

Insert into Employees values (101,'Akshay',50000,NULL,201)

Insert into Employees(Empid,Ename,Salary,Dept) values (101,'Akshay',50000,201)

Insert into Employees values (101,'Akshay',50000,'Pune',201)

Update Employees
Set City = NULL
Where Empid = 101

Drop Table Employees

--Default 

Create Table Employees
(
	Empid int,
	Ename varchar(25),
	Salary money,
	City varchar(20) NOT NULL,
	Dept int Default 210
)

Select * From Employees

Insert into Employees (Empid,Ename,Salary,City) values (101,'Akshay',50000,'Mumbai')

Insert into Employees values (101,'Akshay',50000,'Mumbai',NULL)

Insert into Employees values (102,'Sandip',60000,'Pune',203)

Drop Table Employees

--Check Constraint

Create Table Employees
(
	Empid int,
	Ename varchar(25),
	Salary money,
	Gender char(1) Check(Gender in ('M','F')),
	City varchar(20) NOT NULL,
	Dept int Default 210
)

Select * From Employees

Insert into Employees values (103,'Akshay',50000,'R','Mumbai',204)

Insert into Employees(Empid,Ename,Salary,Gender,City) values (102,'Rupali',50000,'F','Pune')

Update Employees
Set Gender = 'S'
Where Empid = 103

Drop Table Employees

--Unique
--(Unique + NULL)

Create Table Employees
(
	Empid int,
	Ename varchar(25),
	Salary money,
	Gender char(1) Check(Gender in ('M','F')),
	City varchar(20) NOT NULL,
	Mobile Bigint unique,
	Dept int Default 210
)
Select * From Employees

Insert into Employees values (103,'Yash',50000,'M','Mumbai',9876543234,203)

Insert into Employees(Empid,Ename,Salary,Gender,City) values (102,'Rupali',50000,'F','Pune')

Drop Table Employees

--Primary Key
--(Unique + NOT NULL)

Create Table Employees
(
	Empid int primary key,
	Ename varchar(25),
	Salary money,
	Gender char(1) Check(Gender in ('M','F')),
	City varchar(20) NOT NULL,
	Mobile Bigint unique,
	Dept int Default 210
)

Select * From Employees

Insert into Employees values (102,'Akshay',50000,'M','Mumbai',9876543235,203)

Insert into Employees(Ename,Salary,Gender,City,Mobile) values ('Rupali',50000,'F','Pune',9876543223)

Drop Table Employees

--Foreign Key
--mode NO ACTION / DEFAULT ACTION

Create Table Department
(
	Did int primary key,
	Dname varchar(25)
)

Create Table Employees
(
	Empid int primary key,
	Ename varchar(25),
	Salary money,
	Gender char(1) Check(Gender in ('M','F')),
	City varchar(20) NOT NULL,
	Mobile Bigint unique,
	Dept int Default 210 Foreign key References Department(Did)
)

Select * From Department	
Select * From Employees


Insert into Department values (205,'IT'),(202,'HR'),(203,'Sales'),(204,'Finance')

Insert into Employees values
(102,'Sandip',70000,'M','Pune',9876543251,201),
(103,'Yash',60000,'M','Mumbai',9876543512,202),
(104,'Rupali',20000,'F','Pune',9876543562,203),
(105,'Prite',60000,'M','Nashik',9876543234,204)


Update Department
Set Did = 212
Where Did = 201

Update Employees
Set Dept = 212
Where Dept = 201

Delete From Department
Where Did = 205

Drop Table Employees

--CASCADE

Create Table Employees
(
	Empid int primary key,
	Ename varchar(25),
	Salary money,
	Gender char(1) Check(Gender in ('M','F')),
	City varchar(20) NOT NULL,
	Mobile Bigint unique,
	Dept int Default 210 Foreign key References Department(Did)
	ON UPDATE CASCADE
	ON DELETE CASCADE
)

Select * From Department	
Select * From Employees


Insert into Department values (205,'IT'),(202,'HR'),(203,'Sales'),(204,'Finance')

Insert into Employees values
(101,'Akshay',70000,'M','Nashik',9876543227,203),
(102,'Sandip',70000,'M','Pune',9876543251,201),
(103,'Yash',60000,'M','Mumbai',9876543512,202),
(104,'Rupali',20000,'F','Pune',9876543562,203),
(105,'Prite',60000,'M','Nashik',9876543234,204)


Update Department
Set Did = 212
Where Did = 201

Update Employees
Set Dept = 201
Where Dept = 212

Delete From Department
Where Did = 212

Drop Table Employees

--SET NULL

Create Table Employees
(
	Empid int primary key,
	Ename varchar(25),
	Salary money,
	Gender char(1) Check(Gender in ('M','F')),
	City varchar(20) NOT NULL,
	Mobile Bigint unique,
	Dept int Default 210 Foreign key References Department(Did)
	ON UPDATE SET NULL
	ON DELETE SET NULL
)

Select * From Department	
Select * From Employees


Insert into Department values (205,'IT'),(202,'HR'),(203,'Sales'),(204,'Finance')

Insert into Employees values
(101,'Akshay',70000,'M','Nashik',9876543227,203),
(102,'Sandip',70000,'M','Pune',9876543251,205),
(103,'Yash',60000,'M','Mumbai',9876543512,202),
(104,'Rupali',20000,'F','Pune',9876543562,203),
(105,'Prite',60000,'F','Nashik',9876543234,204)


Update Department
Set Did = 212
Where Did = 203

Update Employees
Set Dept = 213
Where Dept = 202

Update Employees
Set Dept = 212
Where Dept IS NULL

Delete From Department
Where Did = 212

Drop Table Employees

--SET DEFAULT

Create Table Employees
(
	Empid int primary key,
	Ename varchar(25),
	Salary money,
	Gender char(1) Check(Gender in ('M','F')),
	City varchar(20) NOT NULL,
	Mobile Bigint unique,
	Dept int Default 212
	Foreign key References Department(Did)
	ON UPDATE SET DEFAULT 
	ON DELETE SET DEFAULT
)

Select * From Department	
Select * From Employees


Insert into Department values (201,'Admin'),(205,'IT'),(202,'HR'),(203,'Sales'),(204,'Finance')

Insert into Employees values
(101,'Akshay',70000,'M','Nashik',9876543227,202),
(102,'Sandip',70000,'M','Pune',9876543251,201),
(103,'Yash',60000,'M','Mumbai',9876543512,202),
(104,'Rupali',20000,'F','Pune',9876543562,204),
(105,'Prite',60000,'F','Nashik',9876543234,204)

Insert into Employees (Empid,Ename,Salary,Gender,City,Mobile)
values (106,'Ram',70000,'M','Nashik',9876543223)

Update Department
Set Did = 205
Where Did = 210

Update Employees
Set Dept = 213
Where Dept = 202

Delete From Department
Where Did = 210

Drop Table Employees

--------------------------------------
Select * From Department	
Select * From Employees

----------------------------------------
--constraints:
NOT NULL :-
	Does not allow NULL Values, Column Level 
Default :-
	sets Default value to column , Column Level
Check :-
	used to check each value inserted in column , Column level , it is slow
Unique :-
	(Unique + NULL) , 1 NULL is Allowed , Duplicates NOT ALLOWED , Column level and Table Level,
	1 table has multiple Unique keys
Primary key :-
	(Unique + NOT NULL), NULL NOT ALLOWED , Duplicates NOT ALLOWED , Column level and Table Level,
	1 table has only 1 primary key
Foreign key :-
	is a column in a table that references to the primary key in other table,
	NULLs are Allowed,Duplicates are ALLOWED ,  Column level , 
	1 table can have multiple Foreign keys

--operators :
+,-,*,/,%
and,or,not
like,
between,
in
--set operators :
Union
Union ALL
Intersect
Except
--Inbuilt functions:
 -Aggregate functions:- min(),max(),count(),sum(),avg()
 -scalar functions:- abs(),power(),sin(),cos(),tan(),square(),sqrt(),floor(),ceiling(),pi()
 -ranking functions:- rank(),dense_rank(),row_number()
 -string functions:- upper(),lower(),substring(),left(),right(),ltrim(),rtrim(),stuff()
 -date functions:- getdate(),dateadd(),datepart(),datename(),datediff()
--Subquery :-
	Query inside query is called subquery
	-single value
	-multi value
	-nested subquery
	-corelated subquery


--Create table Emp_backup and copy data of Employees table to Emp_backup

--method 1:-
Select * From Employees

Create Table Emp_backup
(
	Empid int primary key,
	Ename Nvarchar(25),
	Salary money,
	Dept int,
	City varchar(20)
)

Select * From Emp_backup

Insert into Emp_backup
select * From Employees

drop table Emp_backup
-------------------------
--method 2:-

-- To Copy only structure
Select * into Emp_backup
From Employees
Where 1=0

-- To copy Structure with Data
select * into Emp_backup 
From Employees

Select * From Emp_backup

---------------------------------------------
Select * From Employees
Select * From Department

--Retrieve the list of employees who belong to the department with the highest number of employees. 
--Display their employee name and dept_no.

select Ename,Dept
From Employees 
Where Dept = (Select Top 1 Dept
				From Employees
				Group By Dept
				order by count(*) Desc
				)


CTE => Common Table Expression



--Find all the employees who earn more than the average salary.

Select *
From Employees e
Where Salary > (Select avg(salary) as avg_salary
					From Employees
					)

----Find all the employees who earn more than the average salary in their department.
Select *
From Employees e
Where e.Salary > (Select Avg(Salary)  as avg_salary
				From Employees
				Where Dept = e.Dept
				)

--Find the departments where the average salary of employees is higher than the overall average salary across all departments. 
--Display the department name and the average salary.

Select avg(salary)
From Employees