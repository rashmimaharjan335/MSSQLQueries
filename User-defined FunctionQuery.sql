USE COMPANY_DB;
GO

SELECT * FROM employee;
GO

--Scalar-valued Function
CREATE FUNCTION salary(@name VARCHAR(50))
RETURNS DECIMAL
BEGIN 
	DECLARE @sal decimal;

	SELECT @sal= emp_salary from employee
	WHERE emp_name=@name;

	RETURN @sal;
END
GO

SELECT dbo.salary('Rashmi') AS 'Employee Salary';
GO

--Inline table-valued function
CREATE FUNCTION getAllEmployees(@salary decimal)
RETURNS TABLE
AS
RETURN
	SELECT *FROM employee WHERE emp_salary= @salary;

GO

SELECT * FROM dbo.getAllEmployees(300000);
GO

--Multi-statement Table-valued Function
CREATE FUNCTION getEmployees(@id VARCHAR(50))
RETURNS @Result TABLE
(ID INT, NAME VARCHAR(50), SALARY DECIMAL, DEPTID VARCHAR(50))
AS
BEGIN
	INSERT INTO @Result
	SELECT *FROM employee WHERE emp_deptid=@id;
	RETURN
END
GO

SELECT * FROM getEmployees('D3');
GO

--Alter function
ALTER FUNCTION getAllEmployees(@salary decimal)
RETURNS TABLE
AS
RETURN
	SELECT emp_name, emp_salary, emp_Deptid FROM employee WHERE emp_salary= @salary;

GO

SELECT * FROM dbo.getAllEmployees(300000);
