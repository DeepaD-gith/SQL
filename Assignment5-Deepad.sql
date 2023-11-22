--1.Arrange the ‘Orders’ dataset in decreasing order of amount
Select * from Orders
Order BY AMOUNT DESC

--2. Create a table with the name ‘Employee_details1’ consistingof thesecolumns: 
   --‘Emp_id’, ‘Emp_name’, ‘Emp_salary’. Create another tablewiththe name ‘Employee_details2’ 
   --consisting of the same columns as the first table. 
CREATE TABLE Employee_details1
(Emp_id int Identity(1,1) PRIMARY KEY,
 Emp_name varchar(30),
 Emp_Salary decimal(9,2)
 )
 CREATE TABLE Employee_details2
(Emp_id int Identity(1,1) PRIMARY KEY,
 Emp_name varchar(30),
 Emp_Salary decimal(9,2)
 )
 Insert into Employee_details1 (Emp_name, Emp_Salary)
 values ('Áshima H', 50000), ('Ánjana S', 340000), ('Rakesh Eapen',95000), ('Sai Kumar', 25000);
 Insert into Employee_details2 (Emp_name, Emp_Salary)
 values ('Deepthi S', 42000), ('Biju M', 39000), ('Rakesh Eapen',95000), ('Sai Kumar', 25000);



--3. Apply the UNION operator on these two tables
Select * from Employee_details1
UNION
Select * from Employee_details2

--4. Apply the INTERSECT operator on these two tables
Select * from Employee_details1
INTERSECT
Select * from Employee_details2

--5. Apply the EXCEPT operator on these two tables
Select * from Employee_details1
EXCEPT
Select * from Employee_details2