﻿SQL => Structured Query Language
TYPES:
DDL => Create,Alter,Drop,Truncate
DML => Insert,Update,Delete
DQL => Select
DCL => Grant,Revoke,Deny
TCL => Begin transaction,commit,rollback,save


--------DDL--------------
CREATE DATABASE B27

USE B27

CREATE TABLE Employees
(
	Empid INT,
	Ename VARCHAR(25),
	Salary MONEY,
	DEPT INT
)


ALTER TABLE Employees
ADD City Varchar(20)

drop table Employees

Truncate Table Employees

----------DQL----------------------------
SELECT * FROM Employees

-----DML-------
INSERT INTO Employees
VALUES (112,'Pradeep',50000,202,'Pune')

INSERT INTO Employees VALUES 
(110,'Mahendra',40000,204,'Pune'),
(111,'Yash',70000,204,'Mumbai'),
(112,'Ajay',90000,202,'Nashik')

Insert into Employees
Values (109,'Sita',30000,203,'Nashik')

Insert into Employees (Empid,Ename,Dept,City)
Values (106,'Ram',202,'Mumbai')

UPDATE Employees
set Salary = 50000
where Empid = 105 and Salary = 30000            

DELETE FROM Employees
Where Ename = 'Sham' 

---------DCL------------------

Grant Create,update on Employees to xyz_user

Revoke Create on Emplyees to xyz_user

-------TCL---------
Begin Transaction
Update Employees
set City = 'Nagpur'
Where Empid = 104 

Save Transaction A

commit

Begin Transaction
Insert into Employees 
Values (108,'Baban',30000,201,'Mumbai')

Rollback Transaction A

Save 

----------------------------------
select * from sys.databases

Create view View1
As
select name,database_id,state_desc,user_access_desc
from sys.databases

Select * from View1

select * from sysdatabases

select * from INFORMATION_SCHEMA.TABLES

select * from INFORMATION_SCHEMA.COLUMNS

select * from INFORMATION_SCHEMA.VIEWS

------------------------------------
select * from Employees

-- Display no. of Employees in each Dept

Select Dept,count(*) as No_of_emp
From Employees
where 1=1
Group by Dept

--Display Number of Employees in Each City

Select city,count(*) as no_of_Emp
From Employees
Where 1=1
Group by City

--Display Total Salary of Emloyees in Each Dept

Select Dept,sum(Salary) as Total_salary
From Employees
Where 1=1
Group by Dept

--Display Departments where Total Salary is Greater than 100000

Select Dept,sum(Salary) as Total_salary
From Employees
Where 1=1
Group by Dept
Having sum(Salary) > 100000

--Display Cities Where Employees Total Salary is Greater than Average Salary

Select city,sum(Salary) as Total_salary
from Employees
Where 1=1
Group By City
Having sum(Salary) > avg(Salary)


--Display Employees whose name is Starting with 'A'

Select *
From Employees
Where Ename like 'A%'

--Display Employees whose name has third last letter as 'd'

select *
From Employees
Where Ename like '%d__'

--Display Current Date

Select GETDATE()

-- delete column Joining_date

alter table employees
drop column joining_date

--Add column Joining Date and The Joining Date for Each Employee

select * from Employees

alter table employees
add Joining_date date

update Employees
Set Joining_date = '2023-12-01'
where Empid = 101

update Employees
Set Joining_date = '2022-05-01'
where Empid in (102,104)

update Employees
Set Joining_date = '2021-07-01'
where Empid in (103,105,107) 

-- Display Joining date of Each Employee

select Empid,Joining_date
From Employees


-- Display Joining Month of Each Employee

Select Empid,Datepart(MONTH,Joining_date) as Joining_month
From Employees

Select Empid,Datename(MONTH,Joining_date) as Joining_month
From Employees

-- Display Months of Experience of Each Employees

Select Empid,Ename,Datediff(MONTH,Joining_date,GETDATE())
From Employees

-- Display Years of Experience of Each Employees

Select Empid,Ename,Datediff(YEAR,Joining_date,GETDATE())
From Employees

--Add 2 months to Joining date of an Employee

select * from Employees

update Employees
Set Joining_date = Dateadd(MONTH,2,Joining_date)
Where Empid = 103 and Joining_date = '2021-07-01'


-- Display Names in Uppercase

Select UPPER(Ename)
From Employees

-- Display Names in Lower

Select Lower(Ename)
From Employees

--substring,len Functions

Select SUBSTRING(Ename,3,5)
From Employees

Select Empid,Ename,len(Ename)
From Employees

Select Right(Ename,3)
From Employees

Select Left(Ename,3)
From Employees

/*DataTypes

int,Bigint,smallint,money
varchar,char,text
float,double,real
date,time,datetime,
nchar,nvarchar
*/

--Display rowid and rownum for emplaoyees table

Select %%physloc%% as RowID,Row_number() over(order by Empid) as Rownumber,*
From Employees


-- Insert Hiroshima (広島) city in employees table

Delete From Employees
Where Empid = 105

Insert into Employees
values (105,N'अक्षय',50000,204,'Pune')

alter table Employees
alter column Ename nvarchar(25)

Insert into Employees 
values (108,'Jackie',90000,203,N'広島','2020-01-01') 

Select * from Employees
Where Ename = N'अक्षय'

Delete from Employees
Where Empid = 108

Alter table Employees
Alter column City nvarchar(25)

------------------------------------

Select cast(Dept as varchar(10)) dept
from Employees

select getdate()
select convert(nvarchar(30),getdate(),101)
select convert(nvarchar(30),getdate(),105)
select convert(nvarchar(30),getdate(),112)
select convert(nvarchar(30),getdate(),114)

---------Aggregate Function----------------------
Min(),Max(),Avg(),Sum(),Count()

Select min(Salary) as Min_Salary
from Employees

Select max(Salary) as max_Salary
from Employees

Select avg(Salary) as avg_Salary
from Employees

Select sum(Salary) as Total_Salary
from Employees

Select Count(*) as No_of_Emp
from Employees

-------Ranking Functions--------------------

Select * from Employees

select *, Row_number() over(order by Salary) as Row_number
From Employees

Select *, Rank() over(order by Salary) as Rank
from Employees

select * , Dense_rank() over(order by salary) as Dense_rank
from Employees

-- Display Employees with 2nd Highest salary

Select * from
(select *, Dense_rank() over(order by salary desc) as salary_rank
From Employees) T1
Where Salary_rank = 2

-- display 2nd Hihest salary

select * from Employees
where salary =
(Select max(salary) from Employees
where salary < (select max(salary) from Employees))

select max(salary) from Employees
where salary not in (select max(salary) from Employees)

--Display 2 Employees from each department having highest salary

Select * From
(Select *, Row_number() over(partition by Dept order by Salary Desc) as Row_number
From Employees) T1
Where Row_number <= 2


-- Display Highest Salary in Each Department

Select Dept,max(Salary) As Highest_salary
from Employees
Where 1=1
Group By Dept

--------------Set Operators---------------------------
Union
Union ALL
Intersect
Except

Example:
A = {1,2,3,4,5}
B ={3,4,5,6,7}

A Union B = {1,2,3,4,5,6,7}
A Union All B = {1,2,3,4,5,3,4,5,6,7}
A Intersect B = {3,4,5}
A Except B = {1,2}
B Except A = {6,7}


--Display Employees of Dept 202 from city Pune and Employees of Dept 203 from city Mumbai 

Select *
From Employees
Where Dept = 202 and City = 'Pune' 
Union 
Select *
From Employees
Where Dept = 203 and City = 'Mumbai'

-- Display Departments in Pune as well in Mumbai

Select Dept
From Employees
Where City = 'Pune' 
Intersect
Select Dept
From Employees
Where City = 'Mumbai'

--Display Emp details from Dept pune and Mumbai

Select * 
From Employees
Where City = 'Pune' or City = 'Mumbai'

--Display Departments in Mumbai but not in Pune

Select Dept
From Employees
Where City = 'Mumbai'
Except
Select Dept
From Employees
Where City = 'Pune'

--Subquery

-- Display Emp Names having Maximum Salary in Each Department

Select Ename,Salary,Dept 
From Employees
Where Salary in 
	(Select max(Salary)
	From Employees
	Where 1=1
	Group By Dept)
Order by Dept

--Create Table Department

create table Department
(
	Did int,
	Dname varchar(20),
)

Select * From Employees
Select * From Department

Insert into Department Values
(201,'Admin'),
(202,'HR'),
(203,'Sales'),
(204,'Finance')

--Display Employees from HR Department

Select * 
From Employees
Where dept in (Select Did From Department 
				Where Dname = 'HR')

--Find From Where the Employees of Sales Department Work From

Select City
From Employees 
Where Dept in (Select Did From Department
				Where Dname = 'Sales')

Before Constraints

Insert into Employees values (113,'Ramesh',60000,205,'Nagpur')

--constraints
Not NULL
Unique
Default
Check
Primary Key
Foreign Key

--Not NULL
--Add Not NULL Constraint to Ename Column in Employees table

Alter Table Employees
Alter Column Ename Nvarchar(25) Not NULL

Insert into Employees Values (114,NULL,40000,204,'Nagpur')

--Add Not NULL Constraint to City Column in Employees table

Select * 
From Employees

Update Employees
Set City = 'UNKNOWN'
Where City IS NULL

Alter Table Employees
Alter Column City Varchar(20) Not NULL

-- Unique constraint
--Add Unique

Select * 
From Employees

Delete From Employees
Where Ename in ('Ram','Pradeep')

--Column level

Alter Table Employees
Add Constraint UK_Empid Unique(Empid)

Insert into Employees Values (103,'Sahil',60000,201,'Pune')

Update Employees
Set Empid = 103
Where Ename = 'Akshay'

Insert into Employees (Ename,Salary,Dept,City) Values ('Rishi',60000,201,'Pune')

--table level
Create table Students
(
	Sid int,
	Sname varchar(25),
	location varchar(20),
	Aadhar Bigint,
	Unique(Sid,Aadhar)
)

Select * From Students

Insert into Students Values (102,'Sandip','Pune',736987532168)

Drop Table Students

--Default Constraint
Select * 
From Employees

Alter Table Employees
Add Constraint Df_city
Default 'UNKNOWN' for City

Insert into Employees(Empid,Ename,Salary,Dept) Values (114,'Rishi',60000,201)

-- Check Constraint

--column level
Create table Students
(
	Sid int,
	Sname varchar(25),
	location varchar(20),
	Aadhar Bigint Check(len(Aadhar) = 12),
	
)

Insert into Students Values (102,'Sandip','Pune',987654321234)

Select * From Students

Drop Table Students

--Primary Key (Unique + Not NULL)

--column level
Create table Students
(
	Sid int Primary Key,
	Sname varchar(25),
	location varchar(20),
	Aadhar Bigint Check(len(Aadhar) = 12),
	
)

Insert into Students Values (102,'Sandip','Pune',987654321234)

Insert into Students Values (102,'Akshay','Pune',987654321234)

Insert into Students Values (NULL,'Sandip','Pune',987654321234)

Drop Table Students

-- table level

Create table Students
(
	Sid int,
	Sname varchar(25),
	location varchar(20),
	Aadhar Bigint Check(len(Aadhar) = 12),
	Primary Key (Sid,Aadhar)
)

Insert into Students Values (102,'Sandip','Pune',987654321234)

Insert into Students Values (102,'Akshay','Pune',987654321234)

Insert into Students Values (NULL,'Sandip','Pune',987654321234)

Insert into Students Values (102,'Akshay','Pune',987654321235)

Insert into Students Values (103,'Ramesh','Pune',987654321235)

select * From Students

drop Table Students

-- Foreign Key

--For NO ACTION / Default Action

Create Table College_Department
(
	Did int Primary key,
	Dname varchar(25),
	
)


Create table Students
(
	Sid int primary key ,
	Sname varchar(25),
	location varchar(20),
	Aadhar Bigint Check(len(Aadhar) = 12),
	Dept_id int Foreign Key References College_Department(Did),

)

Select * From Students
Select * From College_Department

Insert into college_Department Values (201,'Computer Science')

Insert into Students values (101,'Ramesh','Pune',987654321235,201)

Insert into college_Department Values (202,'ENTC'),(203,'Mechanical')

Insert into Students values 
(102,'Sandip','Pune',987654321225,202),
(103,'Akshay','Mumbai',987654321224,201),
(104,'Vijay','Pune',987654321235,201),
(105,'Ram','Mumbai',987654321565,202)

Update College_Department
Set Did = 204
Where Did = 201

Update Students
Set Dept_id = 204
Where Dept_id = 201

Delete From College_Department
Where Did = 202

Delete From Students
Where Dept_id = 201

Drop Table College_Department
Drop Table Students

-- For CASCADE

Create Table College_Department
(
	Did int Primary key,
	Dname varchar(25),
	
)


Create table Students
(
	Sid int primary key ,
	Sname varchar(25),
	location varchar(20),
	Aadhar Bigint Check(len(Aadhar) = 12),
	Dept_id int Foreign Key References College_Department(Did)
	ON DELETE CASCADE
	ON UPDATE CASCADE
)

Select * From Students
Select * From College_Department

Insert into college_Department Values (201,'Computer Science')

Insert into Students values (101,'Ramesh','Pune',987654321235,201)

Insert into college_Department Values (202,'ENTC'),(203,'Mechanical')

Insert into Students values 
(102,'Sandip','Pune',987654321225,205),
(103,'Akshay','Mumbai',987654321224,201),
(104,'Vijay','Pune',987654321235,201),
(105,'Ram','Mumbai',987654321565,203)

Update college_department
Set Did = 205
Where Did = 201

Delete From college_department
Where Did = 202

Delete From Students
Where Dept_id = 205

Drop Table College_Department
Drop Table Students

--For SET NULL
Create Table College_Department
(
	Did int Primary key,
	Dname varchar(25),
	
)


Create table Students
(
	Sid int primary key ,
	Sname varchar(25),
	location varchar(20),
	Aadhar Bigint Check(len(Aadhar) = 12),
	Dept_id int Foreign Key References College_Department(Did)
	ON DELETE SET NULL
	ON UPDATE SET NULL
)

Select * From Students
Select * From College_Department

Insert into college_Department Values (201,'Computer Science')

Insert into Students values (101,'Ramesh','Pune',987654321235,201)

Insert into college_Department Values (202,'ENTC'),(203,'Mechanical')

Insert into Students values 
(102,'Sandip','Pune',987654321225,202),
(103,'Akshay','Mumbai',987654321224,201),
(104,'Vijay','Pune',987654321235,201),
(105,'Ram','Mumbai',987654321565,203)

Update college_department
Set Did = 204
Where Did = 203

Delete From college_department
Where Did = 202

Drop Table College_Department
Drop Table Students

--For SET DEFAULT
Create Table College_Department
(
	Did int Primary key,
	Dname varchar(25),	
)


Create table Students
(
	Sid int primary key ,
	Sname varchar(25),
	location varchar(20),
	Aadhar Bigint Check(len(Aadhar) = 12),
	Dept_id int Default 210 Foreign Key References College_Department(Did)
	ON DELETE SET DEFAULT 
	ON UPDATE SET DEFAULT 
)

Select * From Students
Select * From College_Department

Insert into college_Department Values (201,'Computer Science')

Insert into Students values (101,'Ramesh','Pune',987654321235,201)

Insert into Students(Sid,Sname,location,Aadhar) values (106,'Ramesh','Pune',987654321235)

Insert into Students values (105,'Ramesh','Pune',987654321235,NULL)


Insert into college_Department Values (202,'ENTC'),(203,'Mechanical')

Insert into Students values 
(102,'Sandip','Pune',987654321225,202),
(103,'Akshay','Mumbai',987654321224,201),
(104,'Vijay','Pune',987654321235,201),
(107,'Ram','Mumbai',987654321565,203)

Update college_department
Set Did = 204
Where Did = 203

Delete From college_department
Where Did = 202

Drop Table College_Department
Drop Table Students

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
------------------------------------------------------------------------------------
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
