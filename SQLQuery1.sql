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

----------DQL----------------------------
SELECT * FROM Employees

-----DML-------
INSERT INTO Employees
VALUES (101,'Akshay',40000,202,'Pune')

INSERT INTO Employees VALUES 
(102,'Sandip',50000,203,'Pune'),
(103,'Vijay',30000,201,'Mumbai'),
(104,'Abhi',77000,203,'Nashik')

UPDATE Employees
set Salary = 80000
where Empid = 104

DELETE FROM Employees
Where Empid = 105

---------DCL------------------

Grant Create on Employees to xyz_user

Revoke Create on Emplyees to xyz_user

-------TCL---------

