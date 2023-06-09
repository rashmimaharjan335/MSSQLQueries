CREATE DATABASE COMPANY_DB;
USE COMPANY_DB;
GO
/****** Object:  Table [dbo].[ddl_logs]    Script Date: 5/3/2023 6:55:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ddl_logs](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[event_data] [xml] NULL,
	[performed_by] [sysname] NOT NULL,
	[event_type] [varchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[demo2]    Script Date: 5/3/2023 6:55:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[demo2](
	[id] [int] NULL,
	[value] [varchar](20) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[department]    Script Date: 5/3/2023 6:55:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[department](
	[dept_id] [varchar](20) NULL,
	[dept_name] [varchar](100) NULL,
	[dept_location] [varchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[employee]    Script Date: 5/3/2023 6:55:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[employee](
	[emp_id] [int] NULL,
	[emp_name] [varchar](100) NULL,
	[emp_salary] [decimal](10, 2) NULL,
	[emp_deptid] [varchar](20) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[employeeLogs]    Script Date: 5/3/2023 6:55:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[employeeLogs](
	[id] [int] NULL,
	[name] [varchar](255) NULL,
	[salary] [decimal](18, 0) NULL,
	[deptid] [varchar](255) NULL,
	[modifiedBy] [varchar](255) NULL,
	[modifiedOn] [date] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[triggereventcapture]    Script Date: 5/3/2023 6:55:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[triggereventcapture](
	[name] [varchar](100) NULL,
	[age] [int] NULL
) ON [PRIMARY]
GO

insert into employee values 
(1111,'Ram', 25000, 'D1'),
(1112,'Rahul', 50000, 'D2'),
(1113,'Rashmi', 60000, 'D3'),
(1114,'Shyam', 40000, 'D2'),
(1115,'Hari', 30000, 'D5');
GO

insert into department values 
('D1','Development','California'),
('D2','Marketing', 'Mumbai'),
('D3','Accounts', 'New York'),
('D4','Management','Nepal');
GO