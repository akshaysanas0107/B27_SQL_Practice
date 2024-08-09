
Use DB2

-- Create Employees table
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DepartmentID INT,
    CONSTRAINT FK_Employees_Departments FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

-- Create Departments table
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50)
);

-- Create Projects table
CREATE TABLE Projects (
    ProjectID INT PRIMARY KEY,
    ProjectName VARCHAR(50),
    DepartmentID INT,
    CONSTRAINT FK_Projects_Departments FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

-----------------------------------

Insert into Departments values
(201,'Admin'),
(202,'Sales'),
(203,'Finance'),
(204,'HR'),
(205,'Manufacturing')

Insert into Employees values
(101,'Akshay','Sanas',202),
(102,'Yash','Pandhare',203),
(103,'Rupali','Sontakke',202),
(104,'Sandip','Engle',201),
(105,'Priti','Dhumal',203),
(106,'Rahul','Patil',201)

Insert into Projects values
(301,'Project-1',202),
(302,'Project-2',201),
(303,'Project-3',203),
(304,'Project-4',202),
(305,'Project-5',204),
(306,'Project-6',NULL)

------------------------------------------------------

Select * From Departments
Select * From Employees
Select * From Projects

---------------------------------------------
--List the departments along with the average number of projects they have. 
--Display the department name and the average project count.

select DepartmentName,AVG(Project_count) as Avg_Project_count
From
(Select d.DepartmentName,count(*) as Project_count
From Projects p
Join Departments d
On p.DepartmentID = d.DepartmentID
Group By d.DepartmentName)T1
Group By DepartmentName


--Find the employee with the highest number of projects. 
--Display their first name, last name, and the count of projects they are involved in.

select e.FirstName,e.LastName,COUNT(*) projects_count
From Employees e
Join Departments d
On e.DepartmentID = d.DepartmentID
Join Projects p
On p.DepartmentID = d.DepartmentID
Group By e.FirstName,e.LastName
order by projects_count Desc

--Retrieve the list of departments along with the total number of employees in each department.
--Display the department name and the employee count.


select d.DepartmentName,count(*) as Total_emp
From Employees e
Join Departments d
On e.DepartmentID = d.DepartmentID
Group By d.DepartmentName

--------------------------------------------
--Find the project with the highest number of employees. 
--Display the project name and the count of employees working on it.

Select p.ProjectName,count(Distinct e.EmployeeID) as Emp_count
From Employees e
Join Projects p
On p.DepartmentID = e.DepartmentID
Group By p.ProjectName

Select * From Employees
Select * From Projects

-- List the employees who are working on more than one project. 
--Display their first name, last name, and the count of projects they are involved in.

Select e.FirstName,e.LastName,count(p.ProjectName) as Project_count
From Employees e
Join Projects p
On p.DepartmentID = e.DepartmentID
Where 1=1
Group By e.FirstName,e.LastName
Having count(p.ProjectName) > 1


