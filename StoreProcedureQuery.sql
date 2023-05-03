USE COMPANY_DB;
GO

--Store procedure to display employee details
CREATE PROCEDURE proc_allEmployeeDetails
AS
BEGIN
	SELECT * FROM employee;
END
GO

EXECUTE proc_allEmployeeDetails;
GO
SELECT * FROM department;
GO

--Parameterized Store procedure 
CREATE PROCEDURE proc_employeeDetailsLocationWise(@location AS VARCHAR(100))
AS
BEGIN
	SELECT * FROM employee e inner join department d
	ON e.emp_deptid=d.dept_id
	WHERE d.dept_location = @location;
END
GO

EXECUTE proc_employeeDetailsLocationWise @location='New York';
GO

--ALter Store Procedure
ALTER PROCEDURE proc_allEmployeeDetails
AS
BEGIN 
	SELECT e.emp_name, e.emp_salary,d.dept_location
	FROM employee e inner Join department d
	on e.emp_deptid=d.dept_id;
END
GO

EXECUTE proc_allEmployeeDetails;
GO

--Alter Parameterized Store Procedure
ALTER PROCEDURE proc_employeeDetailsLocationWise(@location AS VARCHAR(100))
AS
BEGIN
	SELECT e.emp_name, e.emp_salary,d.dept_location, d.dept_name FROM employee e inner join department d
	ON e.emp_deptid=d.dept_id
	WHERE d.dept_location = @location;
END
GO

EXECUTE proc_employeeDetailsLocationWise @location='California';
GO

--Rename Store procedure (not recommended)
EXECUTE sp_rename 'proc_allEmployeeDetails','proc_displayEmployeeDetails';

SELECT * FROM sys.sql_modules;
GO

--Creating the previous store procedure with new name
CREATE PROCEDURE proc_displayEmployeeDetails
AS
BEGIN 
	SELECT e.emp_name, e.emp_salary,d.dept_location
	FROM employee e inner Join department d
	on e.emp_deptid=d.dept_id;
END
GO

SELECT* FROM employee;
GO

--Store procedure to insert data
CREATE PROCEDURE proc_insertEmployeeData
(
	@empId INT,
	@empName VARCHAR(100),
	@empSalary DECIMAL(10,2),
	@empDeptId VARCHAR(20)
)
AS 
BEGIN
	INSERT INTO employee
	VALUES (@empId, @empName,@empSalary,@empDeptId)
	PRINT 'New Employee Data Inserted'
END
GO

EXECUTE proc_insertEmployeeData 1116,'Tina', 40000, 'D3'
GO

--Store procedure to update data
CREATE PROCEDURE proc_updateEmployeeData(@empId INT, @newValue VARCHAR(20))
AS
BEGIN
	UPDATE employee SET emp_deptid=@newValue
	WHERE emp_id=@empId
END
GO

EXECUTE proc_updateEmployeeData 1116,'D5'
GO

--Store procedure to insert and update data
CREATE PROCEDURE proc_insertAndUpdateData
(
	@empId INT,
	@empName VARCHAR(100),
	@empSalary DECIMAL(10,2),
	@empDeptId VARCHAR(20)
)
AS
BEGIN
	IF EXISTS (SELECT 1 FROM employee WHERE emp_id=@empID)
	BEGIN
		UPDATE employee SET 
		emp_id=@empID,
		emp_name=@empName,
		emp_salary=@empSalary,
		emp_deptid=@empDeptId
		WHERE emp_id=@empID
		PRINT 'Employee Data Updated'
	END
	ELSE
		BEGIN
			INSERT INTO employee
			VALUES (@empId, @empName,@empSalary,@empDeptId)
			PRINT 'New Employee Data Inserted'
		END
END
GO

--Update
EXECUTE proc_insertAndUpdateData 1111,'Ram', 200000, 'D4'

--Insert
EXECUTE proc_insertAndUpdateData 1117,'Ramey', 200000, 'D1'

--Update with NULL value
EXECUTE proc_insertAndUpdateData 1115,'Hari', NULL , 'D5'
GO

--Store procedure to insert, update and delete data
CREATE PROCEDURE proc_insertUpdateDeleteData
(
	@empId INT,
	@empName VARCHAR(100),
	@empSalary DECIMAL(10,2),
	@empDeptId VARCHAR(20),
	@StmtType NVARCHAR(20)=''
)
AS
BEGIN
	IF @StmtType='INSERT'
		BEGIN
			INSERT INTO employee
			VALUES (@empId, @empName,@empSalary,@empDeptId)
			PRINT 'New Employee Data Inserted'
		END

	IF @StmtType='UPDATE'
		BEGIN
			UPDATE employee SET 
			emp_id=@empID,
			emp_name=@empName,
			emp_salary=@empSalary,
			emp_deptid=@empDeptId
			WHERE emp_id=@empID
			PRINT 'Employee Data Updated'
		END

	ELSE IF @StmtType='DELETE'
		BEGIN
			DELETE FROM employee 
			WHERE emp_id=@empId
			PRINT 'Employee Data Deleted'
		END
END
GO

--Insert Operation

EXECUTE proc_insertUpdateDeleteData 1118, 'Shradha', 150000, 'D1', 'INSERT';

--Update Operation

EXECUTE proc_insertUpdateDeleteData 1113, 'Rashmi', 300000, 'D3', 'UPDATE';

--Delete Operation

Execute proc_insertUpdateDeleteData 1117, 'Ramey', 200000, 'D1', 'DELETE';

EXECUTE proc_displayEmployeeDetails;