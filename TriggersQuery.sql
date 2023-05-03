USE COMPANY_DB;
GO

SELECT* FROM employee;
GO

--DML TRIGGERS

CREATE TRIGGER tr_message
ON employee
AFTER INSERT
AS
	BEGIN
		PRINT '	WELCOME TO OUR COMPANY!!';
	END

INSERT INTO employee values(1119, 'Aayush', 50000,'D1');

CREATE TABLE employeeLogs
(id INT, name VARCHAR(255), salary DECIMAL, deptid VARCHAR(255),
modifiedBy varchar(255), modifiedOn date);

SELECT * FROM employeeLogs;
GO

CREATE TRIGGER tr_employee_after_insert
ON employee
AFTER INSERT
AS
	BEGIN
		INSERT INTO employeeLogs
		SELECT emp_id,emp_name,emp_salary,emp_deptid, 'Rashmi', getdate()
		FROM inserted;
	END
GO

INSERT INTO employee VALUES(1000,'Sujin',30000,'D4') ;
GO

CREATE TRIGGER tr_employee_after_update
ON employee
AFTER UPDATE
AS
	BEGIN
		INSERT INTO employeeLogs
		SELECT emp_id,emp_name,emp_salary,emp_deptid, 'Rashmi', getdate()
		FROM inserted;
	END
GO

UPDATE employee SET emp_Salary=10000 WHERE emp_id=1000;
GO

CREATE TRIGGER tr_employee_after_delete
ON employee
AFTER DELETE
AS
	BEGIN
		INSERT INTO employeeLogs
		SELECT emp_id,emp_name,emp_salary,emp_deptid, 'Rashmi', getdate()
		FROM deleted;
	END
GO

DELETE FROM employee where emp_name ='Shyam'; 
GO

CREATE or ALTER TRIGGER tr_employee_allDMLOperations
on employee
AFTER INSERT, DELETE, UPDATE
AS
BEGIN
	--INSERT
	IF EXISTS(SELECT * FROM inserted) AND NOT EXISTS(SELECT * FROM deleted)
		INSERT INTO employeeLogs
		SELECT emp_id,emp_name,emp_salary, emp_deptid,'Rashmi',getdate()
		FROM inserted
	
	--UPDATE
	ELSE IF EXISTS(SELECT * FROM inserted) AND EXISTS(SELECT * FROM deleted)
		INSERT INTO employeeLogs
		SELECT emp_id,emp_name,emp_salary, emp_deptid,'Rashmi',getdate()
		FROM deleted 

	--DELETE
	ELSE IF EXISTS(SELECT *from deleted) AND NOT EXISTS(SELECT * FROM inserted)
		INSERT INTO employeeLogs
		SELECT emp_id,emp_name,emp_salary, emp_deptid,'Rashmi',getdate()
		FROM deleted 

	ELSE 
		BEGIN
			PRINT 'NOTHING CHANGED..'
			RETURN
		END
END

SELECT * FROM employee;
SELECT * FROM employeeLogs;

INSERT INTO employee VALUES(1001,'Vijay', 50000, 'D4');

Update employee SET emp_salary=20000 where emp_id=1118;

DELETE FROM employee WHERE emp_name='Ram';

GO

--DDL TRIGGERS

CREATE or ALTER TRIGGER tr_onTableCreate
ON DATABASE
FOR CREATE_TABLE, DROP_TABLE
AS
BEGIN
	 PRINT 'New table is created or dropped successfully';
END

CREATE TABLE sampleTable(id INT, name VARCHAR(20));

DROP TABLE sampleTable;
GO

CREATE TABLE new_temp(name VARCHAR(100), age INT);
GO

CREATE OR ALTER TRIGGER tr_TableRENAME
ON DATABASE
FOR RENAME
AS 
BEGIN
	PRINT 'Table is renamed';
END

sp_rename 'new_temp', 'triggerdemo';
GO

CREATE TABLE ddl_logs(
	id INT IDENTITY PRIMARY KEY,
	event_data XML,
	performed_by SYSNAME,
	event_type VARCHAR(200)
);
GO

CREATE OR ALTER TRIGGER tr_ddlEventTrigger
ON DATABASE
FOR CREATE_TABLE, RENAME, DROP_TABLE
AS
	BEGIN
		INSERT INTO ddl_logs(event_data,performed_by, event_type)
		VALUES (EVENTDATA(), USER, EVENTDATA().value('(/EVENT_INSTANCE/EventType)[1]','varchar(max)'));
	END

sp_rename 'triggerdemo', 'triggereventcapture'

 CREATE TABLE demo(id INT, value varchar(20));
 CREATE TABLE demo2(id INT, value varchar(20));

SELECT * FROM ddl_logs;

DROP TABLE demo;