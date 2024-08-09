
Create Database Pub_DB

Create Database Sub_DB
-----------------------------------------
Use Pub_DB

Create Table Employee
(
	Empid int
)

Create Table Department
(
	Did int
)

Create Table Student
(
	Sid int
)

------------------------------

Use Sub_DB

Create Table Employee
(
	Empid int
)

Create Table Department
(
	Did int
)

Create Table Student
(
	Sid int
)

-----------------------------------

Use Pub_DB

Select count(*) From Employee
Select count(*) From Department
Select count(*) From Student

Use Sub_DB

Select count(*) From Employee
Select count(*) From Department
Select count(*) From Student

-----------------------------------

Create Procedure Get_count()
As
Begin
	
End