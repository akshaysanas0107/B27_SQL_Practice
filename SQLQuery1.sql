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
Values (105,'Sham',30000,201,NULL)

Insert into Employees (Empid,Ename,Dept,City)
Values (106,'Ram',202,'Mumbai')

UPDATE Employees
set Salary = 50000
where Empid = 105 and Salary = 30000

DELETE FROM Employees
Where Empid = 106

---------DCL------------------

Grant Create on Employees to xyz_user

Revoke Create on Emplyees to xyz_user

-------TCL---------
Begin Transaction
Update Employees
set City = 'Mumbai'
Where Empid = 105 

Save Transaction A

commit

Begin Transaction
Insert into Employees 
Values (108,'Baban',30000,201,'Mumbai')

Rollback Transaction A

Save 

----------------------------------
select * from sys.databases

select * from sysdatabases

select * from INFORMATION_SCHEMA.TABLES

select * from INFORMATION_SCHEMA.COLUMNS

select * from INFORMATION_SCHEMA.VIEWS

------------------------------------
select * from Employees

-- Display no. of Employees in each Dept

select Dept,count(*) As No_of_Employees
from Employees
Where 1=1
Group by Dept

--Display Number of Employees in Each City
Select City, count(*) No_of_Employees 
From Employees
Where 1=1
Group By City

--Display Total Salary of Emloyees in Each Dept
Select Dept,sum(Salary) 
From Employees
Where 1=1
Group By Dept

--Display Departments where Total Salary is Greater than 100000
Select Dept,Sum(Salary)
From Employees
Where 1=1
Group By Dept
Having Sum(Salary) > 100000

--Display Cities Where Employees Total Salary is Greater than Average Salary

Select City,Sum(Salary)
From Employees
Where 1=1
Group By City
Having Sum(Salary) > avg(Salary)

--Display Employees whose name is Starting with 'A'
Select *
From Employees
Where Ename like 'A%'

--Display Employees whose name is third last letter as 'd'
Select * 
From Employees
Where Ename like '%d__'

--Display Current Date
Select GETDATE()

--Add column Joining Date and The Joining Date for Each Employee

Alter table Employees
Add Joining_Date date

select * from Employees

Update Employees
Set Joining_Date = '2023-03-01'
Where Empid in (101,103,105)

Update Employees
Set Joining_Date = '2023-09-01'
Where Empid in (102,104)

Update Employees
Set Joining_Date = '2023-12-01'
Where Empid = 107

-- Display Joining date of Each Employee

Select Empid,Joining_Date
From Employees

-- Display Joining Month of Each Employee

Select Empid,Datepart(MONTH,Joining_Date) Joining_month
From Employees

Select Empid,DATENAME(MONTH,Joining_Date) Joining_month
From Employees

-- Display Months of Experience of Each Employees

Select Empid,Datediff(MONTH,Joining_Date,GETDATE()) Exp_Months
From Employees

-- Display Years of Experience of Each Employees

Select Empid,Datediff(YEAR,Joining_Date,GETDATE()) Exp_Years
From Employees

--Add 2 months to Joining date of an Employee

Update Employees
Set Joining_Date = Dateadd(MONTH,2,Joining_Date)
Where Empid = 102

Select * from Employees

-- Display Names in Uppercase
select Upper(Ename)
From Employees

-- Display Names in Lower
select Lower(Ename)
From Employees

--String Functions

select SUBSTRING(Ename,1,4)
From Employees

select LEFT(Ename,4)
From Employees

select len(Ename)
From Employees


int,Bigint,smallint,money
varchar,char,text
float,double,real
date,time,datetime,
nchar,nvarchar