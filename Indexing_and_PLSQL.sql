--Indexing
select * From INFORMATION_SCHEMA.TABLES

Select * From sysindexes

sp_helpindex Employees

Select * From Employees

Select * into Emp_backup
From Employees

Select * From Emp_backup

sp_helpindex Emp_backup

Alter table Emp_backup
Add PAN varchar(16)

Create Index INDEX_1
on Emp_backup(EmployeeID)

Create Clustered Index INDEX_1
on Emp_backup(EmployeeID)

drop index INDEX_1
on Emp_backup

Alter Table Emp_backup
Alter column PAN varchar(20) NOT NULL 

Alter Table Emp_backup
Alter column PAN varchar(20) Unique Key

Alter table Emp_backup
Add constraint uk_1 unique(PAN)

Drop index Index_1
On Emp_backup

Create Clustered Index Index_clus_PAN
On Emp_backup(PAN)

Alter table Emp_backup
Add Constraint PK_EmpId Primary Key(EmployeeID)

Alter Index Index_clus_PAN
On Emp_backup Rebuild

Alter Index Index_clus_PAN
On Emp_backup Reorganize
------------------------------------------------
--PL/SQL


Declare @E int
Set @E = 102

Select * From Employees
Where EmployeeID = @E

Declare @CNT int
Set @CNT = (Select COUNT(*) From Employees)
Print 'Total Employees = '+ cast(@CNT as varchar(10))

Declare @fname varchar(10),@DOJ varchar(10),@E int
Set @E=103
Select @fname = FirstName, @DOJ = Joining_date
From Employees 
Where EmployeeID = @E
Print 'Employee with Name '+cast(@fname as varchar(max))+' and EmpID ='+ cast(@E as varchar(max)) +' has Date of Joining '+cast(@DOJ as varchar(max))

--Stored Procedure
--it is subprogram to perform task or set of tasks
--it provides reuability feature 
--stored procrdure is a precompiled object stored in the database, i.e it is compiled once and exceute multiple times.
--it provides exception exception handling, programming features like if ,else,while loops etc.
--it contains block of SQL statements like insert,update,delete,commit,rollback,etc.
--Stored procedure may or may not take arguments.
--Stored procedure may or may not return a value.



--Write a SP to display employees under the given managerID (eg:mgrID=104)


Create Procedure get_emp(@mid int)
AS
Begin
	Select * From Employees
	Where Mgr_id = @mid
End

Exec get_emp 105


--procedure 1

Create Procedure Proc_1(@city varchar(10),@cnt int out)
As
Begin
	Select @cnt=count(*) From Employees where City = @city
End

Declare @EmpCount int
Exec Proc_1 'Pune',@EmpCount out
Print 'No of Employees = ' + convert(varchar(max),@EmpCount)

---------------------------------
--Return Codes

Create Procedure Proc_2(@city varchar(10))
As
Begin
	Select * From Employees
	Where City = @city

	if @@ROWCOUNT > 0
		return(1)
	else
		return(0)
End


Declare @return_code int
Exec @return_code =  Proc_2 'mumbai'
select @return_code

-------------------------------------------------------
--nested SP

Alter Procedure addition(@a int,@b int)
As
Begin
	print 'Addition = ' + cast((@a+@b) as varchar(10))
End


Create Procedure Substraction(@a int,@b int)
As
Begin
	print 'Substraction = ' + cast((@a-@b) as varchar(10))
End

Create Procedure Multiplication(@a int,@b int)
As
Begin
	print 'Multiplication = ' + cast((@a*@b) as varchar(10))
End


Alter Procedure Calculate(@a int,@b int)
As
Begin
	print 'a='+ cast(@a as varchar)
	print 'b='+ cast(@b as varchar)
	Exec addition @a,@b
	Exec Substraction @a,@b
	Exec Multiplication @a,@b
End

Exec Calculate 30,10

----------------------------------
--procedure to diplay employees of Admin department

Alter Procedure Proc_3(@dept varchar(10))
As
Begin
	Select * From Employees
	Where DEPT = (Select did from Department where Dname = @dept)
End

Exec Proc_3 'Admin'


Select * From Employees
Select * From Department


---------------------------------------
---------  Cursor  --------------------
---------------------------------------
--cursor is the pointer to the temporary memory where the data retrived from the table is stored.
--cursor allowes you to process the individual row returned by the query.
--cursor is written inside stored procedure.

--steps to use cursor
--Declare cursor => Open cursor => Fetch from Cursor => if Empty => close cursor => deallocate cursor


--Write a cursor to increase salary of employees based on City as below
--Pune => 20%
--Mumbai => 15%
--Nashik => 10%
--Others => 5%
Select * From Employees

Create Procedure sp_Update_Salary_on_city
As 
Begin
	Declare salary_hike cursor
	for Select Empid,Salary,City From Employees

	Declare @E int,@S money,@C varchar(20)

	open salary_hike

	Fetch Next From Salary_hike into @E,@S,@C

	While @@FETCH_STATUS = 0
	Begin
		if @C = 'Pune'
			set @S = @S + @S*20/100
		else if @C = 'Mumbai'
			set @S = @S + @S*15/100
		else if @C = 'Nashik'
			set @S = @S + @S*10/100
		else
			set @S = @S + @S*5/100

		update Employees
		set Salary = @S
		Where Empid = @E

		Fetch Next From Salary_hike into @E,@S,@C
	End

	close Salary_hike
	Deallocate Salary_hike
End


Exec sp_Update_Salary_on_city

Select * From Employees

------------------------------------------
--write a cursor to categorize the employees baseed on their salary
--Low Range: 30,000 - 50,000
--Medium Range: 50,000 - 75,000
--High Range: 75,000 - 100,000

Alter table Employees
Add Salary_Category varchar(10)

Select * From Employees

Create Procedure Cat_Emp_Salary
As
Begin
	Declare salary_cat Cursor
	For Select Empid,Salary from Employees

	Declare @E int,@S money

	Open Salary_cat

	Fetch Next From Salary_cat into @E,@S

	While @@FETCH_STATUS = 0
	Begin
		if @S <= 50000
			Update Employees
			Set Salary_category = 'Low'
			Where Empid = @E

		else if @S Between 50000 and 75000
			Update Employees
			Set Salary_category = 'Medium'
			Where Empid = @E

		else if @S >= 75000
			Update Employees
			Set Salary_category = 'High'
			Where Empid = @E

		Fetch Next From Salary_cat into @E,@S
	End

	Close Salary_cat
	Deallocate Salary_cat
End

Exec Cat_Emp_Salary

Select * From Employees

---------------------------------------

Backup Database Netflix_Analysis
To Disk = 'D:\B27_SQL\backup_file.bak'

Select * From [dbo].[netflix_Dataset]
Where type = 'Movie'

-----------------------------------------------
--Function

Create Function Func_1()
returns int
As
Begin
	return(select count(*) From Employees)
End

declare @result int
Exec @result = Func_1 
Select @result

---------------------------------------------------

Backup Database [TEST_DATABASE]
To Disk = 'D:\B27_SQL\Test_databse_backup.bak'

---------------------------------------------------
-- SP to take database backup
Create procedure take_backup
As
Begin
	Declare @name varchar(50),
			@filename varchar(256),
			@path varchar(256),
			@date varchar(20)

	set @date = GETDATE()

	set @path = 'D:\B27_SQL\DBBackup\'

	Declare dbbackup Cursor 
	for Select name from sysdatabases Where name not In ('master','tempdb','model','msdb')

	open dbbackup

	Fetch Next From dbbackup into @name
	
	While @@FETCH_STATUS = 0
	Begin
		set @filename = @path + @name + '_' + @date + '.bak'

		Backup Database @name
		To Disk = @filename

		Fetch Next From dbbackup into @name
	End

	Close dbbackup
	Deallocate dbbackup	
End


exec take_backup

----------------------------------------------------------------
--After Trigger

create table Student_history
(
	studentID int,
	Name varchar(20),
	Gender varchar(5),
	Deleted_On date
)


Create Trigger After_Trg
On Student
After Delete
As
Begin
	Insert into Student_history(studentID,Name,Gender,Deleted_On)
	Select STUDENTID,NAME,GENDER,GETDATE()
	From deleted
End
-----------------------------

select * From STUDENT

delete From STUDENT
Where STUDENTID = 105

Select * From Student_history

drop trigger After_Trg
-------------------------------------------------------
--Instead Of Trigger

Create Trigger Instead_of_trg
On Student
Instead of Delete
As
Begin
	Declare @sid int,@sname varchar(20)

	Begin tran
		Select @sid=STUDENTID,@sname=NAME From deleted

		print 'You Cannot Delete this Row.'
		print 'Details: StudentID='+cast(@sid as varchar(20)) + ',' + 'Student Name='+cast(@sname as varchar(20))
	
End


select * From STUDENT

Delete From STUDENT
Where STUDENTID = 104

drop trigger Instead_of_trg
----------------------------------------------------------
--for Insert

Alter Trigger Insert_trg
On student
After Insert
As
Begin
	Declare @sid int,@name varchar(20),@sname varchar(20)

	select  @sid=STUDENTID,@name=NAME,@sname=SURNAME 
	From inserted

	Begin Transaction
		Update STUDENT
		Set NAME = Upper(@name),SURNAME=UPPER(@sname)
		Where STUDENTID=@sid
	commit
End

select * From STUDENT

delete From STUDENT
Where STUDENTID = 101

Insert into STUDENT values (101,'akshay','sanas','1999-07-30','M','5Sci',89)

---------------------------------------------------------


