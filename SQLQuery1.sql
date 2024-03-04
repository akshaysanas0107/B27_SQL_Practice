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
VALUES (101,'Akshay',40000,202,'Pune')

INSERT INTO Employees VALUES 
(102,'Sandip',50000,203,'Pune'),
(103,'Vijay',30000,201,'Mumbai'),
(104,'Abhi',77000,203,'Nashik')

Insert into Employees
Values (107,'Sham',30000,201,NULL)

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

--------------Set Operators---------------------------



