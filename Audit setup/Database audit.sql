-- Database audit implementation

-- Use the master database to create the server audit

USE master;
GO

-- Create a server audit and give a target location to save the logs

CREATE SERVER AUDIT Database_Audit
TO FILE (FILEPATH = 'C:\Audit\DatabaseAudit\');
GO

-- Enable the server audit

ALTER SERVER AUDIT Database_Audit WITH (STATE = ON);

-- Use the specific database to create or modify the database audit specification

USE AdventureWorks2022;
GO

-- Create a database audit specification and enable it

CREATE DATABASE AUDIT SPECIFICATION Database_Audit_Specification
FOR SERVER AUDIT Database_Audit
WITH (STATE = ON);
GO

-- To turn off server audit and database audit specification before making changes

ALTER SERVER AUDIT Database_Audit WITH (STATE = OFF);
GO

ALTER DATABASE AUDIT SPECIFICATION Database_Audit_Specification WITH (STATE = OFF);
GO

-- To change the target location of the audit logs if required

ALTER SERVER AUDIT Database_Audit
TO FILE (FILEPATH = 'C:\Audit\DatabaseAudit\'); 

-- To turn on server audit and database audit specification

ALTER SERVER AUDIT Database_Audit WITH (STATE = ON);
GO

ALTER DATABASE AUDIT SPECIFICATION Database_Audit_Specification WITH (STATE = ON);
GO