SQL => Structured Query Language
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
	Dept_id int Foreign Key References College_Department(Did)
	ON Delete NO ACTION
	ON UPDATE NO ACTION
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

Insert into Students values (106,'Ramesh','Pune',987654321238,202)

Insert into college_Department Values (202,'ENTC'),(203,'Mechanical')

Insert into Students values 
(102,'Sandip','Pune',987654321225,203),
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

-------------------------------------------
-- drop constraint

Select * 
From Information_schema.table_constraints

-- unique key from employees table

Alter table Employees
Drop constraint UK_Empid

----18-03-2024--------------------------
Create table Country
(
	Country_id int,
	Country_name varchar(25),
	
)

Create table State
(
	State_id int,
	State_name varchar(25),
	Country_id int
)

Create table District
(
	District_id int,
	District_name varchar(25),
	State_id int
)


----------------------------------------------
Insert into Country values
(201,'India'),
(202,'USA'),
(203,'Russia')



Insert into State values
(1,'Maharashtra',201),
(2,'Karnataka',201),
(3,'Tamil Nadu',201),
(4,'Gujurat',201),
(5,'Delhi',201),
(6,'Goa',201)

Insert into District values
(101,'Pune',1),
(102,'Mumbai',1),
(103,'Nagpur',1),
(104,'Nashik',1),
(105,'Belgav',2),
(106,'Banglore',2),
(107,'Maysore',2),
(108,'Chennai',3),
(109,'Rameshwaram',3),
(110,'Panji',6)




------------------------------------
Select * From Country
Select * From State
Select * From District

------------------------------------
--Display District details of State of Maharashtra

Select *
From District
Where State_id in (Select State_id From State Where State_name = 'Maharashtra')

--Display District details and state name of State of Maharashtra

Select d.*,s.state_name
From District d
Join State s
On d.State_id = s.State_id
Where s.state_name = 'Maharashtra'

--display Districts from country India
select *
From District
Where State_id in
(select State_id
From State 
Where Country_id in (Select country_id
						From Country
						Where Country_name = 'India'))

--display Districts,state and country details from country India

select d.*,s.state_name,c.country_name
From District d
Join State s
On d.state_id = s.state_id
Join Country c
On c.country_id = s.country_id
Where c.country_name = 'India'

--Find 3rd Highest Salary using subquery

select * From Employees
Where Salary in(select max(salary) from Employees
				Where salary < (select max(salary) from Employees
				Where salary < (Select max(salary) From Employees)))

--Find 2nd and 3rd Highest Salary From Employees

Select *From
(Select *,Dense_rank() over(order by salary Desc) as Sal_rank 
From Employees) T1
Where Sal_rank in (2,3)

--Find 2nd lowest Salary From Employees

Select * From Employees
Where Salary in (Select Min(salary) From Employees
				Where Salary > (Select Min(Salary) From Employees))

--Nth Highest Salary (Say 5th salary)

Select *
From Employees main_q 
Where 4 = (Select count(Distinct Salary)
			From Employees sub_q
			Where sub_q.salary >= main_q.salary)

-------------------------------------------------------------

Select * From Emp_backup

Alter Table Emp_backup
Add Mgr_id int

--Display employees with their manager names

Select e.Empid,e.Ename,e.Salary,e.Dept,e.mgr_id,m.Ename
From Emp_backup e
Join Emp_backup m
On e.mgr_id = m.Empid

--Display Employees who leave in the same city as Abhi leaves

Select *
From Emp_backup e
Join Emp_backup m
On e.City = m.City and e.Empid != m.Empid
Where e.Ename = 'Abhi'

--Display Employee Details with their Department details

Select e.*,d.Dname
From Employees e
Join Department d
On e.dept = d.did

--Diplay Employees with their departments and also the departments that are having no employees

Select e.*,d.Dname
From Employees e
Right Join Department d
On e.dept = d.did

--display Employees having no Department

Select *
From Employees
Where dept IS NULL

--Using case statement categorize employees based on their salary
--< 50000 .......Low
--50000 - 75000 ...Medium
-->75000.........High

Select * From Emp_backup

Select Empid,Ename,Salary,
	Case
		When Salary < 50000 then  'Low'
		When Salary between 50000 and 75000 then  'Medium'
		When Salary > 75000 then  'High'
	End as Salary_category
From Emp_backup

-----------------------------

Select name,database_id,state,
	case
		when state = 0  then 'Online'
		When state = 6 then 'Offline'
		Else 'Recovery'	
	end as status
From sys.databases

-------------------------------




