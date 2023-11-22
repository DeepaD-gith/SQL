--1. List all the employee details.
Select * from employee;
--2. List all the department details. 
Select * from department;
--3. List all job details.
Select * from Job;
--4. List all the locations. 
Select * from Location;

--5. List out the First Name, Last Name, Salary, Commission for allEmployees. 
Select First_Name,Last_Name,Salary, Comm 
from Employee;

--6. List out the Employee ID, Last Name, Department ID 
	--for all employees and alias Employee ID as "ID of the Employee", 
	--Last Name as "Name of the Employee", Department ID as "Dep_id". 
Select Employee_Id as 'ID of the Employee',
	   Last_Name as 'Name of the Employee',
	   Department_ID as 'Dep_id'
from Employee;

--7. List out the annual salary of the employees with their names only.
Select First_Name + ' ' + Last_Name as 'Employee Name',
       Salary * 12 as 'Annual Salary'  --assuming salary given is monthly salary.
from Employee;

--*************Where Condition
--1. List the details about "Smith". 
Select * 
from Employee
where Last_Name = 'Smith';

--2. List out the employees who are working in department 20. 
Select * 
from Employee
where Department_Id = 20; 

--3. List out the employees who are earning salaries between 3000 and4500. 
Select * 
from Employee
where Salary >= 3000 and Salary<= 4500;

--4. List out the employees who are working in department 10 or 20. 
Select * 
from Employee
where Department_Id in (10,20);

--5. Find out the employees who are not working in department 10 or 30.
Select * 
from Employee
where Department_Id not in (10,30);

--6. List out the employees whose name starts with 'S'.
Select * 
from Employee
where Last_Name like 'S%';

--7. List out the employees whose name starts with 'S' and ends with 'H'. 
Select * 
from Employee
where Last_Name like 'S%H';

--8. List out the employees whose name length is 4 and start with 'S'. 
Select * 
from Employee
where Last_Name like 'S%'
and Len(Last_Name)=4;

--9. List out employees who are working in department 10 and draw salaries more than 3500. 
Select * 
from Employee
where Department_Id = 10
and Salary> 3500; 

--10. List out the employees who are not receiving commission
Select * 
from Employee
where Comm is null; 

--***************ORDER BY Clause
--1. List out the Employee ID and Last Name in ascending order based on the Employee ID.
Select Employee_ID,Last_Name 
from Employee
Order By Employee_ID;

--2. List out the Employee ID and Name in descending order based onsalary. 
Select Employee_ID,Last_Name 
from Employee
Order By Salary Desc;

--3. List out the employee details according to their Last Name in ascending-order. 
Select * 
from Employee
Order By Last_Name; 

--4. List out the employee details according to their Last Name in ascending order 
	--and then Department ID in descending order.
Select Employee_ID,Last_Name 
from Employee
Order By Last_name, Department_Id Desc;

--***************GROUP BY and HAVING Clause: 
--1. How many employees are in different departments in the organization? 
Select E.Department_Id, D.Name as 'DepartmentName', 
	   Count(E.Employee_Id) as 'Num of Employees by Department'
from Employee E
join Department D on E.DEPARTMENT_ID = D.Department_Id
group by E.Department_Id,D.Name;

--2. List out the department wise maximum salary, minimum salary and average salary of the employees.
Select E.Department_Id, D.Name as 'DepartmentName',
	   Max(Salary) as 'Highest Salary',
	   Min(Salary) as 'Lowest Salary',
	   Avg(Salary) as 'Avg Salary'
from Employee E
join Department D on E.DEPARTMENT_ID = D.Department_Id
group by E.Department_Id,D.Name;

--3. List out the job wise maximum salary, minimum salary and average salary of the employees.
Select E.Job_Id, J.Designation,
	   Max(Salary) as 'Highest Salary',
	   Min(Salary) as 'Lowest Salary',
	   Avg(Salary) as 'Avg Salary'
from Employee E
Join Job J on E.Job_Id = J.Job_Id
group by E.Job_Id,J.Designation;

--4. List out the number of employees who joined each month in ascendingorder. 
Select DateName(month, Hire_Date) as 'Hiring Month', 
	   Count(Employee_Id) as '# of Employees Hired'
from Employee
group by DateName(Month, Hire_Date),Month(Hire_Date)
order by Month(Hire_Date);

--5. List out the number of employees for each month and year in ascending order based on the year and month. 
Select Year(Hire_Date) 'Hiring Year', 
	   DateName(month, Hire_Date) 'Hiring Month', 
	   Count(Employee_Id) as '# of Employees Hired'
from Employee
group by Year(Hire_Date), Month(Hire_Date),DateName(month, Hire_Date)
order by Year(Hire_Date), Month(Hire_Date);

--6. List out the Department ID having at least four employees. 
Select Department_Id,
	   Count(Employee_Id) as 'Num of Employees'
from Employee
group by Department_Id
having Count(Employee_Id)>=4;

--7. How many employees joined in the month of January? 
Select DateName(month, Hire_Date) as 'Hiring Month', 
	   Count(Employee_Id) as '# of Employees Hired'
from Employee
where DateName(month, Hire_Date) = 'January'
group by DateName(Month, Hire_Date);


--8. How many employees joined in the month of January orSeptember?
Select DateName(month, Hire_Date) as 'Hiring Month', 
	   Count(Employee_Id) as '# of Employees Hired'
from Employee
group by DateName(Month, Hire_Date)
having DateName(month, Hire_Date) in( 'January', 'September') ;

--9. How many employees joined in 1985? 
Select Year(Hire_Date) as 'Hiring Year', 
	   Count(Employee_Id) as '# of Employees Hired'
from Employee
group by Year(Hire_Date)
having Year(Hire_Date) = '1985';

--10. How many employees joined each month in 1985? 
Select Year(Hire_Date) as 'Hiring Year', 
DateName(month, Hire_Date) as 'Hiring Month',
	   Count(Employee_Id) as '# of Employees Hired'
from Employee
group by Year(Hire_Date), DateName(month, Hire_Date) 
having Year(Hire_Date) = '1985';

--11. How many employees joined in March 1985? 
Select Count(Employee_Id) as '# of Employees Hired in March'
from Employee
group by Year(Hire_Date), Month(Hire_Date) 
having Year(Hire_Date) = '1985' and Month(Hire_Date)=3;

--12. Which is the Department ID having greater than or equal to 3 employees joining in April 1985?
Select Department_Id, count(Employee_Id) '# of Employees Hired in April'
from
	(Select Employee_Id, Department_Id
	from Employee
	where Month(Hire_Date) = 4 and Year(Hire_Date) = 1985)
	AprilHire
group by Department_Id
having count(Employee_Id)>=3;
--or
Select  Department_Id, count(Employee_Id) '# of Employees Hired in April'
	from Employee
	where Month(Hire_Date) = 4 and Year(Hire_Date) = 1985
	group by Department_Id
having count(Employee_Id)>=3;

--***********Joins: 
--1. List out employees with their department names. 
Select E.Last_Name + ' ' + E.First_Name as 'Employee', D.Name as 'Department Name'
from Employee E
join Department D on E.DEPARTMENT_ID = D.Department_Id

--2. Display employees with their designations.
Select E.Last_Name + ' ' + E.First_Name as 'Employee', J.Designation as 'Designation'
from Employee E
join Job J on E.JOB_ID = J.Job_ID

--3. Display the employees with their department names and regional groups.
Select E.Last_Name + ' ' + E.First_Name as 'Employee', 
	   D.Name as 'Department Name',
	   L.City
from Employee E
join Department D on E.DEPARTMENT_ID = D.Department_Id
join LOCATION L on L.Location_ID = D.Location_Id

--4. How many employees are working in different departments? Display with department names.
Select D.Name as 'Department Name',
	   Count(E.Employee_Id) as '# of Employees'
from Employee E
join Department D on E.DEPARTMENT_ID = D.Department_Id
group by D.Name

--5. How many employees are working in the sales department? 
Select D.Name as 'Department Name',
	   Count(E.Employee_Id) as '# of EMployees'
from Employee E
join Department D on E.DEPARTMENT_ID = D.Department_Id
Where D.Name = 'Sales'
group by D.Name;

--6. Which is the department having greater than or equal to 5 employees? 
--   Display the department names in ascending order. 
Select D.Name as 'Department Name',
	   Count(E.Employee_Id) as '# of Employees'
from Employee E
join Department D on E.DEPARTMENT_ID = D.Department_Id
group by D.Name
having Count(E.Employee_Id) >=5
Order by D.Name ;

--7. How many jobs are there in the organization? Display with designations.
Select J.Designation as 'Designation',
       Count(E.Employee_Id) as '# of Jobs'
from Employee E
join Job J on E.JOB_ID = J.Job_ID
group by J.Designation;

--8. How many employees are working in "New York"? 
Select L.City,
	   Count(E.Employee_id) as '# of Employees'
from Employee E
join Department D on E.DEPARTMENT_ID = D.Department_Id
join LOCATION L on L.Location_ID = D.Location_Id
where L.City = 'New York'
group by L.City;

--9. Display the employee details with salary grades. Use conditional statementto create a grade column. 
Select  Employee_Id, First_Name + ' ' + Last_Name as 'Employee Name',
		case 
		  when Salary < 1000 then 'Lower Grade'
		  when salary >= 1000 and salary <2000 then 'Medium Grade'
		  when Salary > 2000 then 'Higher Grade'
		 end as 'Salary Grade'
from employee
--10. List out the number of employees grade wise. Use conditional statementto create a grade column. 
Select SalaryGrade, Count(Employee_Id) as 'Num of Employees'
from(
	Select  Employee_Id, 
		case 
		  when Salary < 1000 then 'Lower Grade'
		  when salary >= 1000 and salary <2000 then 'Medium Grade'
		  when Salary > 2000 then 'Higher Grade'
		 end as 'SalaryGrade'
	from employee
) SG
group by SalaryGrade
--11.Display the employee salary grades and the number of employees between 2000 to 5000 range of salary.
Select SalaryGrade, 
	   Count(Employee_Id) as 'Num of Employees'
from(Select  Employee_Id, Salary,
		case 
		  when Salary < 1000 then 'Lower Grade'
		  when salary >= 1000 and salary <2000 then 'Medium Grade'
		  when Salary > 2000 then 'Higher Grade'
		 end as 'SalaryGrade'
	 from employee) SG
where Salary between 2000 and 5000
group by SalaryGrade;

--12. Display all employees in sales or operation departments. 
Select Employee_Id, 
	   First_Name + ' ' + Last_Name as 'Employee Name', 
	   D.Name
from Employee E
join Department D on E.DEPARTMENT_ID = D.Department_Id
where D.Name in ('Sales','Operations');

----********SET Operators: 
--1. List out the distinct jobs in sales and accounting departments.
Select J.Designation 
from Employee E
Join Job J on E.JOB_ID = J.Job_ID
Join Department D on E.DEPARTMENT_ID = D.Department_Id
where D.Name = 'Sales'
Union
Select J.Designation 
from Employee E
Join Job J on E.JOB_ID = J.Job_ID
Join Department D on E.DEPARTMENT_ID = D.Department_Id
where D.Name = 'Accounting'

--2. List out all the jobs in sales and accounting departments. 
Select  J.Designation 
from Employee E
Join Job J on E.JOB_ID = J.Job_ID
Join Department D on E.DEPARTMENT_ID = D.Department_Id
where D.Name = 'Sales'
Union All
Select  J.Designation 
from Employee E
Join Job J on E.JOB_ID = J.Job_ID
Join Department D on E.DEPARTMENT_ID = D.Department_Id
where D.Name = 'Accounting'

--3. List out the common jobs in research and accounting departments in ascending order.
Select  J.Designation 
from Employee E
Join Job J on E.JOB_ID = J.Job_ID
Join Department D on E.DEPARTMENT_ID = D.Department_Id
where D.Name = 'Research'
Intersect
Select  J.Designation 
from Employee E
Join Job J on E.JOB_ID = J.Job_ID
Join Department D on E.DEPARTMENT_ID = D.Department_Id
where D.Name = 'Accounting'
Order By D.Name;

--Subqueries: 
--1. Display the employees list who got the maximum salary.
Select * from Employee
where Salary = (Select Max(Salary) from Employee)

 --2. Display the employees who are working in the sales department. 
 Select * from Employee E
 where E.DEPARTMENT_ID = (Select DEPARTMENT_ID from DEPARTMENT d where d.Name ='Sales');

 --3. Display the employees who are working as 'Clerk'. 
 Select * from Employee E
 where E.JOB_ID = (Select Job_Id from Job where Designation = 'Clerk');

 --4. Display the list of employees who are living in "New York". 
  Select E.Last_Name,E.First_Name, D.Name as 'Department', D.Location_Id
  from Employee E
  Join DEPARTMENT d on d.Department_Id = E.DEPARTMENT_ID
  where D.Location_Id = (Select Location_Id from LOCATION where City = 'New York');

 --5. Find out the number of employees working in the sales department.
  Select Count(Employee_Id) as '# of Sales ppl'
  from Employee E
  where E.DEPARTMENT_ID in (Select DEPARTMENT_ID from DEPARTMENT where name = 'Sales');

 --6. Update the salaries of employees who are working as clerks on the basis of 10%. 
 Update Employee 
 set Salary = Salary + .1*Salary
 where Employee.JOB_ID in (Select Job_Id from Job where Designation = 'Clerk');

 --7. Delete the employees who are working in the accounting department. 
 Delete from
 Employee 
 where DEPARTMENT_ID in (Select DEPARTMENT_ID from DEPARTMENT where name = 'Accounting');

 --8. Display the second highest salary drawing employee details. 
 ; with SalaryCte as (Select E.Last_name, E.First_Name, 
		Salary,
		dense_rank()over ( order by Salary Desc) as 'SalaryRank'
from Employee E)
Select * from SalaryCte 
where SalaryRank = 2;

 --9. Display the nth highest salary drawing employee details. 
 Select * from
 (Select E.Last_name, E.First_Name, 
		Salary, 
		dense_rank()over ( order by Salary Desc) as 'SalaryRank'
   from Employee E) PickSalaryRank
where SalaryRank = 2   --nth highest, give whichever number as needed

 --10. List out the employees who earn more than every employee in department 30. 
Select E.Last_name, E.First_Name, Salary
from Employee E
where Salary > all (Select Salary
				from Employee E1 
				Where E1.DEPARTMENT_ID =30);

 --11. List out the employees who earn more than the lowest salary in department.
Select E.Last_name, E.First_Name, Salary, D.Name as 'Department'
from Employee E
Join DEPARTMENT D on E.DEPARTMENT_ID = D.Department_Id
where Salary > (Select Min(Salary)
				from Employee E1 
				Where E1.DEPARTMENT_ID = E.Department_Id)

--12. Find out which department has no employees.
Select D.Name as 'Department'
from DEPARTMENT D
where D.Department_Id Not In (Select Department_Id from EMPLOYEE);

--13. Find out the employees who earn greater than the average salary for their department
Select E.Last_name, E.First_Name, Salary
from Employee E
where Salary > (Select Avg(Salary)
				from Employee E1 
				Where E1.DEPARTMENT_ID = E.Department_Id)






