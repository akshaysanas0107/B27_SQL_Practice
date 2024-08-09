
Create Table Student
(
	Stud_id int primary key,
	Name varchar(20),
	Batch_no int foreign key references Batch(Batch_no)
)

Create Table Batch
(
	Batch_no int primary key,
	Start_Date date,
	End_Date date
)

Create Table Attendance
(
	A_status int,
	Sid int foreign key references Student(Stud_id),
	Date date
)

Create Table Fee_Receipt
(
	Receipt_no int,
	Amount money,
	Sid int foreign key references Student(Stud_id)
)

-----------------------------------------------------
Insert into Batch values
(1001,'2024-01-01','2024-03-31'),
(1002,'2024-02-01','2024-04-30'),
(1003,'2024-03-01','2024-05-31'),
(1004,'2024-04-01','2024-06-30'),
(1005,'2024-05-01','2024-07-31'),
(1006,'2024-06-01','2024-08-31')



Insert into Student Values 
(1,'A',1001),
(2,'B',1006),
(3,'C',1003),
(4,'D',1003),
(5,'E',1004),
(6,'F',1005),
(7,'G',1006),
(8,'H',1001),
(9,'I',1002),
(10,'J',1003)

Truncate table Attendance

Insert into Attendance values
(1,1,'2024-01-01'),
(1,2,'2024-01-01'),
(1,3,'2024-01-01'),
(1,4,'2024-01-01'),
(1,5,'2024-01-01'),
(1,6,'2024-01-01'),
(1,7,'2024-01-01'),
(1,8,'2024-01-01'),
(1,9,'2024-01-01'),
(1,10,'2024-01-01'),
(1,1,'2024-01-02'),
(1,2,'2024-01-02'),
(1,3,'2024-01-02')

Insert into Fee_Receipt values
(3001,5000,1),
(3002,15000,2),
(3003,10000,3),
(3004,5000,1),
(3005,15000,5),
(3006,5000,3),
(3007,5000,1),
(3008,15000,NULL)

-----------------------------------------
Select * From Batch
Select * From Student
Select * From Attendance
Select * From Fee_Receipt

-----------------------------------------
--Display studentID,Name,Batchno,StartDate,EndDate,Total Present days and Total Fees paid

Select Stud_id,Name,Batch_no,Start_Date,End_Date,Total_Present_days,Total_fees_paid
From
(Select s.Stud_id,s.Name,s.Batch_no,b.Start_Date,b.End_Date,SUM(a.A_status) as Total_Present_days
From Student s
Join Batch b
On s.Batch_no = b.Batch_no
Left Join Attendance a
On a.Sid = s.Stud_id
Group By s.Stud_id,s.Name,s.Batch_no,b.Start_Date,b.End_Date) T1

Left Join

(Select Sid,SUM(Amount) as Total_fees_paid
From Fee_Receipt
Group By Sid) T2

On T1.Stud_id = T2.Sid

