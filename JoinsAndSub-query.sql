/*create database COMPANY_DB;

USE COMPANY_DB;

CREATE TABLE employee(
emp_id int,
emp_name varchar(100),
emp_salary decimal(10,2),
emp_deptid int
);

select *from employee;

ALTER TABLE employee ALTER COLUMN emp_deptid varchar(20);

insert into employee values 
(1111,'Ram', 25000, 'D1'),
(1112,'Rahul', 50000, 'D2'),
(1113,'Rashmi', 60000, 'D3'),
(1114,'Shyam', 40000, 'D2'),
(1115,'Hari', 30000, 'D5');

CREATE TABLE department(
dept_id varchar(20),
dept_name varchar(100),
dept_location varchar(100)
);

insert into department values 
('D1','Development','California'),
('D2','Marketing', 'Mumbai'),
('D3','Accounts', 'New York'),
('D4','Management','Nepal');
*/

Select *from employee;
Select *from department;

Select emp_id, emp_name, emp_salary, dept_name, dept_location
from employee INNER JOIN department 
on employee.emp_deptid=department.dept_id;

Select e.emp_id, e.emp_name, e.emp_salary, d.dept_name, d.dept_location
from employee e INNER JOIN department d
on e.emp_deptid=d.dept_id;

Select emp_id,emp_name,emp_salary,dept_name,dept_location
from employee left outer join department
on employee.emp_deptid=department.dept_id;

Select e.emp_id, e.emp_name, e.emp_salary,d.dept_name,d.dept_location
from employee e left outer join department d
on e.emp_deptid=d.dept_id;

Select e.emp_id, e.emp_name, e.emp_salary,d.dept_name,d.dept_location
from employee e  right outer join department d
on e.emp_deptid=d.dept_id;

Select e.emp_id, e.emp_name, e.emp_salary,d.dept_name,d.dept_location
from department d right outer join employee e 
on e.emp_deptid=d.dept_id;

Select e.emp_id, e.emp_name, e.emp_salary,d.dept_name,d.dept_location
from employee e  full outer join department d
on e.emp_deptid=d.dept_id;

Select e.emp_id, e.emp_name, e.emp_salary,d.dept_name,d.dept_location
from department d full outer join  employee e  
on e.emp_deptid=d.dept_id;

/--Display name,salary of employee whose salary is greater than Shyam's salary --/

Select emp_name, emp_salary from employee
where emp_salary > (select emp_salary from employee
where emp_name='Shyam');

/--Display name,salary of the employees whoes salary is greater than Rahul's salary and deptno same as Rahul's deptno --/

Select emp_name, emp_salary from employee 
WHERE emp_salary >(Select emp_salary from employee where emp_name='Rahul')
and emp_deptid =(Select emp_deptid from employee where emp_name='Rahul');

/-- Display the employee information whose department is located at New york. --/


Select e.emp_id,e.emp_name,e.emp_Salary,d.dept_name,d.dept_location
from employee e FULL OUTER JOIN department d 
on e.emp_deptid= d.dept_id 
where d.dept_id=(
Select dept_id from department where dept_location= 'New York');